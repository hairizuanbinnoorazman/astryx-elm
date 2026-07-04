.PHONY: docs format-check test showcase check clean

docs:
	elm make --docs=docs.json

format-check:
	elm-format --validate src tests showcase/src

test:
	elm-test

showcase:
	mkdir -p showcase/dist
	cd showcase && elm make src/Main.elm --output=dist/showcase.js

check: format-check docs test showcase

clean:
	rm -rf elm-stuff showcase/elm-stuff showcase/dist docs.json
