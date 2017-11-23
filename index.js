var express = require('express');
var bodyParser = require("body-parser");

var fs=require('fs');
var file="d:\\0.json";
var result=JSON.parse(fs.readFileSync( file));

var app = express();
app.use(bodyParser.urlencoded({ extended: false }));  
app.get('/', function (req, res) {
  res.send('Hello World!');
});


//注册
app.post('/signup',function(req,res){
	
	var obj = { name: req.body.username, psw: req.body.psw ,score:"0"};
	var user = result.filter((p) => {
    	return p.name == req.body.username;
	});
	if (user.length>0){
		res.send("exist")
		return
	}else{
		result.push(obj)
		var destString = JSON.stringify(result);
		fs.writeFile('d:\\0.json', destString);
		res.send("ok")
		return
	}
	
})
//登录
app.post('/signin',function(req,res){
	
	var user = result.filter((p) => {
    	return p.name == req.body.username;
	});
	if(user.length>0){
		if(user[0].psw == req.body.psw){
			res.send("success")
			return
		}else{
			res.send("error")
			return
		}
	}else{
		res.send("error")
		return
	}
})
//上传分数
app.post('/addscore',function(req,res){
	for (var i in result){
		if(result[i].name==req.body.username){
			console.log("in")
			if (parseInt(result[i].score)<parseInt(req.body.score)){
				result[i].score = req.body.score
				var destString = JSON.stringify(result);
				fs.writeFile('d:\\0.json', destString);
			}
			
			res.send("ok")
			return
		}
	}
	res.send("error")
	return
	
})
//获取全部分数
app.get('/getall',function(req,res){
	res.send(JSON.stringify(result))
	return
})

var server = app.listen(3000, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});