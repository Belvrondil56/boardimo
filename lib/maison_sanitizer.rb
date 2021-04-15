class MaisonSanitizer


    def initialize(data)
        @data = data
    end
    

    def to_h
        call
        @data
    end

    private

    def call
      lien
      nom
      ville
      surface
      prix
      classe_nrg
      annee
    end

    def lien
        @data[:lien]
    end

    def nom
        @data[:nom]
    end

    def ville
        @data[:ville] = @data[:ville].scan(/Questembert|questembert|séné|Séné|Auray|auray|Vannes|vannes/).first.capitalize

        @data[:ville]
    end

    def surface

        @data[:surface].slice!("m2") if @data[:surface].include?("m2")

        @data[:surface] = @data[:surface].delete("^0-9").to_i
    end

    def prix

        @data[:prix] = @data[:prix].to_s.tr(" ","").delete("^0-9").to_i

        @data[:prix]
    end

    def classe_nrg

        if @data[:classe_nrg].include?("Classe")
            @data[:classe_nrg] = @data[:classe_nrg].split
            @data[:classe_nrg] = @data[:classe_nrg].last
        else 
            @data[:classe_nrg] = @data[:classe_nrg].scan(/[A-G]/).first
        end
        @data[:classe_nrg]

    end


    def annee
        @data[:annee] = @data[:annee].delete("^0-9").to_i
    end

    

    

end