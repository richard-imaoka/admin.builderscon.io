import admin
import flask
import flasktools
import functools

def load_logged_in_user():
    if 'user_id' in flask.session:
        user = admin.api.lookup_user(flask.session.get('user_id'))
        if user:
            flask.g.stash['user'] = user
            flask.g.lang = admin.get_locale()
            return True
        del flask.session['user_id']
    return False

def load_user_only(cb, **args):
    load_logged_in_user()
    return cb(**args)

def load_user_or_login(cb, **args):
    if load_logged_in_user():
        return cb(**args)
    next_url = flask.request.path + "?" + flasktools.urlencode(flask.request.args)
    query = flasktools.urlencode({'.next': next_url})
    return flask.redirect("/login?" + query)

def check_login(cb, **args):
    return functools.update_wrapper(functools.partial(load_user_only, cb, **args), cb)

# Check if we have the user session field pre-populated.
def require_login(cb, **args):
    return functools.update_wrapper(functools.partial(load_user_or_login, cb, **args), cb)

def require_email(cb, **args):
    return functools.update_wrapper(functools.partial(check_email, cb, **args), cb)

def check_email(cb, **args):
    user = flask.g.stash.get('user')
    if not user:
        return "require_login must be called first", 500

    if not user.get('email'):
        next_url = flask.request.path + "?" + flasktools.urlencode(flask.request.args)
        flask.session['next_url_after_email_registration'] = next_url
        return flask.redirect('/user/email/register')

    return cb(**args)

def with_conference(cb, lang='en'):
    def _load_conference(cb, id, lang):
        conf = admin.api.lookup_conference(id=id, lang=lang)
        if not conf:
            return flask.abort(404)
        flask.g.stash['conference'] = conf
        flask.g.stash['conference_id'] = id
        return cb()

    return functools.update_wrapper(functools.partial(_load_conference, cb, lang=lang), cb)

def with_conference_series_list(cb):
    def _load_conference_series_list(cb):
        serieses = admin.api.list_conference_series()
        if not serieses:
            return flask.abort(404)
        flask.g.stash['conference_series'] = serieses
        return cb()

    return functools.update_wrapper(functools.partial(_load_conference_series_list, cb), cb)

def with_venue_list(cb, lang='en'):
    def _load_venue_list(cb, lang):
        venues = admin.api.list_venue(lang=lang)
        if not venues:
            return flask.abort(404)
        flask.g.stash['venues'] = venues
        return cb()

    return functools.update_wrapper(functools.partial(_load_venue_list, cb, lang=lang), cb)