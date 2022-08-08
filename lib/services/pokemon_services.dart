import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonService {
  Future<PokemonModel> fetchPokemons(/*pokeId*/) async { //future is equivalent to promises in JavaScript

    final Uri url = Uri(
      scheme: 'https',
      host: 'pokeapi.co/api/v2/',
      path:'pokemon/',
      // queryParameters: { 'q': pokeId},
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200 /*ok*/) {
      return PokemonModel.fromJson(response.body);
    } else {
      throw Exception("failed to load weather information");
    }

  }
}