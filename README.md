# OmniTag
通用标签功能(Rails engine)

## Usage


## Installation
Add this line to your application's Gemfile:

```ruby
gem "omni_tag", git: "git@github.com:as181920/omni_tag.git", branch: "master"
```

## Known bugs

* linked tagged_with query
```ruby
scope.tagged_with("recommend", context: "system").tagged_with("blacklisted", context: "security")
```

## Contributing
fork and make any pull request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
