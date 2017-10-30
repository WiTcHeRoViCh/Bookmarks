module ApplicationHelper

	def link_label_without_protocol(url)
		url_without_protocol = url.remove(/^https?:\/\//, "")

		link = content_tag(:a, url_without_protocol, href: "#{url}")
		return link
	end

  def show_image(img)

    if img.file.nil?
      html_img = image_tag(img, class: "bookmark_image_link default_img")
    else
      html_img = image_tag(img, class: "bookmark_image_link")
    end

    return html_img
  end

end
