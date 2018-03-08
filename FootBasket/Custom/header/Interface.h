#define URLHeader @"http://120.78.254.71/"
#define URLPicHeader @"http://120.78.254.71/Basket/"

#define RQLogin   @"/Basket/control/UserNavigate_logIn_OL.action" // 登录 mobile=1 code=873940

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

#define RQMyOrderList @"/Basket/business/OrderNavigate_searchPageOL_OL.action" //我的订单userId deliveryState 2 待收货  3 已收货   page rows=10

#define RQMyOrderDetail @"/Basket/business/OrderNavigate_detail_OL.action" // 订单详情 objectID 
#define RQDoneReceiveOrder @"/Basket/business/DeliveryNavigate_confirmReceipt_OL.action"//确认收货 orderId

#define RQDeliveryList @"/Basket/business/DeliveryNavigate_searchPageOL_OL.action" // 送货单 userId deliveryState  2未送货  3已送货

#define RQPayDoneCommit @"/Basket/business/OrderNavigate_confirmPayed_OL.action"//确认付款 orderId deliveryUserId

#define RQSearchProductList @"/Basket/resource/ProductBasicNavigate_searchPageOL_OL.action"// 搜索产品 productName page rows

#define RQUploadUserAvatar @"/Basket/control/UserForm_uploadAvatar_OL.action" // 上传头像objectID 参数 file

#define RQUploadRestaurantInfo @"/Basket/control/MerchantForm_save_OL.action" //添加新餐馆信息userId name address files

#define RQRestaurantList @"/Basket/control/MerchantNavigate_searchPageOL_OL.action" //餐饮列表 userId

#define RQRestaurantDetail @"/Basket/control/MerchantNavigate_detail_OL.action" //餐馆详情 objectID

#define RQMyCouponList @"/Basket/business/OrderNavigate_searchPageOL_OL.action"//q我的优惠列表userId  isCoupon

#define RQMyUpdateAddr @"/Basket/resource/UserAddressForm_update_OL.action" //更新收货地址objectID address mobile userName defaultAdr province city county

#define RQDeleteMyAddr  @"/Basket/resource/UserAddressForm_deleteEntity_OL.action" //删除地址 objectID

#define RQModifyUserInfo @"/Basket/control/UserForm_update_OL.action"//修改用户信息 objectID realName nickName

#define RQSMSCode   @"/Basket/control/SMSCodeNavigate_getSMSCode_OL.action" //获取验证码 mobile

#define RQSetDefaultAddr @"/Basket/resource/UserAddressNavigate_setDefault_OL.action" //默认地址objectID

#define RQGetVersion @"/Basket/control/VersionNavigate_searchPageOL_OL.action"//获取版本 phoneType=ios android
