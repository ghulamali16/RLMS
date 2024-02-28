require_relative '../author'

RSpec.describe Author do
  describe '#initialize' do
    context 'with a valid name' do
      it 'creates a new author with the given name' do
        author = Author.new('John Doe')
        expect(author.name).to eq('John Doe')
      end
    end

    context 'with an invalid name' do
      it 'raises an ArgumentError if name is blank' do
        expect { Author.new('') }.to raise_error(ArgumentError, 'Author name cannot be blank')
      end

      it 'raises an ArgumentError if name is nil' do
        expect { Author.new(nil) }.to raise_error(ArgumentError, 'Author name cannot be blank')
      end

      it 'raises an ArgumentError if name contains only spaces' do
        expect { Author.new('    ') }.to raise_error(ArgumentError, 'Author name cannot be blank')
      end
    end
  end
end
