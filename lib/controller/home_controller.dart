import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/model/product_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<ProductModel> products = [];
  List<ProductModel> cartProducts = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onAddProductToCart(ProductModel value) {
    if (cartProducts.contains(value)) {
      value.quantity += 1;
    } else {
      value.quantity = 1;
      cartProducts.add(value);
    }
    calculateAddTotalPrice(value.price ?? 0.0);
    update();
  }

  void onRemoveProductFromCart(ProductModel value) {
    if (cartProducts.contains(value)) {
      if (value.quantity == 1) {
        value.quantity -= 1;
        calculateRemoveTotalPrice(0.0);
        cartProducts.remove(value);
      } else {
        value.quantity -= 1;
        calculateRemoveTotalPrice(value.price ?? 0.0);
      }
    } else {
      value.quantity = 0;
      calculateRemoveTotalPrice(value.price ?? 0.0);
    }

    update();
  }

  void calculateAddTotalPrice(double value) {
    _totalPrice += value;
    update();
  }

  void calculateRemoveTotalPrice(double value) {
    if (value == 0.0) {
      _totalPrice = value;
    } else {
      _totalPrice -= value;
    }

    update();
  }

  void increment() => count.value++;
  void getProducts() async {
    _isLoading = true;
    update();
    //call the api
    var url = Uri.https('fakestoreapi.com', '/products');
    var response = await http.get(url);
    debugPrint('${response.body}');
    var data = jsonDecode(response.body);
    products =
        List<ProductModel>.from(data.map((x) => ProductModel.fromJson(x)));
    _isLoading = false;
    update();
  }
}
