should = require('chai').should()
MailStripper = require('./../src/mail-stripper')

describe 'MailStripper', ->
  before (done) ->
    @stripper = new MailStripper
      patterns: [/@caramail.com/]
    done()

  describe 'with a simple message', ->
    it 'should return the message', (done) ->
      mail = "Hey what's up?
      Martin"
      message = @stripper.parse(mail)
      message.should.eql(mail)
      done()

  describe 'with a previous email (from Blackberry)', ->
    it 'should strip it!', (done) ->
      mail ="Julien, à quelle heure repars-tu à Madrid dimanche? On peut faire un thé dimanche aprem plutot? Je dois aider ma mere samedi à preparer une soirée...\r\nMerci\r\n------Message d'origine------\r\nDe: martin@vytein.com\r\nExpéditeur: event-1h9xkuw8@vyte.in\r\nÀ: caro@gmail.com\r\nRépondre à: event-1h9xkuw8@vyte.in\r\nObjet: Brunch\r\nEnvoyé: 17 mars 2014 15:46\r\n\r\n---- Envoyé avec BlackBerry® d'Orange ----"
      message = @stripper.parse(mail)
      message.should.eql("Julien, à quelle heure repars-tu à Madrid dimanche? On peut faire un thé dimanche aprem plutot? Je dois aider ma mere samedi à preparer une soirée...\nMerci")
      done()

  describe 'with a previous email (from hotmail)', ->
    it 'should strip it!', (done) ->
      mail = "Ça ne me dérange pas, je suis juste triste.  Tu viens qd même au bureau ? On se croisera peut être .... Besos\r\n\r\n--- Message initial ---\r\n\r\nDe : martin.saintmac@gmail.com\r\nEnvoyé : 3 novembre 2013 19:58\r\nA : marie@hotmail.com\r\nObjet : Re: déjeuner\r\n\r\nmartin@vytein.com:\r\n    Hello Marie,\r\n\r\nJe suis désolé mais j'ai un empêchement demain. Ça te dérange si on décalé\r\nà la semaine prochaine?\r\n\r\nGros bisous\r\n\r\nMartin\r\n\r\nevent page\r\nhttp://vytein.herokuapp.com/events/527156b65d55a9123"
      message = @stripper.parse(mail)
      message.should.eql("Ça ne me dérange pas, je suis juste triste.  Tu viens qd même au bureau ? On se croisera peut être .... Besos")
      done()


  describe 'with a previous email (from vyte.in)', ->
    it 'should strip it!', (done) ->
      mail = "Félicitations!\r\nDu coup, c'est Martin qui gagne et c'est moi qui offre le Champomy:)\r\nJ'aurais dû m'en douter pour les coups de pied...\r\n\r\n\r\n2014-05-06 10:50 GMT+02:00 vyte.in updates <event-owcjklm1@vyte.in>:"
      target = "Félicitations!\nDu coup, c'est Martin qui gagne et c'est moi qui offre le Champomy:)\nJ'aurais dû m'en douter pour les coups de pied..."
      message = @stripper.parse(mail)
      message.should.eql(target)
      done()

  describe 'with a previous email (from gmail)', ->
    it 'should strip it!', (done) ->
      mail = "Yop\r\n\r\nLe lundi 12 mai 2014, toto@caramail.com a écrit :"
      target = "Yop"
      message = @stripper.parse(mail)
      message.should.eql(target)
      done()

  describe 'with a previous email (from gmail)', ->
    it 'should strip it!', (done) ->
      mail = "So?\n\nLe mercredi 14 mai 2014, Martin Saint-Macary <martin.saintmac@gmail.com> a\nécrit :"
      target = "So?"
      message = @stripper.parse(mail)
      message.should.eql(target)
      done()

  describe 'with a previous email (from gmail)', ->
    it 'should strip it!', (done) ->
      mail = "And now?\n\nLe mercredi 14 mai 2014, Martin Saint-Macary <martin.saintmac@gmail.com> a\nécrit :"
      target = "And now?"
      message = @stripper.parse(mail)
      message.should.eql(target)
      done()

  describe 'with a previous email (from Mailbox)', ->
    it 'should strip it!', (done) ->
      mail = "Salut ça va?Oui oui\r\n—\r\nSent from Mailbox"
      target = "Salut ça va?Oui oui"
      message = @stripper.parse(mail)
      message.should.eql(target)
      done()

  describe 'with an  awkward signature', ->
    it 'should strip it!', (done) ->
      mail = "john.appleseed\n\n\n\n\nJOHN APPLESEED\nwww.apple.com\n\nCe message électronique et toutes les pièces jointes qu'il contient sont\nconfidentiels et destinés exclusivement à l'usage de la personne à laquelle\nils sont adresses. Si vous avez reçu ce message par erreur, merci de le\nretourner à son émetteur. Les idées et opinions présentées dans ce message\nsont celles de son auteur, et ne représentent pas nécessairement celles de\nl'institution dont l'auteur est l'employé. La publication, l'usage, la\ndistribution, l'impression ou la copie non autorisée de ce message et des\npièces jointes qu'il contient sont strictement interdits.\n\n\nThis email and any files transmitted with it are confidential and intended\nsolely for the use of the individual or entity to whom they are addressed.\nIf you have received this email in error please return it to the sender.\nThe ideas and views expressed in this email are solely those of its author,\nand do not necessarily represent the views of the institution or company of\nwhich the author is an employee. Unauthorized publication, use,\ndistribution, printing or copying of this e-mail or any attached files is\nstrictly forbidden."
      target = "john.appleseed"
      name = "John Appleseed"
      message = @stripper.parse(mail, name)
      message.should.eql(target)
      done()

  describe 'with a message containing the name', ->
    it 'should not strip it', (done) ->
      mail = "Hi, my name is john appleseed.\nHow are you doing?"
      name = "John Appleseed"
      message = @stripper.parse(mail, name)
      message.should.eql(mail)
      done()



