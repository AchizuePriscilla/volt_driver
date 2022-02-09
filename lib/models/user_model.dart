import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? email;
  final String? id;
  final String? phoneNumber;
  final String? address;
  final String? country;
  final String? state;
  final int? vltCoinBalance;
  final int? vltNairaBalance;
  final String? password;
  final String? timeOfCreation;
  final String? timeOfUpdate;
  final double? latitude;
  final double? longitude;
  final String? avatar;

  const UserModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.country,
      this.state,
      this.vltCoinBalance,
      this.vltNairaBalance,
      this.timeOfCreation,
      this.timeOfUpdate,
      this.password,
      this.latitude,
      this.longitude,
      this.avatar});

  factory UserModel.fromJson(Map json) {
    Map<String?, dynamic> _json = Map<String?, dynamic>.from(json);
    return UserModel(
        id: _json['id'] ?? '',
        name: _json['name'] ?? '',
        email: _json['email'] ?? '',
        password: _json['password'] ?? '',
        phoneNumber: _json['phone'] ?? '',
        avatar: _json['avatar'] ?? '',
        address: _json['location']['address'] ?? '',
        state: _json['location']['state'] ?? '',
        country: _json['location']['country'] ?? '',
        latitude: _json['location']['lat'],
        longitude: _json['location']['lng'],
        vltCoinBalance: _json['wallet']['VLT_COIN']['amount'] ?? '',
        vltNairaBalance: _json['wallet']['VLT_NGN']['amount'] ?? '',
        timeOfCreation: _json['createdAt'] ?? '',
        timeOfUpdate: _json['updatedAt'] ?? '');
  }

  Map<String?, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phoneNumber,
      'name': name,
      'location': {
        "address": address,
        "state": state,
        "country": country,
      },
      'wallet': {
        'VLT_COIN': {'amount': vltCoinBalance},
        'VLT_NGN': {'amount': vltNairaBalance}
      }
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        address,
        country,
        state,
        vltCoinBalance,
        vltNairaBalance,
      ];

  UserModel copyWith(
      {String? name,
      String? phoneNumber,
      String? address,
      double? latitude,
      double? longitude,
      String? avatar}) {
    return UserModel(
        id: id,
        name: name ?? this.name,
        email: email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        country: country,
        state: state,
        vltCoinBalance: vltCoinBalance,
        vltNairaBalance: vltNairaBalance,
        timeOfCreation: timeOfCreation,
        timeOfUpdate: timeOfUpdate,
        password: password,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        avatar: avatar ?? this.avatar);
  }
}
