require_relative './book'

class BookRepository
  def all
    sql = 'SELECT id, title, author_name FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])

    books = []

    result_set.each do |record|
      book = Book.new

      book.id = record["id"]
      book.title = record["title"]
      book.author_name = record["author_name"]

      books.push(book)
    end

    return books
  end
end