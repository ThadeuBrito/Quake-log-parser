class ParserLog

  def initialize
    @log = File.open('game.log', 'r')
    @game_id = 0
    self.analyze
  end

  def analyze
    @log.each_line do |line|
      self.start_game(@game_id) if line.to_s.split(' ')[1] == 'InitGame:'
      self.new_player((line.to_s.split(' ')[2]).to_i) if line.to_s.split(' ')[1] == 'ClientConnect:'
    end
  end

  def start_game(game_id)
    @total_kills =    0
    @kills       =    {}
    @game_id    +=    1
    @players     =    []
    @game        =    {"game_#{@game_id}" => { "total_kills" => "", "players" => [], "kills" => {} } }
  end

  def new_player(player_id)
    @players << {"id" => player_id, "name" => "", "kills" => 0} unless @players.map{|i| i.to_a[0][1]}.include?(player_id )
  end

end

parser = ParserLog.new
