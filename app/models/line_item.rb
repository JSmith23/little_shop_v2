class LineItem
    attr_reader :item_id, :quantity
    
    def initialize(item_id, quantity)
        @item_id = item_id
        @quantity = quantity
    end

    def name 
        item.name
    end

    def thumbnail
        item.thumbnail
    end

    def merchant_name
        item.user.name
    end

    def price
        item.price
    end

    def subtotal
        price * quantity
    end

    private

    def item
        @item ||= Item.find(item_id)
    end
end
