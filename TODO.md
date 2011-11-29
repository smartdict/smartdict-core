
## Tasks to do:

1. Make train command work with time parameters and work by default using words translated today.
1. Add logger
    Add option for a log level
1. Refactor: Do we really need driver and translation_source. Are not they  the same?
1. Make support for input stream for translate and train commands.
1. Think about different views for same entities. For example: short view style, more detail view style and so on...
1. Esape output of setting when config --list is called. It is needed for displaying asci colors
1. Modify configuration structure:
     cli
        colors
     gui
     common
        from_lang
        to_lang

1. Create driver for Lingvo: http://lingvo.abbyyonline.com/en/en-ru/lie


## KNOWN BUGS

1. When you run "smartdict translate fuck" or "smartdict translate rapidly" translations are not found but they exist!



## Archicture

### Plugins

Plugins should have an ability to extend Smartdict as far as it possible.
Need to investigate another Software based on plugins.

Take a look at:

* Redcar

The exetended features can be:

* New translation drivers (also think how them will iteract with GUI).
* New commands.
* New menu items.
* New data formats(views).
* New audio adapters to play audio files.
* Models? 

Think. Can plugin system be implemented with rubygems? 

Develop plugin stracture based on rubygems system.

Plugin items should not conflict with items provided by Smartdict Core. So, probably I should create some kind of validation if it is possible.

### Commands

Thinks about rejecting the Commander gem because it is heavy. Take a look to gem sources, how did they implement commands?
One more reason to use own command system is to implement commands like classes.


Smartdict::Drivers
    GoogleTranslateDriver
    LingvoDriver

Smartdict::Commands
    TranslateCommand
    ListCommand

Smartdict::Formats
    CliFormat
    Fb2Format

Smartdict::Models
    Word
    WordClass
    Translations

Smartdict::Plugins?


Every plugin should contain its class, for example: Smartdict::Plugins::AbbyLingvoPlugin.
And this class should have #load method, which do all staff realated to initialization of plugin.
Also it should have #install method which is called when plugin installed(or loaded first time?).
