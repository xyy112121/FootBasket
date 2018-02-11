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
#define RQMyUserCenter  @"/Basket/control/UserNavigate_getUser_OL.action"//用户中心 objectID=1
#define RQGoodsDetail @"/Basket/resource/ProductBasicNavigate_detail_OL.action" //商品详情 objectID=2

