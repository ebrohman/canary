
# Canary

## Installation

This code is a standard Ruby gem and can be installed by manually building gem the after cloning the repo and then installing the .gem file
```
  $ cd canary
  $ bundle
  $ gem build canary.gemspec
  $ gem install canary-0.1.0.gem
```

This gem was developed and tested against ruby `2.6.5`.  I cannot guarantee other ruby versions will work, but they likely will.  I use `rvm` to manage rubies.

## Tests
There are a suite of unit tests for the various commands which can be invoked by running `$ rake spec` from inside the project root.

## Usage

The gem, once installed will create an executable called `canary` and add it to your PATH.  All of the features are executable as a subcommand of `canary`.
E.g. - `$ canary create -f /path/to/file`

The CLI uses the gem `Thor` as an options parser and for documentation.  Each command can be introspected with `canary help <command>` to see required arguments and optional arguments.

## Features
  - File creation
      -  `$ canary help create` #docs
      - `$ canary create -f <file-path>` #example

- File modification
    - `$ canary help modify` #docs
    - `$ canary modify -f <file-path> -d <data>` #example

- File deletion
    - `$ canary help delete` #docs
    - `$ canary delete -f <file-path>` #example

- Network Request
    - `$ canary help request` #docs
    - `$ canary request --host <host> --path <path>`

- Process start
    - `$ canary help spawn` #docs
    - `$ canary spawn -f <file-path> --options <process args>` #example

## Logging
Each command logs pertinent data to a log file, the path of which is taken from the ENV,
e.g. `LOG_FILE=/path/to/file canary request ...`.
If no log file is present in the ENV, canary will log to the default log file inside the project at `log/telemetry.csv`
