require "deploy/code/version"

module Deploy
  module Code
    # Your code goes here...

    def self.within_capistrano(&block)
      Capistrano::Configuration.instance(:must_exist).load(&block)
    end
  end
end
