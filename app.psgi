use strict;
use Plack::Builder;
use Octav::AdminWeb;
use MIME::Base64;
use Mojo::Server::PSGI;
use Sereal::Decoder;
use Sereal::Encoder;

my $web = Octav::AdminWeb->new();
my $server = Mojo::Server::PSGI->new(app => $web);
my $app = $server->to_psgi_app;

my $redis = $web->redis();
my $encoder = Sereal::Encoder->new();
my $decoder = Sereal::Decoder->new();
my $store = Plack::Util::inline_object(
    get => sub {
        my $h = $redis->command('get', @_);
        chomp($h);
        if ($h =~ /^ERR / || $h !~ /\S/) {
            return;
        }
        return $h;
    },
    set => sub {
        my $h = $redis->command('set', @_);
        if ($h =~ /^ERR /) {
            return
        }
        return 1;
    },
    remove => sub { $redis->command('del', @_) },
);

# file should contain a key/value pair of username/password.
# TODO: maybe put this in the database.
my $authmap = {};
if (my $file = $ENV{BASIC_AUTH_MAP}) {
    $authmap = do $file;
}

builder {
    if (keys %$authmap > 0) {
        enable 'Auth::Basic', authenticator => sub {
            my($username, $password, $env) = @_;
            return exists $authmap->{$username} && $authmap->{$username} eq $password;
        };
    }
    enable 'Session::Simple',
        store => $store,
        serializer => [
            sub { 
                my $raw = $_[0];
                my $encoded = encode_base64($encoder->encode($raw));
                return $encoded;
            },
            sub {
                my $raw = $_[0];
                if (!$raw || $raw !~ /\S/) {
                    return # optmize
                }

                my $decodedb64 = decode_base64($raw);
                my $ret = eval { $decoder->decode($decodedb64) };
                if ($@) {
                    warn "Failed to decode session: $@";
                    return
                }
                return $ret;
            },
        ],
        cookie_name => "octav_admin_session",

    ;
    $app;
};
