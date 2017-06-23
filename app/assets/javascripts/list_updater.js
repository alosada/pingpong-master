function TableUpdater(params){
	this.table = document.getElementById(params['listId'])
	this.url = params['url']
	this.clearTable = params['clearTable']
	this.refreshRate = params['refreshRate']
	this.startUpdater();
};

TableUpdater.prototype = {
	call: function(){
		this.xhr = new XMLHttpRequest();
	    this.xhr.open('GET', this.url);
		this.xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest")
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
		var collection = JSON.parse(this.xhr.response);
		if( collection.length > 0 ){
			if(this.clearTable){this.resetTable()}
		    collection.reverse().forEach(this.addObject.bind(this));
		};
	},
	onFailure: function(){
		console.log('AJAX request failed');
	},
	addObject: function(object){
		var row = document.createElement('TR')
		object.forEach(function(text){
			var cell = document.createElement('TD')
			var textNode = document.createTextNode(text)

			cell.appendChild(textNode)
			row.appendChild(cell)
		})
		row.className = 'fade-in'
		this.table.insertBefore(row,this.table.firstChild)
		row.offsetWidth;
		row.style.opacity = 1;
	},
	startUpdater: function(){
		setInterval(function(){
			this.call()
		}.bind(this), this.refreshRate)
	},
	resetTable: function(){
		while(this.table.hasChildNodes()){
			this.table.removeChild(this.table.lastChild)
		}
	}
};
