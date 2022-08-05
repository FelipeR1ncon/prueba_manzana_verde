///Clase de presentacion con los atributos de los productos
///que se mostraran al usuario
class ProductUIModel {
  final String productImagePath;
  final String productName;
  final String productMeasurement;
  final String productBrand;
  final String normalPrice;
  final String offerPrice;

  ProductUIModel(
      {required this.productImagePath,
      required this.productName,
      required this.productMeasurement,
      required this.productBrand,
      required this.normalPrice,
      this.offerPrice = ""});
}
