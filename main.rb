# This is the main entrypoint into the program
# It requires the other files/gems that it needs
require 'colorize'
require 'pry'
require './candidates'
require './filters'
require './InvalidCandidate'

## Your test code can go here
#binding.pry
#pp qualified_candidates(@candidates)

run_repl
