# eslint-rails-ee: a fork of eslint-rails with enhanced features

#### Due to the original repo not being maintained, and several PRs/issues still being open after two years, I have decided to fork and keep this repo separated. Please send any requests, concerns, etc to dvaidlewisrogers3@gmail.com -- I would be more than happy to merge these new features into the original repo.

Run [ESLint][] against your Rails repo, and even auto-correct issues! The supported javascript file extensions are the following:

- _.js_
- _.jsx_
- _.es6_

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eslint-rails-ee'
gem 'therubyracer'
gem 'execjs'
```

This uses TheRubyRacer as a runtime. For most environments, this works fine. However if you run windows do this to your gemfile:

```ruby
gem 'eslint-rails-ee'
gem 'therubyracer', :platforms => :ruby
gem 'execjs'
```

## Configuration

To customize configuration, place an eslint config file in your app's
`config/eslint.json`.

You can print the configuration thusly:

```sh
# Print the configuration that we're using. If there's a custom configuration
# present, print that; if not, print the default configuration.
rake eslint:print_config

# Or print the default configuration even if a custom one exists.
rake eslint:print_config[true]
```

You can also retrieve the current eslint.json by visiting `/eslint/eslint.json`
in your browser. To force retrieval of the default conguration, use
`/eslint/eslint.json?force_default=true`.

## Usage

### CLI

![rake-eslint-rails-run][]

This will analyze all of the javascript files in the project:

```sh
rake eslint:run_all
```

Or you can run it on a single file. This will analyze `application.js`:

```sh
rake eslint:run
```

Or, you can supply a filename to the task, using several different formats, and it will lint just that file. For example, to analyze `app/assets/javascripts/components/utilities.js`, you can run any of the following:

```sh
rake eslint:run[components/utilities]
rake eslint:run[components/utilities.js]
rake eslint:run[app/assets/javascripts/components/utilities]
rake eslint:run[app/assets/javascripts/components/utilities.js]
```

To auto-correct files in either execution of the above rake tasks just add `true` to the arguments like so:

```sh
rake eslint:run_all[true]
```
or

```sh
rake eslint:run[test.js,true]
```

### Web interface

On non-production environments, visit these URLs on your application:

Path                                  | Description
------------------------------------- | -------------------------------------------------
`/eslint`                             | Optionally supply a filename parameter to analyze a file other than `application.js`, e.g.  `/eslint?filename=foo` to analyze foo.js.
`/eslint/source?filename=application` | Optionally replace `application` with the name of another JavaScript file, e.g.  `eslint/source?filename=button_stuff` can show you `button_stuff.js`, and `eslint/source?filename=components/buttons/icon_button` can show you `components/buttons/icon_button.js.coffee.erb`. This returns the source code with syntax highlighting
`/eslint?filename=<path+filename>`    | Providing you give a correct path/filename, it will run the eslint report and show you the errors
`/eslint?filename=<path+filename>&should_autocorrect=true` | Same as above, but will report errors AFTER auto-correcting any auto-correct-able issues

![eslint-rails-web][]

![eslint-rails-web-source][]

# Contributing

It's easiest to contribute by forking the repo and creating a pull request. For
help with this, see this [helpful article][fork a repo].

For all of the example shell commands below, I'm going to assume that you've set
these two variables, so go ahead and customize these and set them before you
start.

```sh
ESLINT=~/src/eslint
ESLINT_RAILS=~/src/eslint-rails
```

## Cloning the repository

```sh
git clone https://github.com/appfolio/eslint-rails-ee $ESLINT_RAILS
```

## Updating ESLint version

### Summary

1. [Clone the ESLint repository](#clone-the-eslint-repository)
2. [Install dependencies](#install-dependencies)
3. [Render `eslint.js`](#render-eslintjs)
4. [Copy `eslint.js` into `eslint-rails`](#copy-eslintjs-into-eslint-rails)
5. [Update the file in git](#update-the-file-in-git)
6. [Commit, push, and create a pull request](#commit-push-and-create-a-pull-request)

### Step-by-step instructions

First, make sure you set the environment variables [as suggested above](#contributing).

#### Clone the [ESLint repository][]

I would recommend only trying this with a released version unless you have a
good reason to. In this example, I'm going to check out v1.10.1 and work with
that.

```sh
git clone https://github.com/eslint/eslint $ESLINT
cd $ESLINT
git checkout v1.10.1
```

#### Install dependencies

```sh
cd $ESLINT
npm install
```

#### Render `eslint.js`

```sh
cd $ESLINT
node Makefile.js browserify
```

#### Copy `eslint.js` into `eslint-rails`

```sh
# Assuming you cloned eslint into a repository next to eslint-rails
cp $ESLINT/build/eslint.js $ESLINT_RAILS/vendor/assets/javascripts/eslint.js
```

#### Update the file in git

```sh
cd $ESLINT_RAILS
git add vendor/assets/javascripts/eslint.js
```

#### Commit, push, and create a pull request

The details of how to create your own branch, commit, push, and create a pull
request are outside the scope of this README. If you need help with this part,
here's a [helpful article][fork a repo]. This is the gist.

```sh
cd $ESLINT_RAILS
# Make your changes
git add :/
git commit
git push origin master
# Open a pull request
```
# Fork Authors

Since the original repo lacked some features I wanted and hasn't seen support/PRs in over a year, I decided to make this repo. Future maintenance of this gem will exist in 
the new eslint-rails-ee repo: 

- David Valentine &lt;[davidlewisrogers3@gmail.com][]&gt;

# Original Authors

This repo was orignially written by the following people:

- Jon Kessler &lt;[jon.kessler@appfolio.com][]&gt;
- Justin Force &lt;[justin.force@appfolio.com][]&gt;

# License

[MIT License][].

[ESLint]: http://eslint.org/
[fork a repo]: https://help.github.com/articles/fork-a-repo/
[ESLint repository]: https://github.com/eslint/eslint
[justin.force@appfolio.com]: mailto:justin.force@appfolio.com
[jon.kessler@appfolio.com]: mailto:jon.kessler@appfolio.com
[MIT License]: http://www.opensource.org/licenses/MIT)

[rake-eslint-rails-run]: https://cloud.githubusercontent.com/assets/324632/6672146/9d1f278e-cbc7-11e4-9f56-5a4511d35921.png
[eslint-rails-web-source]: https://cloud.githubusercontent.com/assets/324632/6671965/33d6819c-cbc6-11e4-9a64-30be84f20b96.png
[eslint-rails-web]: https://cloud.githubusercontent.com/assets/324632/6671966/33d8cc86-cbc6-11e4-904d-3379907c429d.png
