@isTest
private class ShowOwnerInformationControllerTest {
    @testSetup static void setup() {
         Profile admin = [select id from profile where name='System Administrator'];
         User systemusr = new User( FirstName ='Test',
                                LastName = 'User',
                                Email = 'TestUser@gmail.com',
                                Username = 'TestUser@gmail.com-test',
                                ProfileId = admin.Id,
                                Alias = 'Admin',
                                TimeZoneSidKey = 'America/Los_Angeles',
                                EmailEncodingKey='UTF-8',
                                LanguageLocaleKey='en_US',
                                LocaleSidKey = 'en_US'
                              ); 
        insert systemusr;
    }
    //with Account
    static testMethod void case1(){
        user usr =[Select Username from User where Username='TestUser@gmail.com-test'];
        System.runAs(usr) {
           test.startTest();
            Account acc = new Account(Name='Test1');
            insert acc;
            user u = ShowOwnerInformationController.fetchUserDetails(acc.Id);
           test.stopTest();
           system.assertNotEquals(usr.Username, 'TestUser@gmail.com-test');            
        }
        
    }
   //with Id Null
   static testMethod void case2(){
        user usr =[Select Username from User where Username='TestUser@gmail.com-test'];
        System.runAs(usr) {
           test.startTest();
            ShowOwnerInformationController.fetchUserDetails(null);
           test.stopTest();
        }
    }
    //with Lead
     static testMethod void case3(){
        user usr =[Select Username from User where Username='TestUser@gmail.com-test'];
        System.runAs(usr) {
           test.startTest();
            Lead l = new Lead(LastName='TestLead',Company='TestCompany');
            insert l;
            ShowOwnerInformationController.fetchUserDetails(l.Id);
           test.stopTest();
            system.assertNotEquals(usr.Username, 'TestUser@gmail.com-test'); 
        }
    }

}