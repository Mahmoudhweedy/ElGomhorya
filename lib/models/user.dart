class Guser {
  final String firstName,
      lastName,
      userName,
      companyName,
      city,
      role,
      email,
      address,
      mobileNumber,
      password;
  final int id, status;
  final Duration createdAt, updatedAt;

  Guser({
    this.firstName,
    this.lastName,
    this.userName,
    this.id,
    this.mobileNumber,
    this.companyName,
    this.address,
    this.city,
    this.role,
    this.email,
    this.password,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Guser.fromJson(Map json) {
    return Guser(
      id: json['id'],
      city: json['city'],
      companyName: json['company_name'],
      email: json['email'],
      firstName: json['f_name'],
      lastName: json['l_name'],
      mobileNumber: json['mobile'],
      role: json['role'],
      address: json['address'],
    );
  }
}
