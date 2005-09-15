require 'drb'

class SvnWatch < Plugin

  def help(plugin)
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
    @bot.say "#pdx.rb",  str
  end  
  
  private
  def start_up
    sd = svndrb.new    
    # start the DRb instance
    DRb.start_service('druby://localhost:7666', sd)
    DRb.thread.join
  end
    
end

class svndrb < SvnWatch

end

# register with rbot
svnwatch = SvnWatch.new
svnwatch.register("svnwatch")




