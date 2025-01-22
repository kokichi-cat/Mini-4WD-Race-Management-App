module ApplicationHelper
  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def page_title(title = "")
    base_title = "MINI4NOTE"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def assign_meta_tags(options = {})
    defaults = t("meta_tags.defaults")
    options.reverse_merge!(defaults)
    site = options[:site] || "MINI4NOTE"
    title = options[:title].presence || site
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url("placeholder.png")
    configs = {
      separator: "|",
      reverse: true,
      site:,
      title:,
      description:,
      keywords:,
      canonical: request.original_url,
      icon: {
        href: image_url("favicon.ico")
      },
      og: {
        type: "website",
        title: "#{title} | #{site}",
        description:,
        url: request.original_url,
        image:,
        site_name: site
      },
      twitter: {
        site:,
        card: "summary_large_image",
        image:
      }
    }
    set_meta_tags(configs)

    puts "options[:title]: #{options[:title].inspect}"
    puts "title before assignment: #{title}"
  end
end
