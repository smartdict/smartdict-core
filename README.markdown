# smartdict-core [![Build Status](https://secure.travis-ci.org/smartdict/smartdict-core.png)](http://travis-ci.org/smartdict/smartdict-core)

By [Sergey Potapov](https://github.com/greyblake)


Core of [Smartdict dictionary](https://github.com/smartdict/smartdict).

## Installation

```
gem install smartdict
```

## Usage

To get help just type:

```
smartdict --help
```

To get a help on specific command:

```
smartdict help <COMMAND>
```

### Translate words:

To translate word `hallo` from German to Russian:

  smartdict translate --from de --to ru hallo


### List translated words:

If you want to take a look at words you've translated use `list` command.
You can specify date range and languages to filter words and
you can specify format for output.

To get more information see help:

```
smartdict translate --help
```

#### Example:

To see words translated today:

```
smartdict list
```

To save words translated since 13th of January 2012 from English to Russian in
[FictionBook](http://en.wikipedia.org/wiki/FictionBook) format to `words.fb2`
file.


```
smartdict --since 2012-01-13 --from en --to ru --format fb2 > ./words.fb2
```

## How to configure?

See file `$HOME/.smartdict/configuration.yml`.

NOTE: currently not all options listed there have an effect.


## Contributing to smartdict

* Make sure all tests pass.
* Send me a patch.

## Copyright

Copyright (c) 2012 Potapov Sergey. The software is distributed under
[GNU GeneralPublic License version 2](http://www.gnu.org/licenses/gpl-2.0.txt).
See GPL-LICENSE.txt file for more details.
