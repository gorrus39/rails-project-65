[![Actions Status](https://github.com/tovarish39/rails-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/tovarish39/rails-project-65/actions)
![local tests and linter](https://github.com/tovarish39/rails-project-65/actions/workflows/rubyonrails.yml/badge.svg)

# Project "Bulletin Board"
The project is a bulletin board, a simplified analogue of, for example, avito and similar services. Executed in Russian. The service publishes advertisements grouped under certain categories. Users of the service can view advertisements posted by other users and can add their own advertisements. To add an ad, you must register via github. The service defines various opportunities for registered users. Users with administrator rights have access to the administrative part of the service. During the process of creation and processing, the advertisement is assigned the appropriate status. Convenient search for advertisements. Pagination.
    Possibilities of an unregistered user
    - view advertisements in the “publication” status

    Registered user capabilities
    - view advertisements in the “publication” status
    - create an ad in the "draft" status
    - send your ads for moderation
    - edit your ads
    - send your advertisements to the archive

    Administrator Features
    - create, delete and edit categories to which advertisements are attached
    - publish, reject advertisements sent for moderation
    - send any advertisements to the archive

## The project works at [link](https://rails-project-65-qkap.onrender.com)
## Sample project works at [link](https://rails-bulletin-board-ru.hexlet.app)


## Technical specifications and project requirements
- ruby ​​-v => 3.2.2
- rails -v => 7.1.3
- CI - git actions - testing, linters rubocop, slim.
- CD - Render(auto-deploy)
- use of the slim template engine
- authentication via github
- authorization is done through gem 'pundit'
- gem 'sentry-ruby' - receiving errors from the production environment on
- bootstrap
- announcement statuses are made using FSC ( gem 'aasm' )
- pagination - gem 'kaminari'
- search - gem 'ransack'
- all text outputs are made via i18n technology
- postgres for production environment

## Running the project locally in development mode
    make install

fill .env file with github keys 

    rails s