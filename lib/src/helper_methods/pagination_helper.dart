// TODO(ME): create a pagination helper here.
//
// /// A generic pagination utility class for Dart.
// ///
// /// This class provides a simple way to handle pagination of a list of items.
// /// It is designed to be flexible and can work with any type of data.
// ///
// /// Type Parameter:
// ///   T - The type of data in the list that needs pagination.
// ///
// /// Example Usage:
// /// ```
// /// Paginator<MyDataType> paginator = Paginator(items: myDataList, itemsPerPage: 10);
// /// List<MyDataType> currentItems = paginator.currentPageItems;
// /// paginator.nextPage();
// /// ```
// class Paginator<T> {
//   /// Constructor for Paginator.
//   ///
//   /// Parameters:
//   ///   items - The list of all items to be paginated.
//   ///   itemsPerPage - (Optional) The number of items to be shown per page. Defaults to 10.
//   Paginator({
//     required List<T> items,
//     this.itemsPerPage = 10,
//   }) : _allItems = items;
//
//   /// Private field to store all items.
//   final List<T> _allItems;
//
//   /// Private field to track the current page.
//   int _currentPage = 0;
//
//   /// The number of items per page.
//   final int itemsPerPage;
//
//   /// Getter to retrieve the items of the current page.
//   ///
//   /// Returns:
//   ///   A sublist of items corresponding to the current page.
//   List<T> get currentPageItems {
//     final startIndex = _currentPage * itemsPerPage;
//     final endIndex = startIndex + itemsPerPage;
//     return _allItems.sublist(
//         startIndex, endIndex > _allItems.length ? _allItems.length : endIndex);
//   }
//
//   /// Getter to check if there is a next page.
//   ///
//   /// Returns:
//   ///   A boolean indicating whether there is a next page available.
//   bool get hasNextPage => (_currentPage + 1) * itemsPerPage < _allItems.length;
//
//   /// Getter to check if there is a previous page.
//   ///
//   /// Returns:
//   ///   A boolean indicating whether there is a previous page available.
//   bool get hasPreviousPage => _currentPage > 0;
//
//   /// Method to navigate to the next page.
//   void nextPage() {
//     if (hasNextPage) {
//       _currentPage++;
//     }
//   }
//
//   /// Method to navigate to the previous page.
//   void previousPage() {
//     if (hasPreviousPage) {
//       _currentPage--;
//     }
//   }
//
//   /// Method to go to a specific page number.
//   ///
//   /// Parameters:
//   ///   page - The page number to navigate to.
//   ///
//   /// Throws:
//   ///   RangeError if the page number is out of the range of available pages.
//   void goToPage(int page) {
//     if (page < 0 || page * itemsPerPage >= _allItems.length) {
//       throw RangeError('Page out of range');
//     }
//     _currentPage = page;
//   }
//
//   /// Getter to retrieve the current page number.
//   ///
//   /// Returns:
//   ///   The current page number.
//   int get currentPage => _currentPage;
//
//   /// Getter to retrieve the total number of pages.
//   ///
//   /// Returns:
//   ///   The total number of pages.
//   int get totalPages => (_allItems.length / itemsPerPage).ceil();
// }
