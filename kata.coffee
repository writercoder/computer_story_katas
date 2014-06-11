
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

artifacts = loadYml 'artifacts'
forms = loadYml 'forms'
nouns = loadYml 'nouns'
verbs = loadYml 'verbs'

if argv.form
  chosenForm = argv.form
else
  chosenForm = randomMemberOf(forms)
chosenArtifactType = randomKeyOf artifacts
chosenArtifact = randomMemberOf artifacts[chosenArtifactType]
chosenNoun = randomMemberOf nouns
chosenVerb = randomMemberOf verbs

katas = {
  a: -> "Write #{chosenForm} about #{chosenNoun} and #{chosenArtifact}"
  b: -> "Write #{chosenForm} about #{chosenNoun} and #{chosenArtifact} using the verb '#{chosenVerb}'"
}

if argv.kata
  kata = katas[argv.kata]
else
  kata = randomMemberOf(katas)

console.log kata()