function fn(type,extraParams){
    var headers =
        {'Accept':'application/json',
         'Content-Type':'application/json'
        };

    for(let key in extraParams){
        headers[key]=extraParams[key];
    }

    if(type === 'BasicAuth'){
        var temp = karate.get('username') + ':' + karate.get('apiPassKey');
        var Base64 = Java.type('java.util.Base64');
        var encoded = Base64.getEncoder().encodeToString(temp.toString().getBytes());
        headers['Authorization'] = 'Basic ' + encoded;
    }

    if(type === 'OAUTH2_2L'){

    }

    if(type === 'OAUTH2_2L_U'){

    }

    if(type === 'OAUTH2_3L'){

    }

    return headers;
}