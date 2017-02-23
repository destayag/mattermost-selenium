.PHONY: test test-chrome test-all clean patch-files

all: test-all

clean:
	mvn clean

nuke:
	mvn clean
	rm -rf src/test/resources/selenium_standalone_binaries
	rm -rf src/test/resources/selenium_standalone_zips


patch-files:
	sed -i'' -e 's|// Sleep|Thread.sleep(1000);|g' ./src/test/java/com/mattermost/selenium/tests/*.java
	sed -i'' -e 's|// DisableAnnimations|disableAnnimations();|g' ./src/test/java/com/mattermost/selenium/tests/*.java

test: patch-files
	mvn clean verify

test-chrome: patch-files
	mvn -Dbrowser=chrome clean verify

test-firefox: patch-files
	mvn -Dbrowser=firefox clean verify

test-all: patch-files
	mvn -Dbrowser=firefox clean verify
	mvn -Dbrowser=chrome clean verify