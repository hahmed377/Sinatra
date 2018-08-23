class PostController < Sinatra::Base
# Sets the root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

# sets the view directory correctly
  set :views, Proc.new { File.join(root, 'Views')}




configure :development do
  register Sinatra::Reloader
end


  $posts = [{
    id:0,
    title: "post 0",
    post_body: "this is the first post"
    },
    {
      id:1,
      title: "post 1",
      post_body: "this is the second post"
    },
      {
        id:2,
        title: "post 2",
        post_body: "this is the third post"
      },
      {
        id:3,
        title: "post 3",
        post_body: "this is the fourth post"
        }
      ]


  get "/" do
    @title = "Blog posts"
    @posts = $posts
    erb :'posts/index'
  end

  get "/new" do
    @title = "New"
    @post = {
      id: "",
      title: "",
      post_body: ""
    }
    erb :'posts/new'


  end

  # this will display a specific movies by calling a specific id number.
  get "/:id" do
    id = params[:id].to_i
    @post = $posts[id]

    erb :'posts/show'
  end

  post "/" do
    new_posts = {
      id: $posts.length,
      title: params[:title],
      post_body: params[:post_body]
    }
    $posts.push(new_posts)
    redirect "/"
  end

  put "/:id" do
    id = params[:id].to_i
    post = $posts[id]
    post[:title] = params[:title]
    post[:post_body] = params[:post_body]
    $posts[id] = post

    redirect "/"

  end

  delete "/:id" do
    id = params[:id].to_i
    $posts.delete_at(id)
    redirect "/"
  end

  get "/:id/edit" do
    @title = "Edit"
    id = params[:id].to_i
    @post = $posts[id]
    erb :'posts/edit'

  end






end
