class MaisonSerializer

    def to_h
        maison_propre
        @data
    end



    def initialize(maison:)
        @data = maison
    end

end