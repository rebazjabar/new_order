// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
    Data? data;

    Store({
        this.data,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? strId;
    String? url;
    String? imageUrl;
    String? quantity;
    dynamic price;
    dynamic countryPrice;
    dynamic subTotal;
    dynamic countrySubTotal;
    dynamic shippingPrice;
    dynamic totalShippingPrice;
    dynamic internalShippingPrice;
    dynamic total;
    bool? isPaid;
    DateTime? statusUpdatedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.strId,
        this.url,
        this.imageUrl,
        this.quantity,
        this.price,
        this.countryPrice,
        this.subTotal,
        this.countrySubTotal,
        this.shippingPrice,
        this.totalShippingPrice,
        this.internalShippingPrice,
        this.total,
        this.isPaid,
        this.statusUpdatedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        strId: json["str_id"],
        url: json["url"],
        imageUrl: json["image_url"],
        quantity: json["quantity"],
        price: json["price"],
        countryPrice: json["country_price"],
        subTotal: json["sub_total"],
        countrySubTotal: json["country_sub_total"],
        shippingPrice: json["shipping_price"],
        totalShippingPrice: json["total_shipping_price"],
        internalShippingPrice: json["internal_shipping_price"],
        total: json["total"],
        isPaid: json["is_paid"],
        statusUpdatedAt: json["status_updated_at"] == null ? null : DateTime.parse(json["status_updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "str_id": strId,
        "url": url,
        "image_url": imageUrl,
        "quantity": quantity,
        "price": price,
        "country_price": countryPrice,
        "sub_total": subTotal,
        "country_sub_total": countrySubTotal,
        "shipping_price": shippingPrice,
        "total_shipping_price": totalShippingPrice,
        "internal_shipping_price": internalShippingPrice,
        "total": total,
        "is_paid": isPaid,
        "status_updated_at": statusUpdatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
