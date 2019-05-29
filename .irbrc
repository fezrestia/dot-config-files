# .irbrc

require 'rubygems'

# Completion on TAB, auto coloring.
require 'wirble'
Wirble.init
Wirble.colorize

# History.
IRB.conf[:HISTORY_FILE] = '~/.irb_history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 100 # Use __[line_no]

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
