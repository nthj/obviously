require 'spec_helper'

describe 'Obviously' do

  class User < ActiveRecord::Base
    class Schedule < ActiveRecord::Base
      connection.create_table :user_schedules do |t|
        t.references :user
      end unless table_exists?

      belongs_to :user
    end

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

    has_many :schedules

    has_many :memberships

    has_many :users,
      through: :memberships
  end

  class Discussion < ActiveRecord::Base
    class Schedule < ActiveRecord::Base
      connection.create_table :discussion_schedules do |t|
        belongs_to :discussion
      end unless table_exists?

    end

    connection.create_table :discussions do |t|

    end unless table_exists?
  end

  around :each do |example|
    ActiveRecord::Base.transaction do
      example.call
      raise ActiveRecord::Rollback
    end
  end

  it "should recognize namespaced models in association definitions" do
    expect(Project.create.users.create).to be_true
  end

  it "should error on ambiguous models" do
    expect {
      Project.create.schedules.create
    }.to raise_error(ActiveRecord::Reflection::AssociationReflection::AmbiguousAssociationClassError)
  end
end

