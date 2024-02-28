class Book
  attr_accessor :title, :author, :isbn, :checked_out

  def initialize(title, author, isbn)
    validate_presence(title, 'Title')
    validate_presence(isbn, 'ISBN')
    @title = title
    @author = author
    @isbn = isbn
    @checked_out = false
  end

  def available?
    !@checked_out
  end

  def checkout
    @checked_out = true
  end

  def return_book
    @checked_out = false
  end

  private

  def validate_presence(value, field)
    raise ArgumentError, "#{field} cannot be blank" if value.nil? || value.to_s.strip.empty?
  end
end
