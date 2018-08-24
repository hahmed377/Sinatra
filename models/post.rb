class Post
  # made public so file outside of the class can see it
  attr_accessor(:id, :title, :post_body)

  def self.open_connection
    conn = PG.connect(dbname: "blog")
  end

  def save
    conn = Post.open_connection

    if (!self.id)
      sql = "INSERT INTO post (title, post_body) VALUES ('#{self.title}', '#{self.post_body}')"
    else
      sql = "UPDATE post SET title='#{self.title}', post_body='#{self.post_body}' WHERE id = #{self.id}"

    end


    conn.exec(sql)
  end

  # finds all the different posts
  def self.all
  # create a connection
    conn = self.open_connection

    sql = "Select id, title, post_body FROM post ORDER BY id"

    results = conn.exec(sql)

    posts = results.map do |result|
      self.hydrate(result)
    end
    posts

  end
# find one by the id
  def self.find(id)
    conn = self.open_connection

    sql = "SELECT * FROM post WHERE id = #{id} LIMIT 1"

    posts_result = conn.exec(sql)
    post = self.hydrate(posts_result[0])

  end
# delete one by its id
  def self.destroy(id)

    conn = self.open_connection

    sql = "DELETE FROM post WHERE id=#{id}"

    conn.exec(sql)

  end
  # this will sure the data is in the right format. make sure its added correctly to the db.
  def self.hydrate(post_data)
    post = Post.new

    post.id = post_data["id"]
    post.title = post_data["title"]
    post.post_body = post_data["post_body"]

    post
  end
end
