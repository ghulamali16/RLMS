require_relative '../book'
require_relative '../author'

RSpec.describe Book do
  let(:author) { Author.new('John Doe') }

  describe '#initialize' do
    context 'with valid parameters' do
      it 'creates a new book with the given title, author, and ISBN' do
        book = Book.new('Sample Book', author, '123-456-789')
        expect(book.title).to eq('Sample Book')
        expect(book.author).to eq(author)
        expect(book.isbn).to eq('123-456-789')
      end
    end

    context 'with invalid parameters' do
      it 'raises an ArgumentError if title is blank' do
        expect { Book.new('', author, '123-456-789') }.to raise_error(ArgumentError, 'Title cannot be blank')
      end

      it 'raises an ArgumentError if ISBN is blank' do
        expect { Book.new('Sample Book', author, '') }.to raise_error(ArgumentError, 'ISBN cannot be blank')
      end

      it 'raises an ArgumentError if title is nil' do
        expect { Book.new(nil, author, '123-456-789') }.to raise_error(ArgumentError, 'Title cannot be blank')
      end

      it 'raises an ArgumentError if ISBN is nil' do
        expect { Book.new('Sample Book', author, nil) }.to raise_error(ArgumentError, 'ISBN cannot be blank')
      end
    end
  end

  describe '#available?' do
    it 'returns true if the book is available' do
      book = Book.new('Sample Book', author, '123-456-789')
      expect(book.available?).to be(true)
    end

    it 'returns false if the book is checked out' do
      book = Book.new('Sample Book', author, '123-456-789')
      book.checkout
      expect(book.available?).to be(false)
    end
  end

  describe '#checkout' do
    it 'sets checked_out to true' do
      book = Book.new('Sample Book', author, '123-456-789')
      book.checkout
      expect(book.checked_out).to be(true)
    end
  end

  describe '#return_book' do
    it 'sets checked_out to false' do
      book = Book.new('Sample Book', author, '123-456-789')
      book.checkout
      book.return_book
      expect(book.checked_out).to be(false)
    end
  end
end
