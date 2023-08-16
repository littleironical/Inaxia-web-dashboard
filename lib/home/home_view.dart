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
  final List<AllTshirtTypesModel> _allTshirtTypes = [];

  // FOR T-SHIRT TYPE & PRICE
  int _selectedTshirtTypeIndex = AppValueManager.v0;

  // FOR T-SHIRT IMAGES
  late List _selectedTshirtImages;
  int _selectedTshirtImagesIndex = AppValueManager.v0;

  // FOR T-SHIRT QUALITIES
  late List _tshirtQualitiesAvailable;
  late String _selectedTshirtQuality;
  int _selectedTshirtQualityIndex = AppValueManager.v0;

  // FOR T-SHIRT SIZES
  late List _tshirtSizesAvaialble;
  late String _selectedTshirtSize;
  int _selectedTshirtSizeIndex = AppValueManager.v0;

  // FOR T-SHIRT COLORS
  late List _tshirtColorsAvailable;
  late Color _selectedTshirtColor;
  int _selectedTshirtColorsIndex = AppValueManager.v0;

  // PRINITNG TECHNIQUES
  final List _printingTechniquesAvailable = [
    StringsManager.printingTechniqueDTF,
  ];
  String? _selectedPrintingTechnique;
  int? _selectedPrintingTechniquesIndex;

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
  final List _tshirtQuantityList = [
    StringsManager.tshirtQuantity1,
    StringsManager.tshirtQuantity25,
    StringsManager.tshirtQuantity50,
    StringsManager.tshirtQuantity100,
    StringsManager.tshirtQuantity200,
    StringsManager.tshirtQuantity300,
    StringsManager.tshirtQuantity500,
  ];
  int _tshirtQuantityValue = AppValueManager.v1;
  int _tshirtQuantitySliderValue = AppValueManager.v1;
  bool _isCustomTshirtQuantity = false;
  String _customTshirtErrorMessage = StringsManager.emptyString;

  // FINAL PRICING
  late double _tshirtPrice;
  late int _printingPriceMinimum;
  late int _printingPriceMaximum;
  late double _finalPriceMinimum;
  late double _finalPriceMaximum;

  // INITIALIZING ALL DATA
  @override
  void initState() {
    _initializeAllTshirtTypes();
    _initializeTshirt();
    super.initState();
  }

  _initializeAllTshirtTypes() {
    _allTshirtTypes.add(
      AllTshirtTypesModel(
        true,
        StringsManager.tshirtTypeRoundNeck,
        [
          AssetsManager.regularTshirt1,
          AssetsManager.regularTshirt2,
          AssetsManager.regularTshirt3,
          AssetsManager.regularTshirt4,
          AssetsManager.regularTshirt5,
        ],
        [
          StringsManager.tshirtQualityPolyester,
          StringsManager.tshirtQualityDrifit,
          StringsManager.tshirtQualityDotknit,
          StringsManager.tshirtQualitySublimationCotton,
          StringsManager.tshirtQuality100Cotton,
          StringsManager.tshirtQualityCottonBiowash,
        ],
        [
          StringsManager.tshirtSizesS,
          StringsManager.tshirtSizesM,
          StringsManager.tshirtSizesL,
          StringsManager.tshirtSizesXL,
          StringsManager.tshirtSizes2XL,
        ],
      ),
    );
    _allTshirtTypes.add(
      AllTshirtTypesModel(
        false,
        StringsManager.tshirtTypePolo,
        [
          AssetsManager.poloTshirt1,
          AssetsManager.poloTshirt2,
          AssetsManager.poloTshirt3,
          AssetsManager.poloTshirt4,
          AssetsManager.poloTshirt5,
        ],
        [
          StringsManager.tshirtQualityMatty,
          StringsManager.tshirtQualityPolyCottonMatty,
        ],
        [
          StringsManager.tshirtSizesS,
          StringsManager.tshirtSizesM,
          StringsManager.tshirtSizesL,
          StringsManager.tshirtSizesXL,
          StringsManager.tshirtSizes2XL,
        ],
      ),
    );
  }

  _initializeTshirt() {
    for (var element in _allTshirtTypes) {
      if (element.isSelected == true) {
        // T-SHIRT QUALITIES
        _tshirtQualitiesAvailable = element.tshirtQualitiesAvailable;
        _selectedTshirtQuality =
            _tshirtQualitiesAvailable[_selectedTshirtQualityIndex];

        // T-SHIRT SIZES
        _tshirtSizesAvaialble = element.tshirtSizesAvailable;

        // T-SHIRT COLORS
        _tshirtColorsAvailable = _getTshirtColorsAvailable();
        _selectedTshirtColor =
            _tshirtColorsAvailable[_selectedTshirtColorsIndex];

        // T-SHIRT IMAGES
        _selectedTshirtImages = element.tshirtImages;
      }
    }
  }

  // T-SHIRT COLOR BASED ON QUALITY
  _getTshirtColorsAvailable() {
    if (_selectedTshirtQuality == StringsManager.tshirtQualityPolyester) {
      return [
        ColorsManager.whiteTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.redTshirt,
        ColorsManager.greenTshirt,
        ColorsManager.greyTshirt,
      ];
    } else if (_selectedTshirtQuality == StringsManager.tshirtQualityDrifit) {
      return [
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
    } else if (_selectedTshirtQuality == StringsManager.tshirtQualityDotknit) {
      return [
        ColorsManager.whiteTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.greenTshirt,
        ColorsManager.pinkTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.redTshirt,
      ];
    } else if (_selectedTshirtQuality ==
        StringsManager.tshirtQualitySublimationCotton) {
      return [
        ColorsManager.whiteTshirt,
        ColorsManager.greenTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.pinkTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.greyTshirt,
      ];
    } else if (_selectedTshirtQuality ==
        StringsManager.tshirtQuality100Cotton) {
      return [
        ColorsManager.whiteTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.greyTshirt,
        ColorsManager.redTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.blackTshirt,
      ];
    } else if (_selectedTshirtQuality ==
        StringsManager.tshirtQualityCottonBiowash) {
      return [
        ColorsManager.whiteTshirt,
        ColorsManager.yellowTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.orangeTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.redTshirt,
        ColorsManager.greyTshirt,
        ColorsManager.pinkTshirt,
      ];
    } else if (_selectedTshirtQuality == StringsManager.tshirtQualityMatty) {
      return [
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
    } else if (_selectedTshirtQuality ==
        StringsManager.tshirtQualityPolyCottonMatty) {
      return [
        ColorsManager.whiteTshirt,
        ColorsManager.redTshirt,
        ColorsManager.skyBlueTshirt,
        ColorsManager.blackTshirt,
        ColorsManager.greyTshirt,
        ColorsManager.orangeTshirt,
      ];
    } else {
      return [];
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
          _selectedTshirtTypeIndex = AppValueManager.v0;

          for (var element in _allTshirtTypes) {
            element.isSelected = false;
          }
          _allTshirtTypes[_selectedTshirtTypeIndex].isSelected = true;

          // T-SHIRT IMAGES
          _selectedTshirtImagesIndex = AppValueManager.v0;
          _selectedTshirtImages =
              _allTshirtTypes[_selectedTshirtTypeIndex].tshirtImages;

          // T-SHIRT QUALITIES
          _tshirtQualitiesAvailable = _allTshirtTypes[_selectedTshirtTypeIndex]
              .tshirtQualitiesAvailable;
          _selectedTshirtQualityIndex = AppValueManager.v0;
          _selectedTshirtQuality =
              _tshirtQualitiesAvailable[_selectedTshirtQualityIndex];

          // T-SHIRT SIZES
          _tshirtSizesAvaialble =
              _allTshirtTypes[_selectedTshirtTypeIndex].tshirtSizesAvailable;
          _selectedTshirtSizeIndex = AppValueManager.v0;
          _selectedTshirtSize = _tshirtSizesAvaialble[_selectedTshirtSizeIndex];

          // T-SHIRT COLORS
          _tshirtColorsAvailable = _getTshirtColorsAvailable();
          _selectedTshirtColorsIndex = AppValueManager.v0;
          _selectedTshirtColor =
              _tshirtColorsAvailable[_selectedTshirtColorsIndex];

          // PRINTING TECHNIQUES
          _selectedPrintingTechnique = null;
          _selectedPrintingTechniquesIndex = null;

          // PRINTING AREAS
          _selectedPrintingArea = null;
          _selectedPrintingAreaIndex = null;

          // QUANTITY
          _tshirtQuantityValue = AppValueManager.v1;
          _tshirtQuantitySliderValue = AppValueManager.v1;
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
                : (_screenWidth >= AppBreakpointManager.b550)
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
          : (_screenWidth >= AppBreakpointManager.b550)
              ? AppWidgetHeightManager.sh500
              : AppWidgetHeightManager.sh590,
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetWidthManager.sw400
          : (_screenWidth >= AppBreakpointManager.b550)
              ? AppWidgetWidthManager.sw400
              : double.maxFinite,
      child: Container(
        color: _selectedTshirtColor,
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
                if (_selectedTshirtImagesIndex ==
                    (_allTshirtTypes[_selectedTshirtTypeIndex]
                            .tshirtImages
                            .length -
                        1)) {
                  return;
                } else {
                  setState(() {
                    _selectedTshirtImagesIndex++;
                  });
                }
              }

              // SWIPED RIGHT - PREVIUOS IMAGE TO BE SEEN
              else if (swipeDirection == 'right') {
                if (_selectedTshirtImagesIndex == 0) {
                  return;
                } else {
                  setState(() {
                    _selectedTshirtImagesIndex--;
                  });
                }
              }
            },
            child: Image.network(
              _selectedTshirtImages[_selectedTshirtImagesIndex],
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

  // INTERACTIVE VIEW
  _interactiveImageView() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(StringsManager.imageInteractiveView),
        content: Container(
          color: _selectedTshirtColor,
          child: InteractiveViewer(
            child: Image.network(
              _selectedTshirtImages[_selectedTshirtImagesIndex],
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
          itemCount: _selectedTshirtImages.length,
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
            child: Container(
              height: (_screenWidth >= AppBreakpointManager.b550)
                  ? AppWidgetHeightManager.sh120
                  : AppWidgetHeightManager.sh80,
              width: (_screenWidth >= AppBreakpointManager.b550)
                  ? AppWidgetWidthManager.sw60
                  : AppWidgetWidthManager.sw80,
              color: _selectedTshirtColor,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTshirtImagesIndex = index;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      border: (_selectedTshirtImagesIndex == index)
                          ? Border.all(
                              color: ColorsManager.primary,
                              width: AppWidgetWidthManager.sw2,
                            )
                          : null,
                    ),
                    child: Image.network(
                      _selectedTshirtImages[index],
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
          _optionTitle(StringsManager.tshirtTypeTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _tshirtType(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT QUALITIES AVAILABLE
          _tshirtQualityTitle(),
          _heightSpacing(AppPaddingManager.p5),
          _tshirtQualityGuideTextButton(),
          _heightSpacing(AppPaddingManager.p10),
          _tshirtQualities(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT SIZES AVAILABLE
          _optionTitle(StringsManager.tshirtSizesTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _tshirtSizes(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT COLORS AVAILABLE
          _tshirtColorsTitle(),
          _heightSpacing(AppPaddingManager.p10),
          _tshirtColors(),
          _heightSpacing(AppPaddingManager.p20),

          // PRINTING TECHNIQUES
          _optionTitle(StringsManager.printingTechniquesTitle, true),
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
          _optionTitle(StringsManager.tshirtQuantityTitle, true),
          _customTshirtQuantitySwitch(),
          _heightSpacing(AppPaddingManager.p10),
          (_isCustomTshirtQuantity)
              ? _customTshirtQuantity()
              : _tshirtQuantity(),
          _heightSpacing(AppPaddingManager.p20),

          // FINAL PRICE
          _optionTitle(StringsManager.pricingTitle, false),
          _heightSpacing(AppPaddingManager.p10),
          _finalPricing(),
          _heightSpacing(AppPaddingManager.p20),

          // ORDER A SAMPLE BUTTON
          _heightSpacing(AppPaddingManager.p10),
          _orderASample(),

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
  _tshirtType() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _allTshirtTypes.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              if (_selectedTshirtTypeIndex != index) {
                for (var element in _allTshirtTypes) {
                  element.isSelected = false;
                }
                _allTshirtTypes[index].isSelected = true;

                setState(() {
                  // T-SHIRT TYPES
                  _selectedTshirtTypeIndex = index;

                  // T-SHIRT IMAGES
                  _selectedTshirtImages =
                      _allTshirtTypes[_selectedTshirtTypeIndex].tshirtImages;
                  _selectedTshirtImagesIndex = AppValueManager.v0;

                  // T-SHIRT QUALITIES
                  _tshirtQualitiesAvailable =
                      _allTshirtTypes[_selectedTshirtTypeIndex]
                          .tshirtQualitiesAvailable;
                  _selectedTshirtQualityIndex = AppValueManager.v0;
                  _selectedTshirtQuality =
                      _tshirtQualitiesAvailable[_selectedTshirtQualityIndex];

                  // T-SHIRT SIZES
                  _tshirtSizesAvaialble =
                      _allTshirtTypes[_selectedTshirtTypeIndex]
                          .tshirtSizesAvailable;
                  _selectedTshirtSizeIndex = AppValueManager.v0;
                  _selectedTshirtSize =
                      _tshirtSizesAvaialble[_selectedTshirtSizeIndex];

                  // T-SHIRT COLORS
                  _tshirtColorsAvailable = _getTshirtColorsAvailable();
                  _selectedTshirtColorsIndex = 0;
                  _selectedTshirtColor =
                      _tshirtColorsAvailable[_selectedTshirtColorsIndex];

                  // PRINTING TECHNIQUES
                  _selectedPrintingTechnique = null;
                  _selectedPrintingTechniquesIndex = null;

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
              backgroundColor: (_allTshirtTypes[index].isSelected == true)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _allTshirtTypes[index].tshirtType,
                style: (_allTshirtTypes[index].isSelected == true)
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
  _tshirtQualityTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.tshirtQualityTitle, true),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Text(
            '($_selectedTshirtQuality: ${_getQualityGSM(_tshirtQualitiesAvailable[_selectedTshirtQualityIndex])} GSM) '),
      ],
    );
  }

  // DESCRIPTION TEXT BUTTON
  _tshirtQualityGuideTextButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showQualityDetails(_selectedTshirtQuality),
        child: Text(
          'What is $_selectedTshirtQuality?',
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

    if (title == StringsManager.tshirtQualityPolyester) {
      qualityDescription = StringsManager.tshirtQualityPolyesterDesciption;
    } else if (title == StringsManager.tshirtQualityDrifit) {
      qualityDescription = StringsManager.tshirtQualityDrifitDesciption;
    } else if (title == StringsManager.tshirtQualityDotknit) {
      qualityDescription = StringsManager.tshirtQualityDotknitDesciption;
    } else if (title == StringsManager.tshirtQualitySublimationCotton) {
      qualityDescription =
          StringsManager.tshirtQualitySublimationCottonDesciption;
    } else if (title == StringsManager.tshirtQuality100Cotton) {
      qualityDescription = StringsManager.tshirtQuality100CottonDesciption;
    } else if (title == StringsManager.tshirtQualityCottonBiowash) {
      qualityDescription = StringsManager.tshirtQualityCottonBiowashDesciption;
    } else if (title == StringsManager.tshirtQualityMatty) {
      qualityDescription = StringsManager.tshirtQualityMattyDesciption;
    } else if (title == StringsManager.tshirtQualityPolyCottonMatty) {
      qualityDescription =
          StringsManager.tshirtQualityPolyCottonMattyDescription;
    } else {
      qualityDescription = StringsManager.tshirtQualityDescriptionNotFound;
    }

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(qualityDescription),
      ),
    );
  }

  // CALCULATING QUALITY'S GSM
  _getQualityGSM(String quality) {
    if (quality == StringsManager.tshirtQualityPolyester) {
      return AppValueManager.v100;
    } else if (quality == StringsManager.tshirtQualityDrifit) {
      return AppValueManager.v130;
    } else if (quality == StringsManager.tshirtQualityDotknit) {
      return AppValueManager.v170;
    } else if (quality == StringsManager.tshirtQualitySublimationCotton) {
      return AppValueManager.v190;
    } else if (quality == StringsManager.tshirtQuality100Cotton) {
      return AppValueManager.v200;
    } else if (quality == StringsManager.tshirtQualityCottonBiowash) {
      return AppValueManager.v200;
    } else if (quality == StringsManager.tshirtQualityMatty) {
      return AppValueManager.v220;
    } else if (quality == StringsManager.tshirtQualityPolyCottonMatty) {
      return AppValueManager.v250;
    } else {
      return AppValueManager.v0;
    }
  }

  // ALL QUALITIES
  _tshirtQualities() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _tshirtQualitiesAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedTshirtQualityIndex = index;
                _selectedTshirtQuality = _tshirtQualitiesAvailable[index];
                _tshirtColorsAvailable = _getTshirtColorsAvailable();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_selectedTshirtQualityIndex == index)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _tshirtQualitiesAvailable[index],
                style: (_selectedTshirtQualityIndex == index)
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
  _tshirtSizes() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _tshirtSizesAvaialble.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedTshirtSize = _tshirtSizesAvaialble[index];
                _selectedTshirtSizeIndex = index;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_selectedTshirtSizeIndex == index)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _tshirtSizesAvaialble[index],
                style: (_selectedTshirtSizeIndex == index)
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
  _tshirtColorsTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.tshirtColorsTitle, true),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Text(
            '(${_getColorName(_tshirtColorsAvailable[_selectedTshirtColorsIndex])})'),
      ],
    );
  }

  // ALL T-SHIRT COLORS
  _tshirtColors() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _tshirtColorsAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p5),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTshirtColorsIndex = index;
                  _selectedTshirtColor = _tshirtColorsAvailable[index];
                });
              },
              child: Tooltip(
                message: _getColorName(_tshirtColorsAvailable[index]),
                child: Container(
                  width: AppWidgetWidthManager.sw50,
                  height: AppWidgetHeightManager.sh50,
                  padding: const EdgeInsets.all(AppPaddingManager.p3),
                  decoration: BoxDecoration(
                    color: (_selectedTshirtColorsIndex == index)
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
                        color: _tshirtColorsAvailable[index],
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadiusManager.r30)),
                        border: (_tshirtColorsAvailable[index] ==
                                ColorsManager.whiteTshirt)
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
    } else {
      return StringsManager.emptyString;
    }
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
                _selectedPrintingTechnique =
                    _printingTechniquesAvailable[index];
                _selectedPrintingTechniquesIndex = index;
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
              _printingAreaHeight = 0;
              _printingAreaWidth = 0;
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
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: (_selectedPrintingTechniquesIndex == null)
                  ? StringsManager.selectPrintingTechnique
                  : StringsManager.emptyString,
              child: DropdownButton(
                value: _printingAreaHeight,
                menuMaxHeight: AppWidgetHeightManager.sh400,
                elevation: AppValueManager.v10,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPaddingManager.p10),
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadiusManager.r10)),
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
                onChanged: (_selectedPrintingTechniquesIndex == null)
                    ? null
                    : (value) {
                        setState(() {
                          _printingAreaHeight = int.parse(value.toString());
                        });
                      },
              ),
            ),
          ],
        ),
        const SizedBox(width: AppWidgetWidthManager.sw10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(StringsManager.customPrintingWidth),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: (_selectedPrintingTechniquesIndex == null)
                  ? StringsManager.selectPrintingTechnique
                  : StringsManager.emptyString,
              child: DropdownButton(
                value: _printingAreaWidth,
                menuMaxHeight: AppWidgetHeightManager.sh400,
                elevation: AppValueManager.v10,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPaddingManager.p10),
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadiusManager.r10)),
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
                onChanged: (_selectedPrintingTechniquesIndex == null)
                    ? null
                    : (value) {
                        setState(() {
                          _printingAreaWidth = int.parse(value.toString());
                        });
                      },
              ),
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
          child: Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: (_selectedPrintingTechniquesIndex == null)
                ? StringsManager.selectPrintingTechnique
                : StringsManager.emptyString,
            child: ElevatedButton(
              onPressed: (_selectedPrintingTechniquesIndex == null)
                  ? null
                  : () {
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
      ),
    );
  }

  // SWITCH
  _customTshirtQuantitySwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.customTshirtQuality, false),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Switch(
          value: _isCustomTshirtQuantity,
          onChanged: (value) {
            setState(() {
              _isCustomTshirtQuantity = !_isCustomTshirtQuantity;
              _customTshirtErrorMessage = StringsManager.emptyString;
              _tshirtQuantityValue = AppValueManager.v1;
              _tshirtQuantitySliderValue = AppValueManager.v1;
            });
          },
        ),
      ],
    );
  }

  // T-SHIRT QUANTITY SELECT
  _customTshirtQuantity() {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        initialValue: _tshirtQuantityValue.toString(),
        cursorColor: ColorsManager.primary,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        maxLines: AppValueManager.v1,
        maxLength: AppValueManager.v3,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: StringsManager.customTshirtsNumber,
          errorText: (_customTshirtErrorMessage == StringsManager.emptyString)
              ? null
              : _customTshirtErrorMessage,
        ),
        onChanged: (value) {
          if (value == StringsManager.emptyString || value.isEmpty) {
            setState(() {
              _customTshirtErrorMessage =
                  StringsManager.customTshirtsErrorNumberEmpty;
            });
          } else if (int.parse(value) < 1) {
            setState(() {
              _customTshirtErrorMessage =
                  StringsManager.customTshirtsErrorNumberBetween1To999;
            });
          } else {
            setState(() {
              _customTshirtErrorMessage = StringsManager.emptyString;
              _tshirtQuantityValue = int.parse(value);
            });
          }
        },
      ),
    );
  }

  // ALL T-SHIRT QUANTITY
  _tshirtQuantity() {
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
                _tshirtQuantityList.length,
                (index) => SizedBox(
                  height: AppWidgetHeightManager.sh35,
                  width: AppWidgetWidthManager.sw27,
                  child: Column(
                    children: [
                      Text(_tshirtQuantityList[index]),
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
            value: _tshirtQuantitySliderValue.toDouble(),
            divisions: _tshirtQuantityList.length - 1,
            onChanged: (value) {
              setState(() {
                _tshirtQuantitySliderValue = value.toInt();
                _setTshirtQuantity(value.toInt());
              });
            },
          ),
        ],
      ),
    );
  }

  // CONVERTING SLIDER'S DATA TO INTEGER
  _setTshirtQuantity(int value) {
    if (value == AppValueManager.v1) {
      _tshirtQuantityValue = AppValueManager.v1;
    } else if (value == AppValueManager.v84) {
      _tshirtQuantityValue = AppValueManager.v25;
    } else if (value == AppValueManager.v167) {
      _tshirtQuantityValue = AppValueManager.v50;
    } else if (value == AppValueManager.v250) {
      _tshirtQuantityValue = AppValueManager.v100;
    } else if (value == AppValueManager.v333) {
      _tshirtQuantityValue = AppValueManager.v200;
    } else if (value == AppValueManager.v416) {
      _tshirtQuantityValue = AppValueManager.v300;
    } else if (value == AppValueManager.v500) {
      _tshirtQuantityValue = AppValueManager.v500;
    } else {
      _tshirtQuantityValue = AppValueManager.v1;
    }
  }

  // TOTAL PRICING CALCULATION
  _finalPricing() {
    _setTshirtPrice();
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
        (_tshirtPrice + _printingPriceMinimum) * _tshirtQuantityValue;
    _finalPriceMaximum =
        (_tshirtPrice + _printingPriceMaximum) * _tshirtQuantityValue;

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
        Text('• Product Price: ${StringsManager.pricingCurrency}$_tshirtPrice'),
        const SizedBox(height: AppWidgetHeightManager.sh5),
        (_printingAreaHeight > AppValueManager.v0 &&
                _printingAreaWidth > AppValueManager.v0)
            ? Text(
                '• Printing & Handling: ${StringsManager.pricingCurrency}$_printingPriceMinimum - ${StringsManager.pricingCurrency}$_printingPriceMaximum')
            : const Text('• Printing & Handling: ₹${AppValueManager.v0}'),
        const SizedBox(height: AppWidgetHeightManager.sh5),
        Text('• Product Quantity: ${_tshirtQuantityValue.toInt()}'),
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

  // CALCULATING T-SHIRT PRICE
  _setTshirtPrice() {
    if (_selectedTshirtQuality == StringsManager.tshirtQualityPolyester) {
      _tshirtPrice = AppValueManager.v85.toDouble();
    } else if (_selectedTshirtQuality == StringsManager.tshirtQualityDrifit) {
      _tshirtPrice = AppValueManager.v110.toDouble();
    } else if (_selectedTshirtQuality == StringsManager.tshirtQualityDotknit) {
      _tshirtPrice = AppValueManager.v120.toDouble();
    } else if (_selectedTshirtQuality ==
        StringsManager.tshirtQualitySublimationCotton) {
      _tshirtPrice = AppValueManager.v170.toDouble();
    } else if (_selectedTshirtQuality ==
        StringsManager.tshirtQuality100Cotton) {
      _tshirtPrice = AppValueManager.v180.toDouble();
    } else if (_selectedTshirtQuality ==
        StringsManager.tshirtQualityCottonBiowash) {
      _tshirtPrice = AppValueManager.v190.toDouble();
    } else if (_selectedTshirtQuality == StringsManager.tshirtQualityMatty) {
      _tshirtPrice = AppValueManager.v130.toDouble();
    } else if (_selectedTshirtQuality ==
        StringsManager.tshirtQualityPolyCottonMatty) {
      _tshirtPrice = AppValueManager.v160.toDouble();
    } else {
      _tshirtPrice = AppValueManager.v0.toDouble();
    }
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
      } else {
        _printingAreaHeight = AppValueManager.v0;
        _printingAreaWidth = AppValueManager.v0;
      }
    }
  }

  // BUTTON
  _orderASample() {
    return InkWell(
      onTap: () => _sendWhatsappMessage(
          'Hi, I wanted to order a sample of \n• T-shirt Type: ${_allTshirtTypes[_selectedTshirtTypeIndex].tshirtType} \n• T-shirt Size: $_selectedTshirtSize \n• T-shirt Color: ${_getColorName(_selectedTshirtColor)} \n• Printing Technique: $_selectedPrintingTechnique \n• Printing Area (inch): $_printingAreaHeight x $_printingAreaWidth \n• Product Price: ₹$_tshirtPrice \n• Printing Price: ₹$_printingPriceMinimum \n• T-shirt Quantity: $_tshirtQuantityValue \nTotal Cost: ₹$_finalPriceMinimum \nFinal Price: ₹$_finalPriceMinimum'),
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
      onTap: () => _sendWhatsappMessage(
          'Hi, I\'m looking for... \n• T-shirt Type: ${_allTshirtTypes[_selectedTshirtTypeIndex].tshirtType} \n• T-shirt Size: $_selectedTshirtSize \n• T-shirt Color: ${_getColorName(_selectedTshirtColor)} \n• Printing Technique: $_selectedPrintingTechnique \n• Printing Area (inch): $_printingAreaHeight x $_printingAreaWidth \n• Product Price: ₹$_tshirtPrice \n• Printing Price: ₹$_printingPriceMinimum \n• T-shirt Quantity: $_tshirtQuantityValue \nTotal Cost: ₹$_finalPriceMinimum \nFinal Price: ₹$_finalPriceMinimum'),
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
  Future _sendWhatsappMessage(String whatsAppMessage) async {
    const String whatsappNumber =
        '919319289478'; // INAXIA OFFICIAL WHATSAPP NUMBER
    String message = whatsAppMessage;
    // 'Hi, I\'m looking for... \n• T-shirt Type: ${_allTshirtTypes[_selectedTshirtTypeIndex].tshirtType} \n• T-shirt Size: $_selectedTshirtSize \n• T-shirt Color: ${_getColorName(_selectedTshirtColor)} \n• Printing Technique: $_selectedPrintingTechnique \n• Printing Area (inch): $_printingAreaHeight x $_printingAreaWidth \n• Product Price: ₹$_tshirtPrice \n• Printing Price: ₹$_printingPrice \n• T-shirt Quantity: $_tshirtQuantityValue \nTotal Cost: ₹$_totalCost \nDiscount: $_discountValue% \nFinal Price: ₹$_finalDiscountedPrice';
    final url = Uri.parse("https://wa.me/$whatsappNumber?text=$message");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
