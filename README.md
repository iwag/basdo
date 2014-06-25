basdo
=====

# requirement
  * rake
  * docker 
  * gitreceive

# install & configure

  rake build
  rake config

# config.json

```javascript

{
	"api": { // node name
		"service": "redis", // repository ? image ? name
		"port":[
			"guest":..., "host":...
		]
	}
}

```

# run

```bash
rake run  
cat foo.tar | ./getbuild.sh nodejs # update and restart nodejs app
```

# TODO
* serviceという名前はょくなぃ
