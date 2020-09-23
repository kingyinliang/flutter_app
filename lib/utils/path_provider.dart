import 'dart:io';
import 'package:path_provider/path_provider.dart';

// 获取文件缓存大小
Future<String> loadCache() async {
  Directory tempDir = await getTemporaryDirectory();
  double value = await _getTotalSizeOfFilesInDir(tempDir);
  var _cacheSizeStr = _renderSize(value);
  return _cacheSizeStr.toString();
}

// 获取数据存储大小
getSharePreferences() async {
  var tempDir = await getTemporaryDirectory();
  String tempDirPath = tempDir.path;
  var sharePath = tempDirPath.splitMapJoin(
    '/cache',
    onMatch: (match) {
      return '';
    },
  );
  sharePath = sharePath + '/shared_prefs';
  double value = await _getTotalSizeOfFilesInDir(Directory(sharePath));
  var _cacheSizeStr = _renderSize(value);
  return _cacheSizeStr.toString();
}

// 获取数据存储和文件存储大小
getStorageSize() async {
  Directory tempDir = await getTemporaryDirectory();
  double pathProviderSize = await _getTotalSizeOfFilesInDir(tempDir);

  String tempDirPath = tempDir.path;
  var sharePath = tempDirPath.splitMapJoin(
    '/cache',
    onMatch: (match) {
      return '';
    },
  );
  sharePath = sharePath + '/shared_prefs';
  double sharerSize = await _getTotalSizeOfFilesInDir(Directory(sharePath));
  double size = pathProviderSize + sharerSize;
  var _sizeStr = _renderSize(size);
  return _sizeStr.toString();
}

// 获取文件大小
Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
  if (file is File) {
    int length = await file.length();
    return double.parse(length.toString());
  }
  if (file is Directory) {
    final List<FileSystemEntity> children = file.listSync();
    double total = 0;
    if (children != null)
      for (final FileSystemEntity child in children)
        total += await _getTotalSizeOfFilesInDir(child);
    return total;
  }
  return 0;
}

// 转换文件大小
_renderSize(double value) {
  if (null == value) {
    return 0;
  }
  List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
  int index = 0;
  while (value > 1024) {
    index++;
    value = value / 1024;
  }
  String size = value.toStringAsFixed(2);
  return size + unitArr[index];
}

// ignore: unused_element
void _clearCache() async {
  Directory tempDir = await getTemporaryDirectory();
  await delDir(tempDir);
  await loadCache();
}

///递归方式删除目录
Future<Null> delDir(FileSystemEntity file) async {
  if (file is Directory) {
    final List<FileSystemEntity> children = file.listSync();
    for (final FileSystemEntity child in children) {
      await delDir(child);
    }
  }
  await file.delete();
}
