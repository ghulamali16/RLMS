# Library Management System

## Overview

This command-line library management system is designed to manage a collection of books and authors. It provides features such as adding books, searching for books by title or author, checking out and returning books, and displaying the library catalog.

## Project Structure

- `main.rb`: The main entry point for the application.
- `author.rb`: Defines the Author class.
- `book.rb`: Defines the Book class.
- `library.rb`: Defines the Library class, including functionality for book management.

## Features

### Data Generation

- Automatically generates a list of books and authors.

### Object-Oriented Design

- Implements classes such as Book, Author, and Library.

### Configuration

- Externalizes library settings (e.g., opening hours, maximum borrow limit) in a YAML file (`library_config.yml`).

### User Interactions

- Enables user interactions like searching for a book, checking out, and returning books.

### Output

- Provides functionality to display the library catalog in JSON format on the command line.

### Validation and Safety Checks

- Performs safety checks on the YAML configuration file, ensuring that the max borrow limit and opening hours are provided and in the correct format.

### Interactivity

- Handles max borrow limit and opening hours to prevent exceeding limits and borrowing during closed hours.

## Getting Started

1. Clone the repository.
2. Execute `ruby main.rb` to start the library management system.

## Configuration

- Modify the `library_config.yml` file to customize library settings such as opening hours and the maximum borrow limit.

## Dependency
- `Rspec`
