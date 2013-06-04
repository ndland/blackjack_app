#= require application

// describe('User', function(){
// 
//   var server;
//   beforeEach( function() {
//     this.server = sinon.fakeServer.create();
//   });
// 
//   afterEach( function() {
//     this.server.restore();
//   });
// 
// 
//   it ('should have a user', function() {
//     this.server.respondWith("GET", "/api/user/",
//                        [200, { "Content-Tyoe": "application/json"},
//                          '{"credits":100,"id":19,"level":1,"name":"User_1"}']
//                       );
//    var callback = sinon.spy();
//     var myUser = new blackjack.User( {id: 19 } );
//     myUser.fetch( {success: function() { var view = new blackjack.userView();
//                view.initialize();
//     this.server.respond();
//     }});
//     sinon.assert.calledWith(callback, [{ id: 19, level: 1 }]);
//   });
// });
