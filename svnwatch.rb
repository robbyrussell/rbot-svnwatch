require 'drb'

class SvnWatch < Plugin

  attr_writer :channel
  
  def help(plugin, topic="")
    m.reply "svnwatch start (starts the drb instance)"
  end
  
  def privmsg(m)  
  
    unless(m.params)
      m.reply "Incorrect usage. " + help(m.plugin)
    end

    if m.params == "start"
      start_up  
    end

  end

  def post(str)
    @bot.say @channel,  str
  end  
  
end

# register with rbot
svnwatch = SvnWatch.new
svnwatch[:channel] = "#pdx.rb"
svnwatch.register("svnwatch")

# start DRb in a new thread so it doesn't hang up the bot
Thread.new {
    # start the DRb instance
    DRb.start_service('druby://localhost:7666', self.class.new)
    DRb.thread.join
}


