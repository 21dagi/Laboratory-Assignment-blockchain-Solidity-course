contract Contract {
    uint public x;

    constructor(uint _x) {
        x = _x;
    }

    function increment() external {
        x += 1;
    }

    function add(uint _value) external view returns (uint) {
        return x + _value;
    }
}