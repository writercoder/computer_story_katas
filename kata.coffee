
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

randomKeyOf = (o) ->
  randomMemberOf(k for k of o)

loadYml = (what) -> 
  yaml.load(fs.readFileSync("#{__dirname}/seeds/#{what}.yml", 'utf8'))


randomItemFrom = (collection) ->
  randomMemberOf(loadYml collection)

randomForm = -> randomItemFrom 'forms'

artifacts = loadYml 'artifacts'
nouns = loadYml 'nouns'
verbs = loadYml 'verbs'

chosenForm = ->
  argv.form || randomForm()

chosenArtifactType = randomKeyOf artifacts
chosenArtifact = randomMemberOf artifacts[chosenArtifactType]
chosenNoun = randomMemberOf nouns
chosenVerb = randomMemberOf verbs

katas = {
  a: -> "Write #{chosenForm()} about #{chosenNoun} and #{chosenArtifact}"
  b: -> "Write #{chosenForm()} using the verb '#{chosenVerb}' about #{chosenNoun} and #{chosenArtifact} "
}

if argv.kata
  kata = katas[argv.kata]
else
  kata = randomMemberOf(katas)

console.log kata()