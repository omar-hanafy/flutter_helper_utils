// import 'package:mime/mime.dart';
//
// void main() {
//   var testCases = {
//     'holiday_trip.html': (String? path) => path!.isHTML,
//     'style.css': (String? path) => path!.isCSS,
//     'script.py': (String? path) => path!.isPython,
//     'Application.java': (String? path) => path!.isJAVA,
//     'server.php': (String? path) => path!.isPHP,
//     'data.xml': (String? path) => path!.isXML,
//     'config.json': (String? path) => path!.isJSON,
//     'holiday_trip.mp4': (String? path) => path!.isVideo && path.isMP4,
//     'https://www.example.com/music.mp3': (String? path) =>
//         path!.isAudio && path.isMP3,
//     'profile_picture.jpg': (String? path) => path!.isImage && path.isJPEG,
//     'document.pdf': (String? path) => path.isPDF,
//     'logo.svg': (String? path) => path!.isImage && path.isSVG,
//     'recording.wav': (String? path) => path!.isAudio && path.isWAV,
//     'my_song.wma': (String? path) => path!.isAudio,
//     'family_photo.png': (String? path) => path!.isImage && path.isPNG,
//     'presentation.pptx': (String? path) => path.isPPTX,
//     'spreadsheet.xlsx': (String? path) => path.isXLSX,
//     'archive.zip': (String? path) => path.isArchive,
//     'archive.rar': (String? path) => path.isArchive,
//     'archive.7z': (String? path) => path.isArchive,
//     'archive.iso': (String? path) => path.isArchive,
//     'font.ttf': (String? path) => path.isTTF && path.isFont,
//     'contact.vcf': (String? path) => path!.isContact,
//     'audio.aac': (String? path) => path!.isAudio && path.isAAC,
//     'image.bmp': (String? path) => path!.isImage && path.isBMP,
//     'video.avi': (String? path) => path!.isVideo && path.isAVI,
//     'holiday_movie.mov': (String? path) => path!.isVideo && path.isMOV,
//     'video.wmv': (String? path) => path!.isVideo && path.isWMV,
//     'film.mkv': (String? path) => path!.isVideo && path.isMKV,
//     'clip.webm': (String? path) => path!.isVideo && path.isWebM,
//     'funny_video.flv': (String? path) => path!.isVideo && path.isFLV,
//     'presentation.old.ppt': (String? path) => path.isPPT,
//     'presentation.pptx': (String? path) => path.isPPTX,
//     'sheet.xls': (String? path) => path.isXLS,
//     'compressed.7z': (String? path) => path!.isArchive && path.is7Z,
//     'data.tar': (String? path) => path!.isArchive && path.isTAR,
//     'backup.gzip': (String? path) => path!.isArchive && path.isGZ,
//     'disk.iso': (String? path) => path!.isArchive && path.isISO,
//     'contact_card.txt': (String? path) => path.isTXT,
//     'novel.txt': (String? path) => path.isTXT,
//     'report.rtf': (String? path) => path.isRTF,
//     'photo.tiff': (String? path) => path!.isImage && path.isTIFF,
//     'album.ogg': (String? path) => path!.isAudio && path.isOGG,
//     'fancy_font.otf': (String? path) => path!.isFont && path.isOTF,
//     'website_logo.webp': (String? path) => path!.isImage && path.isWebP,
//     'application_font.eot': (String? path) => path!.isFont && path.isEOT,
//     'presentation.ppt': (String? path) => path.isPPT,
//     'spreadsheet.xls': (String? path) => path.isXLS,
//     'font.otf': (String? path) => path!.isFont && path.isOTF,
//     'contact.vcard': (String? path) => path!.isContact,
//     'audio.flac': (String? path) => path!.isAudio && path.isFLAC,
//     'image.gif': (String? path) => path!.isImage && path.isGIF,
//     'video.mov': (String? path) => path!.isVideo && path.isMOV,
//     'document.docx': (String? path) => path.isDOCX,
//     'font.woff': (String? path) => path!.isFont && path.isWOFF,
//     'document.txt': (String? path) => path.isTXT,
//     'font.eot': (String? path) => path!.isFont && path.isEOT,
//     'image.png': (String? path) => path!.isImage && path.isPNG,
//     'video.mkv': (String? path) => path!.isVideo && path.isMKV,
//     'document.rtf': (String? path) => path.isRTF,
//     'image.tif': (String? path) => path!.isImage && path.isTIFF,
//     'video.webm': (String? path) => path!.isVideo && path.isWebM,
//     'archive.tar': (String? path) => path!.isArchive && path.isTAR,
//     'image.webp': (String? path) => path!.isImage && path.isWebP,
//     'video.flv': (String? path) => path!.isVideo && path.isFLV,
//     'archive.gz': (String? path) => path!.isArchive && path.isGZ,
//     'document.doc': (String? path) => path.isDOC,
//     'video.3gp': (String? path) =>
//         path!.isVideo, // Assuming generic video check for 3gp
//     'image.jpg': (String? path) => path!.isImage && path.isJPEG,
//     'video.ts': (String? path) =>
//         path!.isVideo, // Assuming generic video check for ts
//     'image.tiff': (String? path) => path!.isImage && path.isTIFF,
//     'video.vob': (String? path) =>
//         path!.isVideo, // Assuming generic video check for vob
//     'video.asf': (String? path) =>
//         path!.isVideo, // Assuming generic video check for asf
//     'video.ogv': (String? path) => path!.isVideo && path.isOGG,
//
//     // Audio Formats
//     'song.aiff': (String? path) => path!.isAudio && path.isAIFF,
//     'soundtrack.wav': (String? path) => path.isAudio && path.isWAV,
//     'ringtone.amr': (String? path) => path.isWAV,
//     'music.opus': (String? path) =>
//         path.isAudio && path.isOGG, // Assuming opus is checked via isOGG
//
//     // Image Formats
//     'icon.ico': (String? path) => path!.isImage && path.isICO,
//     'icon.icns': (String? path) => path!.isImage && path.isICNS,
//     'sketch.heif': (String? path) => path.isImage && path.isHEIF,
//     'banner.heic': (String? path) => path.isImage && path.isHEIC,
//
//     // Archive Formats
//     'package.deb': (String? path) => path.isDeb,
//     'bundle.rpm': (String? path) => path.isVideo,
//
//     // Font Formats
//     'vector_font.svg': (String? path) => path.isSVG,
//     'web_font.woff2': (String? path) => path.isFont && path.isWOFF2,
//     'web_font.woff1': (String? path) => path.isFont && path.isWOFF,
//     'web_font.woff': (String? path) => path.isFont && path.isWOFF,
//
//     // Video Formats
//     'trailer.mpeg': (String? path) => path.isVideo,
//     'animation.m4v': (String? path) => path.isVideo,
//
//     // Miscellaneous
//     'presentation.key': (String? path) => path.isVideo,
//     'spreadsheet.numbers': (String? path) => path.isVideo,
//     'document.pages': (String? path) => path.isVideo,
//
//     'family_movie.mov': (String? path) => path.isMOV,
//     'tutorial.avi': (String? path) => path.isAVI,
//     'game_clip.wmv': (String? path) => path.isWMV,
//     'documentary.mkv': (String? path) => path.isMKV,
//     'presentation.webm': (String? path) => path.isWebM,
//     'animation.flv': (String? path) => path.isFLV,
//     'portrait.png': (String? path) => path.isPNG,
//     'icon.ico': (String? path) => path.isICO,
//     'photo.heif': (String? path) => path.isHEIF,
//     'picture.heic': (String? path) => path.isHEIC,
//     'image.jpeg': (String? path) => path.isJPEG,
//     'snapshot.jpg': (String? path) => path.isJPG,
//     'vector_graphic.svg': (String? path) => path.isSVG,
//     'funny_meme.gif': (String? path) => path.isGIF,
//     'website_image.webp': (String? path) => path.isWebP,
//     'scan.bmp': (String? path) => path.isBMP,
//     'archive_document.tiff': (String? path) => path.isTIFF,
//     'old_scan.tif': (String? path) => path.isTIF,
//     'report.pdf': (String? path) => path.isPDF,
//     'manual.docx': (String? path) => path.isDOCX,
//     'letter.doc': (String? path) => path.isDOC,
//     'spreadsheet.xlsx': (String? path) => path.isXLSX,
//     'financial_report.xls': (String? path) => path.isXLS,
//     'presentation_file.pptx': (String? path) => path.isPPTX,
//     'slides.ppt': (String? path) => path.isPPT,
//     'notes.txt': (String? path) => path.isTXT,
//     'formatted_text.rtf': (String? path) => path.isRTF,
//     'song.mp3': (String? path) => path.isMP3,
//     'sound_effect.wav': (String? path) => path.isWAV,
//     'podcast.aac': (String? path) => path.isAAC,
//     'album.flac': (String? path) => path.isFLAC,
//     'audio_book.ogg': (String? path) => path.isOGG,
//     'recording.aiff': (String? path) => path.isAIFF,
//     'compressed_files.zip': (String? path) => path.isZIP,
//     'archive.rar': (String? path) => path.isRAR,
//     'backup.7z': (String? path) => path.is7Z,
//     'data.tar': (String? path) => path.isTAR,
//     'log_files.gzip': (String? path) => path.isGZIP,
//     'system_image.iso': (String? path) => path.isISO,
//     // Assuming you'd have specific cases or representations for contacts, fonts, etc.
//     'contact_info.vcf': (String? path) =>
//         path.isContact, // Example, adjust based on actual getter
//     'font.ttf': (String? path) => path.isTTF,
//     'open_font.otf': (String? path) => path.isOTF,
//     'web_font.woff': (String? path) => path.isWOFF,
//     'embedded_font.eot': (String? path) => path.isEOT,
//     'latest_web_font.woff2': (String? path) => path.isWOFF2,
//   };
//
//   testCases.forEach((file, test) {
//     if (test(file)) {
//     } else {
//       final type = lookupMimeType(file);
//       if (type != null) {
//         print("Test failed for $file || ${type}");
//       }
//     }
//   });
// }
//
// extension VideoMimeChecksExtensions on String? {
//   /// Checks if a file path or URL represents a video file.
//   bool get isVideo {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType?.startsWith('video/') ?? false;
//   }
//
//   /// Checks if a file path or URL represents an MP4 video file.
//   bool get isMP4 {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'video/mp4';
//   }
//
//   /// Checks if a file path or URL represents a MOV video file.
//   bool get isMOV {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'video/quicktime';
//   }
//
//   /// Checks if a file path or URL represents an AVI video file.
//   bool get isAVI {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'video/x-msvideo';
//   }
//
//   /// Checks if a file path or URL represents a WMV video file.
//   bool get isWMV {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'video/x-ms-wmv';
//   }
//
//   /// Checks if a file path or URL represents an MKV video file.
//   bool get isMKV {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'video/x-matroska';
//   }
//
//   /// Checks if a file path or URL represents a WebM video file.
//   bool get isWebM {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'video/webm';
//   }
//
//   /// Checks if a file path or URL represents an FLV video file.
//   bool get isFLV {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'video/x-flv';
//   }
// }
//
// extension ImageMimeChecksExtensions on String? {
//   /// Checks if a file path or URL represents an image file.
//   bool get isImage {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType?.startsWith('image/') ?? false;
//   }
//
//   /// Checks if a file path or URL represents a PNG image.
//   bool get isPNG {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'image/png';
//   }
//
//   /// Checks if a file path or URL represents an icon file.
//   bool get isIcon {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'image/x-icon' || // Common MIME type for .ico files
//         mimeType == 'image/x-icns'; // Common MIME type for .icns files
//     // You can add more MIME types if there are other icon formats you want to support.
//   }
//
//   /// Checks if a file path or URL represents an ICO image.
//
//   bool get isICO => lookupMimeType(this ?? '') == 'image/x-icon';
//
//   /// Checks if a file path or URL represents an ICNS image.
//   bool get isICNS => lookupMimeType(this ?? '') == 'image/x-icns';
//
//   /// Checks if a file path or URL represents a HEIF image.
//
//   bool get isHEIF => lookupMimeType(this ?? '') == 'image/heif';
//
//   /// Checks if a file path or URL represents a HEIC image.
//
//   bool get isHEIC => lookupMimeType(this ?? '') == 'image/heic';
//
//   /// Checks if a file path or URL represents a JPEG or JPG image.
//   bool get isJPEG => isJPG; // Alias for JPG
//
//   /// Checks if a file path or URL represents a JPEG or JPG image.
//   bool get isJPG {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'image/jpeg';
//   }
//
//   /// Checks if a file path or URL represents an SVG image.
//   bool get isSVG {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'image/svg+xml';
//   }
//
//   /// Checks if a file path or URL represents a GIF image.
//   bool get isGIF {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'image/gif';
//   }
//
//   /// Checks if a file path or URL represents a WebP image.
//   bool get isWebP {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'image/webp';
//   }
//
//   /// Checks if a file path or URL represents a BMP image.
//   bool get isBMP {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'image/bmp';
//   }
//
//   /// Checks if a file path or URL represents a TIFF or TIF image.
//   bool get isTIFF => isTIF; // Alias for TIF
//
//   /// Checks if a file path or URL represents a TIFF or TIF image.
//   bool get isTIF {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'image/tiff';
//   }
// }
//
// extension DocumentMimeChecksExtensions on String? {
//   /// Checks if the file path or URL represents a PDF document.
//   ///
//   /// Returns `true` if the MIME type is `application/pdf`.
//   bool get isPDF {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/pdf';
//   }
//
//   /// Checks if the file path or URL represents a Microsoft Word document.
//   ///
//   /// Returns `true` for both DOC and DOCX formats (`application/msword` and
//   /// `application/vnd.openxmlformats-officedocument.wordprocessingml.document`).
//   bool get isDOCX {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType ==
//             'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ||
//         mimeType == 'application/msword';
//   }
//
//   /// Alias for `isDOCX` to cover both DOC and DOCX formats.
//   bool get isDOC => isDOCX;
//
//   /// Checks if the file path or URL represents any Microsoft Excel spreadsheet. (.xls or .xlsx)
//   bool get isExcel {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/vnd.ms-excel' || // Old .xls
//         mimeType ==
//             'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'; // .xlsx
//   }
//
//   /// Checks if the file path or URL represents a latest Microsoft Excel spreadsheet.
//   bool get isXLSX {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType ==
//             'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ||
//         mimeType == 'application/vnd.ms-excel';
//   }
//
//   /// Checks if the file path or URL represents an old Microsoft Excel spreadsheet.
//   bool get isXLS {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/vnd.ms-excel';
//   }
//
//   /// Checks if a file path or URL represents a Microsoft PowerPoint presentation (.ppt or .pptx).
//   bool get isPowerPoint {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/vnd.ms-powerpoint' || // Old .ppt
//         mimeType ==
//             'application/vnd.openxmlformats-officedocument.presentationml.presentation'; // .pptx
//   }
//
//   /// Checks if a file path or URL represents a latest Microsoft PowerPoint presentation (.pptx).
//   bool get isPPTX {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType ==
//         'application/vnd.openxmlformats-officedocument.presentationml.presentation';
//   }
//
//   /// Checks if a file path or URL represents an Old Microsoft PowerPoint presentation (.pptx).
//   bool get isPPT {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/vnd.ms-powerpoint';
//   }
//
//   /// Checks if the file path or URL represents a plain text document.
//   ///
//   /// Returns `true` if the MIME type is `text/plain`.
//   bool get isTXT {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'text/plain';
//   }
//
//   /// Checks if the file path or URL represents a Rich Text Format document.
//   ///
//   /// Returns `true` if the MIME type is `application/rtf`.
//   bool get isRTF {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/rtf';
//   }
// }
//
// extension AudioMimeChecksExtensions on String? {
//   /// Checks if a file path or URL represents an audio file.
//   bool get isAudio {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType?.startsWith('audio/') ?? false;
//   }
//
//   /// Checks if a file path or URL represents an MP3 audio file.
//   bool get isMP3 {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'audio/mpeg';
//   }
//
//   /// Checks if a file path or URL represents a WAV audio file.
//   bool get isWAV {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'audio/wav' || mimeType == 'audio/x-wav';
//   }
//
//   /// Checks if a file path or URL represents an AAC audio file.
//   bool get isAAC {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'audio/aac';
//   }
//
//   /// Checks if a file path or URL represents a FLAC audio file.
//   bool get isFLAC {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'audio/x-flac';
//   }
//
//   /// Checks if a file path or URL represents an OGG (Vorbis) audio file.
//   bool get isOGG {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType?.contains('/ogg') ?? false;
//   }
//
//   /// Checks if a file path or URL represents an AIFF audio file.
//   bool get isAIFF {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'audio/aiff' || mimeType == 'audio/x-aiff';
//   }
// }
//
// extension ArchiveMimeChecksExtensions on String? {
//   /// Checks if a file path or URL represents an archive file.
//   bool get isArchive {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/zip' ||
//         mimeType == 'application/x-rar-compressed' ||
//         mimeType == 'application/x-7z-compressed' ||
//         mimeType == 'application/x-tar' ||
//         mimeType == 'application/x-iso9660-image' ||
//         mimeType == 'application/gzip';
//   }
//
//   /// Checks if a file path or URL represents a ZIP archive.
//   bool get isZIP {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/zip';
//   }
//
//   /// Checks if a file path or URL represents a ZIP archive.
//   bool get isDeb {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/x-debian-package';
//   }
//
//   /// Checks if a file path or URL represents a RAR archive.
//   bool get isRAR {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/x-rar-compressed';
//   }
//
//   /// Checks if a file path or URL represents a 7-Zip archive.
//   bool get is7Z {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/x-7z-compressed';
//   }
//
//   /// Checks if a file path or URL represents a TAR archive.
//   bool get isTAR {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/x-tar';
//   }
//
//   /// Checks if a file path or URL represents a GZIP compressed file.
//   bool get isGZIP => isGZ; // alias for GZ
//
//   bool get isGZ {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/gzip';
//   }
//
//   /// Checks if a file path or URL represents an ISO disc image.
//   bool get isISO {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/x-iso9660-image';
//   }
// }
//
// extension ContactMimeChecksExtensions on String? {
//   /// Checks if a file path or URL represents a contact file.
//   bool get isContact {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'text/vcard' || mimeType == 'text/x-vcard';
//   }
// }
//
// extension FontMimeChecksExtensions on String? {
//   /// Checks if a file path or URL represents a font file.
//   bool get isFont {
//     final mimeType = lookupMimeType(this ?? '');
//     if (mimeType == null) return false;
//     return mimeType.contains('font') ||
//         mimeType == 'application/vnd.ms-fontobject' ||
//         mimeType == 'application/x-font-woff';
//   }
//
//   /// Checks if a file path or URL represents a TrueType Font file.
//   bool get isTTF {
//     final mimeType = lookupMimeType(this ?? '');
//     if (mimeType == null) return false;
//     return mimeType.contains('font') && mimeType.contains('ttf');
//   }
//
//   /// Checks if a file path or URL represents an OpenType Font file.
//   bool get isOTF {
//     final mimeType = lookupMimeType(this ?? '');
//     if (mimeType == null) return false;
//     return mimeType.contains('font') && mimeType.contains('otf');
//   }
//
//   /// Checks if a file path or URL represents a Web Open Font Format file.
//   bool get isWOFF => lookupMimeType(this ?? '') == 'application/x-font-woff';
//   bool get isWOFF2 => lookupMimeType(this ?? '') == 'font/woff2';
//
//   /// Checks if a file path or URL represents an Embedded OpenType file.
//   bool get isEOT {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/vnd.ms-fontobject';
//   }
// }
//
// extension ProgrammingMimeChecksExtensions on String? {
//   /// Checks if a file path or URL represents an HTML file.
//   bool get isHTML {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'text/html';
//   }
//
//   /// Checks if a file path or URL represents a CSS file.
//   bool get isCSS {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'text/css';
//   }
//
//   /// Checks if a file path or URL represents a Python script.
//   bool get isPython {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'text/x-python';
//   }
//
//   /// Checks if a file path or URL represents a JAVA source file.
//   bool get isJAVA {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'text/x-java-source';
//   }
//
//   /// Checks if a file path or URL represents a PHP file.
//   bool get isPHP {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/x-httpd-php';
//   }
//
//   /// Checks if a file path or URL represents an XML file.
//   bool get isXML {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/xml' || mimeType == 'text/xml';
//   }
//
//   /// Checks if a file path or URL represents a JSON file.
//   bool get isJSON {
//     final mimeType = lookupMimeType(this ?? '');
//     return mimeType == 'application/json';
//   }
// }
