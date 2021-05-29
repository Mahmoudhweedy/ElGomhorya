import '../models/user.dart';

class Stores extends Guser {
  final String firstName,
      lastName,
      password,
      companyName,
      city,
      role,
      email,
      region,
      mobileNumber;

  final int id;
  // final int packageId;
  final int userId;
  final List categories;

  Stores(
      {this.firstName,
      this.password,
      this.lastName,
      this.companyName,
      this.city,
      this.role,
      this.email,
      this.mobileNumber,
      this.id,
      // this.packageId,
      this.userId,
      this.region,
      this.categories});
  factory Stores.fromJson(Map json) {
    return Stores(
      city: json['city'],
      companyName: json['company_name'],
      email: json['email'],
      firstName: json['f_name'],
      id: json['id'],
      lastName: json['l_name'],
      mobileNumber: json['mobile'],
      // packageId: json['package_id'],
      role: json['role'],
      userId: json['user_id'],
      region: json['region'],
      categories: json['Categories'],
    );
  }
}
