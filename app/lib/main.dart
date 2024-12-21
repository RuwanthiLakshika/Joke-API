import 'dart:convert';
import 'joke_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const JokeListPage(title: ''),
    );
  }
}

class JokeListPage extends StatefulWidget {
  const JokeListPage({super.key, required this.title});
  final String title;

  @override
  State<JokeListPage> createState() => _JokeListPageState();
}

class _JokeListPageState extends State<JokeListPage> {
  final JokeService _jokeService = JokeService();
  List<Map<String, dynamic>> _jokeRaw = [];
  bool _isLoading = false;
  String _selectedJokeType = 'Any'; // Default joke type
  int _jokesFetched = 0; // Track number of jokes fetched

  Future<void> _fetchJokes() async {
    setState(() => _isLoading = true);
    try {
      final newJokes = await _jokeService.fetchJokesRaw(_selectedJokeType, _jokesFetched);
      setState(() {
        _jokeRaw.addAll(newJokes);
        _jokesFetched += newJokes.length;
      });
    } catch (e) {
      print('Error fetching jokes: $e');
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _fetchJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Joke App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade200, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to the Joke App!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  shadows: [Shadow(color: Colors.white, blurRadius: 2)],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Choose the type of jokes you want to see:',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  isExpanded: true, // Ensures the button takes up full width
                  value: _selectedJokeType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedJokeType = newValue!;
                      _jokesFetched = 0; // Reset the jokes fetched when type changes
                      _jokeRaw.clear(); // Clear the previous jokes
                    });
                    _fetchJokes(); // Fetch new jokes
                  },
                  items: <String>['Any', 'Programming', 'Miscellaneous', 'Puns']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _fetchJokes,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _isLoading ? 'Loading...' : 'Fetch Jokes',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildJokeList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJokeList() {
    if (_jokeRaw.isEmpty) {
      return const Center(
        child: Text(
          'No jokes fetched yet.',
          style: TextStyle(fontSize: 18, color: Colors.deepPurple),
        ),
      );
    }
    return ListView.builder(
      itemCount: _jokeRaw.length + 1, // Add one for the loading indicator
      itemBuilder: (context, index) {
        if (index == _jokeRaw.length) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: _fetchJokes,
                  child: const Center(
                    child: Text(
                      'Tap to load more jokes...',
                      style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                    ),
                  ),
                );
        }
        final jokeJson = _jokeRaw[index];
        final jokeText = jokeJson['joke'] ?? jokeJson['setup'] + ' ' + jokeJson['delivery'];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              jokeText,
              style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
            ),
          ),
        );
      },
    );
  }
}
