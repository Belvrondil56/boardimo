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
        @data[:ville]
    end

    def surface
        if @data[:surface].to_s.include?("m²")
          @data[:surface] = @data[:surface].split("m²").first.tr(' ','').to_i
        end

        @data[:surface] = @data[:surface].to_s.tr(" ","").to_i

        @data[:surface]
    end

    def prix
        if @data[:prix].to_s.include?("€")
          @data[:prix] = @data[:prix].split("€").first.tr(' ','').to_i
        end

        @data[:prix] = @data[:prix].to_s.tr(" ","").to_i

        @data[:prix]
    end

    def classe_nrg
        @data[:classe_nrg]
    end


    def annee
        @data[:annee]
    end

    

    

end