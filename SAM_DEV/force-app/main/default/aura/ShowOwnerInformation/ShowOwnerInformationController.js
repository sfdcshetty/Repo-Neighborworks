({
	doInit : function(cmp, event, helper) {
        var action = cmp.get("c.fetchUserDetails");
        action.setParams({ recId : cmp.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var usr = response.getReturnValue();
                if(!$A.util.isUndefinedOrNull(usr) && !$A.util.isEmpty(usr)){
                    cmp.set("v.userDetails",usr);
                    
                }else{
                   var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "type": "error",
                        "message": "unknown Error"
                    });
                    toastEvent.fire();  
                }
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);	
	}
})