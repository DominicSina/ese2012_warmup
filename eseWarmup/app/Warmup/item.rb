#Dominic Sina 11-111-507
module Warmup

  class Item
    # generate getter and setter for name and grades
    attr_accessor :name, :price, :status, :owner

    # factory method (constructor) on the class
    # @param name[String], price[int], owner[User]
    def self.create(name, price, owner)
      item = self.new
      item.name = name
      item.price = price
      item.owner = owner
      item
    end

    # initialize is called automatically
    # when an instance is created
    def initialize
      self.status = 'inactive'
    end

    #Checks if this item can be bought with
    #this amount of credits to spend
    def enough_money?(maxAmount)
      self.price<=maxAmount
    end

    def to_s
      "#{self.name} #{self.price}$"
    end
  end

end