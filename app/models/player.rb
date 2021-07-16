class Player < ApplicationRecord

    @@first_names = ["Super", "Ultra", "omni", "Bati", "Mega", "Aqua"]
    @@middle_names = ["Chayote", "Champiñon", "Tomate", "Colifor", "Rabano"]
    @@last_names = ["Vengador", "Nocturno", "de las sombras", "Tronador", "Indestructible"]

    before_create :init_members

    def init_members
        self.name = [@@first_names[rand(0..5)] , @@middle_names[rand(0..4)] , @@last_names[rand(0..4)]].join(" ")
        self.health =  rand(25..75)
        self.power = rand(25..75)
    end      

    def woot
        if self.power+10 > 100
            self.power = 100
        else
            self.power += 10
        end
    end

    def blam
        if self.health-10 < 0
            self.health = 0
        else
            self.health -= 10
        end
    end

    def dead?
        self.health <= 0
    end

    def status
        if self.health <= 0 
            return "DEAD"
        end
        if self.power >= 100
            return "MAXED OUT"
        end
        "NORMAL"
    end

    def color
        if self.health <= 0 
            return "red"
        end
        if self.power >= 100
            return "blue"
        end
        "green"
    end

end
