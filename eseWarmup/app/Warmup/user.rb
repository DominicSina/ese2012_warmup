#Dominic Sina 11-111-507
module Warmup

  class User
    # generate getter and setter for name and grades
    attr_accessor :name, :credits, :items

    # factory method (constructor) on the class
    #@param name[String]
    def self.named( name )
      user = self.new
      user.name = name
      user
    end

    # initialize is called automatically
    # when an instance is created
    def initialize
      self.credits = 100
      self.items = Array.new
    end

    #Creates an item and adds it
    #to the item array of this user
    #@param name[String], price[int]
    def add_item(name, price)
      items.push(Item.create(name,price,self))
    end

    #Activates an item of this user
    #@param name[String]
    def activate_item(name)
      toActivate=get_item(name)
      toActivate.status='active'
    end

    #Searches item in the items of another
    #user and checks several things
    #@param name[String], owner[User]
    def buy_item(name, owner)
      wanted = owner.get_item(name)
      if wanted!= nil && wanted.enough_money?(self.credits) && wanted.status=='active' && owner != self
          transfer_item(wanted, self, owner)
      end
    end

    #Actual transfer of item and money
    #@param item[Item], buyer[User], owner[User]
    def transfer_item(item, buyer, owner)
      buyer.alter_credits(-item.price)
      owner.alter_credits(item.price)
      item.status='inactive'
      item.owner=buyer
      buyer.items.push(item)
      owner.items.delete_if { |x| x==item }
    end

    #Searches item by name in item list of this user
    #@param name[String]
    def get_item(name)
      wanted = nil
      for i in items
        if i.name==name
          wanted=i
        end
      end
      wanted
    end

    #Alters credits of this user by amount
    #@param amount [int]
    def alter_credits(amount)
      self.credits=self.credits+amount
    end



    #Lists only active items of this user
    def list_active_items
      output=""
      for i in items
        if i.status=='active'
          output=output + i.to_s + "\n"
        end
      end
      output
    end

    #Lists all items of this user
    def list_all_items
      output=""
      for i in items
          output=output + i.to_s + "\n"
      end
      output
    end

  end
end
