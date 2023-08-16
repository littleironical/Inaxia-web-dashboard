class AllProductTypesModel {
  bool isSelected;
  final String productType;
  final List productImages;
  final List productQualitiesAvailable;
  final List productSizesAvailable;
  
  AllProductTypesModel(
    this.isSelected,
    this.productType,
    this.productImages,
    this.productQualitiesAvailable,
    this.productSizesAvailable,
  );
}
