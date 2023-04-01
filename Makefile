fmt:
	rufo lib

test:
	bundle exec watchexec -e rb,erb 'rspec --format=progress'

docs:
	bundle exec rdoc -m README.md -x spec -x *.rb -x tmp -x Gemfile -x *.gemspec -x Makefile
