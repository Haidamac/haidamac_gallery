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

  show do
    attributes_table do
      row :image do |photo|
        if photo.image.attached?
          image_tag photo.image.variant(:main)
        else
          content_tag(:span, "No Image Attached")
        end
      end
      row :title
      row :description
      row :gallery
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    div class: 'current-image' do
      if f.object.image.present?
        image_tag(f.object.image.variant(:thumb))
      else
        content_tag(:span, 'No image yet')
      end
    end
    f.inputs do
      f.input :gallery
      f.input :title
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end
end
