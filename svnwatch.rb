#
# svnwatch - a subversion plugin for rbot.
# author(s): Robby Russell and Ben Bleything of the PDX.rb
#
# This file should be placed in the rbot plugins/ directroy. When you load rbot
# it will scan the directory and load this plugin. DRb will automatically start up.

require 'drb'

# Configuration
@conf = Hash.new

@conf[:port] = '7666'	   # 7666
@conf[:host] = 'localhost' # localhost, don't set to remote ip unless you know what you are doing
@conf[:chan] = '#pdx.rb'

class SvnWatch < Plugin

  def new(channel="#pdx.rb")
    @channel = channel
  end
  
  def help(plugin, topic="")
    m.reply "nothing to do. svnwatch talks without your written consent. ;-)"
  end
  
  def privmsg(m)  
    m.reply "I don't actually have anything to say. I just sit and wait for SVN to call me."    
  end

  # Sends a message to the channel defined. This will allow 
  # you to use the DRb instance to call the send_msg(str)  
  # method, which will output to the desired channel
  def send_msg(str)
    @bot.say @channel,  str
  end  
  
end

# register with rbot
@svnwatch = SvnWatch.new(@conf[:chan])
@svnwatch.register("svnwatch")

# start DRb in a new thread so it doesn't hang up the bot
Thread.new {
  # start the DRb instance
  DRb.start_service("druby://#{@conf[:host]}:#{@conf[:port]}", @svnwatch)
  DRb.thread.join
}
