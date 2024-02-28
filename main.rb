# main.rb

require_relative 'author'
require_relative 'book'
require_relative 'library'
require 'json'
require 'yaml'

# Loading YML Config here
begin
  config = YAML.load_file('library_config.yml')

  # Validating the config
  unless config.is_a?(Hash) && config['max_borrow_limit'].is_a?(Integer) && config['opening_hours'].is_a?(String)
    puts 'Error: Invalid configuration. Please check max borrow limit and opening hours in library_config.yml.'
    exit
  end

  # Create instances
  author1 = Author.new('Ellard')
  author2 = Author.new('Marc')

  book1 = Book.new('Rock Book', author1, '123-456-789')
  book2 = Book.new('Paper Book', author2, '987-654-321')
  book3 = Book.new('Scissors Book', author2, '111-222-333')


  library = Library.new
  library.add_book(book1)
  library.add_book(book2)
  library.add_book(book3)

 #CLI Menu
  loop do
    puts "\nLibrary Menu:"
    puts "1. Add a Book"
    puts "2. Search for a Book"
    puts "3. Borrow a Book"
    puts "4. Display Catalog"
    puts "5. Return Book"
    puts "6. Exit"


    choice = gets.chomp.to_i

    case choice
    when 1
      # User Interaction: Add a Book
      puts "Enter Book Title:"
      title = gets.chomp
      puts "Enter Author Name:"
      author_name = gets.chomp
      puts "Enter ISBN:"
      isbn = gets.chomp

      author = Author.new(author_name)
      new_book = Book.new(title, author, isbn)
      library.add_book(new_book)

      puts "Book '#{new_book.title}' added successfully."

    when 2
      # User Interaction: Search for a Book
      puts "Enter Search Keyword (Title or Author):"
      search_query = gets.chomp.downcase

      search_result = library.search_by_title(search_query) + library.search_by_author(search_query)
      if search_result.empty?
        puts "No matching books found."
      else
        puts "Matching Books:"
        search_result.uniq.each { |book| puts " - #{book.title} by #{book.author.name}" }
      end

    when 3
      # User Interaction: Borrow a Book
      puts "Enter ISBN of the Book to Borrow:"
      isbn_to_borrow = gets.chomp

      result = library.checkout_book(isbn_to_borrow)
      puts result

    when 4
      # User Interaction: Display Catalog
      puts JSON.pretty_generate(library.display_catalog)

    when 5
      # User Interaction: Return a Book
      puts "Enter ISBN of the Book to Return:"
      isbn_to_return = gets.chomp

      result = library.return_book(isbn_to_return)
      puts result
    when 6
      # User Interaction: Exit
      break

    else
      puts "Invalid choice. Please enter a number between 1 and 5."
    end
  end

rescue StandardError => e
  puts "Error: #{e.message}"
end
