Eyeos Hooks Library
===================

## Overview

This library is for distribute the hooks necessary to boost development time and let not commit without passing unit tests.

## How to use it

```bash
git clone <EYEOS_REPO>
```

After that you will have the hooks installed in your local .git/hooks folder.

### pre-commit

Currently what pre commit does is execute the tests in src/test with a human reporter (the one in grunt file is xunit, for sonar parsing).
Then, if they exist, execute test-dev.sh and integration-test.sh that are test scripts where they are dev machine tests.
And if you have an eyeos environment running and you set the envar EXECUTE_COMPONENT_TEST, you will also execute the component tests in pre commit stage.

### install library in a repo that still don't has eyeos-hooks

You have to add the library and then commit push the package.json:

```bash
npm install --save eyeos-hooks
```

**be sure that after that command, the version of the library is \* as all the other libraries from eyeos**
```bash
git add package.json
git commit -m "Added eyeos-hooks"
git push origin master
```

## Quick help

* Install modules

```bash
	$ npm install
```
