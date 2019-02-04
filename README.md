# gotests [![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://github.com/rdeusser/gotests/blob/master/LICENSE) [![godoc](https://img.shields.io/badge/go-documentation-blue.svg)](https://godoc.org/github.com/rdeusser/gotests) [![Build Status](https://travis-ci.org/rdeusser/gotests.svg?branch=master)](https://travis-ci.org/rdeusser/gotests) [![Go Report Card](https://goreportcard.com/badge/github.com/rdeusser/gotests)](https://goreportcard.com/report/github.com/rdeusser/gotests)

**This is a fork of [cweill's version](https://github.com/cweill/gotests) of gotests to fix some issues and add my own flavor.**

`gotests` makes writing Go tests easy. It's a Go commandline tool that generates [table driven tests](https://github.com/golang/go/wiki/TableDrivenTests) based on its target source files' function and method signatures. Any new dependencies in the test files are automatically imported.

## Installation

__Minimum Go version:__ Go 1.11

Use [`go get`](https://golang.org/cmd/go/#hdr-Download_and_install_packages_and_dependencies) to install and update:

```sh
$ go get -u github.com/rdeusser/gotests/...
```

## Usage

From the commandline, `gotests` can generate Go tests for specific source files or an entire directory. By default, it prints its output to `stdout`.

```sh
$ gotests [options] PATH ...
```

Available options:

```
  -all           generate go tests for all functions and methods

  -excl          regexp. generate go tests for functions and methods that don't
                 match. Takes precedence over -only, -exported, and -all

  -exported      generate go tests for exported functions and methods. Takes
                 precedence over -only and -all

  -i             print test inputs in error messages

  -only          regexp. generate go tests for functions and methods that match only.
                 Takes precedence over -all

  -w             write output to (test) files instead of stdout

  -nosubtests    disable subtest generation. Only available for Go 1.7+

  -template_dir  optional. Path to a directory containing custom test code templates
```

## License

`gotests` is released under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0).
