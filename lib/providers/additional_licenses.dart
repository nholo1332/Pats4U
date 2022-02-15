import 'package:flutter/foundation.dart';

class AdditionalLicenses extends LicenseEntry {
  @override
  final List<String> packages;
  @override
  final List<LicenseParagraph> paragraphs;

  AdditionalLicenses(this.packages, this.paragraphs);
}

// Actually add the licenses
Stream<LicenseEntry> licenses() async* {
  yield AdditionalLicenses(
    [
      'SKvector',
    ],
    [
      const LicenseParagraph(
        '"Illustration with School Building and Owl" - school event background image. Licensed through Envato Elements subscription.',
        0,
      ),
    ],
  );
  yield AdditionalLicenses(
    [
      'Chanut_industries',
    ],
    [
      const LicenseParagraph(
        '"20 Sport isometric elements pack" - event background image. Licensed through Envato Elements subscription.',
        0,
      ),
    ],
  );
  yield AdditionalLicenses(
    [
      'uicreativenet',
    ],
    [
      const LicenseParagraph(
        '"Sport Poster" - event background behind isometric graphics. Image edited to fit needs. Licensed through Envato Elements subscription.',
        0,
      ),
    ],
  );
  yield AdditionalLicenses(
    [
      'Poppins Font',
    ],
    [
      const LicenseParagraph(
        'Provided by Google Fonts. https://fonts.google.com/specimen/Poppins?query=poppins',
        0,
      ),
    ],
  );
}

void addLicenses() {
  LicenseRegistry.addLicense(licenses);
}