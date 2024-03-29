import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/home_delivery_widgets/card_widget.dart';

import 'package:aid_humanity/core/entities/request_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String _searchTerm = '';
  List<RequestEntity> _allRequests = []; // Initialize as empty list
  List<RequestEntity> _filteredRequests = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetAllRequestsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<RequestEntity> _searchRequests(
      List<RequestEntity> allRequests, String searchTerm) {
    final searchTextLower = searchTerm.toLowerCase();
    print(allRequests);
    print("----------------------------------------------------");
    return allRequests
        .where((request) =>
            (request.address?.isNotEmpty ?? false) &&
                request.address["location"]
                    .toString()
                    .toLowerCase()
                    .contains(searchTextLower) ||
            (request.numberOfItems?.toString()?.isNotEmpty ?? false) &&
                request.numberOfItems
                    .toString()
                    .toLowerCase()
                    .contains(searchTextLower))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _searchTerm = value),
          decoration: const InputDecoration(
            hintText: 'Search requests...',
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is GetAllRequestsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetAllRequestsSuccess) {
            _allRequests = state.requests;
          }

          // Conditional rendering for UI
          return _allRequests.isNotEmpty
              ? _buildSearchResults()
              : const Center(child: Text('No results found'));
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    _filteredRequests = _searchRequests(_allRequests, _searchTerm);

    return ListView.builder(
      itemCount: _filteredRequests.length,
      key: const PageStorageKey<String>('CardDeliverWidget'),
      itemBuilder: (context, index) {
        return CardWidget(requestEntity: _filteredRequests[index]);
      },
    );
  }
}
