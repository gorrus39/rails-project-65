# подразумевается деплой на Render. (подразумевается что бд уже создана на Render)
# для локального запуска в продакшн среде, 
# необходимо настроить соединение с postgres. 
# в development режиме работает на sqlite 

# первый запуск
install:   prepare_dependencies make_env_file prepare_db prepare_assets lint_rubocop lint_slim test

on_commit: prepare_dependencies mirgate_db prepare_assets lint_rubocop lint_slim test

prepare_dependencies:
	bundle install

prepare_db:
	bin/rails db:migrate db:seed RAILS_ENV=production

mirgate_db:
	bin/rails db:migrate RAILS_ENV=production

prepare_assets:
	bin/rails assets:precompile

lint_rubocop:
	bundle exec rake lint:rubocop

lint_slim:
	bundle exec rake lint:slim

test:
	bin/rails test

make_env_file:
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
	fi