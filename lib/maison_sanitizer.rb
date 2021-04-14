class maison_sanitizer


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
      description
      ville
      surface
      prix
      classe_nrg
      annee
    end


    def annee
        @data[:annee] = @data[:annee].to_i

        @data[:annee]
    end

    def prix
        if @data[:prix].to_s.include("€")
          data[:prix] = @data[:prix].split("€").first.tr(' ','').to_i
        end

        @data[:prix] = @data[:prix].to_s.tr(" ","").to_i

        @data[:prix]
    end

    def surface
        if @data[:surface].to_s.include("m²")
          data[:surface] = @data[:surface].split("m²").first.tr(' ','').to_i
        end

        @data[:surface] = @data[:surface].to_s.tr(" ","").to_i

        @data[:surface]
    end