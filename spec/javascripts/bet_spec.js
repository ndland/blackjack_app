#= require application

describe('Todo', function(){
  it ('should get a default value', function() {
     var todo = new Todo();
      expect(todo.get('value')).to.eq(0);
  });
});

