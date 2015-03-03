module Sitemap
  @@host="http://iopenbiznes.ru/"
  @@res=""
  @@level=0
  @@home_page_date=Date.new 2015, 3, 1
  @@about_page_date=Date.new 2015, 3, 1

  def self.generate
    add_header
    urlset(' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:mobile="http://www.google.com/schemas/sitemap-mobile/1.0" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"') do
      add_home
      add_blog 'ru'
      add_blog 'en'
    end
    File.open("#{Rails.root}/public/sitemap.xml", 'w') { |file| file.write(Sitemap.res) }
  end

  def self.res
    @@res
  end

  def self.add(str)
    @@res << Array.new(@@level*2, " ").join << str << "\n"
  end

  def self.add_header
    self.add '<?xml version="1.0" encoding="UTF-8"?>'
  end

  def self.add_url(path, options={})
    Sitemap::url do
      Sitemap::loc do
        self.add @@host+path
      end
      if options[:image]
        image_data=options.delete(:image)
        Sitemap.send('image:image') do
          Sitemap.send('image:loc') do
            self.add @@host[0..-2]+'/paperclip/images/original/'+image_data[:url]
          end
          Sitemap.send('image:title') do
            self.add image_data[:title]
          end
        end
      end
      options.each do |key, value|
        Sitemap.send(key) do
          self.add value
        end
      end
    end
  end

  def self.add_home
    Sitemap.add_url "",
                    lastmod: Blog::Post.maximum(:updated_at).strftime("%Y-%m-%d"),
                    changefreq: "weekly",
                    priority: '0.8'
  end

  def self.add_about(locale)
    Sitemap.add_url "#{locale}/about/",
                    lastmod: Blog::Post.maximum(:updated_at).strftime("%Y-%m-%d"),
                    changefreq: "weekly",
                    priority: '0.6'
  end


  def self.add_blog(locale)
    blog_path="#{locale}/blog/"
    posts_path="#{blog_path}posts/"
    posts=Blog::Post.where(language: locale, status:'published').to_a
    if posts.count > 0
      add_url posts_path,
              lastmod: posts.map(&:updated_at).max.strftime("%Y-%m-%d"),
              changefreq: 'daily',
              priority: '1.0'


      posts.each do |post|
        slug = if post.slug.empty?
                 posts_path + post.id.to_s
               else
                 blog_path + post.slug
               end
        add_url slug,
                lastmod: post.updated_at.strftime("%Y-%m-%d"),
                changefreq: 'monthly',
                image: {url: post.image, title:post.title}
      end
    end
  end

  def self.method_missing(method_sym, *arguments, &block)
    self.add "<#{method_sym}#{arguments.join}>"
    @@level=@@level+1
    block.call
    @@level=@@level-1
    self.add "</#{method_sym}>"
  end
end
