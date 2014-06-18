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
      self.edit_player( (line.to_s.split(' ')[2]).to_i, (line.to_s.split(' ')[3]) ) if line.to_s.split(' ')[1] == 'ClientUserinfoChanged:'
      self.new_kill(line.to_s.split(' ')[2].to_i, line.to_s.split(' ')[3].to_i, @game_id) if line.to_s.split(' ')[1] == 'Kill:'
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

  def edit_player(player_id, line)
    for player in @players
      player["name"] = line.split('n\\').last.split('\\t').first if player["id"] == player_id
    end
  end

  def new_kill(killer_id, dead_id, game_id)
    @game["game_#{game_id}"]["total_kills"] = (@total_kills += 1)
    if killer_id == 1022
      for player in @players
        player["kills"] -= 1 if player["id"] == dead_id
      end
    else
      for player in @players
        player["kills"] += 1 if player["id"] == killer_id
      end
    end
  end

end

parser = ParserLog.new
