.PHONY: test rubocop setup clean

test:
	RAILS_ENV=test bundle exec rspec

rubocop-analyze:
	bundle exec rubocop

rubocop-fix:
	bundle exec rubocop -a

setup:
	bundle install
	rails db:create

migrate:
	rails db:migrate

doctor:
	rails active_record_doctor	


help:
	@echo ""
	@echo "\033[1mAvailable targets:\033[0m"
	@echo "\033[32m  test           \033[0m→ Run tests"
	@echo "\033[33m  rubocop-analyze\033[0m → Run rubocop to get analysis"
	@echo "\033[33m  rubocop-fix    \033[0m → Run rubocop to fix issues"
	@echo "\033[34m  setup          \033[0m → Install gems and create DB"
	@echo "\033[36m  migrate        \033[0m → Migrate DB"
	@echo "\033[35m  doctor         \033[0m → Execute Active Record Doctor"


