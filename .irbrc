# .irbrc

require 'rubygems'

# History.
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 100
IRB.conf[:USE_READLINE] = true
IRB.conf[:HISTORY_PATH] = File.expand_path('~/.irb_history')

# Indent.
IRB.conf[:AUTO_INDENT] = false

# Prompt.
IRB.conf[:PROMPT][:CUSTOM_PROMPT] = {
    :PROMPT_I => "IRB > ", # normal
    :PROMPT_N => "   |  ", # indented
    :PROMPT_C => "f  |  ", # in-formura
    :PROMPT_S => "s  |  ", # in-string
    :RETURN   => "   => %s \n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM_PROMPT

# Completion and colorize.
require 'wirble'
Wirble.init
Wirble.colorize



#### Util methods.

def cd(path)
  Dir.chdir(File.expand_path(path))
end

def pwd
  puts Dir.pwd
end

def ls
  elms = `ls -a -l -F`
  elms.each_line { |elm|
    puts "  #{elm}"
  }

  nil
end



puts "## CUSTOMIZED .irbrc LOADED"
