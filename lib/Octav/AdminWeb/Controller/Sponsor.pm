package Octav::AdminWeb::Controller::Sponsor;
use Mojo::Base qw(Mojolicious::Controller);

sub _lookup {
    my $self = shift;

    my $id = $self->param('id');
    if (!$id) {
        $self->render(text => "not found", status => 404);
        return;
    }

    my $client = $self->client;
    my $sponsor = $client->lookup_sponsor({id => $id, lang => "all"});
    if (!$sponsor) {
        $self->render(text => "not found", status => 404);
        return;
    }

    my $conference = $client->lookup_conference({id => $sponsor->{conference_id}, lang => "all"});
    $self->stash(conference => $conference);
    $self->stash(sponsor => $sponsor);
    return 1
}

sub lookup {
    my $self = shift;
    if (!$self->_lookup()) {
        return
    }
    $self->render(tx => "sponsor/lookup");
}

sub edit {
    my $self = shift;
    if (!$self->_lookup()) {
        return
    }

    my $client = $self->client();
    $self->render(tx => "sponsor/edit");
}

sub update {
    my $self = shift;

    my $id = $self->param('id');
    if (!$id) {
        return $self->render(text => "not found", status => 404);
    }

    my $client = $self->client;
    my $sponsor = $client->lookup_sponsor({id => $id, lang => "all"});

    my @columns = ("name", "logo_url1", "logo_url2", "logo_url3", "url", "group_name", "name#ja");
    my %params = (id => $id, user_id => $self->stash('ui_user')->{id});
    for my $pname (@columns) {
        my $pvalue = $self->param($pname);
        if ($pvalue ne $sponsor->{$pname}) {
            $params{$pname} = $pvalue;
        }
    }

    if (!$client->update_sponsor(\%params)) {
        die $client->last_error();
    }

    $self->redirect_to($self->url_for('/sponsor/lookup')->query(id => $id));
}

1;