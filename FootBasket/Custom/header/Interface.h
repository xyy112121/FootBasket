#define URLHeader @"http://120.78.254.71/"
#define URLPicHeader @"http://120.78.254.71/Basket/"

#define RQLogin   @"/Basket/control/UserNavigate_logIn_OL.action" // 登录 mobile=1 code=873940
#define RQSMSCode   @"/Basket/control/SMSCodeNavigate_getSMSCode_OL.action" //获取验证码 mobile=1
#define RQDiscount   @"/Basket/resource/ProductDiscountNavigate_searchPageOL_OL.action" //特惠商品  page=1&rows=10
#define RQRecommend   @"/Basket/resource/ProductRecommendNavigate_searchPageOL_OL.action" //推荐商品  page=1&rows=10
#define RQCategoryMain  @"/Basket/resource/CategoryNavigate_searchPageOL_OL.action" //获取大分类 page=1&rows=10"
#define RQCategoryOther  @"/Basket/resource/CategorySmallNavigate_searchPageOL_OL.action" //获取小分类searchCond.categoryId=1&page=1&rows=10
#define RQCategoryGood @"/Basket/resource/ProductBasicNavigate_searchPageOL_OL.action" //获取分类下的产品searchCond.categorySmallId=1&page=1&rows=10"
#define RQMyShoppingCar @"/Basket/business/ShoppingCartNavigate_searchPageOL_OL.action" //我的购物车 searchCond.userId=1
#define RQAddShoppingCar @"/Basket/business/ShoppingCartForm_save_OL.action"//添加购物车 userId=1517993433154kr191l&productBasicId=151797994232036mahf
#define RQDeleteShoppingCar @"/Basket/business/ShoppingCartForm_deleteEntity_OL.action"  // 购物车删除 ids=1519400529395nsdehb%2C1519435933982ui6nn6
#define RQMyUserCenter  @"/Basket/control/UserNavigate_getUser_OL.action"//用户中心 objectID=1
#define RQGoodsDetail @"/Basket/resource/ProductBasicNavigate_detail_OL.action" //商品详情 objectID=2

#define RQShoppingCarSettlement @"/Basket/business/OrderForm_settleOrder_OL.action" // 结算 userId products{productId:"123" count:23}

#define RQAddNewAddress @"/Basket/resource/UserAddressForm_save_OL.action"// 添加新地址 userId address mobile userName defaultAdr"

#define RQAddrList @"/Basket/resource/UserAddressNavigate_searchPageOL_OL.action" // 我的地址列表 userId page rows

#define RQCommitOrder @"/Basket/business/OrderForm_confirmOrder_OL.action" // 提交订单userId addressId products

#define RQMyOrderList @"/Basket/business/OrderNavigate_searchPageOL_OL.action" //我的订单userId deliveryState 2 待收货  3 已收货

#define RQMyOrderDetail @"/Basket/business/OrderNavigate_detail_OL.action" // 订单详情 objectID 


