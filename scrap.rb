require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"



villes = {
  vannes: "https://simply-home.herokuapp.com",
  questembert: "https://simply-home-group.herokuapp.com",
  auray: "https://simply-home-cda.herokuapp.com"
}

page_questembert = URI.open("#{villes[:questembert]}/NosMaisons.php")
scrap = Nokogiri::HTML(page_questembert)

liens_maisons = scrap.css("a.card").map { |lien| lien["href"]}
db = SQLITE3::Database.new("boardimo.db")

# QUESTEMBERT

liens_maisons.each do |maison|

  maison = URI.open("#{villes[:questembert]}/#{maison}")
  scrap = Nokogiri::HTML(maison)

  lien = "#{villes[:questembert]}/#{maison}"
  nom = scrap.css(".title").children.text
  description = scrap.css(".houseDescription").children.text
  ville = scrap.css(".city").children.text
  surface = scrap.css(".surface").children.text
  prix = scrap.css(".price").children.text
  classe_nrg = scrap.css(".energetics").children.text
  annee = scrap.css(".year").children.text
end


# VANNES

page_vannes = URI.open("#{villes[:vannes]}/house.php")
scrap = Nokogiri::HTML(page_vannes)

liens_maisons = scrap.css("a.card").map { |lien| lien["href"]}

liens_maisons.each do |maison|

  maison = URI.open("#{villes[:vannes]}/#{maison}")
  scrap = Nokogiri::HTML(maison)

  lien = "#{villes[:vannes]}/#{maison}"
  nom = scrap.css("#titleSingleArticle h2").children.text
  description = scrap.css("#articleContent").children.text
  ville = scrap.css(".location").children.text
  surface = scrap.css(".size").children.text
  prix = scrap.css(".price").children.text
  classe_nrg = scrap.css(".energy").children.text
  annee = scrap.css(".foundation-years").children.text
end


# AURAY

page_auray = URI.open("#{villes[:auray]}/pages/nosmaisons.php")
scrap = Nokogiri::HTML(page_auray)

liens_maisons = scrap.css("a.card").map { |lien| lien["href"]}

liens_maisons.each do |maison|

  maison = URI.open("#{villes[:auray]}/pages/#{maison}")
  scrap = Nokogiri::HTML(maison)

  lien = "#{villes[:auray]}/pages/#{maison}"
  nom = scrap.css("h1").children.text
  infos = scrap.css("#single-ad-description > div > p")
  ville = infos[1].text
  surface = infos[0].text
  prix = infos[2].text
  classe_nrg = infos[3].text
  annee = infos[4].text
  description = scrap.css("#single-ad-description > p:first-child").children.text

  p description

end

#db.execute("INSERT OR IGNORE INTO house VALUES(nom, description, ville, surface, prix, classe_nrg, annee")


  # PREVIOUS DATA version :
  #
  # condition_val = Yacht::CONDITIONS[condition_key]
  #
  # data = {
  #   "label" => label,
  #   "price" => price,
  #   "year" => year,
  #   "loa" => loa,
  #   "boa" => boa,
  #   "condition" => condition_val
  # }

  #sanitized_data = 
   # YachtSanitizer.new(
    #  label: label,
     # price: price,
      #year: year,
      #loa: loa,
      #boa: boa,
      #condition: condition_key
    #).to_h

  #db.execute("INSERT OR IGNORE INTO yacht VALUES (:label, :price, :year, :loa, :boa, :condition)", sanitized_data)
