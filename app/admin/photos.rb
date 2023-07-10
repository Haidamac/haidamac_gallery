ActiveAdmin.register Photo do

  permit_params :title, :description, :gallery_id, :image
  includes :gallery
  includes image_attachment: :blob
  
  index do
    selectable_column
    id_column 
    column :image do |photo|
      if photo.image.attached?
        image_tag photo.image.variant(resize: '100x100')
      else
        content_tag(:span, "No Image Attached")
      end
    end
    column :title
    column :description
    column :gallery
    actions
  end
  
  form do |f|
    f.inputs do
      f.input :gallery
      f.input :title
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end
end
