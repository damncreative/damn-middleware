should = require 'should'
dm = require '../index'


describe 'View Test', ->
  it 'should exist', (done) ->
    should.exist dm.view
    done()

  describe 'Breadcrumb Test', ->
    it 'should give me the breadcrumbs for /test/1/2/3', (done) ->
      req = {}
      res = {}
      res.locals = {}
      req.url = '/test/1/2/3'
      next = (err)->
        should.not.exist err

      dm.view.breadcrumbs req, res, next
      
      should.exist res.locals.breadcrumb

      # 0
      res.locals.breadcrumb[0].href.should.eql '/test'
      res.locals.breadcrumb[0].title.should.eql 'test'
      # 1 
      res.locals.breadcrumb[1].href.should.eql '/test/1'
      res.locals.breadcrumb[1].title.should.eql '1'
      # 2
      res.locals.breadcrumb[2].href.should.eql '/test/1/2'
      res.locals.breadcrumb[2].title.should.eql '2'
      # 3
      res.locals.breadcrumb[3].href.should.eql '/test/1/2/3'
      res.locals.breadcrumb[3].title.should.eql '3'

      done()

