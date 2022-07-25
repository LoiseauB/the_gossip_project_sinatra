class Gossip
  attr_accessor :author, :content, :comments
  
  def initialize(user_name, content)
   @author = user_name
   @content = content
   @comments =["first"]
  end

  def save
    require 'csv'
    CSV.open("db/gossip.csv","ab") do |csv|
      csv << [@author, @content, @comments]
    end
  end

  def self.all
    require 'csv'
    all_gossip = []
    CSV.read("db/gossip.csv").each do |csv_lign|
      all_gossip << Gossip.new(csv_lign[0],csv_lign[1])
    end
    return all_gossip
  end

  def self.find(id)
    all_gossip = Gossip.all
    return all_gossip[id]
  end

  def self.update(id, author, content)
    all_gossip = Gossip.all
    all_gossip.delete_at(id)
    all_gossip.insert(id, Gossip.new(author,content,[]))
    CSV.open("db/gossip.csv","w") do |gossip|
      all_gossip.each do |potin|
        gossip << [potin.author, potin.content]
      end
    end
  end

  def comment(comment,id)
    
    #puts comment
    all_gossip = Gossip.all
    all_gossip[id].comments << comment
    puts all_gossip[id].comments
    puts
    #all_gossip.delete_at(id)
    #all_gossip.insert(id, Gossip.new(@author,@content,@comments))
    CSV.open("db/gossip.csv","w") do |gossip|
      all_gossip.each do |potin|
        puts potin.comments
        puts
        gossip << [potin.author, potin.content, potin.comments]
      end
    end
  end

end