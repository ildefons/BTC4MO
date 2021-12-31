.PHONY: check docs test

check:
	find src -type f -name '*.mo' -print0 | xargs -0 moc --check ~/.cache/dfinity/versions/0.8.4/base 

all: check-strict docs test

check-strict:
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell vessel bin)/moc $(shell vessel sources) -Werror --check
docs:
	$(shell vessel bin)/mo-doc
test:
	make -C test
