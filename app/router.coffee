GithubView = require 'views/page_github'
PersonView = require 'views/page_people'
ProjectPage = require 'views/page_project'
MailmanView = require 'views/page_mailman'
TwitterView = require 'views/page_twitter'

# Function to consistently target the main div
content = -> $('#content')
# Generator of singleton view pages
singletons =
    githubView:  -> return @_github = @_github or new GithubView()
    personView:  -> return @_person = @_person or new PersonView()
    projectPage: -> return @_project = @_project or new ProjectPage()
    mailmanView: -> return @_mailman = @_mailman or new MailmanView()
    twitterView: -> return @_twitter = @_twitter or new TwitterView()

module.exports = class Router extends Backbone.Router
    routes:
        '': 'project'
        'person': 'person'
        'project': 'project'
        'project/:projectName': 'project'
        'github': 'github'
        'github/:graphmode': 'github'
        'mailman': 'mailman'
        'twitter': 'twitter'

    initialize: ->
        # Trigger nav updates
        @on 'all', (trigger) =>
            trigger = trigger.split(':')
            if trigger[0]=='route'
              $('.navbar .nav li').removeClass 'active'
              $('.navbar .nav li[action="'+trigger[1]+'"]').addClass 'active'

    setCurrent: (view) =>
        if not (view==@currentView)
            @currentView = view
            view.renderPage content()

    ## Router Paths
    ## ------------
    #
    person: ->
        @setCurrent singletons.personView()
    project: (projectName='ckan') ->
        @setCurrent singletons.projectPage()
        singletons.projectPage().showProject projectName
    github: (graphMode='watchers') ->
        @setCurrent singletons.githubView()
        singletons.githubView().showGraph graphMode
    mailman: ->
        @setCurrent singletons.mailmanView()
    twitter: ->
        @setCurrent singletons.twitterView()
    recline: ->
        @setCurrent singletons.reclineView()
