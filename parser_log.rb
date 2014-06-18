class ParserLog

  def initialize
    @log = File.open('game.log', 'r')
    @game_id = 0
    self.analyze
  end

  def analyze
    @log.each_line do |line|
      self.start_game(@game_id) if line.to_s.split(' ')[1] == 'InitGame:'
    end
  end

  def start_game(game_id)
    @total_kills =    0
    @kills       =    {}
    @game_id    +=    1
    @players     =    []
    @game        =    {"game_#{@game_id}" => { "total_kills" => "", "players" => [], "kills" => {} } }
  end

end

parser = ParserLog.new
