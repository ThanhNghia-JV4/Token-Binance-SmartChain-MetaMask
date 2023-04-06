pragma solidity >=0.7.0 <0.9.0;

contract Token{
    //Variable
    uint public totalSupply = 10000 * 10 ** 18; //tong so coin phat hanh
    string public name = 'Test Token';
    string public symbol = 'TTK';
    uint public decimals = 18;

    //Mapping
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    //Event
    event Transfer(address indexed from, address indexed to, uint amount); // tao su kien chuyen tien
    event Approve(address indexed owner, address indexed spender, uint amount); //tao su kien uy quyen

    constructor (){
        balances[msg.sender] = totalSupply;
    }
    //Function
    function balanceOf(address owner) public view returns(uint){ //tra ve so luong coin cua nguoi dang so huu
        return balances[owner];
    }

    function transfer(address to, uint amount) public returns(bool){ //Chuyen tien, gui den dau (to), gui bao nhieu (amount)
        //kien tra so tien chuyen phai nho hon so du
        require(balanceOf(msg.sender) >= amount, 'balance to low');
        balances[to] += amount; // cong tien cho nguoi nhan
        balances[msg.sender] -= amount; //tru tien cua nguoi gui

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint amount) public returns(bool) {
        //nguoi gui phai co tien, tien gui <= amount(so du) va nguoi duoc uy quyen cung phai vay !!!
        require(balanceOf(from) >= amount, 'Balance to low');
        require(allowance[from][msg.sender] >= amount, 'Balance to low');
        balances[to] += amount; // cong tien cho nguoi nhan
        balances[msg.sender] -= amount; //tru tien cua nguoi gui
        emit Transfer(from, to, amount);

        return true;
    }

    function approve(address spender, uint amount) public returns(bool) { //uy quyen chuyen tien. nguoi uy quyen nhu 1 ben thu 3 ??? 
        allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

}