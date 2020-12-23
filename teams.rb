class Teams

  def self.mlb_teams
    {al_east: [{bal: "Baltimore Orioles"},
               {bos: "Boston Red Sox"},
               {nyy: "New York Yankees"},
               {tb: "Tampa Bay Rays"},
               {tor: "Toronto Blue Jays"}],
     al_central: [{chw: "Chicago White Sox"},
                  {cle: "Cleveland Indians"},
                  {det: "Detroit Tigers"},
                  {kan: "Kansas City Royals"},
                  {min: "Minnesota Twins"}],
     al_west: [{hou: "Houston Astros"},
              {laa: "Los Angeles Angels"},
              {oak: "Oakland Athletics"},
              {sea: "Seattle Mariners"},
              {tex: "Texas Rangers"}],
     nl_east: [{atl: "Atlanta Braves"},
               {mia: "Miami Marlins"},
               {nym: "New York Mets"},
               {phi: "Philadelphia Phillies"},
               {was: "Washington Nationals"}],
      nl_central: [{chc: "Chicago Cubs"},
                   {cin: "Cincinnati Reds"},
                   {mil: "Milwaukee Brewers"},
                   {pit: "Pitsburgh Pirates"},
                    {stl: "St Louis Cardinals"}],
      nl_west: [{ari: "Arizona Diamondbacks"},
                {col: "Colorado Rockies"},
                {lad: "Los Angeles Dodgers"},
                {sd: "San Diego Padres"},
                {sf: "San Fransisco Giants"}]}
  end

  def self.nba_teams
    {atlantic: [{bos: "Boston Celtics"},
               {bkn: "Brooklyn Nets"},
               {nyk: "New York Knicks"},
               {phi: "Philadelphia 76ers"},
               {tor: "Toronto Raptors"}],
     central: [{chi: "Chicago Bulls"},
                  {cle: "Cleveland Cavaliers"},
                  {det: "Detroit Pistons"},
                  {ind: "Indiana Pacers"},
                  {mil: "Milwaukee Bucks"}],
     southeast: [{atl: "Atlanta Hawks"},
              {cha: "Charlotte Hornets"},
              {mia: "Miami Heat"},
              {orl: "Orlando Magic"},
              {wsh: "Washington Wizards"}],
     northwest: [{den: "Denver Nuggets"},
               {min: "Minnesota Timberwolves"},
               {okc: "Oklahoma City Thunder"},
               {por: "Portland Trail Blazers"},
               {utah: "Utah Jazz"}],
     pacific: [{gsw: "Golden State Warriors"},
                   {lac: "LA Clippers"},
                   {lal: "LA Lakers"},
                   {phx: "Phoenix Suns"},
                    {sac: "Sacramento Kings"}],
      southwest: [{dal: "Dallas Mavericks"},
                {hou: "Houston Rockets"},
                {mem: "Memphis Grizzlies"},
                {nop: "New Orleans Pelicans"},
                {sas: "San Antonio Spurs"}]}
  end

  def self.nhl_teams
    {atlantic: [{bos: "Boston Bruins"},
                {buf: "Buffalo Sabres"},
                {det: "Detroit Redwings"},
                {fla: "Florida Panthers"},
                {mtl: "Montreal Canadiens"},
                {ott: "Ottowa Senators"},
                {tb: "Tampa Bay Lightning"},
                {tor: "Toronto Maple Leafs"}],
     central: [{chi: "Chicago Blackhawks"},
               {col: "Colorado Avalanche"},
               {dal: "Dallas Stars"},
               {min: "Minnesota Wild"},
               {nsh: "Nashville Predators"},
               {stl: "St. Louis Blues"},
               {wpg: "Winnipeg Jets"}],
     metropolitan: [{car: "Carolina Hurricanes"},
                    {cbj: "Columbus Blue Jackets"},
                    {nj: "New Jersey Devils"},
                    {nyi: "New York Islanders"},
                    {nyr: "New York Rangers"},
                    {phi: "Philadelphi Flyers"},
                    {pit: "Pittsburgh Penguins"},
                    {wsh: "Washington Capitals"}],
     pacific: [{ana: "Anaheim Ducks"},
               {ari: "Arizona Coyotes"},
               {cgy: "Calgary Flames"},
               {edm: "Edmonton Oilers"},
               {la: "Los Angeles Kings"},
               {sj: "San Jose Sharks"},
               {van: "Vancouver Canucks"},
               {vgs: "Vegas Golden Knights"}]}
  end

  def self.nfl_teams
    {afc_east: [{buf: "Buffalo Bills"},
                {mia: "Miami Dolfins"},
                {ne: "New England Patriots"},
                {nyj: "New York Jets"}],
     afc_north: [{bal: "Baltimore Ravens"},
                 {cin: "Cincinnati Bengals"},
                 {cle: "Cleveland Browns"},
                 {pit: "Pitsburgh Steelers"}],
     afc_south: [{hou: "Houston Texans"},
                 {ind: "Indianapolis Colts"},
                 {jax: "Jacksonville Jaguars"},
                 {ten: "Tennessee Titans"}],
     afc_west: [{den: "Denver Broncos"},
                {kc: "Kansas City Chiefs"},
                {lac: "Los Angeles Chargers"},
                {oak: "Oakland Raiders"}],
      nfc_east: [{dal: "Dallas Cowboys"},
                 {nyg: "New York Giants"},
                 {phi: "Philadelphia Eagles"},
                 {wsh: "Washington Redskins"}],
      nfc_north: [{chi: "Chicago Bears"},
                  {det: "Detroit Lions"},
                  {gb: "Green Bay Packers"},
                  {min: "Minnesota Vikings"}],
      nfc_south: [{atl: "Atlanta Falcons"},
                  {car: "Carolina Panthers"},
                  {no: "New Orleans Saints"},
                  {tb: "Tampa Bay Buccaneers"}],
      nfc_west: [{ari: "Arizona Cardinals"},
                 {lar: "Los Angeles Rams"},
                 {sf: "San Fransisco 49ers"},
                 {sea: "Seattle Seahawks"}]}
  end

  def self.team_abbreviations(sport)
    abbr_teams = []

    case sport
    when "mlb"
      teams = mlb_teams
    when "nba"
      teams = nba_teams
    when "nfl"
      teams = nfl_teams
    when "nhl"
      teams = nhl_teams
    end

    teams.each do |division, teams|
      teams.each {|team| team.each {|abbr, full| abbr_teams << abbr.to_s}}
    end
    abbr_teams
  end

end
