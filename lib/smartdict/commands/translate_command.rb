class Smartdict::Commands::TranslateCommand < Smartdict::Command
  name        "translate"
  summary     "Translate a word"
  description "Translate a word"
  syntax       "#{prog_name} <WORD> [--from LANGUAGE] [--to LANGUAGE]"
  usage <<-USAGE
    #{prog_name} hello
    #{prog_name} again --from en
    #{prog_name} again --to ru
  USAGE

  def execute

  end
end
