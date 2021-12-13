class DummyData {
  static const listOfStock = [
    {
      "currency": "IDR",
      "description": "ZEBRA NUSANTARA TBK PT",
      "displaySymbol": "ZBRA.JK",
      "figi": "BBG000BG5PN5",
      "mic": "XIDX",
      "symbol": "ZBRA.JK",
      "type": "Common Stock"
    },
    {
      "currency": "IDR",
      "description": "CATURKARDA DEPO BANGUNAN TBK",
      "displaySymbol": "DEPO.JK",
      "figi": "BBG0139DKMW8",
      "mic": "XIDX",
      "symbol": "DEPO.JK",
      "type": "Common Stock"
    }
  ];

  static const watchlist = {
    "error": false,
    "message": "List Stocks",
    "data": [
      {
        "id": 112,
        "uid": "gjVgVwcdrQThils0ahU88REsknE2",
        "symbol": "RBMS.JK",
        "description": "RISTIA BINTANG MAHKOTA TBK",
        "created_at": "2021-12-12T15:45:06.000000Z",
        "updated_at": "2021-12-12T15:45:06.000000Z"
      },
      {
        "id": 113,
        "uid": "gjVgVwcdrQThils0ahU88REsknE2",
        "symbol": "SNLK.JK",
        "description": "SUNTER LAKESIDE HOTEL TBK PT",
        "created_at": "2021-12-12T15:45:09.000000Z",
        "updated_at": "2021-12-12T15:45:09.000000Z"
      },
      {
        "id": 114,
        "uid": "gjVgVwcdrQThils0ahU88REsknE2",
        "symbol": "BPFI.JK",
        "description": "BATAVIA PROSPERINDO FINANCE",
        "created_at": "2021-12-12T15:45:10.000000Z",
        "updated_at": "2021-12-12T15:45:10.000000Z"
      }
    ]
  };

  static const addToWatchlistResponse = {
    "error": false,
    "message": "Stock added to watchlist",
    "data": {
      "uid": "123123123",
      "symbol": "IRRA",
      "description": "PT Itama Ranoraya Tbk",
      "updated_at": "2021-12-13T12:20:45.000000Z",
      "created_at": "2021-12-13T12:20:45.000000Z",
      "id": 116
    }
  };

  static const removeFromWatchlistResponse = {
    "error": false,
    "message": "Stock removed from watchlist"
  };
}
