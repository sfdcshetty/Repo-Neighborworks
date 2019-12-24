public class ShowOwnerInformationController {
    @AuraEnabled
    public static user fetchUserDetails(Id recId){
        if(recId != null){
           String sObjName = recId.getSObjectType().getDescribe().getName();
           sObject s = Database.query('Select Id,OwnerId From '+sObjName + ' Where Id =:recId ');
           String ownerId = (s.get('OwnerId')!= null?String.valueOf(s.get('OwnerId')):'');
           return [Select Name,Id,FullPhotoUrl From User where Id=: ownerId Limit 1];  
        }
        else {return null;}
    }
}