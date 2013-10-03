
/*
 * GET home page.
 */

exports.index = function(req, res){
    var data = {
        metrics: [
            { colour: 'orange', number: '123', title: 'Anonymous Visitors' },
            { colour: 'blue', number: '456', title: 'Normal Visitors' },
            { colour: 'green', number: '789', title: 'Premium Visitors' }
        ]
    }
    res.render('index', data);
};