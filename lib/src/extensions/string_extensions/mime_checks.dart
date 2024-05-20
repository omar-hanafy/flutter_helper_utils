import 'package:mime/mime.dart';

extension FHUMimeChecksExtensions on String? {
  String? mimeType({List<int>? headerBytes}) =>
      lookupMimeType(this ?? '', headerBytes: headerBytes);
}

extension FHUVideoMimeChecksExtensions on String? {
  /// Checks if a file path or URL represents a video file.
  bool get isVideo {
    final mt = mimeType();
    return mt?.startsWith('video/') ?? false;
  }

  /// Checks if a file path or URL represents an MP4 video file.
  bool get isMP4 {
    final mt = mimeType();
    return mt == 'video/mp4';
  }

  /// Checks if a file path or URL represents a MOV video file.
  bool get isMOV {
    final mt = mimeType();
    return mt == 'video/quicktime';
  }

  /// Checks if a file path or URL represents an AVI video file.
  bool get isAVI {
    final mt = mimeType();
    return mt == 'video/x-msvideo';
  }

  /// Checks if a file path or URL represents a WMV video file.
  bool get isWMV {
    final mt = mimeType();
    return mt == 'video/x-ms-wmv';
  }

  /// Checks if a file path or URL represents an MKV video file.
  bool get isMKV {
    final mt = mimeType();
    return mt == 'video/x-matroska';
  }

  /// Checks if a file path or URL represents a WebM video file.
  bool get isWebM {
    final mt = mimeType();
    return mt == 'video/webm';
  }

  /// Checks if a file path or URL represents an FLV video file.
  bool get isFLV {
    final mt = mimeType();
    return mt == 'video/x-flv';
  }
}

extension FHUImageMimeChecksExtensions on String? {
  /// Checks if a file path or URL represents an image file.
  bool get isImage {
    final mt = mimeType();
    return mt?.startsWith('image/') ?? false;
  }

  /// Checks if a file path or URL represents a PNG image.
  bool get isPNG {
    final mt = mimeType();
    return mt == 'image/png';
  }

  /// Checks if a file path or URL represents an icon file.
  bool get isIcon {
    final mt = mimeType();
    return mt == 'image/x-icon' || // Common MIME type for .ico files
        mt == 'image/x-icns'; // Common MIME type for .icns files
    // You can add more MIME types if there are other icon formats you want to support.
  }

  /// Checks if a file path or URL represents an ICO image.

  bool get isICO => mimeType() == 'image/x-icon';

  /// Checks if a file path or URL represents an ICNS image.
  bool get isICNS => mimeType() == 'image/x-icns';

  /// Checks if a file path or URL represents a HEIF image.

  bool get isHEIF => mimeType() == 'image/heif';

  /// Checks if a file path or URL represents a HEIC image.

  bool get isHEIC => mimeType() == 'image/heic';

  /// Checks if a file path or URL represents a JPEG or JPG image.
  bool get isJPEG => isJPG; // Alias for JPG

  /// Checks if a file path or URL represents a JPEG or JPG image.
  bool get isJPG {
    final mt = mimeType();
    return mt == 'image/jpeg';
  }

  /// Checks if a file path or URL represents an SVG image.
  bool get isSVG {
    final mt = mimeType();
    return mt == 'image/svg+xml';
  }

  /// Checks if a file path or URL represents a GIF image.
  bool get isGIF {
    final mt = mimeType();
    return mt == 'image/gif';
  }

  /// Checks if a file path or URL represents a WebP image.
  bool get isWebP {
    final mt = mimeType();
    return mt == 'image/webp';
  }

  /// Checks if a file path or URL represents a BMP image.
  bool get isBMP {
    final mt = mimeType();
    return mt == 'image/bmp';
  }

  /// Checks if a file path or URL represents a TIFF or TIF image.
  bool get isTIFF => isTIF; // Alias for TIF

  /// Checks if a file path or URL represents a TIFF or TIF image.
  bool get isTIF {
    final mt = mimeType();
    return mt == 'image/tiff';
  }
}

extension FHUDocumentMimeChecksExtensions on String? {
  /// Checks if the file path or URL represents a PDF document.
  ///
  /// Returns `true` if the MIME type is `application/pdf`.
  bool get isPDF {
    final mt = mimeType();
    return mt == 'application/pdf';
  }

  /// Checks if the file path or URL represents a Microsoft Word document.
  ///
  /// Returns `true` for both DOC and DOCX formats (`application/msword` and
  /// `application/vnd.openxmlformats-officedocument.wordprocessingml.document`).
  bool get isDOCX {
    final mt = mimeType();
    return mt ==
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ||
        mt == 'application/msword';
  }

  /// Alias for `isDOCX` to cover both DOC and DOCX formats.
  bool get isDOC => isDOCX;

  /// Checks if the file path or URL represents any Microsoft Excel spreadsheet. (.xls or .xlsx)
  bool get isExcel {
    final mt = mimeType();
    return mt == 'application/vnd.ms-excel' || // Old .xls
        mt ==
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'; // .xlsx
  }

  /// Checks if the file path or URL represents a latest Microsoft Excel spreadsheet.
  bool get isXLSX {
    final mt = mimeType();
    return mt ==
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ||
        mt == 'application/vnd.ms-excel';
  }

  /// Checks if the file path or URL represents an old Microsoft Excel spreadsheet.
  bool get isXLS {
    final mt = mimeType();
    return mt == 'application/vnd.ms-excel';
  }

  /// Checks if a file path or URL represents a Microsoft PowerPoint presentation (.ppt or .pptx).
  bool get isPowerPoint {
    final mt = mimeType();
    return mt == 'application/vnd.ms-powerpoint' || // Old .ppt
        mt ==
            'application/vnd.openxmlformats-officedocument.presentationml.presentation'; // .pptx
  }

  /// Checks if a file path or URL represents a latest Microsoft PowerPoint presentation (.pptx).
  bool get isPPTX {
    final mt = mimeType();
    return mt ==
        'application/vnd.openxmlformats-officedocument.presentationml.presentation';
  }

  /// Checks if a file path or URL represents an Old Microsoft PowerPoint presentation (.pptx).
  bool get isPPT {
    final mt = mimeType();
    return mt == 'application/vnd.ms-powerpoint';
  }

  /// Checks if the file path or URL represents a plain text document.
  ///
  /// Returns `true` if the MIME type is `text/plain`.
  bool get isTXT {
    final mt = mimeType();
    return mt == 'text/plain';
  }

  /// Checks if the file path or URL represents a markdown file.
  ///
  /// Returns `true` if the MIME type is `text/markdown`.
  bool get isMarkdown {
    final mt = mimeType();
    return mt == 'text/markdown';
  }

  /// Checks if the file path or URL represents a Rich Text Format document.
  ///
  /// Returns `true` if the MIME type is `application/rtf`.
  bool get isRTF {
    final mt = mimeType();
    return mt == 'application/rtf';
  }
}

extension FHUAudioMimeChecksExtensions on String? {
  /// Checks if a file path or URL represents an audio file.
  bool get isAudio {
    final mt = mimeType();
    return mt?.startsWith('audio/') ?? false;
  }

  /// Checks if a file path or URL represents an MP3 audio file.
  bool get isMP3 {
    final mt = mimeType();
    return mt == 'audio/mpeg';
  }

  /// Checks if a file path or URL represents a WAV audio file.
  bool get isWAV {
    final mt = mimeType();
    return mt == 'audio/wav' || mt == 'audio/x-wav';
  }

  /// Checks if a file path or URL represents an AAC audio file.
  bool get isAAC {
    final mt = mimeType();
    return mt == 'audio/aac';
  }

  /// Checks if a file path or URL represents a FLAC audio file.
  bool get isFLAC {
    final mt = mimeType();
    return mt == 'audio/x-flac';
  }

  /// Checks if a file path or URL represents an OGG (Vorbis) audio file.
  bool get isOGG {
    final mt = mimeType();
    return mt?.contains('/ogg') ?? false;
  }

  /// Checks if a file path or URL represents an AIFF audio file.
  bool get isAIFF {
    final mt = mimeType();
    return mt == 'audio/aiff' || mt == 'audio/x-aiff';
  }
}

extension FHUArchiveMimeChecksExtensions on String? {
  /// Checks if a file path or URL represents an archive file.
  bool get isArchive {
    final mt = mimeType();
    return mt == 'application/zip' ||
        mt == 'application/x-rar-compressed' ||
        mt == 'application/x-7z-compressed' ||
        mt == 'application/x-tar' ||
        mt == 'application/x-iso9660-image' ||
        mt == 'application/gzip';
  }

  /// Checks if a file path or URL represents a ZIP archive.
  bool get isZIP {
    final mt = mimeType();
    return mt == 'application/zip';
  }

  /// Checks if a file path or URL represents a ZIP archive.
  bool get isDeb {
    final mt = mimeType();
    return mt == 'application/x-debian-package';
  }

  /// Checks if a file path or URL represents a RAR archive.
  bool get isRAR {
    final mt = mimeType();
    return mt == 'application/x-rar-compressed';
  }

  /// Checks if a file path or URL represents a 7-Zip archive.
  bool get is7Z {
    final mt = mimeType();
    return mt == 'application/x-7z-compressed';
  }

  /// Checks if a file path or URL represents a TAR archive.
  bool get isTAR {
    final mt = mimeType();
    return mt == 'application/x-tar';
  }

  /// Checks if a file path or URL represents a GZIP compressed file.
  bool get isGZIP => isGZ; // alias for GZ

  bool get isGZ {
    final mt = mimeType();
    return mt == 'application/gzip';
  }

  /// Checks if a file path or URL represents an ISO disc image.
  bool get isISO {
    final mt = mimeType();
    return mt == 'application/x-iso9660-image';
  }
}

extension FHUProgrammingMimeChecksExtensions on String? {
  /// Checks if a file path or URL represents an HTML file.
  bool get isHTML {
    final mt = mimeType();
    return mt == 'text/html';
  }

  /// Checks if a file path or URL represents a CSS file.
  bool get isCSS {
    final mt = mimeType();
    return mt == 'text/css';
  }

  /// Checks if a file path or URL represents a Python script.
  bool get isPython {
    final mt = mimeType();
    return mt == 'text/x-python';
  }

  /// Checks if a file path or URL represents a JAVA source file.
  bool get isJAVA {
    final mt = mimeType();
    return mt == 'text/x-java-source';
  }

  /// Checks if a file path or URL represents a PHP file.
  bool get isPHP {
    final mt = mimeType();
    return mt == 'application/x-httpd-php';
  }

  /// Checks if a file path or URL represents an XML file.
  bool get isXML {
    final mt = mimeType();
    return mt == 'application/xml' || mt == 'text/xml';
  }

  /// Checks if a file path or URL represents a JSON file.
  bool get isJSON {
    final mt = mimeType();
    return mt == 'application/json';
  }

  /// Checks if a file path or URL represents a JavaScript file.
  bool get isJavaScript {
    final mt = mimeType();
    return mt == 'application/javascript';
  }

  /// Checks if a file path or URL represents a TypeScript file.
  bool get isTypeScript {
    final mt = mimeType();
    return mt == 'application/typescript';
  }

  /// Checks if a file path or URL represents a C# source file.
  bool get isCSharp {
    final mt = mimeType();
    return mt == 'text/x-csharp';
  }

  /// Checks if a file path or URL represents a C++ source file.
  bool get isCpp {
    final mt = mimeType();
    return mt == 'text/x-c++src';
  }

  /// Checks if a file path or URL represents a C source file.
  bool get isC {
    final mt = mimeType();
    return mt == 'text/x-csrc';
  }

  /// Checks if a file path or URL represents a Go source file.
  bool get isGo {
    final mt = mimeType();
    return mt == 'text/x-go';
  }

  /// Checks if a file path or URL represents a Ruby source file.
  bool get isRuby {
    final mt = mimeType();
    return mt == 'text/x-ruby';
  }

  /// Checks if a file path or URL represents a Swift source file.
  bool get isSwift {
    final mt = mimeType();
    return mt == 'text/x-swift';
  }

  /// Checks if a file path or URL represents a Kotlin source file.
  bool get isKotlin {
    final mt = mimeType();
    return mt == 'text/x-kotlin';
  }
}

extension FHUContactMimeChecksExtensions on String? {
  /// Checks if a file path or URL represents a contact file.
  bool get isContact {
    final mt = mimeType();
    return mt == 'text/vcard' || mt == 'text/x-vcard';
  }
}

extension FHUFontMimeChecksExtensions on String? {
  /// Checks if a file path or URL represents a font file.
  bool get isFont {
    final mt = mimeType();
    if (mt == null) return false;
    return mt.contains('font') ||
        mt == 'application/vnd.ms-fontobject' ||
        mt == 'application/x-font-woff';
  }

  /// Checks if a file path or URL represents a TrueType Font file.
  bool get isTTF {
    final mt = mimeType();
    if (mt == null) return false;
    return mt.contains('font') && mt.contains('ttf');
  }

  /// Checks if a file path or URL represents an OpenType Font file.
  bool get isOTF {
    final mt = mimeType();
    if (mt == null) return false;
    return mt.contains('font') && mt.contains('otf');
  }

  /// Checks if a file path or URL represents a Web Open Font Format file.
  bool get isWOFF => mimeType() == 'application/x-font-woff';

  bool get isWOFF2 => mimeType() == 'font/woff2';

  /// Checks if a file path or URL represents an Embedded OpenType file.
  bool get isEOT {
    final mt = mimeType();
    return mt == 'application/vnd.ms-fontobject';
  }
}
