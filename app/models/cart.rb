class Cart 
    attr_reader :contents

     def initialize(initial_contents)
        @contents = initial_contents || {}
     end

     def empty?
        self.grand_total == 0
     end

     def items
        contents.select { |_, quantity| quantity > 0 }.map do |id, quantity|
            LineItem.new(id, quantity)
        end
     end

     def remove_item(item_id)
        contents[item_id.to_s] = 0 
     end

     def add_item(item_id)
        contents[item_id.to_s] ||= 0 
        contents[item_id.to_s] += 1
     end 

     def can_increment_item?(item_id)
        item = Item.find(item_id)
        new_quantity = contents[item_id.to_s] + 1
        item.inventory >= new_quantity
     end

     def increment_item(item_id)
        contents[item_id.to_s] += 1
     end

     def decrement_item(item_id)
        contents[item_id.to_s] -= 1
     end

     def count_all 
        contents.values.sum
     end 

     def count_of(item_id)
        contents[item_id.to_s]
     end 

     def grand_total
        items.sum do |item|
            item.subtotal
        end
     end
end 