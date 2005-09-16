#
# svnwatch - a subversion plugin for rbot.
# author(s): Robby Russell and Ben Bleything of the PDX.rb
#
# This file should be placed in the rbot plugins/ directroy. When you load rbot
# it will scan the directory and load this plugin. DRb will automatically start up.

require 'drb'
require 'rbot/formatting'

# Configuration Options
@conf = { 
  :port => '7666',       # 7666
  :host => 'localhost',  # localhost, don't set to remote ip unless you know what you are doing
  :chan => '#pdx.rb'     # IRC channel that you want rbot to send notices to
}

class SvnWatch < Plugin

  attr_writer :channel
  
  def help(plugin, topic="")
    m.reply "nothing to do. svnwatch talks without your written consent. ;-)"
  end
  
  def privmsg(m)  
    m.reply "I don't actually have anything to say. I just sit and wait for SVN to call me."    
  end
  
  def svn_commit(info)
    send_msg(build_msg(info))
  end
  
  # Sends a message to the channel defined. This will allow 
  # you to use the DRb instance to call the send_msg(str)  
  # method, which will output to the desired channel
  private
    def send_msg(str)
      @bot.say @channel,  str
    end  
  
    def build_msg(info)
      author = Irc.Formatting.color(:green) + info[:author] + Irc::Formatting.reset
      repository = Irc.Formatting.color(:cyan) + info[:repository] + Irc::Formatting.reset
      revision =  Irc.Formatting.bold + "[" + info[:revision] + ":/]" + Irc::Formatting.reset
      note =  Irc.Formatting.color(:yellow) info[:log] +  Irc::Formatting.reset
      message = "#{author} * #{revision} #{repos} - #{note}"
      return message
    end
    
end

# register with rbot
@svnwatch = SvnWatch.new
@svnwatch.channel = @conf[:chan]
@svnwatch.register("svnwatch")

# start DRb in a new thread so it doesn't hang up the bot
Thread.new {
  # start the DRb instance
  DRb.start_service("druby://#{@conf[:host]}:#{@conf[:port]}", @svnwatch)
  DRb.thread.join
}

# that's all folks!