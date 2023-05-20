ActiveAdmin.register Photo do

  permit_params :title, :description, :gallery_id, :image
  includes :gallery
  includes image_attachment: :blob
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
