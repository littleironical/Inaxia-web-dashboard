import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inaxia_catalogue/model/models.dart';
import 'package:inaxia_catalogue/resources/assets_manager.dart';
import 'package:inaxia_catalogue/resources/colors_manager.dart';
import 'package:inaxia_catalogue/resources/fonts_manager.dart';
import 'package:inaxia_catalogue/resources/icons_manager.dart';
import 'package:inaxia_catalogue/resources/strings_manager.dart';
import 'package:inaxia_catalogue/resources/styles_manager.dart';
import 'package:inaxia_catalogue/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late double _screenWidth;
  final List<AllProductTypesModel> _allProductTypes = [];

  // FOR T-SHIRT TYPE & PRICE
  int _selectedProductTypeIndex = AppValueManager.v0;

  // FOR T-SHIRT IMAGES
  late List _productImagesAvailable;
  int _selectedProductImagesIndex = AppValueManager.v0;

  // FOR T-SHIRT QUALITIES
  late List _productQualitiesAvailable;
  late String _selectedProductQuality;
  int _selectedProductQualityIndex = AppValueManager.v0;

  // FOR T-SHIRT SIZES
  late List _productSizesAvaialble;
  late String _selectedProductSize;
  int _selectedProductSizeIndex = AppValueManager.v0;

  // FOR T-SHIRT COLORS
  late List _productColorsAvailable;
  late Color _selectedProductColor;
  int _selectedProductColorsIndex = AppValueManager.v0;

  // PRINITNG TECHNIQUES
  final List _printingTechniquesAvailable = [
    StringsManager.printingTechniqueDTF,
  ];
  late String _selectedPrintingTechnique;
  int _selectedPrintingTechniquesIndex = AppValueManager.v0;

  // PRINTING AREA
  final List _printingAreaAvailable = [
    StringsManager.printingAreasA3,
    StringsManager.printingAreasA4,
    StringsManager.printingAreasA5,
    StringsManager.printingAreasA6,
    StringsManager.printingAreasA7,
  ];
  String? _selectedPrintingArea;
  int? _selectedPrintingAreaIndex;
  int _printingAreaHeight = AppValueManager.v0;
  int _printingAreaWidth = AppValueManager.v0;
  bool _isCustomPrintingArea = false;

  // T-SHIRT QUANTITY
  final List _productQuantityList = [
    StringsManager.productQuantity1,
    StringsManager.productQuantity25,
    StringsManager.productQuantity50,
    StringsManager.productQuantity100,
    StringsManager.productQuantity200,
    StringsManager.productQuantity300,
    StringsManager.productQuantity500,
  ];
  int _productQuantityValue = AppValueManager.v1;
  int _productQuantitySliderValue = AppValueManager.v1;
  bool _isCustomProductQuantity = false;
  String _customProductErrorMessage = StringsManager.emptyString;

  // FINAL PRICING
  late double _productPrice;
  late int _printingPriceMinimum;
  late int _printingPriceMaximum;
  late double _finalPriceMinimum;
  late double _finalPriceMaximum;

  // WHATSAPP MESSAGE SENDING
  final String _whatsAppNumber = '919319289478';
  late String _whatsAppMessage;

  // INITIALIZING ALL DATA
  @override
  void initState() {
    _initializeAllProductTypes();
    _initializeProduct();
    super.initState();
  }

  _initializeAllProductTypes() {
    _allProductTypes.add(
      AllProductTypesModel(
        true,
        StringsManager.productTypeRoundNeck,
        [
          StringsManager.productQualityPolyester,
          StringsManager.productQualityDrifit,
          StringsManager.productQualityDotknit,
          StringsManager.productQualitySublimationCotton,
          StringsManager.productQuality100Cotton,
          StringsManager.productQualityCottonBiowash,
        ],
        [
          StringsManager.productSizesS,
          StringsManager.productSizesM,
          StringsManager.productSizesL,
          StringsManager.productSizesXL,
          StringsManager.productSizes2XL,
        ],
      ),
    );
    _allProductTypes.add(
      AllProductTypesModel(
        false,
        StringsManager.productTypePolo,
        [
          StringsManager.productQualityMatty,
          StringsManager.productQualityPolyCottonMatty,
        ],
        [
          StringsManager.productSizesS,
          StringsManager.productSizesM,
          StringsManager.productSizesL,
          StringsManager.productSizesXL,
          StringsManager.productSizes2XL,
        ],
      ),
    );
  }

  _initializeProduct() {
    for (var element in _allProductTypes) {
      if (element.isSelected == true) {
        // T-SHIRT QUALITIES
        _productQualitiesAvailable = element.productQualitiesAvailable;
        _selectedProductQuality =
            _productQualitiesAvailable[_selectedProductQualityIndex];

        // T-SHIRT SIZES
        _productSizesAvaialble = element.productSizesAvailable;
        _selectedProductSize = _productSizesAvaialble[_selectedProductSizeIndex];

        // T-SHIRT COLORS
        _setProductImagesColorsAndPricing();
        _selectedProductColor =
            _productColorsAvailable[_selectedProductColorsIndex];

        // T-SHIRT IMAGES
        _setProductImagesColorsAndPricing();

        // PRINTING TECHNIQUES
        _selectedPrintingTechnique =
            _printingTechniquesAvailable[_selectedPrintingTechniquesIndex];
      }
    }
  }

  // T-SHIRT COLOR BASED ON QUALITY
  _setProductImagesColorsAndPricing() {
    if (_selectedProductQuality == StringsManager.productQualityPolyester) {
      _productPrice = AppValueManager.v85.toDouble();
      _productImagesAvailable = [
        AssetsManager.polyester,
        AssetsManager.polyester1,
        AssetsManager.polyester2,
      ];
      _productColorsAvailable = [
        ColorsManager.whiteTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.redTshirt,
        ColorsManager.greenTshirt,
        ColorsManager.greyTshirt,
      ];
    } else if (_selectedProductQuality == StringsManager.productQualityDrifit) {
      _productPrice = AppValueManager.v110.toDouble();
      _productImagesAvailable = [
        AssetsManager.driFit,
        AssetsManager.driFit1,
        AssetsManager.driFit2,
      ];
      _productColorsAvailable = [
        ColorsManager.whiteTshirt,
        ColorsManager.pinkTshirt,
        ColorsManager.greenTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.redTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.greyTshirt,
        ColorsManager.beigeTshirt,
      ];
    } else if (_selectedProductQuality ==
        StringsManager.productQualityDotknit) {
      _productPrice = AppValueManager.v120.toDouble();
      _productImagesAvailable = [
        AssetsManager.dotKnit,
        AssetsManager.dotKnit1,
        AssetsManager.dotKnit2,
      ];
      _productColorsAvailable = [
        ColorsManager.whiteTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.greenTshirt,
        ColorsManager.pinkTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.redTshirt,
      ];
    } else if (_selectedProductQuality ==
        StringsManager.productQualitySublimationCotton) {
      _productPrice = AppValueManager.v170.toDouble();
      _productImagesAvailable = [
        AssetsManager.sublimationCotton,
        AssetsManager.sublimationCotton1,
        AssetsManager.sublimationCotton2,
      ];
      _productColorsAvailable = [
        ColorsManager.whiteTshirt,
        ColorsManager.greenTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.pinkTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.greyTshirt,
      ];
    } else if (_selectedProductQuality ==
        StringsManager.productQuality100Cotton) {
      _productPrice = AppValueManager.v180.toDouble();
      _productImagesAvailable = [
        AssetsManager.cotton100,
        AssetsManager.cotton1001,
        AssetsManager.cotton1002,
      ];
      _productColorsAvailable = [
        ColorsManager.whiteTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.greyTshirt,
        ColorsManager.redTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.blackTshirt,
      ];
    } else if (_selectedProductQuality ==
        StringsManager.productQualityCottonBiowash) {
      _productPrice = AppValueManager.v190.toDouble();
      _productImagesAvailable = [
        AssetsManager.cottonBiowash,
        AssetsManager.cottonBiowash1,
        AssetsManager.cottonBiowash2,
      ];
      _productColorsAvailable = [
        ColorsManager.whiteTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.redTshirt,
        ColorsManager.greyTshirt,
        ColorsManager.pinkTshirt,
      ];
    } else if (_selectedProductQuality == StringsManager.productQualityMatty) {
      _productPrice = AppValueManager.v130.toDouble();
      _productImagesAvailable = [
        AssetsManager.matty,
      ];
      _productColorsAvailable = [
        ColorsManager.whiteTshirt,
        ColorsManager.beigeTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.redTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.greyTshirt,
        ColorsManager.greenTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.pinkTshirt,
      ];
    } else if (_selectedProductQuality ==
        StringsManager.productQualityPolyCottonMatty) {
      _productPrice = AppValueManager.v160.toDouble();
      _productImagesAvailable = [
        AssetsManager.polyCottonMatty,
        AssetsManager.polyCottonMatty1,
        AssetsManager.polyCottonMatty2,
      ];
      _productColorsAvailable = [
        ColorsManager.whiteTshirt,
        ColorsManager.redTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.greyTshirt,
        ColorsManager.orangeTshirt,
      ];
    } else {
      _productPrice = AppValueManager.v0.toDouble();
      _productImagesAvailable = [];
      _productColorsAvailable = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      color: ColorsManager.primary,
      onRefresh: () {
        setState(() {
          // SETTINGS VALUES TO INITIAL VALUES
          // T-SHIRT TYPE
          _selectedProductTypeIndex = AppValueManager.v0;

          for (var element in _allProductTypes) {
            element.isSelected = false;
          }
          _allProductTypes[_selectedProductTypeIndex].isSelected = true;

          // T-SHIRT IMAGES
          _setProductImagesColorsAndPricing();
          _selectedProductImagesIndex = AppValueManager.v0;

          // T-SHIRT QUALITIES
          _productQualitiesAvailable =
              _allProductTypes[_selectedProductTypeIndex]
                  .productQualitiesAvailable;
          _selectedProductQualityIndex = AppValueManager.v0;
          _selectedProductQuality =
              _productQualitiesAvailable[_selectedProductQualityIndex];

          // T-SHIRT SIZES
          _productSizesAvaialble =
              _allProductTypes[_selectedProductTypeIndex].productSizesAvailable;
          _selectedProductSizeIndex = AppValueManager.v0;
          _selectedProductSize =
              _productSizesAvaialble[_selectedProductSizeIndex];

          // T-SHIRT COLORS
          _setProductImagesColorsAndPricing();
          _selectedProductColorsIndex = AppValueManager.v0;
          _selectedProductColor =
              _productColorsAvailable[_selectedProductColorsIndex];

          // PRINTING TECHNIQUES
          _selectedPrintingTechniquesIndex = AppValueManager.v0;
          _selectedPrintingTechnique =
              _printingTechniquesAvailable[_selectedPrintingTechniquesIndex];

          // PRINTING AREAS
          _selectedPrintingArea = null;
          _selectedPrintingAreaIndex = null;
          _printingAreaHeight = AppValueManager.v0;
          _printingAreaWidth = AppValueManager.v0;

          // QUANTITY
          _productQuantityValue = AppValueManager.v1;
          _productQuantitySliderValue = AppValueManager.v1;
        });
        return Future<void>.delayed(
            const Duration(seconds: AppValueManager.v1));
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (_screenWidth >= AppBreakpointManager.b1100)
                ? _largeScreenBody()
                : (_screenWidth >= AppBreakpointManager.b700)
                    ? _mediumScreenBody()
                    : _smallScreenBody(),
            //* MORE SECTIONS TO BE ADDED
          ],
        ),
      ),
    );
  }

  // LARGE SCREEN
  _largeScreenBody() {
    return Center(
      child: SizedBox(
        width: AppBreakpointManager.b1265,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: AppValueManager.v1,
              child: _largeScreenProductsImages(),
            ),
            Expanded(
              flex: AppValueManager.v1,
              child: _productOptions(),
            ),
          ],
        ),
      ),
    );
  }

  // CONTROLLING ALL IMAGES [IMAGE BANNER + SCROLL IMAGES]
  _largeScreenProductsImages() {
    return Padding(
      padding: const EdgeInsets.all(AppPaddingManager.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productImageScrolls(),
          const SizedBox(width: AppPaddingManager.p10),
          _productImageBanner(),
        ],
      ),
    );
  }

  // MEDIUM SCREEN
  _mediumScreenBody() {
    return Center(
      child: SizedBox(
        width: AppWidgetWidthManager.sw700,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: AppValueManager.v1,
              child: _mediumScreenProductsImages(),
            ),
            Expanded(
              flex: AppValueManager.v1,
              child: _productOptions(),
            ),
          ],
        ),
      ),
    );
  }

  // CONTROLLING ALL IMAGES [IMAGE BANNER + SCROLL IMAGES]
  _mediumScreenProductsImages() {
    return Padding(
      padding: const EdgeInsets.all(AppPaddingManager.p20),
      child: SizedBox(
        height: AppWidgetHeightManager.sh700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _productImageBanner(),
            const SizedBox(height: AppPaddingManager.p10),
            _productImageScrolls(),
          ],
        ),
      ),
    );
  }

  // SMALL SCREEN
  _smallScreenBody() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: AppWidgetHeightManager.sh2250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _smallScreenProductsImages(),
            _productOptions(),
          ],
        ),
      ),
    );
  }

  // CONTROLLING ALL IMAGES [IMAGE BANNER + SCROLL IMAGES]
  _smallScreenProductsImages() {
    return SizedBox(
      height: AppWidgetHeightManager.sh700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _productImageBanner(),
          const SizedBox(height: AppPaddingManager.p10),
          _productImageScrolls(),
        ],
      ),
    );
  }

  // BIG IMAGE
  _productImageBanner() {
    String? swipeDirection;

    return SizedBox(
      height: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetHeightManager.sh600
          : (_screenWidth >= AppBreakpointManager.b700)
              ? AppWidgetHeightManager.sh500
              : AppWidgetHeightManager.sh590,
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetWidthManager.sw400
          : (_screenWidth >= AppBreakpointManager.b700)
              ? AppWidgetWidthManager.sw400
              : double.maxFinite,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _interactiveImageView(),
          onPanUpdate: (details) {
            swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
          },
          onPanEnd: (details) {
            if (swipeDirection == null) {
              return;
            }

            // SWIPED LEFT - NEXT IMAGE TO BE SEEN
            if (swipeDirection == 'left') {
              if (_selectedProductImagesIndex ==
                  (_productImagesAvailable.length - 1)) {
                return;
              } else {
                setState(() {
                  _selectedProductImagesIndex++;
                });
              }
            }

            // SWIPED RIGHT - PREVIUOS IMAGE TO BE SEEN
            else if (swipeDirection == 'right') {
              if (_selectedProductImagesIndex == 0) {
                return;
              } else {
                setState(() {
                  _selectedProductImagesIndex--;
                });
              }
            }
          },
          child: Image.network(
            _productImagesAvailable[_selectedProductImagesIndex],
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Shimmer.fromColors(
                baseColor: ColorsManager.lightBlack,
                highlightColor: ColorsManager.darkLightBlack,
                child: Container(
                  color: ColorsManager.white,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ColorsManager.lightBlack,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(IconsManager.error),
                    SizedBox(height: AppWidgetHeightManager.sh10),
                    Text(StringsManager.networkError),
                  ],
                ),
              );
            },
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  // INTERACTIVE VIEW
  _interactiveImageView() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(StringsManager.imageInteractiveView),
        content: SizedBox(
          height: (_screenWidth >= AppBreakpointManager.b700)
              ? AppWidgetHeightManager.sh700
              : null,
          child: InteractiveViewer(
            child: Image.network(
              _productImagesAvailable[_selectedProductImagesIndex],
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Shimmer.fromColors(
                  baseColor: ColorsManager.lightBlack,
                  highlightColor: ColorsManager.darkLightBlack,
                  child: Container(
                    color: ColorsManager.white,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: ColorsManager.lightBlack,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(IconsManager.error),
                      SizedBox(height: AppWidgetHeightManager.sh10),
                      Text(StringsManager.networkError),
                    ],
                  ),
                );
              },
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }

  // MULTIPLE IMAGES LIST
  _productImageScrolls() {
    return SizedBox(
      height: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetHeightManager.sh600
          : AppWidgetHeightManager.sh100,
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetWidthManager.sw100
          : double.maxFinite,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: (_screenWidth >= AppBreakpointManager.b1100)
              ? Axis.vertical
              : Axis.horizontal,
          shrinkWrap: true,
          itemCount: _productImagesAvailable.length,
          separatorBuilder: (context, index) => SizedBox(
            height: (_screenWidth >= AppBreakpointManager.b1100)
                ? AppWidgetHeightManager.sh10
                : AppWidgetHeightManager.sh0,
            width: (_screenWidth >= AppBreakpointManager.b1100)
                ? AppWidgetWidthManager.sw0
                : AppWidgetWidthManager.sw10,
          ),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (_screenWidth >= AppBreakpointManager.b1100)
                  ? AppPaddingManager.p10
                  : AppPaddingManager.p0,
            ),
            child: SizedBox(
              height: (_screenWidth >= AppBreakpointManager.b700)
                  ? AppWidgetHeightManager.sh120
                  : AppWidgetHeightManager.sh80,
              width: (_screenWidth >= AppBreakpointManager.b700)
                  ? AppWidgetWidthManager.sw60
                  : AppWidgetWidthManager.sw80,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedProductImagesIndex = index;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      border: (_selectedProductImagesIndex == index)
                          ? Border.all(
                              color: ColorsManager.primary,
                              width: AppWidgetWidthManager.sw2,
                            )
                          : null,
                    ),
                    child: Image.network(
                      _productImagesAvailable[index],
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Shimmer.fromColors(
                          baseColor: ColorsManager.lightBlack,
                          highlightColor: ColorsManager.darkLightBlack,
                          child: Container(
                            color: ColorsManager.white,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: ColorsManager.lightBlack,
                          child: const Icon(IconsManager.error),
                        );
                      },
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // DYNAMIC OPTIONS
  _productOptions() {
    return Padding(
      padding: const EdgeInsets.all(AppPaddingManager.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // T-SHIRT TYPE
          _optionTitle(StringsManager.productTypeTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _productType(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT QUALITIES AVAILABLE
          _productQualityTitle(),
          _heightSpacing(AppPaddingManager.p5),
          _productQualityGuideTextButton(),
          _heightSpacing(AppPaddingManager.p10),
          _productQualities(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT SIZES AVAILABLE
          _optionTitle(StringsManager.productSizesTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _productSizes(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT COLORS AVAILABLE
          _productColorsTitle(),
          _heightSpacing(AppPaddingManager.p10),
          _productColors(),
          _heightSpacing(AppPaddingManager.p20),

          // PRINTING TECHNIQUES
          _optionTitle(StringsManager.printingTechniquesTitle, true),
          _heightSpacing(AppPaddingManager.p5),
          _printingTechniquesGuideTextButton(),
          _heightSpacing(AppPaddingManager.p10),
          _printingTechniques(),
          _heightSpacing(AppPaddingManager.p20),

          // PRINTING AREA
          _optionTitle(StringsManager.printingAreasTitle, true),
          _customPrintingAreasSwitch(),
          _heightSpacing(AppPaddingManager.p10),
          (_isCustomPrintingArea) ? _customPrintingAreas() : _printingAreas(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT QUANTITY
          _optionTitle(StringsManager.productQuantityTitle, true),
          _customProductQuantitySwitch(),
          _heightSpacing(AppPaddingManager.p10),
          (_isCustomProductQuantity)
              ? _customProductQuantity()
              : _productQuantity(),
          _heightSpacing(AppPaddingManager.p20),

          // FINAL PRICE
          _optionTitle(StringsManager.pricingTitle, false),
          _heightSpacing(AppPaddingManager.p10),
          _finalPricing(),
          _heightSpacing(AppPaddingManager.p20),

          // ORDER A SAMPLE BUTTON
          _heightSpacing(AppPaddingManager.p10),
          _requestASample(),

          // SHARE ON WHATSAPP BUTTON
          _heightSpacing(AppPaddingManager.p10),
          _shareOnWhatsApp(),
          _heightSpacing(AppPaddingManager.p20),
        ],
      ),
    );
  }

  // TITLES
  _optionTitle(String title, bool isBold) {
    return Text(
      title,
      style: (isBold) ? const TextStyle(fontWeight: FontWeight.bold) : null,
    );
  }

  // GENERAL CONTENT SPACING
  _heightSpacing(double size) {
    return SizedBox(height: size);
  }

  // T-SHIRT TYPES AVAILABLE
  _productType() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _allProductTypes.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              if (_selectedProductTypeIndex != index) {
                for (var element in _allProductTypes) {
                  element.isSelected = false;
                }
                _allProductTypes[index].isSelected = true;

                setState(() {
                  // T-SHIRT TYPES
                  _selectedProductTypeIndex = index;

                  // T-SHIRT IMAGES
                  _setProductImagesColorsAndPricing();
                  _selectedProductImagesIndex = AppValueManager.v0;

                  // T-SHIRT QUALITIES
                  _productQualitiesAvailable =
                      _allProductTypes[_selectedProductTypeIndex]
                          .productQualitiesAvailable;
                  _selectedProductQualityIndex = AppValueManager.v0;
                  _selectedProductQuality =
                      _productQualitiesAvailable[_selectedProductQualityIndex];

                  // T-SHIRT SIZES
                  _productSizesAvaialble =
                      _allProductTypes[_selectedProductTypeIndex]
                          .productSizesAvailable;
                  _selectedProductSizeIndex = AppValueManager.v0;
                  _selectedProductSize =
                      _productSizesAvaialble[_selectedProductSizeIndex];

                  // T-SHIRT COLORS
                  _setProductImagesColorsAndPricing();
                  _selectedProductColorsIndex = 0;
                  _selectedProductColor =
                      _productColorsAvailable[_selectedProductColorsIndex];

                  // PRINTING TECHNIQUES
                  _selectedPrintingTechniquesIndex = AppValueManager.v0;
                  _selectedPrintingTechnique = _printingTechniquesAvailable[
                      _selectedPrintingTechniquesIndex];

                  // PRINTING AREAS
                  _selectedPrintingArea = null;
                  _selectedPrintingAreaIndex = null;
                  _printingAreaHeight = AppValueManager.v0;
                  _printingAreaWidth = AppValueManager.v0;
                });

                // print(MediaQuery.of(context).size.width);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_allProductTypes[index].isSelected == true)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _allProductTypes[index].productType,
                style: (_allProductTypes[index].isSelected == true)
                    ? regularTextStyleManager(color: ColorsManager.white)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TITLE
  _productQualityTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.productQualityTitle, true),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Text(
            '($_selectedProductQuality: ${_getQualityGSM(_productQualitiesAvailable[_selectedProductQualityIndex])} GSM) '),
      ],
    );
  }

  // DESCRIPTION TEXT BUTTON
  _productQualityGuideTextButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showQualityDetails(_selectedProductQuality),
        child: Text(
          'What is $_selectedProductQuality?',
          style: mediumTextStyleManager(
            color: ColorsManager.blue,
          ),
        ),
      ),
    );
  }

  // QUALITY DETAILS DIALOG
  _showQualityDetails(String title) {
    String qualityDescription;

    if (title == StringsManager.productQualityPolyester) {
      qualityDescription = StringsManager.productQualityPolyesterDesciption;
    } else if (title == StringsManager.productQualityDrifit) {
      qualityDescription = StringsManager.productQualityDrifitDesciption;
    } else if (title == StringsManager.productQualityDotknit) {
      qualityDescription = StringsManager.productQualityDotknitDesciption;
    } else if (title == StringsManager.productQualitySublimationCotton) {
      qualityDescription =
          StringsManager.productQualitySublimationCottonDesciption;
    } else if (title == StringsManager.productQuality100Cotton) {
      qualityDescription = StringsManager.productQuality100CottonDesciption;
    } else if (title == StringsManager.productQualityCottonBiowash) {
      qualityDescription = StringsManager.productQualityCottonBiowashDesciption;
    } else if (title == StringsManager.productQualityMatty) {
      qualityDescription = StringsManager.productQualityMattyDesciption;
    } else if (title == StringsManager.productQualityPolyCottonMatty) {
      qualityDescription =
          StringsManager.productQualityPolyCottonMattyDescription;
    } else {
      qualityDescription = StringsManager.productDescriptionNotFound;
    }

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: AppWidgetWidthManager.sw500,
          child: Text(qualityDescription),
        ),
      ),
    );
  }

  // CALCULATING QUALITY'S GSM
  _getQualityGSM(String quality) {
    if (quality == StringsManager.productQualityPolyester) {
      return AppValueManager.v100;
    } else if (quality == StringsManager.productQualityDrifit) {
      return AppValueManager.v130;
    } else if (quality == StringsManager.productQualityDotknit) {
      return AppValueManager.v170;
    } else if (quality == StringsManager.productQualitySublimationCotton) {
      return AppValueManager.v190;
    } else if (quality == StringsManager.productQuality100Cotton) {
      return AppValueManager.v200;
    } else if (quality == StringsManager.productQualityCottonBiowash) {
      return AppValueManager.v200;
    } else if (quality == StringsManager.productQualityMatty) {
      return AppValueManager.v220;
    } else if (quality == StringsManager.productQualityPolyCottonMatty) {
      return AppValueManager.v250;
    } else {
      return AppValueManager.v0;
    }
  }

  // ALL QUALITIES
  _productQualities() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _productQualitiesAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedProductQualityIndex = index;
                _selectedProductQuality = _productQualitiesAvailable[index];

                // FOR IMAGES
                _setProductImagesColorsAndPricing();
                _selectedProductImagesIndex = AppValueManager.v0;

                // FOR COLORS
                _setProductImagesColorsAndPricing();
                _selectedProductColorsIndex = AppValueManager.v0;
                _selectedProductColor =
                    _productColorsAvailable[_selectedProductColorsIndex];
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_selectedProductQualityIndex == index)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _productQualitiesAvailable[index],
                style: (_selectedProductQualityIndex == index)
                    ? regularTextStyleManager(color: ColorsManager.white)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ALL T-SHIRT SIZES
  _productSizes() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _productSizesAvaialble.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedProductSize = _productSizesAvaialble[index];
                _selectedProductSizeIndex = index;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_selectedProductSizeIndex == index)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _productSizesAvaialble[index],
                style: (_selectedProductSizeIndex == index)
                    ? regularTextStyleManager(color: ColorsManager.white)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //  TITLE
  _productColorsTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.productColorsTitle, true),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Text(
            '(${_getColorName(_productColorsAvailable[_selectedProductColorsIndex])})'),
      ],
    );
  }

  // ALL T-SHIRT COLORS
  _productColors() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _productColorsAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p5),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedProductColorsIndex = index;
                  _selectedProductColor =
                      _productColorsAvailable[_selectedProductColorsIndex];
                });
              },
              child: Tooltip(
                message: _getColorName(_productColorsAvailable[index]),
                child: Container(
                  width: AppWidgetWidthManager.sw50,
                  height: AppWidgetHeightManager.sh50,
                  padding: const EdgeInsets.all(AppPaddingManager.p3),
                  decoration: BoxDecoration(
                    color: (_selectedProductColorsIndex == index)
                        ? ColorsManager.primary
                        : ColorsManager.transparent,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppRadiusManager.r30)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(AppPaddingManager.p2),
                    decoration: const BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppRadiusManager.r30)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _productColorsAvailable[index],
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadiusManager.r30)),
                        border: (_productColorsAvailable[index] ==
                                ColorsManager.white)
                            ? Border.all(
                                color: ColorsManager.primary,
                                width: AppWidgetWidthManager.sw0_5,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // CONVERTING COLOR TO STRING
  _getColorName(Color color) {
    if (color == ColorsManager.beigeTshirt) {
      return StringsManager.beigeColor;
    } else if (color == ColorsManager.whiteTshirt) {
      return StringsManager.whiteColor;
    } else if (color == ColorsManager.blackTshirt) {
      return StringsManager.blackColor;
    } else if (color == ColorsManager.lavenderTshirt) {
      return StringsManager.lavenderColor;
    } else if (color == ColorsManager.pinkTshirt) {
      return StringsManager.pinkColor;
    } else if (color == ColorsManager.greyTshirt) {
      return StringsManager.greyColor;
    } else if (color == ColorsManager.navyTshirt) {
      return StringsManager.navyColor;
    } else if (color == ColorsManager.greenTshirt) {
      return StringsManager.greenColor;
    } else if (color == ColorsManager.redTshirt) {
      return StringsManager.redColor;
    } else if (color == ColorsManager.orangeTshirt) {
      return StringsManager.orangeColor;
    } else if (color == ColorsManager.skyBlueTshirt) {
      return StringsManager.skyBlueColor;
    } else if (color == ColorsManager.yellowTshirt) {
      return StringsManager.yellowColor;
    } else {
      return StringsManager.emptyString;
    }
  }

  // DESCRIPTION TEXT BUTTON
  _printingTechniquesGuideTextButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showPrintingTechniquesDetails(_selectedPrintingTechnique),
        child: Text(
          'What is $_selectedPrintingTechnique?',
          style: mediumTextStyleManager(
            color: ColorsManager.blue,
          ),
        ),
      ),
    );
  }

  // QUALITY DETAILS DIALOG
  _showPrintingTechniquesDetails(String title) {
    String printingTechniqueDescription;

    if (title == StringsManager.printingTechniqueDTF) {
      printingTechniqueDescription =
          StringsManager.printingTechniquesDTFDescription;
    } else {
      printingTechniqueDescription = StringsManager.productDescriptionNotFound;
    }

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: AppWidgetWidthManager.sw500,
          child: Text(printingTechniqueDescription),
        ),
      ),
    );
  }

  // ALL PRINTING TECHNIQUES
  _printingTechniques() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _printingTechniquesAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedPrintingTechniquesIndex = index;
                _selectedPrintingTechnique = _printingTechniquesAvailable[
                    _selectedPrintingTechniquesIndex];
                _selectedPrintingArea = null;
                _selectedPrintingAreaIndex = null;
                _printingAreaHeight = AppValueManager.v0;
                _printingAreaWidth = AppValueManager.v0;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_selectedPrintingTechniquesIndex == index)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _printingTechniquesAvailable[index],
                style: (_selectedPrintingTechniquesIndex == index)
                    ? regularTextStyleManager(color: ColorsManager.white)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // SWITCH
  _customPrintingAreasSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.customPrintitngArea, false),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Switch(
          value: _isCustomPrintingArea,
          onChanged: (value) {
            setState(() {
              _isCustomPrintingArea = !_isCustomPrintingArea;
              _selectedPrintingArea = null;
              _selectedPrintingAreaIndex = null;
              _printingAreaHeight = AppValueManager.v0;
              _printingAreaWidth = AppValueManager.v0;
            });
          },
        ),
      ],
    );
  }

  // PRINTING AREAS SELECT
  _customPrintingAreas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(StringsManager.customPrintingHeight),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            DropdownButton(
              value: _printingAreaHeight,
              menuMaxHeight: AppWidgetHeightManager.sh500,
              elevation: AppValueManager.v10,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppPaddingManager.p10),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadiusManager.r10)),
              icon: const Icon(IconsManager.arrowDown),
              items: List.generate(
                AppValueManager.v23,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text(
                    (index).toString(),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _printingAreaHeight = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(width: AppWidgetWidthManager.sw10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(StringsManager.customPrintingWidth),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            DropdownButton(
              value: _printingAreaWidth,
              menuMaxHeight: AppWidgetHeightManager.sh500,
              elevation: AppValueManager.v10,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppPaddingManager.p10),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadiusManager.r10)),
              icon: const Icon(IconsManager.arrowDown),
              items: List.generate(
                AppValueManager.v23,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text(
                    (index).toString(),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _printingAreaWidth = value!;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  // ALL PRINTING AREAS
  _printingAreas() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _printingAreaAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedPrintingArea = _printingAreaAvailable[index];
                _selectedPrintingAreaIndex = index;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_selectedPrintingAreaIndex == index)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _printingAreaAvailable[index],
                style: (_selectedPrintingAreaIndex == index)
                    ? regularTextStyleManager(color: ColorsManager.white)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // SWITCH
  _customProductQuantitySwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.customProductQuality, false),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Switch(
          value: _isCustomProductQuantity,
          onChanged: (value) {
            setState(() {
              _isCustomProductQuantity = !_isCustomProductQuantity;
              _customProductErrorMessage = StringsManager.emptyString;
              _productQuantityValue = AppValueManager.v1;
              _productQuantitySliderValue = AppValueManager.v1;
            });
          },
        ),
      ],
    );
  }

  // T-SHIRT QUANTITY SELECT
  _customProductQuantity() {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        initialValue: _productQuantityValue.toString(),
        cursorColor: ColorsManager.primary,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        maxLines: AppValueManager.v1,
        maxLength: AppValueManager.v4,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: StringsManager.customProductsNumber,
          errorText: (_customProductErrorMessage == StringsManager.emptyString)
              ? null
              : _customProductErrorMessage,
        ),
        onChanged: (value) {
          if (value == StringsManager.emptyString || value.isEmpty) {
            setState(() {
              _customProductErrorMessage =
                  StringsManager.customProductsErrorNumberEmpty;
            });
          } else if (int.parse(value) < AppValueManager.v1) {
            setState(() {
              _customProductErrorMessage =
                  StringsManager.customProductsErrorNumberBetween1To9999;
            });
          } else {
            setState(() {
              _customProductErrorMessage = StringsManager.emptyString;
              _productQuantityValue = int.parse(value);
            });
          }
        },
      ),
    );
  }

  // ALL T-SHIRT QUANTITY
  _productQuantity() {
    return SizedBox(
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? double.maxFinite
          : AppWidgetWidthManager.sw400,
      child: Column(
        children: [
          Container(
            height: AppWidgetHeightManager.sh35,
            padding:
                const EdgeInsets.symmetric(horizontal: AppPaddingManager.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _productQuantityList.length,
                (index) => SizedBox(
                  height: AppWidgetHeightManager.sh35,
                  width: AppWidgetWidthManager.sw27,
                  child: Column(
                    children: [
                      Text(_productQuantityList[index]),
                      const SizedBox(height: AppWidgetHeightManager.sh4),
                      Container(
                        height: AppWidgetHeightManager.sh10,
                        width: AppWidgetWidthManager.sw1,
                        color: ColorsManager.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Slider(
            min: AppValueManager.v1.toDouble(),
            max: AppValueManager.v500.toDouble(),
            value: _productQuantitySliderValue.toDouble(),
            divisions: _productQuantityList.length - 1,
            onChanged: (value) {
              setState(() {
                _productQuantitySliderValue = value.toInt();
                _setProductQuantity(value.toInt());
              });
            },
          ),
        ],
      ),
    );
  }

  // CONVERTING SLIDER'S DATA TO INTEGER
  _setProductQuantity(int value) {
    if (value == AppValueManager.v1) {
      _productQuantityValue = AppValueManager.v1;
    } else if (value == AppValueManager.v84) {
      _productQuantityValue = AppValueManager.v25;
    } else if (value == AppValueManager.v167) {
      _productQuantityValue = AppValueManager.v50;
    } else if (value == AppValueManager.v250) {
      _productQuantityValue = AppValueManager.v100;
    } else if (value == AppValueManager.v333) {
      _productQuantityValue = AppValueManager.v200;
    } else if (value == AppValueManager.v416) {
      _productQuantityValue = AppValueManager.v300;
    } else if (value == AppValueManager.v500) {
      _productQuantityValue = AppValueManager.v500;
    } else {
      _productQuantityValue = AppValueManager.v1;
    }
  }

  // TOTAL PRICING CALCULATION
  _finalPricing() {
    _setPrintingPrice();
    const int pressingChargeMinimum = AppValueManager.v10;
    const int pressingChargeMaximum = AppValueManager.v40;
    _printingPriceMinimum = (_printingAreaHeight > AppValueManager.v0 &&
            _printingAreaWidth > AppValueManager.v0)
        ? (_printingAreaHeight * _printingAreaWidth) +
            pressingChargeMinimum +
            AppValueManager.v30
        : AppValueManager.v0;
    _printingPriceMaximum = (_printingAreaHeight > AppValueManager.v0 &&
            _printingAreaWidth > AppValueManager.v0)
        ? (_printingAreaHeight * _printingAreaWidth) +
            pressingChargeMaximum +
            AppValueManager.v100
        : AppValueManager.v0;
    _finalPriceMinimum =
        (_productPrice + _printingPriceMinimum) * _productQuantityValue;
    _finalPriceMaximum =
        (_productPrice + _printingPriceMaximum) * _productQuantityValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (_finalPriceMinimum != _finalPriceMaximum)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${StringsManager.pricingCurrency}$_finalPriceMinimum',
                    style: boldTextStyleManager(
                      color: ColorsManager.black,
                      fontSize: FontSizeManager.f24,
                    ),
                  ),
                  Text(
                    ' - ${StringsManager.pricingCurrency}$_finalPriceMaximum',
                    style: boldTextStyleManager(
                      color: ColorsManager.black,
                      fontSize: FontSizeManager.f24,
                    ),
                  ),
                ],
              )
            : Text(
                '${StringsManager.pricingCurrency}$_finalPriceMinimum',
                style: boldTextStyleManager(
                  color: ColorsManager.black,
                  fontSize: FontSizeManager.f24,
                ),
              ),
        const SizedBox(height: AppWidgetHeightManager.sh10),
        Text(
            '• Product Price: ${StringsManager.pricingCurrency}$_productPrice'),
        const SizedBox(height: AppWidgetHeightManager.sh5),
        (_printingAreaHeight > AppValueManager.v0 &&
                _printingAreaWidth > AppValueManager.v0)
            ? Text(
                '• Printing & Handling: ${StringsManager.pricingCurrency}$_printingPriceMinimum - ${StringsManager.pricingCurrency}$_printingPriceMaximum')
            : const Text('• Printing & Handling: ₹${AppValueManager.v0}'),
        const SizedBox(height: AppWidgetHeightManager.sh5),
        Text('• Product Quantity: ${_productQuantityValue.toInt()}'),
        const SizedBox(height: AppWidgetHeightManager.sh5),
        const Text(StringsManager.warningPricesNotIncluded),
        const SizedBox(height: AppWidgetHeightManager.sh5),
        const Text(StringsManager.warningBulkDiscounts),
        const SizedBox(height: AppWidgetHeightManager.sh10),
        Text(
          StringsManager.warningPricesMayVary,
          style: boldTextStyleManager(
            color: ColorsManager.black,
            fontSize: FontSizeManager.f14,
          ),
        ),
      ],
    );
  }

  // CALCULATING PRINTING PRICE
  _setPrintingPrice() {
    if (_selectedPrintingTechnique == StringsManager.printingTechniqueDTF) {
      if (_selectedPrintingArea == StringsManager.printingAreasA3) {
        _printingAreaHeight = AppValueManager.v16;
        _printingAreaWidth = AppValueManager.v12;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA4) {
        _printingAreaHeight = AppValueManager.v12;
        _printingAreaWidth = AppValueManager.v8;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA5) {
        _printingAreaHeight = AppValueManager.v8;
        _printingAreaWidth = AppValueManager.v6;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA6) {
        _printingAreaHeight = AppValueManager.v6;
        _printingAreaWidth = AppValueManager.v4;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA7) {
        _printingAreaHeight = AppValueManager.v4;
        _printingAreaWidth = AppValueManager.v2;
      }
    }
  }

  // BUTTON
  _requestASample() {
    return InkWell(
      onTap: () {
        _whatsAppMessage = "HI, I WANTED TO ORDER A SAMPLE OF PRODUCT \n• Type: ${_allProductTypes[_selectedProductTypeIndex].productType} \n• Quality: $_selectedProductQuality (₹$_productPrice) \n• Size: $_selectedProductSize \n• Color: ${_getColorName(_selectedProductColor)} \n• Printing: $_selectedPrintingTechnique \n• Printing Area (inch): $_printingAreaHeight x $_printingAreaWidth \n• Quantity: $_productQuantityValue";
        _sendMessageOnWhatsapp();
      }, 
      child: Container(
        height: AppWidgetHeightManager.sh50,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: ColorsManager.primary,
            borderRadius:
                BorderRadius.all(Radius.circular(AppRadiusManager.r10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppWidgetHeightManager.sh30,
              child: Center(
                child: Icon(
                  IconsManager.orderASampleIcon,
                  size: AppWidgetHeightManager.sh30,
                  color: ColorsManager.white,
                ),
              ),
            ),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            Text(
              StringsManager.orderASampleButtonText,
              style: mediumTextStyleManager(
                color: ColorsManager.white,
                fontSize: FontSizeManager.f18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BUTTON
  _shareOnWhatsApp() {
    return InkWell(
      onTap: () {
        _whatsAppMessage = "Hi, I'M LOOKING FOR A PRODUCT OF \n• Type: ${_allProductTypes[_selectedProductTypeIndex].productType} \n• Quality: $_selectedProductQuality (₹$_productPrice) \n• Size: $_selectedProductSize \n• Color: ${_getColorName(_selectedProductColor)} \n• Printing: $_selectedPrintingTechnique \n• Printing Area (inch): $_printingAreaHeight x $_printingAreaWidth \n• Printing and Handling: ₹$_printingPriceMinimum - ₹$_printingPriceMaximum \n• Quantity: $_productQuantityValue \nFINAL COST RANGE: ₹$_finalPriceMinimum - ₹$_finalPriceMaximum";
        _sendMessageOnWhatsapp();
      }, 
      child: Container(
        height: AppWidgetHeightManager.sh50,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: ColorsManager.whatsappGreen,
            borderRadius:
                BorderRadius.all(Radius.circular(AppRadiusManager.r10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppWidgetHeightManager.sh30,
              child: Image.asset(AssetsManager.whatsappLogo),
            ),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            Text(
              StringsManager.whatsappButtonText,
              style: mediumTextStyleManager(
                color: ColorsManager.white,
                fontSize: FontSizeManager.f18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SENDING MESSAGE ON WHATSAPP
  Future<void> _sendMessageOnWhatsapp() async {
    final Uri url = Uri.parse("https://wa.me/$_whatsAppNumber?text=$_whatsAppMessage");

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      )) {
      throw Exception('Could not launch $url');
    }
  }
}
