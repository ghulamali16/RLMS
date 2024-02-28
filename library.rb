require 'yaml'
require 'time'

class Library
  attr_accessor :books, :authors, :borrowed_books

  def initialize
    @books = []
    @authors = []
    @borrowed_books = []
    validate_configuration
  end

  def add_book(book)
    @books << book
    @authors << book.author unless @authors.include?(book.author)
  end

  def search_by_author(author_name)
    @books.select { |book| book.author.name.downcase.include?(author_name.downcase) }
  end

  def search_by_title(title)
    @books.select { |book| book.title.downcase.include?(title.downcase) }
  end

  def checkout_book(isbn)
    book = @books.find { |b| b.isbn == isbn }
    return 'Book not found' unless book

    if book.available?
      if borrow_limit_exceeded?
        "You have reached the maximum borrow limit. Cannot check out '#{book.title}'."
      elsif !within_opening_hours?
        "The library is currently closed. Cannot check out '#{book.title}'."
      else
        book.checkout
        @borrowed_books << book
        "Book '#{book.title}' checked out successfully"
      end
    else
      "Book '#{book.title}' is not available for checkout"
    end
  end

  def return_book(isbn)
    book = @borrowed_books.find { |b| b.isbn == isbn }
    return 'Book not found' unless book

    if book.checked_out
      book.return_book
      @borrowed_books.delete(book)
      "Book '#{book.title}' returned successfully"
    else
      "Book '#{book.title}' is not checked out"
    end
  end

  def display_catalog
    @books.map { |book| { title: book.title, author: book.author.name, isbn: book.isbn, available: book.available? } }
  end

  private

  def borrow_limit_exceeded?
    config['max_borrow_limit'] && @borrowed_books.size >= config['max_borrow_limit']
  end

  def within_opening_hours?
    opening_hours = config['opening_hours']
    return true unless opening_hours

    current_time = Time.now
    opening_time = Time.parse(opening_hours.to_s.split('-').first.strip)
    closing_time = Time.parse(opening_hours.to_s.split('-').last.strip)

    current_time >= opening_time && current_time <= closing_time
  end

  def config
    @config ||= YAML.load_file('library_config.yml')
  end

  def validate_configuration
    validate_max_borrow_limit
    validate_opening_hours_format
  end

  def validate_max_borrow_limit
    max_borrow_limit = config['max_borrow_limit']
    return if max_borrow_limit.nil? || (max_borrow_limit.is_a?(Integer) && max_borrow_limit >= 0)

    raise ArgumentError, 'Invalid max borrow limit in configuration. Must be a positive integer or nil.'
  end

  def validate_opening_hours_format
    opening_hours = config['opening_hours']

    return unless opening_hours.nil?

    raise ArgumentError, 'Invalid opening hours'
  end
end
