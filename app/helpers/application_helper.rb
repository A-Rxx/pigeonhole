module ApplicationHelper

  def focus_on(id)
    update_page_tag { |page| page[id].focus }
  end
  
  def random_tape_image
    images = Dir[(Rails.root.join('public', 'images', 'tapes', '*'))]
    image_tag('tapes/' + File.basename(images[rand(images.size)]), :height => 95)
  end

  def random_binary_image
    images = Dir[(Rails.root.join('public', 'images', 'binaries', '*'))]
    image_tag('binaries/' + File.basename(images[rand(images.size)]), :height => 86)
  end

  def random_face_image
    images = Dir[(Rails.root.join('public', 'images', 'faces', '*'))]
    image_tag('faces/' + File.basename(images[rand(images.size)]), :height => 54)
  end
  
  def menu_link
    link_to image_tag('menu.png', :height => 50), root_url
  end
  
  def info_block
    "<div id='info'>
      <strong>#{t('.info_headline')}</strong><br/>
      #{t('.info')}
    </div>".html_safe
  end

end
