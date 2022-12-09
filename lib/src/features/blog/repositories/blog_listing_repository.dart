import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/blog/models/blog.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

List<Blog> parseBlogs(responseBody) {
  // final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return responseBody.map<Blog>((json) => Blog.fromJson(json)).toList();
}

abstract class BlogListingRepository {
  final ApiProvider apiProvider = ApiProvider();
  String url = "";
  Future<List<Blog>> getBlogList(
      {required int page, required int rowPerPage, required additionalArg});
  Future<List<Blog>> operate(
      {required String urlSuffix,
      required int page,
      required int rowPerPage}) async {
    try {
//       return [
//         Blog(
//             id: "1",
//             title:
//                 "​ហេតុអ្វីបានជាគេគិតថាប្រេងអូលីវល្អជាងប្រេងចម្អិនម្ហូបដទៃទៀត?",
//             thumbnail:
//                 "https://kohsantepheapdaily.com.kh/wp-content/images/2021/08/fdf664f17c8026035cb91b429b66ec72-768x399.jpg",
//             date: "17 សីហា 2021, 1:30 PM",
//             content: """
//            <!DOCTYPE html>
// <html>
// <head>
// <meta name="viewport" content="width=device-width, initial-scale=1.0">
// <style>
// p {
//     line-height: 25px !important;
// }
// .intrinsic-container-16x9 {
//     padding-bottom: 56.25%;
// }
// .intrinsic-container iframe {
//     position: absolute;
//     top: 0;
//     left: 0;
//     width: 100%;
//     height: 100%;
// }
// .intrinsic-container {
//     position: relative;
//     height: 0;
//     overflow: hidden;
// }
// </style>
// </head>
// <body>
// <h1>ហេតុអ្វីបានជាគេគិតថាប្រេងអូលីវល្អជាងប្រេងចម្អិនម្ហូបដទៃទៀត?</h1>
// <p><span style="color: #808080;">០៨ ខែ សីហា ឆ្នាំ ២០២១ ម៉ោង ១៦:៤៧</span></p>
// <p><img src="https://kohsantepheapdaily.com.kh/wp-content/images/2021/08/78805a221a988e79ef3f42d7c5bfd418-73.png"

//                     alt="" height="" width="100%"></p>
// <p style="text-align: left;">យើងភាគច្រើនប្រើប្រេងឆាក្នុងការចម្អិនម្ហូប
//   ដោយសារតែវាមានតម្លៃសមរម្យ។ តែប្រសិនបើយើងយកចិត្តទុកដាក់ខ្លាំងលើសុខភាព
//   យើងប្រហែលជាជ្រើសរើសយកប្រេងអូលីវហើយ
//   នេះក៏ព្រោះតែវាត្រូវគេជឿថាជួយដល់សុខភាព។
//   វាត្រូវបានគេស្គាល់ដោយសារឥទ្ធិពលវិជ្ជមានរបស់វា ទៅលើបេះដូង
//   ប៉ុន្តែភាពអស្ចារ្យដែលវាអាចធ្វើសម្រាប់រាងកាយរបស់អ្នកគឺហួសពីនោះទៅទៀត។
//   ថ្ងៃនេះ អ្នកនឹងបានស្គាល់ពីអត្ថប្រយោជន៍ធំ៣យ៉ាងរបស់វា មកលើសុខភាពរបស់អ្នក។</p>
// <img

//                     src="https://osssource.alizila.com/uploads/2019/07/olive-oil.jpg" alt=""

//                     height="" width="100%">
// <p>១. ជួយសម្រកទម្ងន់</p>
// <p>ការសិក្សាជាច្រើនបានបង្ហាញថា
//   អាហារដែលសំបូរទៅដោយប្រេងអូលីវមានឥទ្ធិពលវិជ្ជមានទៅលើទំងន់រាងកាយ។ មនុស្សជាង
//   ១៨០នាក់បានចូលរួមក្នុងការសិក្សារយៈពេល ៣ ឆ្នាំដែលបង្ហាញថា
//   ការបរិភោគប្រេងអូលីវជួយឱ្យពួកគេសម្រកទម្ងន់។</p>
// <p>២. ជួយស្បែករបស់អ្នក</p>
// <p>ប្រេងអូលីវគឺជាគ្រឿងផ្សំសំខាន់មួយនៅក្នុងផលិតផលគ្--
//   BG--រឿងសម្អាងជាច្រើន ហើយវាក៏អាចផ្តល់អត្ថប្រយោជន៍ដល់ស្បែករបស់អ្នក
//   ជាផ្នែកមួយនៃរបបអាហារផងដែរ។ វាជួយកាត់បន្ថយការឡើងក្រហមនិងហើម
//   ហើយទប់ស្កាត់ការឡើងជ្រួញលើស្បែកមុខ។
//   ប្រេងអូលីវមានលក្ខណៈសម្បត្តិប្រឆាំងនឹងបាក់តេរីដ៏ល្អ
//   និងដើរតួជាថ្នាំសម្លាប់មេរោគធម្មជាតិ។</p>
// <div class="intrinsic-container intrinsic-container-16x9">
//   <iframe src="https://www.youtube.com/embed/lg1Jy9kx1Kk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
// </div>
// <br>
// <p>៣. ជួយដល់សុខភាពខួរក្បាល</p>
// <p>ការទទួលទានប្រេងអូលីវជាប្រចាំ
//   ជួយបំបាត់នូវការខូចខាតជាច្រើននៅខាងក្នុងកោសិកាខួរក្បាលរបស់អ្នក។
//   ការខូចខាតទាំងនេះអាចបណ្តាលឱ្យមានជម្ងឺវង្វេងវង្វាន់
//   ដែលជាជម្ងឺផ្លូវចិត្តទូទៅបំផុតនៅលើពិភពលោក។ អ្នកដែលញ៉ាំប្រេងអូលីវទៀងទាត់
//   មានការចងចាំល្អជាងអ្នកដែលតមអាហារមានជាតិខ្លាញ់៕</p>
// </body>
// </html>

//             """),
//         Blog(
//             id: "2",
//             title: "​អត្ថប្រយោជន៍ នៃ​ការ​ញ៉ាំ​ផ្លែ​សាវម៉ាវ",
//             thumbnail:
//                 "https://parade.com/wp-content/uploads/2013/06/rambutan-ftr.jpg",
//             date: "17 សីហា 2021, 1:30 PM",
//             content: ''),
//         Blog(
//             id: "3",
//             title:
//                 "​សកម្មភាព៣យ៉ាង ដែលអ្នកមិនគួរធ្វើក្រោយពេលរលាកស្បែកដោយកម្តៅព្រះអាទិត្",
//             thumbnail:
//                 "https://www.healthiestblog.com/wp-content/uploads/2015/07/sunrise-672x372.jpg",
//             date: "17 សីហា 2021, 1:30 PM",
//             content: ''),
//       ];
      url = dotenv.env['baseUrl']! + urlSuffix;
      Response response = (await apiProvider.get(url, null, null))!;
      print(url);

      if (response.statusCode == 200) {
        // return compute(parseBlogs, response.data["data"]);
        List<Blog> blogs = [];
        response.data["data"].forEach((val) {
          blogs.add(Blog.fromJson(val));
        });
        return blogs;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

class BlogListRepo extends BlogListingRepository {
  @override
  Future<List<Blog>> getBlogList(
          {required int page,
          required int rowPerPage,
          required additionalArg}) async =>
      await super.operate(
          urlSuffix: "/blog?row_per_page=$rowPerPage&page=$page",
          page: page,
          rowPerPage: rowPerPage);
}

class BlogListByCategoryRepo extends BlogListingRepository {
  @override
  Future<List<Blog>> getBlogList(
      {required int page,
      required int rowPerPage,
      required additionalArg}) async {
    if (additionalArg is String)
      return await super.operate(
          urlSuffix:
              "/blog?row_per_page=$rowPerPage&page=$page&category_id=$additionalArg",
          page: page,
          rowPerPage: rowPerPage);
    else
      throw CustomException(message: "Invalid argument.");
  }
}

class BlogListBySubCategoryRepo extends BlogListingRepository {
  @override
  Future<List<Blog>> getBlogList(
      {required int page,
      required int rowPerPage,
      required additionalArg}) async {
    if (additionalArg is String)
      return await super.operate(
          urlSuffix:
              "/blog?row_per_page=$rowPerPage&page=$page&subid=$additionalArg",
          page: page,
          rowPerPage: rowPerPage);
    else
      throw CustomException(message: "Invalid argument.");
  }
}

class BlogListBySearch extends BlogListingRepository {
  @override
  Future<List<Blog>> getBlogList(
      {required int page,
      required int rowPerPage,
      required additionalArg}) async {
    return await super.operate(
        urlSuffix:
            "/blogs?page=$page&row_per_page=$rowPerPage&sort=$additionalArg",
        page: page,
        rowPerPage: rowPerPage);
  }
}
