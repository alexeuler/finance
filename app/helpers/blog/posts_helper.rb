module Blog::PostsHelper
  def blog_post_link(post)
    if post.slug and not post.slug.empty?
      "#{blog_root_path}/#{post.slug}"
    else
      blog_post_path(post)
    end
  end
end
