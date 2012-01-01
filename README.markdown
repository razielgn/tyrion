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
It supports validations from ActiveModel::Validations.

``` ruby
  class Post
    include Tyrion::Document
  
    field :title
    field :body
    field :rank
    
    validates_presence_of :title, :body, :rank
  end
```

### Persistence
#### Save
``` ruby
  post = Post.new :title => "Hello", :body => "Hi there, ..."
  post.save
```
``` ruby
  Post.create :title => "Hello", :body => "Hi there, ..."
```

#### Delete
``` ruby
  post = Post.create :title => "Hello", :body => "Hi there, ..."
  post.delete
```
``` ruby
  Post.delete_all
```

### Querying
Chainable querying is allowed.  
First called is first executed and an enumerable is returned.

`where`: all matching documents

``` ruby
  Post.where :title => 'Hello', :rank => 3
```

`limit`: limits returned documents

``` ruby
  Post.limit(5)
```

`skip`: offsets returned documents

``` ruby
  Post.skip(5)
```

`asc`: sorts ascendingly according to passed keys

``` ruby
  Post.asc(:rank, :title)
```

`desc`: sorts discendingly according to passed keys

``` ruby
  Post.desc(:rank, :title)
```

#### Fancy chains
``` ruby
  Post.where(:rank => 5).desc(:title, :body).skip(5).limit(5)
```
And since it delegates to an enumerable...

``` ruby
  Post.where(:rank => 5).count
  Post.where(:rank => 10).each{ |doc| ... }
```

## ToDos

* Modifiers on criterias (delete, update, ...)
* Default values for attributes
* Embedded documents
* Keys (_id?)