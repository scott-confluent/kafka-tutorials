# Kafka Recipes

The source code for the Kafka Recipes microsite.

## Setup

If you want to hack on this site to add a new recipe or make a change, follow these instructions.

### Prerequisites

Make sure you have the following installed:

- ruby 2.3 or later
- [bundler](https://bundler.io/)
- npm
- python3 / pip3

On the Mac, you can get the dependencies like this:

```
brew install ruby node
gem install bundler
```

This repository uses a Python package to facilitate testing the recipes. To keep things simple, we bundled it into this repository. You can get everything you need by running the following:

```
pip3 install pyyaml
cd harness_runner
pip3 install -e .
```

You'll now have an executable called harness-runner on your path. (Note that if you use Python, you likely already have the `pyyaml` package installed.)

### Installing

#### 1. Clone this repository

```
git clone git@github.com:confluentinc/kafka-recipes.git
```

Then `cd` into the directory.

#### 2. Install the node packages

```
npm install
```

This will bring in some external JavaScript and CSS packages that we're using.

#### 3. Install the gems

```
bundle install
```

This will install Jekyll itself and any other gems that we use.

#### 4. Run the development server

```
bundle exec jekyll serve
```

This will launch a web server so that you can work on the site locally. Check it out on `http://localhost:4000`.

## Add code for a new recipe

A recipe is a short procedure, targeted at developers, for getting a certain thing done using Confluent Platform.

In many cases, you can get that thing done using one of several _stacks_. For example, you might be able to perform data filtering by writing a KSQL query, by writing a Kafka Streams application, or by directly using the Kafka Consumer API. These comprise the three stacks this site supports: `ksql`, `kstreams`, and `kafka`.

Kafka Recipes is a bit unique in that rach recipe is self-testing. That is, we have built a harness system that's able to instrument the code that belongs to each recipe to make sure that it actually works. This is really useful as we expect to have a lot of recipes.

With in each stack, these recipes contain a few pieces. These are described below.

#### 1. Describe the problem your recipe solves

The first thing to do is articulate what problem your recipe is meant to solve. Every recipe contains a problem statement and an example scenario. Edit `_data/recipes.yml` and add your entry. The top item in this file represents the _short name_ for your recipe. For example, the recipe for transforming events of a stream is _transforming_. You'll also notice a `status` attribute. You can `enable` as many stacks as you'd like to author for this recipe, but we recommend starting with just one.

#### 2. Make the directory structure

Next, make a few directories to set up for the project:

```
mkdir _includes/recipes/<your recipe short name>/<stack>/code
mkdir _includes/recipes/<your recipe short name>/<stack>/markup
```

#### 3. Write the code for the recipe

Add your code for the recipe under the `code/` directory you created. This should be entirely self-contained and executable with a `docker-compose.yml` file and a platform-appropriate build. Follow the conventions of existing recipes as closely as possible.

At this point, you should feel free to submit a PR! A member of Confluent will take care of writing the markup and test files to integrate your code into the site. You can, of course, proceed to the next section and do it yourself, if you'd like.


## Add a narrative and test for the recipe

This section is generally for those who work at Confluent and will integrating new recipes into the site. We need to do a little more work than just authoring the code. We also need to write the markup to describe the recipe and narrative form, and also write the tests that we described to make sure it all works. This section describes how to do that.

#### 1. Create markup for the recipe

Under the `markup/` directory, create 3 files: `try_it.html`, `test_it.html`, and `take_it_to_prod.html`. Write the recipe prose content here, following the conventions of existing recipes.

#### 2. Tie it all together

Make a file under the `/recipes/<your recipe short name>/<stack>.yml` directory (not `/_includes/recipes`), specifying all the variables of interest. To support a stack, add the trio of variables to the respective markup. For example, to display the recipe with KSQL:

```yml
---                                                                                                                                           
layout: recipe
permalink: /recipes/filter-a-stream-of-events/ksql
stack: ksql
static_data: filtering

try_it: recipes/filtering/ksql/markup/try_it.html
test_it: recipes/filtering/ksql/markup/test_it.html
take_it_to_prod: recipes/filtering/ksql/markup/take_it_to_prod.html
---
```

You can do the same for Kafka Streams and Kafka, by using the `kstreams` and `kafka` stacks, respectively.

#### 5. Write a test

Since this is a self-testing site, add a test to make sure your recipe's content works. Make a directory called `harness` in the `code` directory, and follow the conventions of the existing recipes. Also create a `Makefile` with a target called `recipe` to build the content and run the tests.

#### 6. Tie into build system

Lastly, modify the `.semaphore/semaphore.yml` file to invoke your Makefile. This will make sure your recipe gets checked by the CI system.

## Misc

### Running the tests locally

Some of the tests require Docker containers to be up. In the root directory, `cd` to the `docker` directory and run `docker-compose up` where needed.
