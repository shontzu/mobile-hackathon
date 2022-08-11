import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/pokemon_list_cubit.dart';
import '../states/pokemon_list_states.dart';
import 'list_page.dart';

void searchPokemon(String query) {}

class AlmanacPage extends StatefulWidget {
  const AlmanacPage({Key? key}) : super(key: key);

  @override
  State<AlmanacPage> createState() => _AlmanacPageState();
}

class _AlmanacPageState extends State<AlmanacPage> {
  List<String> selected = List.empty(growable: true);
  List<Map<String, String>> pokemons = [];

  late TextEditingController _pokeController;
  bool _IsCheckEmpty = false;

  bool get canSelectMore => selected.length < 2;

  @override
  void initState() {
    super.initState();
    _pokeController = TextEditingController();
    setState(() {
      selected.clear();
      pokemons.clear();
    });
  }

  void didPop() {
    pokemons.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon App"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: _pokeController,
              textAlign: TextAlign.center,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  label: Text("Search Pokemon"),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
            ),
          ),
          Expanded(
              child: BlocBuilder<PokemonListCubit, PokemonListStates>(
                  bloc: BlocProvider.of<PokemonListCubit>(context),
                  builder: (context, state) {
                    if (state is PokemonListLoading)
                      return const CircularProgressIndicator();

                    if (state is PokemonListLoaded) {
                      return GridView.count(
                        // Create grid with 2 columns (scrollDirection horizontal produces 2 rows)
                        crossAxisCount: 3,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(
                            state.pokemonListModel.results.length, (i) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(
                                      state.pokemonListModel.results[i].name),
                                  content: Text(
                                      state.pokemonListModel.results[i].name),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("close"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Card(
                              // color: Colors.orange[200],
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.all(10.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    FittedBox(
                                      child: Image.network(
                                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/${i + 1}.gif",
                                        fit: BoxFit.fill,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                    Text(
                                        "${state.pokemonListModel.results[i].name}"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ); // Text("${state.pokemonListModel.results[4].name}")
                    }

                    return const Text(
                        "some error occurred while fetching the pokemons");
                  })),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ListPage(),
              ));
        },
        child: const Text(
          "BATTLE",
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
