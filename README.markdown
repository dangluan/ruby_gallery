# Introduction

# Usage

## Setup
   * ``gem "ruby_gallery", git: "git@github.com:dangluan/ruby_gallery.git", tag: "v0.2.4"`` in your gemfile
   * ``bundle``
   * ``rails g ruby_gallery:install``
   * ``rails g ruby_gallery MODEL``
  

      EX:

  ``rails g ruby_gallery user``
         
         
   * ``rake db:migrate``
   
   
## Add upload form for view 
  
    <%= show_gallery_images :OBJECT %>
       EX: 
         
         <%= show_gallery_images @user %>
         
## You can reorder images in box (default you can reorderable)
        You can set it to false 
         <%= show_gallery_images @user, {reorder: false} %>

## You can disable ``close link``
        
        <%= show_gallery_images @user, {reorder: false , close: false }
