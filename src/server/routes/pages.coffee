exports.test = (req, res) ->
  res.render 'test', { title: 'test' }

exports.visualize = (req, res) ->
  res.render 'visualize', { title: 'Jam Motion' }
