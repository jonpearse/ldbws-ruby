fmt:
	rufo lib

test:
	bundle exec watchexec -e rb,erb 'rspec --format=progress'
