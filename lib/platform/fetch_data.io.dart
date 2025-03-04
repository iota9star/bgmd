import 'dart:async';

import 'package:flutter/foundation.dart';

import '../model/bangumi.dart';
import 'fetch_data.dart';


Future<BangumiData> fetchData() async {
  return compute(innerFetch, 'https://unpkg.com/bangumi-data@0.3/dist/data.json');
}
