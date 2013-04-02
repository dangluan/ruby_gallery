# Introduction

# Usage

## Setup

   * ``bundle``
   * ``rails g ruby_gallery:install``
   * ``rails g ruby_gallery MODEL``
  

      EX:

  ``rails g ruby_gallery user``
         
         
   * ``rake db:migrate``
   
   
## Add upload form for view 
  
    <%= show_gallery_images :MODEL %>
       EX: 
         
         <%= show_gallery_images :users %> (note: model is plural)
         
## You can reorder images in box (default you can reorderable)
        You can set it to false 
         <%= show_gallery_images :users, {reorder: false} %>

## You can disable ``close link``
        
        <%= show_gallery_images :users, {reorder: false , close: false }