 
import 'package:flutter_common/flutter_common.dart';
import 'package:get_it/get_it.dart';
import 'package:lm_launcher/epg_manager.dart';
import 'package:lm_launcher/events/search_events.dart';
import 'package:lm_launcher/events/stream_list_events.dart';
import 'package:lm_launcher/events/tv_events.dart';
import 'package:lm_launcher/shared_prefs.dart';

// https://www.filledstacks.com/snippet/shared-preferences-service-in-flutter-for-code-maintainability/

GetIt locator = GetIt.instance;

Future setupLocator() async {
  final device = await RuntimeDevice.getInstance();
  locator.registerSingleton<RuntimeDevice>(device);

  final clientEvents = await ClientEvents.getInstance();
  locator.registerSingleton<ClientEvents>(clientEvents);

  final searchEvents = await SearchEvents.getInstance();
  locator.registerSingleton<SearchEvents>(searchEvents);

  final tvTabEvents = await TvTabsEvents.getInstance();
  locator.registerSingleton<TvTabsEvents>(tvTabEvents);

  final storage = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(storage);

  final package = await PackageManager.getInstance();
  locator.registerSingleton<PackageManager>(package);

  final time = await TimeManager.getInstance();
  locator.registerSingleton<TimeManager>(time);

  final epg = await EpgManager.getInstance();
  locator.registerSingleton<EpgManager>(epg);
}
