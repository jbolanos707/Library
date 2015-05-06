class Book
  attr_reader(:title, :id)
  define_method(:initialize) do |info|
    @title = info.fetch(:title)
    @id = info.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      id = book.fetch("id").to_i()
      books.push(Book.new(title: title, id: id))
    end
    books
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  define_method(:==) do |other_book|
    self.title == other_book.title && self.id == other_book.id
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM books WHERE id = #{@id};")
    @title = result.first.fetch("title")
    Book.new(title: @title, id: @id)
  end
end
