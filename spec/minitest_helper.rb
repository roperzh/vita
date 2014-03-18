ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join('config', 'application'))

require "minitest/unit"
require "mocha/mini_test"

require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/bundle"
end

require "dotenv"
Dotenv.load ".env.test", ".env"


require "minitest/ansi"
MiniTest::ANSI.use!

# Allow usage of 'context' like 'describe'
module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

# Helper methods
def fake_response
  LinkedIn::Mash.new({
    "first_name"   => "John",
    "last_name"    => "Doe",
    "headline"     => "Full stack developer",
    "picture-urls" => LinkedIn::Mash.new({
      "all" => ["http://example.com"]
    }),
    "skills"      => LinkedIn::Mash.new({
      "all" => [LinkedIn::Mash.new({
        "id"    => "232",
        "skill" => LinkedIn::Mash.new({
          "name"  => "skill_1"
        })
      })]
    }),
    "educations" => LinkedIn::Mash.new({
      "all" => [LinkedIn::Mash.new({
        "end_date" => LinkedIn::Mash.new({
          "year"  => "2323",
          "month" => "09"
        }),
        "school_name" => "Some school around here",
        "start_date" => LinkedIn::Mash.new({
          "year"  => "2323",
          "month" => "09"
        }),
      })]
    }),
    "positions" => LinkedIn::Mash.new({
      "all" => [LinkedIn::Mash.new({
        "end_date" => LinkedIn::Mash.new({
          "year"  => "2323",
          "month" => "09"
        }),
        "company" => LinkedIn::Mash.new({
          "name"     => "Hash Brothers",
          "industry" => "Computer Software"
        }),
        "title"      => "Ingenieer",
        "start_date" => LinkedIn::Mash.new({
          "year"  => "2323",
          "month" => "09"
        }),
      })]
    }),
    "projects"  => LinkedIn::Mash.new({
      "all" => [LinkedIn::Mash.new({
        "description" => "cool project description",
        "name"        => "cool project name",
        "url"         => "cool url"
      })]
    }),
    "courses"  => LinkedIn::Mash.new({
      "all" => [LinkedIn::Mash.new({
        "id"     => "343",
        "name"   => "cool course name"
      })]
    })
  })
end
