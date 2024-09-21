import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/widgets/UI/input_field.dart';

class InputRow extends StatelessWidget {
  const InputRow({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // ---------- Input Field and Search Button aligned to left ----------
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: InputField(
                    controller: controller,
                    onSubmitted: () {
                      context
                          .read<WeatherBloc>()
                          .add(FetchWeather(cityName: controller.text));
                      controller.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white70),
                  onPressed: () {
                    context
                        .read<WeatherBloc>()
                        .add(FetchWeather(cityName: controller.text));
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
