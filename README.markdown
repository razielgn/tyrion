# Tyrion [![Build Status](http://travis-ci.org/razielgn/tyrion.png)](http://travis-ci.org/razielgn/tyrion)

A small JSON ODM.

## Goal

Tyrion's goal is to provide a fast (as in _easy to setup_) and dirty unstructured document store.

## Usage
### Connection
Tyrion uses a folder to store JSON files, one for each Tyrion document defined.
Each file is an array of homogeneous documents (much like collections).

``` ruby
  Tyrion::Connection.path = "/a/folder"
```

### Document
``` ruby
  class Post
    include Tyrion::Document
  
    field :title
    field :body
    field :rank
  end
```

### Persistence
#### Save
``` ruby
  post = Post.create :title => "Hello", :body => "Hi there, ..."
  post.save
```
``` ruby
  # Insta-save with !
  Post.create! :title => "Hello", :body => "Hi there, ..."
```

#### Delete
``` ruby
  post = Post.create :title => "Hello", :body => "Hi there, ..."
  post.delete
```
``` ruby
  Post.delete_all # You get the idea
```
``` ruby
  Post.where :title => /^Hello/
```

### Querying
`find_by_attribute`: just the first match

``` ruby
  Post.find_by_title "Hello"
  Post.find_by_body /^Hi there/i
```

`where`: all matching documents

``` ruby
  Post.where :title => /^Hello/, :rank => 3
```