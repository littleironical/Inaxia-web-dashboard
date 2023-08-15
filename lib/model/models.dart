class AllTshirtTypesModel {
  bool isSelected;
  final String tshirtType;
  final double tshirtPrice;
  final List tshirtImages;
  final List tshirtQualitiesAvailable;
  final List tshirtSizesAvailable;
  final List tshirtColorsAvailable;
  
  AllTshirtTypesModel(
    this.isSelected,
    this.tshirtType,
    this.tshirtPrice,
    this.tshirtImages,
    this.tshirtQualitiesAvailable,
    this.tshirtSizesAvailable,
    this.tshirtColorsAvailable,
  );
}
