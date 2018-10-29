class Cart 
    attr_reader :contents

     def initialize(initial_contents)
        @contents = initial_contents || {}
     end

     def empty?
        @contents.empty?
     end

     def items
        contents.map do |id, quantity|
            LineItem.new(id, quantity)
        end
     end

     def add_item(item_id)
        contents[item_id.to_s] ||= 0 
        contents[item_id.to_s] += 1
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