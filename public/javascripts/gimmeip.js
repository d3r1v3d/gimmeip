/*
 * Global utility functions.
 */

// enables default parameter initialization for arbitrary JS functions
// courtesy of: (fatbrain - http://parentnode.org/javascript/default-arguments-in-javascript-functions/)
Function.prototype.defaults = function() {
	var _f = this;
	var _a = Array(_f.length - arguments.length).concat(
		Array.prototype.slice.apply(arguments)
	);
	
	return function() {
		return _f.apply(_f, Array.prototype.slice.apply(arguments).concat(
			_a.slice(arguments.length, _a.length)
		));
	};
};

// if the indexOf Array function isn't defined (as is the case with decrepit browsers like IE6, to name one), 
// define a good implementation
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function(obj, fromIndex) {
        if (fromIndex == null) {
            fromIndex = 0;
        } else if (fromIndex < 0) {
            fromIndex = Math.max(0, this.length + fromIndex);
        }

        for (var ctr = fromIndex, cachedSize = this.length; ctr < cachedSize; ctr++) {
            if (this[ctr] === obj) return ctr;
        }

        return -1;
    };
}

// easy string-to-boolean casting
String.prototype.bool = function() {
	return (/^true$/i).test(this);
};

// conversion utilities
if (typeof(Number.prototype.toRad) === "undefined") {
    Number.prototype.toRad = function() {
        return this * Math.PI / 180;
    }
}
if (typeof(Number.prototype.toDeg) === "undefined") {
    Number.prototype.toDeg = function() {
        return this * 180 / Math.PI;
    }
}

/*
 * This globally-scoped namespace which can (and should) be extended / referenced by disparate pages.
 * 
 * NOTE: Should be obvious, but it's worth noting that this object maintains state only up to a page reload. Thus,
 *       Ajax-retrieved pages may share information using this object, but it will be reset any time a new page is
 *       loaded. Server-side data retention is possible using Tapestry.
 */
// NOTE: structure and scoping inspired by jQuery 1.3. mucho props to John Resig and crew
(function(){
	
var 
	// cache the global Window object. speeds up references
	window = this,
	// similarly, cache the undefined object. speeds up references
	undefined,
	// declare our object in the global namespace and link it to a constructor
	gimme = window.gimme = function(){};

gimme.fn = gimme.prototype = {};

// NOTE: extend is borrowed directly from the jQuery.extend() method in 1.3.2
//       this allows us to extend our object from arbitrary snippets of JS code in a generic fashion 
gimme.extend = gimme.fn.extend = function(){
	// copy reference to target object
	var target = arguments[0] || {}, i = 1, length = arguments.length, deep = false, options;

	// Handle a deep copy situation
	if ( typeof target === "boolean" ) {
		deep = target;
		target = arguments[1] || {};
		// skip the boolean and the target
		i = 2;
	}

	// Handle case when target is a string or something (possible in deep copy)
	if ( typeof target !== "object" && !jQuery.isFunction(target) )
		target = {};

	// extend jQuery itself if only one argument is passed
	if ( length == i ) {
		target = this;
		--i;
	}

	for ( ; i < length; i++ ) {
		// Only deal with non-null/undefined values
		if ( (options = arguments[ i ]) != null ) {
			// Extend the base object
			for ( var name in options ) {
				var src = target[ name ], copy = options[ name ];

				// Prevent never-ending loop
				if ( target === copy ) continue;

				// Recurse if we're merging object values
				if ( deep && copy && typeof copy === "object" && !copy.nodeType ) {
					target[ name ] = jQuery.extend( deep, 
						// Never move original objects, clone them
						src || ( copy.length != null ? [] : {} )
					, copy );
                }
				// Don't bring in undefined values
				else if ( copy !== undefined ) {
					target[ name ] = copy;
                }
			}
        }
    }

	// Return the modified object
	return target;
};

})();

jQuery(function ($) {
    gimme.extend({
        urlRoot: window.location.href.replace(/\/*$/, ''),
        defaults: {}
    });

    $.fn.dataTableExt.oSort['ip-address-asc'] = function(a, b) {
    	var m = a.split("."), x = "",
    	    n = b.split("."), y = "";
    	for(var i = 0; i < m.length; i++) {
    		var item = m[i];
    		if(item.length == 1) {
    			x += "00" + item;
    		} else if(item.length == 2) {
    			x += "0" + item;
    		} else {
    			x += item;
    		}
    	}
    	for(var i = 0; i < n.length; i++) {
    		var item = n[i];
    		if(item.length == 1) {
    			y += "00" + item;
    		} else if(item.length == 2) {
    			y += "0" + item;
    		} else {
    			y += item;
    		}
    	}
    	return ((x < y) ? -1 : ((x > y) ? 1 : 0));
    };
    $.fn.dataTableExt.oSort['ip-address-desc'] = function(a, b) {
    	var m = a.split("."), x = "",
    	    n = b.split("."), y = "";
    	for(var i = 0; i < m.length; i++) {
    		var item = m[i];
    		if(item.length == 1) {
    			x += "00" + item;
    		} else if (item.length == 2) {
    			x += "0" + item;
    		} else {
    			x += item;
    		}
    	}
    	for(var i = 0; i < n.length; i++) {
    		var item = n[i];
    		if(item.length == 1) {
    			y += "00" + item;
    		} else if (item.length == 2) {
    			y += "0" + item;
    		} else {
    			y += item;
    		}
    	}
    	return ((x < y) ? 1 : ((x > y) ? -1 : 0));
    };

    $(document).ready(function(){
        $('table.display').dataTable({
            bJQueryUI: true,
            sPaginationType: 'full_numbers',
            aoColumns: [
                /* Name */ null,
                /* Address */ {
                    sType: 'ip-address'   
                },
                /* Description */ null,
                /* POC */ null,
                /* Delete */ {
                    bSearchable: false,
                    bSortable: false
                }
            ]
        });
    });
});
