require 'drb'

class SvnWatch < Plugin

  def help(plugin, topic="")
    m.reply "nothing to do. svnwatch talks without your written consent. ;-)"
  end
  
  def privmsg(m)  
  
    unless(m.params)
      m.reply "Incorrect usage. " + help(m.plugin)
    end

  end

  # Sends a message to the channel defined. This will allow 
  # you to use the DRb instance to call the send_msg(str)  
  # method, which will output to the desired channel
  def send_msg(str)
    @bot.say "#pdx.rb",  str
  end  
  
end

# register with rbot
svnwatch = SvnWatch.new
svnwatch.register("svnwatch")

# start DRb in a new thread so it doesn't hang up the bot
Thread.new {
    # start the DRb instance
    DRb.start_service('druby://localhost:7666', svnwatch)
    DRb.thread.join
}


