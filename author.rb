class Author
  attr_accessor :name

  def initialize(name)
    validate_name_presence(name)
    @name = name
  end

  private

  def validate_name_presence(name)
    raise ArgumentError, 'Author name cannot be blank' if name.nil? || name.strip.empty?
  end
end
