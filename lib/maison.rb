class Maison

def self.db
    @db ||= SQLite3::Database.new("./boardimo.db")
    @db.results_as_hash = true
    @db
end

def self.add_maison(sanitized_data)
    db.execute("INSERT OR IGNORE INTO house VALUES(:lien, :nom, :ville, :surface, :prix, :classe_nrg, :annee)", sanitized_data)
end
  
def self.all
    db.execute("SELECT * FROM house")
end

def self.find_by_url(params)
    maison = db.execute("SELECT * FROM house WHERE url='#{params}' LIMIT 1")
end


attr_reader :lien, :nom, :ville, :surface, :prix, :classe_nrg, :annee

def initialize(lien:, nom:, ville:, surface:, prix:, classe_nrg:, annee:)
    @lien = lien
    @nom = nom
    @ville = ville
    @surface = surface
    @prix = prix
    @classe_nrg = classe_nrg
    @annee = annee
end


end
