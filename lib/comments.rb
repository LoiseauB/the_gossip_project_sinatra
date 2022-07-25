class Comments
  attr_accessor :content, :id, :author

  def initialize(comment, id)
    @content = comment
    @id = id
  end

  def save
    require 'csv'
    CSV.open("db/comments.csv","ab") do |csv|
      csv << [@content, @id]
    end
  end

  def self.all(id)
    require 'csv'
    all_gossip = []
    CSV.read("db/comments.csv").each do |csv_lign|
      if csv_lign[1].include?(id)
        all_gossip << Comments.new(csv_lign[0],csv_lign[1])
      end
    end
    return all_gossip
  end

  def self.find(id)
    all_comments = Comments.all
    return all_comments[id]
  end
end