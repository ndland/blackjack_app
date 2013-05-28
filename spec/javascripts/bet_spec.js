#= require application

describe('Todo', function(){
  it ('should get a default value' {
     var todo = new Todo();
      expect(todo.get('value')).toBe(0);
  });
});

