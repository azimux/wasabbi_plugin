class Wasabbi
  class Page
    attr_accessor :items, :page, :items_per_page, :total_items

    def total_pages
      ([total_items - 1, 0].max / items_per_page) + 1
    end

    def initialize items, total_items, page, items_per_page = 20
      self.total_items = total_items.to_i
      self.items = items
      self.page = page.to_i
      self.items_per_page = items_per_page.to_i
    end

    def method_missing name, *args, &block
      items.send(name, *args, &block)
    end
  end
end