import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon_app/pages/landing_page.dart';
import 'package:flutter_pokemon_app/states/pokemon_cubit.dart';
import 'package:flutter_pokemon_app/states/pokemon_list_cubit.dart';

void main() {
  runApp(const MyApp());
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => PokemonCubit()),
    BlocProvider(create: (context) => PokemonListCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Deck App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LandingPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
