require 'drb'

class SvnWatch < Plugin

  
  def help(plugin)
    m.reply "svnwatch start (starts the drb instance)"
  end
  
  def privmsg(m)
  
    unless(m.params)
      m.reply "Incorrect usage. " + help(m.plugin)
    end
    
  end

  def post(str)
    m.say "#pdx.rb", str
  end  
  
end

# register with rbot
svnwatch = SvnWatch.new
svnwatch.register("svnwatch")

# start the DRb instance
DRb.start_service('druby://localhost:7666', svnwatch)
DRb.thread.join

