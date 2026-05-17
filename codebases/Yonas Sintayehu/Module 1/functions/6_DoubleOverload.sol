contract Contract {
    function double(uint _value) external pure returns (uint) {
        return _value * 2;
    }

    function double(uint _a, uint _b) external pure returns (uint, uint) {
        return (_a * 2, _b * 2);
    }
}