// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../dto/product_dto.dart';
import '../models/product_model.dart';
import '../services/products_service.dart';

class ProductController {
  final ProductsService _productsService;

  ProductController(this._productsService);

  FutureOr<Response> getAllProducts(Request request) async {
    try {
      final List<ProductModel> allProducts =
          await _productsService.findAllProducts();

      return Response.ok(
          jsonEncode({
            'products': allProducts.map((product) => product.toMap()).toList(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'error': e.toString(),
        }),
      );
    }
  }

  FutureOr<Response> getProductById(Request request, String id) async {
    final int productId = int.parse(id);

    try {
      final ProductModel product =
          await _productsService.findProductById(productId);

      return Response.ok(
          jsonEncode({
            'products': product.toMap(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'error': e.toString(),
        }),
      );
    }
  }

  FutureOr<Response> createProduct(Request request) async {
    final String body = await request.readAsString();
    final Map<String, dynamic> productData = jsonDecode(body);
    final ProductDTO productDTO = ProductDTO.fromMap(productData);

    try {
      final ProductModel newProduct =
          await _productsService.createProductModel(productDTO);
      return Response(201,
          body: jsonEncode({
            'product': newProduct.toMap(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'error': e.toString(),
        }),
      );
    }
  }
}
