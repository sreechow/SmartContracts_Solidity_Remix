
contract sreechocoin_ico
{
    //Introductin the maximum number of sreechocoin available for sale
    
    uint public max_sreechocoins = 1000000;
    
    //Introducting the USG to sreechocoin conversion rate, i.e. 1 USD = 1000 sreechocoins
    uint public usd_to_sreechocoins = 1000;
    
    //the total number of sreechocoins that have been bought by the investor
    uint public total_sreechocoins_bought = 0;
    
    //mapping from the investor address to it's equity in sreechocoins and USD
    mapping(address => uint) equity_sreechocoins;
    mapping(address => uint) equity_usd;
    
    //check if an investor can buy sreechocoins
    modifier can_buy_sreechocoins(uint usd_invested)
    {
        require(usd_invested * usd_to_sreechocoins + total_sreechocoins_bought <= max_sreechocoins);
        _;
    }
    
    // get the equity in sreechocoins of the investor
    function equity_in_sreechocoins(address investorAddrs) external view returns (uint) {
        return equity_sreechocoins[investorAddrs];
    }
    
    // get the equity in USD of the investor
     function equity_in_usd(address investorAddrs) external view returns (uint) {
        return equity_usd[investorAddrs];
    }
    
    //buy sreechocoins
    function buy_sreechocoins(address investorAddrs, uint usd_invested) external
    can_buy_sreechocoins(usd_invested) {
        uint sreechocoins_bought = usd_invested * usd_to_sreechocoins;
        equity_sreechocoins[investorAddrs] += sreechocoins_bought;
        equity_usd[investorAddrs] += equity_sreechocoins[investorAddrs] / usd_to_sreechocoins;
        total_sreechocoins_bought += sreechocoins_bought;
        
    }
    
    //sell sreechocoins
    function sell_sreechocoins(address investorAddrs, uint sreechocoins_sold) external {
        equity_sreechocoins[investorAddrs] -= sreechocoins_sold;
        equity_usd[investorAddrs] += equity_sreechocoins[investorAddrs] / usd_to_sreechocoins;
        total_sreechocoins_bought -= sreechocoins_sold;
    }
        
}