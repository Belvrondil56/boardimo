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




  
end
