function UserWorker(){
	this.call();
	this.startUpdater();
};

UserWorker.prototype = {
	call: function(){
		this.xhr = new XMLHttpRequest();
	    this.xhr.open('GET', '/users');
	    this.xhr.onreadystatechange = this.onStatusChange.bind(this);
	    this.xhr.send();
	},
	onStatusChange: function(){
		if(this.checkReady()){
			this.onReady()
		}
	},
	checkReady: function(){
		return this.xhr.readyState == XMLHttpRequest.DONE
	},
	onReady: function(){
		if(this.checkStatus()){
			this.onSuccess();
		}else{
			this.onFailure();
		};
	},
	checkStatus:function(){
        return this.xhr.status == 200 
	},
	onSuccess: function(){
		var users = JSON.parse(this.xhr.response);
		users.forEach(this.addUser)
	},
	onFailure: function(){
		console.log('AJAX request failed');
	},
	addUser: function(user){
		var row = document.createElement('TR')
		user.forEach(function(element){
			var cell = document.createElement('TD')
			cell.innerHTML = element
			row.appendChild(cell)
		})
		row.className = 'fade-in'
		document.getElementById('index-table-body').appendChild(row);
		row.offsetWidth
		row.style.opacity = 1;
	},
	startUpdater: function(){
		setInterval(function(){
			var list = document.getElementById('index-table-body')
			while(list.hasChildNodes()){
				list.removeChild(list.lastChild)
			}
			this.call()
		}.bind(this), 10000)
	}
};
