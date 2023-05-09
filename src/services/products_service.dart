import '../data/fake_data.dart';
import '../dto/product_dto.dart';
import '../models/product_model.dart';

class ProductsService {
  Future<List<ProductModel>> findAllProducts() async {
    await Future.delayed(Duration(milliseconds: 50));
    List<ProductModel> allProducts =
        products.map((productMap) => ProductModel.fromMap(productMap)).toList();
    return allProducts;
  }

  Future<ProductModel> findProductById(int id) async {
    await Future.delayed(Duration(milliseconds: 50));
    List<ProductModel> allProducts =
        products.map((productMap) => ProductModel.fromMap(productMap)).toList();
    final selectedProduct =
        allProducts.firstWhere((product) => product.id == id);

    return selectedProduct;
  }

  Future<ProductModel> createProductModel(ProductDTO productDTO) async {
    await Future.delayed(Duration(milliseconds: 50));
    productDTO = productDTO.copyWith(id: 8372);
    final Map<String, dynamic> newProductModel = productDTO.toMap();
    products.add(newProductModel);
    return ProductModel.fromMap(newProductModel);
  }
}
