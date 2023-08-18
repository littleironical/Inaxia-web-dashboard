class AllProductTypesModel {
  bool isSelected;
  final String productType;
  final List productQualitiesAvailable;
  final List productSizesAvailable;
  
  AllProductTypesModel(
    this.isSelected,
    this.productType,
    this.productQualitiesAvailable,
    this.productSizesAvailable,
  );
}
