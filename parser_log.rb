class ParserLog

  def initialize
    @log = File.open('game.log', 'r')
    @game_id = 0
    self.analyze
  end

  def analyze
  end

end

parser = ParserLog.new
