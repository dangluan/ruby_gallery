# Introduction

# Usage

## Setup

   * bundle
   * rails g ruby_gallery:install
   * rails g ruby_gallery MODEL
      EX:
         rails g ruby_gallery users (note : model is plural)
         
         
   * rake db:migrate
   
   
## Add upload form for view 
  
    <%= show_gallery_images :MODEL %>
       EX: 
         
         <%= show_gallery_images :users %> (note: model is plural)
         
## You can reorder images in box (default you can reorderable)
        You can set it to false 
         <%= show_gallery_images :users, {reorder: false} %>