# Tyrion [![Build Status](http://travis-ci.org/razielgn/tyrion.png)](http://travis-ci.org/razielgn/tyrion)

A small JSON ODM.

## Goal

Tyrion's goal is to provide a fast (as in _easy to setup_) and dirty unstructured document store.

## Usage

Tyrion uses a folder to store JSON files.  
Each file is an array of homogeneous documents (much like collections).

``` ruby
  Tyrion::Connection.path = "/a/folder"

  class Post
    include Tyrion::Document
  
    field :title
    field :body
  end
  
  post = Post.create! :title => "Hello", :body => "Hi there, ..."
  
  post.find_by_title "Hello"
  post.find_by_body /^Hi there/i
```