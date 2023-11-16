import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../core/view_models/screens/implements/weather_screen_view_model.dart';
import '../core/view_models/screens/interfaces/iweather_screen_view_model.dart';

List<SingleChildWidget> viewModelProviders = [
  ChangeNotifierProvider<IWeatherScreenViewModel>(
    create: (_) => WeatherScreenViewModel(),
  ),
];
