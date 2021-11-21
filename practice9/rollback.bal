type Update record {
    int updateIndex;
    int stockMnt;
};

public function main() returns error? {
    Update[] updates =
    [{updateIndex: 0, stockMnt: 2000},
    {updateIndex: 1, stockMnt: -1000},
    {updateIndex: 2, stockMnt: 1500},
    {updateIndex: 3, stockMnt: -1000},
    {updateIndex: 4, stockMnt: -2000}];

    check transfer(updates);

}
function transfer(Update[] updates) returns error? {
    transaction {
        foreach var u in updates {

            check doUpdate(u);

        }
        
        check commit;

    }
}
function doUpdate(Update u) returns error? {
    if (u.stockMnt < -1500) {
        return error("Not enough Stocks: ", stockIndex = u.updateIndex);
    }

}