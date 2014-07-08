
exports = module.exports

exports.breadcrumbs = (req, res, next)->
  res.locals.breadcrumb = []
  segments = req.url.split('/')
  for segment, index in segments
    if segment.length > 0
      crumb = {}
      crumb.href = '/'+segments.slice(1, index+1).join('/')
      if res.__?
        crumb.title = res.__(segment)
      else
        crumb.title = segment
      res.locals.breadcrumb.push(crumb)
  next()