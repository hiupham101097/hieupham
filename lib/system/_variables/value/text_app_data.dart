class TextAppData {
  static List<TextDataValue> textValues = [
    TextDataValue(key: "title", value: "QLCV.VN"),
    TextDataValue(key: "app", value: "QLCV"),
    TextDataValue(key: "login", value: "Đăng nhập"),
    TextDataValue(key: "userName", value: "Mã đăng nhập"),
    TextDataValue(key: "password", value: "Mật khẩu"),
    TextDataValue(key: "logout", value: "Đăng xuất"),
    TextDataValue(key: "actionSuccess", value: "Lưu thông tin"),
    TextDataValue(
        key: "actionSuccessDetail",
        value: "Dữ liệu đã được cập nhật vào hệ thống"),
    TextDataValue(key: "typeInput", value: "Nhập nội dung"),
    TextDataValue(key: "profile", value: "Thông tin tài khoản"),
    TextDataValue(key: "fullName", value: "Họ và tên"),
    TextDataValue(key: "email", value: "Email"),
    TextDataValue(key: "phone", value: "Điện thoại"),
    TextDataValue(key: "address", value: "Địa chỉ"),
    TextDataValue(key: "edit", value: "Chỉnh sửa thông tin"),
    TextDataValue(key: "save", value: "Lưu thông tin"),
    TextDataValue(key: "cancelEdit", value: "Huỷ chỉnh sửa"),
    TextDataValue(key: "changeAccount", value: "Cập nhật tài khoản"),
    TextDataValue(key: "editAccount", value: "Chỉnh sửa tài khoản"),
    TextDataValue(key: "oldPassword", value: "Mật khẩu hiện tại"),
    TextDataValue(key: "newPassword", value: "Mật khẩu mới"),
    TextDataValue(key: "chooseTenants", value: "Chọn Tổ chức"),
    TextDataValue(key: "groups", value: "Danh sách tin nhắn"),
    TextDataValue(key: "messages", value: "Tin nhắn"),
    TextDataValue(key: "contacts", value: "Danh bạ"),
    TextDataValue(key: "home", value: "Quản lý Công việc"),
    TextDataValue(key: "default", value: "Trang chủ QLCV"),
    TextDataValue(key: "token", value: "Set token"),
  ];

  static String getValue(String key) {
    var textValue = textValues.firstWhere(
      (w) => w.key == key,
      orElse: () => TextDataValue(),
    );
    return textValue.value != null ? textValue.value! : key;
  }
}

class TextDataValue {
  final String? key;
  final String? value;

  TextDataValue({
    this.key,
    this.value,
  });
}
