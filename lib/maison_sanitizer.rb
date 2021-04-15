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
        if @data[:surface].to_s.include?("m²")
          @data[:surface] = @data[:surface].split("m²").first.tr(' ','').to_i
        elsif @data[:surface].to_s.include?("m2")
            @data[:surface] = @data[:surface].split("m2").first.tr(' ','').to_i
        end

        @data[:surface] = @data[:surface].to_s.tr(" ","").delete("^0-9").to_i

        @data[:surface]
    end

    def prix

        @data[:prix] = @data[:prix].to_s.tr(" ","").delete("^0-9").to_i

        @data[:prix]
    end

    def classe_nrg

        @data[:classe_nrg] = @data[:classe_nrg].tr('Classe énergie :','').scan(/A|B|C|D|E|F|G/).first if @data[:classe_nrg].include?("Classe")

        @data[:classe_nrg]

    end


    def annee
        @data[:annee] = @data[:annee].delete("^0-9").to_i
    end

    

    

end