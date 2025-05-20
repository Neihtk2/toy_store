class Endpoints {
  Endpoints._();
  static const String login = '/api/v1/auth/sign-in';
  static const String register = '/api/v1/auth/sign-up';
  static const String getProfile = '/api/v1/user/profile';
  static const String updateProfile = '/api/v1/user/profile';
  static const String getCart = '/api/v1/orders/my-cart';
  static const String getMe = '/api/v1/auth/me';
  static const String updateMe = '/api/v1/users';
  static const String getProducts = '/api/v1/products';
  static const String addProducts = '/api/v1/orders/add-cart';
  static const String getOrder = '/api/v1/orders/list?page=1&limit=30';
  static const String getLike = '/api/v1/favorites/like';
  static const String postLike = '/api/v1/favorites/like';
  static const String removeFromCart = '/api/v1/orders/delete-product';
  static const String checkout = '/api/v1/orders/checkout';
  static const String checkoutVNPay = '/api/v1/orders/checkout-vnpay';
  static const String postRate = '/api/v1/favorites/rate';

}
