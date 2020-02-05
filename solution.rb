require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/solution.db")

class Counter
  include DataMapper::Resource
  property :count, Numeric  
  property :id, Serial
end

DataMapper.finalize.auto_upgrade!

get '/' do
@counter= Counter.first_or_create({},{:count=>0,:id=>1})
erb :index
end

post '/' do
	counter=Counter.get(1)
	count=0
	count=counter.count.to_i unless counter.nil?
	count+=1
	counter.update({:count=>count}) unless counter.nil?
	counter.save unless counter.nil?
	@counter=counter
	erb :index
end