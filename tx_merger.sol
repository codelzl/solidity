
/*pragma solidity ^0.4.15;
put in _tx_hash：
if exist then throw it 
else push into the queue
full then pop first
实现一个队列
输入传入的参数：该参数由keccak256得到并将其转为string类型
若不存在则加入队列尾，队列满时将队首丢弃
存在则丢弃
*/


contract queue
{
    struct Queue {
        bytes[] data;
        uint front;
        uint rear;
    }
    
      // push
    function push(Queue storage q, bytes data) internal
    {
        if ((q.rear + 1) % q.data.length == q.front)
           pop(q); // throw first;
        q.data[q.rear] = data;
        q.rear = (q.rear + 1) % q.data.length;
    }
    
     // Queue length
    function length(Queue storage q) constant internal returns (uint) {
        return q.rear - q.front;
    }
  
    // pop
    function pop(Queue storage q) internal returns (string d)
    {
        if (q.rear == q.front)
            return; // throw;
        bytes r = q.data[q.front];
        d=string(r);
        delete q.data[q.front];
        q.front = (q.front + 1) % q.data.length;
    }
    
}

contract QueueMain is queue {
    Queue requests;
    function QueueMain() {
        requests.data.length = 5;
    }
    

    //put in string(_tx_hash)
    function addRequest(string d) returns(string) {
     for( uint i= requests.front; i<requests.rear+1; i++){
            if(keccak256(string(requests.data[i]))==keccak256(d)) {
                 //  length(requests);
                  return "have exist";
            }
     }       
             if(keccak256(string(requests.data[i]))!=keccak256(d)){
                  push(requests, bytes(d));
                  return"ojbk";
             }
                 
   }
    
    function popRequest() returns (string) {
        return pop(requests);
    }
    
  function queueLength() returns (uint) {
        return length(requests);
    }
    
    
}
