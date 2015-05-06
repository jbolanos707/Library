require('rspec')
require('pg')
require('book')
require('author')
require('inventory')
require('pry')


DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM inventory *;")
  end
end
