[Donate to charity: water via Gittip](https://www.gittip.com/nthj/)

obviously
=========

Guess obvious association class names in ActiveRecord.

Makes using namespaced model names, like Project::Discussion, much less painful.

Installation
============

Add this to your Gemfile: 
  
    gem 'obviously'

Usage
=====
    
Notice the lack of `class_name: 'User::Membership'` style options in the associations. Works with `belongs_to`, `has_one` and `has_many`: 

    class User < ActiveRecord::Base
        class Membership < ActiveRecord::Base
          connection.create_table :user_memberships do |t|
            t.references :user
            t.references :project
          end unless table_exists?

          belongs_to :user
          belongs_to :project
        end

        connection.create_table :users do |t|
          t.string :email
        end unless table_exists?

        has_many :memberships

        has_many :users,
          through: :memberships
      end

      class Project < ActiveRecord::Base
        connection.create_table :projects do |t|
          t.string :name
        end unless table_exists?

        has_many :memberships

        has_many :users,
          through: :memberships
      end

