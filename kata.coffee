
fs = require 'fs'
yaml = require 'js-yaml'
argv = require('yargs')
          .alias('f', 'form')
          .alias('k', 'kata')
          .argv


randomMemberOf = (container) ->
  if container.length
    # container is array like
    container[Math.floor(Math.random() * container.length)] 
  else
    # container is an object
    key = randomKeyOf container
    container[key]

loadYml = (what) -> 
  yaml.load(fs.readFileSync("#{__dirname}/seeds/#{what}.yml", 'utf8'))

randomKeyOf = (o) ->
  randomMemberOf(k for k of o)

randomItemFrom = (collection) ->
  randomMemberOf(loadYml collection)

form = -> argv.form || randomItemFrom 'forms'
artifact = -> 
  artifacts = loadYml 'artifacts'
  chosenArtifactType = randomKeyOf artifacts
  randomMemberOf artifacts[chosenArtifactType]
noun = -> randomMemberOf loadYml('nouns')
verb = -> randomMemberOf loadYml('verbs')


katas = {
  a: -> "Write #{form()} about #{noun()} and #{artifact()}"
  b: -> "Write #{form()} using the verb '#{verb()}' about #{noun()} and #{artifact()} "
}

kata = ->
  if argv.kata
    katas[argv.kata]()
  else
    randomMemberOf(katas)()

console.log kata()