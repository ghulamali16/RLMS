require_relative '../library'
require_relative '../book'
require_relative '../author'

RSpec.describe Library do
  let(:library) { Library.new }

  describe '#initialize' do
    it 'creates a new library instance' do
      expect(library).to be_a(Library)
    end

    it 'initializes books, authors, and borrowed_books arrays' do
      expect(library.books).to eq([])
      expect(library.authors).to eq([])
      expect(library.borrowed_books).to eq([])
    end

    it 'does not raise errors for valid configuration' do
      expect { library }.not_to raise_error
    end
  end

  describe '#add_book' do
    it 'adds a book to the library' do
      author = Author.new('John Doe')
      book = Book.new('Sample Book', author, '123-456-789')

      library.add_book(book)

      expect(library.books).to include(book)
      expect(library.authors).to include(author)
    end
  end

  describe '#search_by_author' do
    it 'returns books by a specific author' do
      author = Author.new('John Doe')
      book1 = Book.new('Sample Book 1', author, '123-456-789')
      book2 = Book.new('Sample Book 2', author, '987-654-321')

      library.add_book(book1)
      library.add_book(book2)

      result = library.search_by_author('John Doe')

      expect(result).to include(book1, book2)
    end
  end

  describe '#search_by_title' do
    it 'returns books with a specific title' do
      author1 = Author.new('John Doe')
      author2 = Author.new('Jane Doe')
      book1 = Book.new('Sample Book 1', author1, '123-456-789')
      book2 = Book.new('Sample Book 2', author2, '987-654-321')

      library.add_book(book1)
      library.add_book(book2)

      result = library.search_by_title('Sample Book')

      expect(result).to include(book1, book2)
    end
  end

  describe '#checkout_book' do
    it 'checks out a book successfully' do
      author = Author.new('John Doe')
      book = Book.new('Sample Book', author, '123-456-789')

      library.add_book(book)

      result = library.checkout_book('123-456-789')

      expect(library.borrowed_books).to include(book)
    end
  end

  describe '#return_book' do
    it 'returns a checked-out book successfully' do
      author = Author.new('John Doe')
      book = Book.new('Sample Book', author, '123-456-789')

      library.add_book(book)
      library.checkout_book('123-456-789')

      result = library.return_book('123-456-789')

      expect(result).to eq("Book 'Sample Book' returned successfully")
      expect(library.borrowed_books).to be_empty
    end
  end

  describe '#display_catalog' do
    it 'displays the library catalog' do
      author1 = Author.new('John Doe')
      author2 = Author.new('Jane Doe')
      book1 = Book.new('Sample Book 1', author1, '123-456-789')
      book2 = Book.new('Sample Book 2', author2, '987-654-321')

      library.add_book(book1)
      library.add_book(book2)

      result = library.display_catalog

      expect(result).to include(
        { title: 'Sample Book 1', author: 'John Doe', isbn: '123-456-789', available: true },
        { title: 'Sample Book 2', author: 'Jane Doe', isbn: '987-654-321', available: true }
      )
    end
  end
end
