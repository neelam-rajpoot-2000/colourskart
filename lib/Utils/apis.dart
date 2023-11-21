class Apis {
  static const String baseUrl = "https://api.247365.exchange/admin-new-apis/";
  static const String dataBaseUrl="http://52.220.88.240:8080/";

  static const String signupApi = "${baseUrl}user/self-register";
  static const String getCardData =
      "${dataBaseUrl}CasinoAdmin/GetData/lucky7AData";
  static const String getCardDataAmar =
      "${dataBaseUrl}CasinoAdmin/GetData/aaaData";
  static const String getResult =
      "${dataBaseUrl}CasinoAdmin/GetData/lucky7AResult";
  static const String getResultAmar =
      "${dataBaseUrl}CasinoAdmin/GetData/aaaResult";

  static const String getuserBalanceApi = "${baseUrl2}enduser/get-user-balance";
  static const String getCardDataTeenPatti =
      "${dataBaseUrl}CasinoAdmin/GetData/t20Data";
  static const String getStakeData =
      "http://18.139.200.104/admin-new-apis/enduser/get-stake-button";
  static const String getReusltsTeenPatti =
      "${dataBaseUrl}CasinoAdmin/GetData/t20Result";

  //------ another base url----------//

  static const baseUrl2 = "http://52.66.99.34/admin-new-apis/";

  static const String loginApi = "${baseUrl2}login/client-login";

  static const String validateToken = "${baseUrl2}util/validate-jwt-token";

  static const String gameListApi =
      "http://13.250.53.81/VirtualCasinoBetPlacer/vc/casino-game-list";

  static const String betListApi = "${baseUrl2}enduser/bet-list-by-matchid";

  static const String makeBetAPi =
      "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";
  static const String matchId = "${baseUrl2}enduser/bet-list-by-matchid";
  static const String profileAPI = "${baseUrl2}enduser/profile";

  static const String statementApi = "${baseUrl2}enduser/account-statement";
  static const String changePasswordApi = "${baseUrl2}enduser/change-password";
  static const String unsettledBetsApi = "${baseUrl2}enduser/unsettled-bet";

  static const String vcLiablityApi =
      "http://13.250.53.81/VirtualCasinoBetPlacer/vc/liability";
  static const imagbaseLink = "http://admin.kalyanexch.com/images/cards/";
  static const String getCardDataOVTP =
      "${dataBaseUrl}CasinoAdmin/GetData/otpData";

  static const String getResultOVTP = "${dataBaseUrl}CasinoAdmin/GetData/otpResult";


static const String getCardDT="${dataBaseUrl}CasinoAdmin/GetData/dt20Data";
 static const String getResultDT="${dataBaseUrl}CasinoAdmin/GetData/dt20Result"; 
  static const dragonTigerLionResult =
      "${dataBaseUrl}CasinoAdmin/GetData/dtl20Result";
  static const dragonTigerLionCardAPi =
      "${dataBaseUrl}CasinoAdmin/GetData/dtl20Data";

      static const bollywoodCardApi =
      "${dataBaseUrl}CasinoAdmin/GetData/bwdtblData";

  static const bollywoodResultApi =
      "${dataBaseUrl}CasinoAdmin/GetData/bwdtblResult";
        static const depositTypeApi = "${baseUrl2}deposit-type/get_sub";
}
