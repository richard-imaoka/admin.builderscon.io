package WebService::Octav;
use strict;
use JSON;
use LWP::UserAgent;
use URI;

sub new {
    my ($class, %args) = @_;
    if (! $args{endpoint}) {
        die "You must supply an endpoint";
    }
    my $endpoint = $args{endpoint};
    $endpoint =~ s{/$}{}; # strip trailing "/"
    my $self = bless {
        endpoint => $endpoint,
        user_agent => LWP::UserAgent->new(agent => "perl5/WebService::Octav"),
    }, $class;
    return $self;
}

sub last_error {
    my $self = shift;
    return $self->{last_error};
}

sub credentials {
    my $self = shift;
    my $uri = URI->new($self->{endpoint});
    $self->{user_agent}->credentials($uri->host_port, "octav", @_[0], @_[1])
}



sub create_user {
    my ($self, $payload) = @_;
    for my $required (qw(nickname auth_via auth_user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/user/create|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub lookup_user {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/user/lookup|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub lookup_user_by_auth_user_id {
    my ($self, $payload) = @_;
    for my $required (qw(auth_via auth_user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/user/lookup_by_auth_user_id|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub update_user {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/user/update|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_user {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/user/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub list_user {
    my ($self, $payload) = @_;
    my $uri = URI->new($self->{endpoint} . qq|/v1/user/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub create_venue {
    my ($self, $payload) = @_;
    for my $required (qw(name address user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/venue/create|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub list_venue {
    my ($self, $payload) = @_;
    my $uri = URI->new($self->{endpoint} . qq|/v1/venue/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub lookup_venue {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/venue/lookup|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub update_venue {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/venue/update|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_venue {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/venue/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub create_room {
    my ($self, $payload) = @_;
    for my $required (qw(venue_id name user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/room/create|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub update_room {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/room/update|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub lookup_room {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/room/lookup|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub delete_room {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/room/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub list_room {
    my ($self, $payload) = @_;
    for my $required (qw(venue_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/room/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub create_conference_series {
    my ($self, $payload) = @_;
    for my $required (qw(user_id slug title)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference_series/create|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub list_conference_series {
    my ($self, $payload) = @_;
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference_series/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub add_conference_series_admin {
    my ($self, $payload) = @_;
    for my $required (qw(series_id admin_id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference_series/admin/add|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub create_conference {
    my ($self, $payload) = @_;
    for my $required (qw(series_id title slug user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/create|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub add_conference_dates {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id dates user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/dates/add|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_conference_dates {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id dates user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/dates/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub add_conference_admin {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id admin_id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/admin/add|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_conference_admin {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id admin_id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/admin/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub add_conference_venue {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id venue_id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/venue/add|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_conference_venue {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id venue_id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/venue/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub lookup_conference {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/lookup|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub lookup_conference_by_slug {
    my ($self, $payload) = @_;
    for my $required (qw(slug)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/lookup_by_slug|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub list_conference {
    my ($self, $payload) = @_;
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub update_conference {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/update|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_conference_series {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference_series/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_conference {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/conference/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub create_session {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id speaker_id title abstract duration user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/session/create|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub lookup_session {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/session/lookup|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub delete_session {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/session/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub update_session {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/session/update|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub list_session_by_conference {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/schedule/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub create_question {
    my ($self, $payload) = @_;
    for my $required (qw(session_id user_id body)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/question/create|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub delete_question {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/question/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub list_question {
    my ($self, $payload) = @_;
    for my $required (qw(session_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/question/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub create_session_survey_response {
    my ($self, $payload) = @_;
    for my $required (qw(session_id user_id user_prior_knowledge speaker_knowledge speaker_presentation material_quality overall_rating)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/survey_session_response/create|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub add_featured_speaker {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id display_name description)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/featured_speaker/add|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub lookup_featured_speaker {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/featured_speaker/lookup|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub list_featured_speakers {
    my ($self, $payload) = @_;
    my $uri = URI->new($self->{endpoint} . qq|/v1/featured_speaker/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub update_featured_speaker {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/featured_speaker/update|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_featured_speaker {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/featured_speaker/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub add_sponsor {
    my ($self, $payload) = @_;
    for my $required (qw(conference_id logo_url1 name url group_name user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/sponsor/add|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub lookup_sponsor {
    my ($self, $payload) = @_;
    for my $required (qw(id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/sponsor/lookup|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub list_sponsors {
    my ($self, $payload) = @_;
    my $uri = URI->new($self->{endpoint} . qq|/v1/sponsor/list|);
    $uri->query_form($payload);
    my $res = $self->{user_agent}->get($uri);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return JSON::decode_json($res->decoded_content);
}

sub update_sponsor {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/sponsor/update|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

sub delete_sponsor {
    my ($self, $payload) = @_;
    for my $required (qw(id user_id)) {
        if (!$payload->{$required}) {
            die qq|property "$required" must be provided|;
        }
    }
    my $uri = URI->new($self->{endpoint} . qq|/v1/sponsor/delete|);
    my $json_payload = JSON::encode_json($payload);
    my $res = $self->{user_agent}->post($uri, Content => $json_payload);
    if (!$res->is_success) {
        $self->{last_error} = $res->status_line;
        return;
    }
    return 1
}

1;
