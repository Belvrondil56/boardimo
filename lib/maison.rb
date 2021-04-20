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

def self.find_by_url(lien)
    maison = db.execute("SELECT nom, ville, surface, prix, classe_nrg, annee FROM house WHERE url='#{lien}' LIMIT 1").first

    self.new(nom: maison["nom"], ville: maison["ville"], surface: maison["surface"], prix: maison["prix"], classe_nrg: maison["classe_nrg"], annee: maison["annee"])

end


end
