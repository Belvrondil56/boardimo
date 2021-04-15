require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"

require "./lib/maison_sanitizer"



agences = {
  vannes: "https://simply-home.herokuapp.com",
  questembert: "https://simply-home-group.herokuapp.com",
  auray: "https://simply-home-cda.herokuapp.com"
}

page_questembert = URI.open("#{agences[:questembert]}/NosMaisons.php")
scrap = Nokogiri::HTML(page_questembert)

liens_maisons = scrap.css("a.card").map { |lien| lien["href"]}
db = SQLite3::Database.new("boardimo.db")

# QUESTEMBERT

liens_maisons.each do |maison|

  page_questembert = URI.open("#{agences[:questembert]}/#{maison}")
  scrap = Nokogiri::HTML(page_questembert)

  lien = "#{agences[:questembert]}/#{maison}"
  nom = scrap.css(".title").children.text
  description = scrap.css(".houseDescription").children.text
  ville = scrap.css(".city").children.text
  surface = scrap.css(".surface").children.text
  prix = scrap.css(".price").children.text
  classe_nrg = scrap.css(".energetic").children.text
  annee = scrap.css(".year").children.text

  sanitized_data =
    MaisonSanitizer.new(
      lien: lien,
      nom: nom,
      ville: ville,
      surface: surface,
      prix: prix,
      classe_nrg: classe_nrg,
      annee: annee
    ).to_h



    db.execute("INSERT OR IGNORE INTO house VALUES(:lien, :nom, :ville, :surface, :prix, :classe_nrg, :annee)", sanitized_data)

end

# VANNES

page_vannes = URI.open("#{agences[:vannes]}/house.php")
scrap = Nokogiri::HTML(page_vannes)
  
liens_maisons = scrap.css(".articleHouse a").map { |lien| lien["href"]}

liens_maisons.each do |maison|

  page_Vannes = URI.open("#{agences[:vannes]}/#{maison}")
  scrap = Nokogiri::HTML(page_Vannes)

  lien = "#{agences[:vannes]}/#{maison}"
  nom = scrap.css("#titleSingleArticle h2").children.text
  description = scrap.css("#articleContent").children.text
  ville = scrap.css(".location").children.text
  surface = scrap.css(".size").children.text
  prix = scrap.css(".price").children.text
  classe_nrg = scrap.css(".energy").children.text
  annee = scrap.css(".foundation-years").children.text



  sanitized_data =
    MaisonSanitizer.new(
      lien: lien,
      nom: nom,
      ville: ville,
      surface: surface,
      prix: prix,
      classe_nrg: classe_nrg,
      annee: annee
    ).to_h


    db.execute("INSERT OR IGNORE INTO house VALUES(:lien, :nom, :ville, :surface, :prix, :classe_nrg, :annee)", sanitized_data)

end


# AURAY

page_auray = URI.open("#{agences[:auray]}/pages/nosmaisons.php")
scrap = Nokogiri::HTML(page_auray)

liens_maisons = scrap.css("#house-cards .card a").map { |lien| lien["href"]}

liens_maisons.each do |maison|

  page_Auray = URI.open("#{agences[:auray]}/pages/#{maison}")
  scrap = Nokogiri::HTML(page_Auray)

  lien = "#{agences[:auray]}/pages/#{maison}"
  nom = scrap.css("h1").children.text
  stats = scrap.css("#single-ad-description > div > p")
  surface = stats[0].text
  ville = stats[1].text
  prix = stats[2].text
  classe_nrg = stats[3].text
  annee = stats[4].text
  
  descr = scrap.css("#single-ad-description > p")
  description = descr .children[0].text

  sanitized_data =
    MaisonSanitizer.new(
      lien: lien,
      nom: nom,
      ville: ville,
      surface: surface,
      prix: prix,
      classe_nrg: classe_nrg,
      annee: annee
    ).to_h

    p sanitized_data

    db.execute("INSERT OR IGNORE INTO house VALUES(:lien, :nom, :ville, :surface, :prix, :classe_nrg, :annee)", sanitized_data)
end



#db.execute("INSERT OR IGNORE INTO house VALUES(:id ,:nom, :ville, :surface, :prix, :classe_nrg, :annee", sanitized_data)


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
