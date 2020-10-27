import 'package:flutter_test/flutter_test.dart';
import 'package:nlsapp/base/datetime/datetime_utils.dart';

void main() {
  test(
      'remainingDuration - DateTime with 1 minute remaining for match start will return 59',
      () {
    var matchTime = DateTime.now().add(Duration(minutes: 1));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingDuration(from: matchTime, to: currentTime)
            .inSeconds,
        59);
  });

  test(
      'remainingHours - DateTime with 1 minute remaining for match start will return 0 hour',
      () {
    var matchTime = DateTime.now().add(Duration(minutes: 1));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingHours(from: matchTime, to: currentTime)
            .toStringAsFixed(0),
        '0');
  });

  test(
      'remainingHours - DateTime with 61 minute remaining for match start will return 1 hour',
      () {
    var matchTime = DateTime.now().add(Duration(minutes: 61));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingHours(from: matchTime, to: currentTime)
            .toStringAsFixed(0),
        '1');
  });

  test(
      'remainingMinutes - DateTime with 61 minute remaining for match start will return 1 minute',
      () {
    var matchTime = DateTime.now().add(Duration(minutes: 61));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingMinutes(from: matchTime, to: currentTime)
            .toStringAsFixed(2),
        '0.98');
  });

  test(
      'remainingTime - DateTime with 1 minute remaining for match start should show 0:59',
      () {
    var matchTime = DateTime.now().add(Duration(minutes: 1));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingTime(from: matchTime, to: currentTime), '00:59');
  });

  test(
      'remainingTime - DateTime with 1441 minute remaining for match start should show 24:00:59',
      () {
    var matchTime = DateTime.now().add(Duration(minutes: 1441));
    var currentTime = DateTime.now();
    expect(DateTimeUtils.remainingTime(from: matchTime, to: currentTime),
        '24:00:59');
  });

  test(
      'remainingTime - DateTime with 30 minute remaining for match start should show 29:59',
      () {
    var matchTime = DateTime.now().add(Duration(minutes: 30));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingTime(from: matchTime, to: currentTime), '29:59');
  });

  test(
      'remainingTime - DateTime with 30 minute and 50 seconds remaining for match start should show 30:49',
      () {
    var matchTime = DateTime.now().add(Duration(minutes: 30, seconds: 50));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingTime(from: matchTime, to: currentTime), '30:49');
  });

  test(
      'remainingTime - DateTime with 50 seconds remaining for match start should show 00:49',
      () {
    var matchTime = DateTime.now().add(Duration(seconds: 50));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingTime(from: matchTime, to: currentTime), '00:49');
  });

  test(
      'remainingTime - DateTime with same time for match start should show 00:00',
      () {
    var matchTime = DateTime.now();
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingTime(from: matchTime, to: currentTime), '00:00');
  });

  test(
      'remainingTime - DateTime with after time for match start should show 00:00',
      () {
    var matchTime = DateTime.now().add(Duration(seconds: -1));
    var currentTime = DateTime.now();
    expect(
        DateTimeUtils.remainingTime(from: matchTime, to: currentTime), '00:00');
  });
}
