# подразумевается деплой на Render. (подразумевается что бд уже создана на Render)
# для локального запуска в продакшн среде, 
# необходимо настроить соединение с postgres. 
# в development режиме работает на sqlite 

# локальный деплой development
install:          prepare_dependencies make_env_file prepare_db_local prepare_assets

deploy_on_render: prepare_dependencies  prepare_db_for_render prepare_assets 

on_commit:        prepare_dependencies mirgate_db db_seed prepare_assets 

prepare_dependencies:
	bundle install

prepare_db_for_render:
	bin/rails db:migrate db:seed RAILS_ENV=production

db_seed:
	bin/rails db:seed RAILS_ENV=production


prepare_db_local:
	bin/rails db:create db:migrate db:seed 

mirgate_db:
	bin/rails db:migrate RAILS_ENV=production

prepare_assets:
	bin/rails assets:precompile


make_env_file:
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
	fi


# lint_rubocop:
# 	bundle exec rake lint:rubocop

# lint_slim:
# 	bundle exec rake lint:slim

# test:
# 	bin/rails test