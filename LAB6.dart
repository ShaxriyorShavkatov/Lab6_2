import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CounterModel()),
      ChangeNotifierProvider(create: (_) => UserModel()),
      ChangeNotifierProvider(create: (_) => ThemeModel()),
      ChangeNotifierProvider(create: (_) => TodoListModel()),
      ChangeNotifierProvider(create: (_) => FavoriteModel()),
      ChangeNotifierProvider(create: (_) => CartModel()),
      ChangeNotifierProvider(create: (_) => AsyncModel()),
      ChangeNotifierProvider(create: (_) => SettingsModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeModel>().isDarkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = <_Demo>[
      _Demo('1.1 Static & Interactive Profile Cards', (_) => const ProfileCardsScreen()),
      _Demo('1.2 ProductCard', (_) => const ProductCardScreen()),
      _Demo('1.3 LikeButton (non-interactive)', (_) => const LikeButtonStaticScreen()),
      _Demo('1.4 LikeButton (interactive)', (_) => const LikeButtonInteractiveScreen()),
      _Demo('1.5 Username TextFormField', (_) => const UsernameFormScreen()),
      _Demo('2.1 Counter (setState)', (_) => const CounterPageSetState()),
      _Demo('2.2 Counter with Decrement', (_) => const CounterWithDecrementPage()),
      _Demo('2.3 Visibility Toggle', (_) => const VisibilityToggleScreen()),
      _Demo('2.4 List Add with TextField', (_) => const ItemListAdderScreen()),
      _Demo('2.5 Color Box', (_) => const ColorBoxScreen()),
      _Demo('3.1 Lifting State: Switch', (_) => const SwitchManagerScreen()),
      _Demo('3.2 Lifting State: Greeting', (_) => const GreetingParentScreen()),
      _Demo('3.3 Temp Converter', (_) => const TemperatureConverterScreen()),
      _Demo('3.4 Survey Slider', (_) => const SurveyScreen()),
      _Demo('3.5 Prop Drilling', (_) => const PropDrillGrandparent()),
      _Demo('4.1/4.3 Provider Counter', (_) => const ProviderCounterScreen()),
      _Demo('4.2 Provider UserModel', (_) => const ProviderUserScreen()),
      _Demo('4.4 Theme Switcher', (_) => const ThemeSwitcherScreen()),
      _Demo('4.5 Todo with Provider', (_) => const TodoListScreen()),
      _Demo('5.1 Provider Refactor Demo', (_) => const ProviderProfileRefactorScreen()),
      _Demo('5.2 Favorite via Provider', (_) => const FavoriteProviderScreen()),
      _Demo('5.3 Shopping Cart', (_) => const ProductScreen()),
      _Demo('5.3 Cart Screen', (_) => const CartScreen()),
      _Demo('5.4 Async Model', (_) => const AsyncModelScreen()),
      _Demo('5.5 Settings via Provider', (_) => const SettingsScreen()),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 6 – All Tasks')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (c, i) => ListTile(
          title: Text(items[i].title),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(c).push(MaterialPageRoute(builder: items[i].builder)),
        ),
      ),
    );
  }
}

class _Demo {
  final String title;
  final WidgetBuilder builder;
  _Demo(this.title, this.builder);
}

class ProfileCardsScreen extends StatelessWidget {
  const ProfileCardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Static & Interactive Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            StaticProfileCard(),
            SizedBox(height: 12),
            InteractiveProfileCard(),
          ],
        ),
      ),
    );
  }
}

class StaticProfileCard extends StatelessWidget {
  const StaticProfileCard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('Shaxriyor Shavkatov'),
        subtitle: Text('s.shavkatov@newuu,uz'),
      ),
    );
  }
}

class InteractiveProfileCard extends StatefulWidget {
  const InteractiveProfileCard({super.key});
  @override
  State<InteractiveProfileCard> createState() => _InteractiveProfileCardState();
}

class _InteractiveProfileCardState extends State<InteractiveProfileCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('Atabek Isakov'),
        subtitle: Text('a.isakov@newuu.uz'),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final double price;
  const ProductCard({super.key, required this.productName, required this.price});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(productName),
        subtitle: Text('\$${price.toStringAsFixed(2)}'),
      ),
    );
  }
}

class ProductCardScreen extends StatelessWidget {
  const ProductCardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProductCard')),
      body: const Center(child: ProductCard(productName: 'Widget Max', price: 19.99)),
    );
  }
}

class LikeButtonStatic extends StatefulWidget {
  const LikeButtonStatic({super.key});
  @override
  State<LikeButtonStatic> createState() => _LikeButtonStaticState();
}

class _LikeButtonStaticState extends State<LikeButtonStatic> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Icon(_isLiked ? Icons.favorite : Icons.favorite_border, size: 64);
  }
}

class LikeButtonStaticScreen extends StatelessWidget {
  const LikeButtonStaticScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Like (static)')), body: const Center(child: LikeButtonStatic()));
  }
}

class LikeButtonInteractive extends StatefulWidget {
  const LikeButtonInteractive({super.key});
  @override
  State<LikeButtonInteractive> createState() => _LikeButtonInteractiveState();
}

class _LikeButtonInteractiveState extends State<LikeButtonInteractive> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 64,
      onPressed: () => setState(() => _isLiked = !_isLiked),
      icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
    );
  }
}

class LikeButtonInteractiveScreen extends StatelessWidget {
  const LikeButtonInteractiveScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Like (interactive)')), body: const Center(child: LikeButtonInteractive()));
  }
}

class UsernameFormScreen extends StatefulWidget {
  const UsernameFormScreen({super.key});
  @override
  State<UsernameFormScreen> createState() => _UsernameFormScreenState();
}

class _UsernameFormScreenState extends State<UsernameFormScreen> {
  String _userName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Username Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(onChanged: (v) => setState(() => _userName = v), decoration: const InputDecoration(labelText: 'Enter name')),
            const SizedBox(height: 16),
            Text('Current: $_userName')
          ],
        ),
      ),
    );
  }
}

class CounterPageSetState extends StatefulWidget {
  const CounterPageSetState({super.key});
  @override
  State<CounterPageSetState> createState() => _CounterPageSetStateState();
}

class _CounterPageSetStateState extends State<CounterPageSetState> {
  int _counter = 0;
  void _inc() => setState(() => _counter++);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('setState Counter')),
      body: Center(child: Text('Count: $_counter', style: Theme.of(context).textTheme.headlineMedium)),
      floatingActionButton: FloatingActionButton(onPressed: _inc, child: const Icon(Icons.add)),
    );
  }
}

class CounterWithDecrementPage extends StatefulWidget {
  const CounterWithDecrementPage({super.key});
  @override
  State<CounterWithDecrementPage> createState() => _CounterWithDecrementPageState();
}

class _CounterWithDecrementPageState extends State<CounterWithDecrementPage> {
  int _counter = 0;
  void _inc() => setState(() => _counter++);
  void _dec() => setState(() => _counter--);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter +/-')),
      body: Center(child: Text('Count: $_counter', style: Theme.of(context).textTheme.headlineMedium)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(onPressed: _dec, child: const Icon(Icons.remove)),
          const SizedBox(width: 16),
          FloatingActionButton(onPressed: _inc, child: const Icon(Icons.add)),
        ],
      ),
    );
  }
}

class VisibilityToggleScreen extends StatefulWidget {
  const VisibilityToggleScreen({super.key});
  @override
  State<VisibilityToggleScreen> createState() => _VisibilityToggleScreenState();
}

class _VisibilityToggleScreenState extends State<VisibilityToggleScreen> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visibility Toggle')),
      body: Center(child: _isVisible ? const Text('Now you see me') : const SizedBox.shrink()),
      floatingActionButton: FloatingActionButton(onPressed: () => setState(() => _isVisible = !_isVisible), child: const Icon(Icons.visibility)),
    );
  }
}

class ItemListAdderScreen extends StatefulWidget {
  const ItemListAdderScreen({super.key});
  @override
  State<ItemListAdderScreen> createState() => _ItemListAdderScreenState();
}

class _ItemListAdderScreenState extends State<ItemListAdderScreen> {
  final _controller = TextEditingController();
  final List<String> _items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Items')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [
              Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(labelText: 'Item'))),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final t = _controller.text.trim();
                  if (t.isNotEmpty) setState(() => _items.add(t));
                  _controller.clear();
                },
                child: const Text('Add'),
              )
            ]),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (_, i) => ListTile(title: Text(_items[i])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColorBoxScreen extends StatefulWidget {
  const ColorBoxScreen({super.key});
  @override
  State<ColorBoxScreen> createState() => _ColorBoxScreenState();
}

class _ColorBoxScreenState extends State<ColorBoxScreen> {
  Color _c = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Box')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 200, height: 200, color: _c),
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: [
              ElevatedButton(onPressed: () => setState(() => _c = Colors.red), child: const Text('Red')),
              ElevatedButton(onPressed: () => setState(() => _c = Colors.green), child: const Text('Green')),
              ElevatedButton(onPressed: () => setState(() => _c = Colors.blue), child: const Text('Blue')),
            ])
          ],
        ),
      ),
    );
  }
}

class SwitchManagerScreen extends StatefulWidget {
  const SwitchManagerScreen({super.key});
  @override
  State<SwitchManagerScreen> createState() => _SwitchManagerScreenState();
}

class _SwitchManagerScreenState extends State<SwitchManagerScreen> {
  bool _isActive = false;
  void _handle(bool v) => setState(() => _isActive = v);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lifting: Switch')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('The Switch is: ${_isActive ? "ON" : "OFF"}'),
          InteractiveSwitch(isActive: _isActive, onChanged: _handle),
        ]),
      ),
    );
  }
}

class InteractiveSwitch extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;
  const InteractiveSwitch({super.key, required this.isActive, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Switch(value: isActive, onChanged: onChanged);
  }
}

class Greeting extends StatelessWidget {
  final String name;
  const Greeting({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Text('Hello, $name');
  }
}

class GreetingParentScreen extends StatefulWidget {
  const GreetingParentScreen({super.key});
  @override
  State<GreetingParentScreen> createState() => _GreetingParentScreenState();
}

class _GreetingParentScreenState extends State<GreetingParentScreen> {
  String _name = 'Guest';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lifting: Greeting')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Greeting(name: _name),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: () => setState(() => _name = 'Alice'), child: const Text('Set Alice'))
        ]),
      ),
    );
  }
}

class CelsiusInput extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  const CelsiusInput({super.key, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Celsius'),
      onChanged: (v) => onChanged(double.tryParse(v) ?? 0),
    );
  }
}

class FahrenheitDisplay extends StatelessWidget {
  final double celsius;
  const FahrenheitDisplay({super.key, required this.celsius});
  @override
  Widget build(BuildContext context) {
    final f = celsius * 9 / 5 + 32;
    return Text('Fahrenheit: ${f.toStringAsFixed(2)}');
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});
  @override
  State<TemperatureConverterScreen> createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  double _c = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temp Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          CelsiusInput(value: _c, onChanged: (v) => setState(() => _c = v)),
          const SizedBox(height: 12),
          FahrenheitDisplay(celsius: _c),
        ]),
      ),
    );
  }
}

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});
  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  double _s = 5.0;
  String get _label => _s < 3 ? 'Awful' : _s < 7 ? 'Okay' : 'Great!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Survey')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Slider(value: _s, min: 0, max: 10, divisions: 100, onChanged: (v) => setState(() => _s = v)),
          Text(_label)
        ]),
      ),
    );
  }
}

class PropDrillGrandparent extends StatefulWidget {
  const PropDrillGrandparent({super.key});
  @override
  State<PropDrillGrandparent> createState() => _PropDrillGrandparentState();
}

class _PropDrillGrandparentState extends State<PropDrillGrandparent> {
  int _count = 0;
  void _inc() => setState(() => _count++);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prop Drilling')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Count: $_count'),
          PropDrillParent(count: _count, onInc: _inc)
        ]),
      ),
    );
  }
}

class PropDrillParent extends StatelessWidget {
  final int count;
  final VoidCallback onInc;
  const PropDrillParent({super.key, required this.count, required this.onInc});
  @override
  Widget build(BuildContext context) {
    return PropDrillChild(onInc: onInc);
  }
}

class PropDrillChild extends StatelessWidget {
  final VoidCallback onInc;
  const PropDrillChild({super.key, required this.onInc});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onInc, child: const Text('Increment'));
  }
}

class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
  void decrement() {
    _count--;
    notifyListeners();
  }
  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class ProviderCounterScreen extends StatelessWidget {
  const ProviderCounterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = context.watch<CounterModel>().count;
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Counter')),
      body: Center(child: Text('Count: $c', style: Theme.of(context).textTheme.headlineMedium)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () => context.read<CounterModel>().decrement(), child: const Text('-')),
            ElevatedButton(onPressed: () => context.read<CounterModel>().increment(), child: const Text('+')),
            ElevatedButton(onPressed: () => context.read<CounterModel>().reset(), child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}

class UserModel extends ChangeNotifier {
  String _username = 'Guest';
  String get username => _username;
  void setAdmin() {
    _username = 'Admin';
    notifyListeners();
  }
  void setName(String n) {
    _username = n;
    notifyListeners();
  }
}

class ProviderUserScreen extends StatelessWidget {
  const ProviderUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final u = context.watch<UserModel>().username;
    return Scaffold(
      appBar: AppBar(title: const Text('UserModel')),
      body: Center(child: Text('User: $u')),
      floatingActionButton: FloatingActionButton(onPressed: () => context.read<UserModel>().setAdmin(), child: const Icon(Icons.admin_panel_settings)),
    );
  }
}

class ThemeModel extends ChangeNotifier {
  bool isDarkMode = false;
  void toggle() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class ThemeSwitcherScreen extends StatelessWidget {
  const ThemeSwitcherScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final t = context.watch<ThemeModel>().isDarkMode;
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Switcher')),
      body: Center(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Text('Dark Mode'),
          Switch(value: t, onChanged: (_) => context.read<ThemeModel>().toggle()),
        ]),
      ),
    );
  }
}

class TodoListModel extends ChangeNotifier {
  final List<String> _tasks = [];
  List<String> get tasks => List.unmodifiable(_tasks);
  void addTask(String t) {
    _tasks.add(t);
    notifyListeners();
  }
  void removeTask(int i) {
    _tasks.removeAt(i);
    notifyListeners();
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TodoListModel>().tasks;
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: TextField(controller: _c, decoration: const InputDecoration(labelText: 'Task'))),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final t = _c.text.trim();
                if (t.isNotEmpty) context.read<TodoListModel>().addTask(t);
                _c.clear();
              },
              child: const Text('Add'),
            )
          ]),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(tasks[i]),
                trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => context.read<TodoListModel>().removeTask(i)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class ProviderProfileRefactorScreen extends StatelessWidget {
  const ProviderProfileRefactorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Refactor')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const ProfileHeader(),
          const SizedBox(height: 12),
          const EditButton(),
        ]),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();
    return Text('User: ${user.username}');
  }
}

class EditButton extends StatelessWidget {
  const EditButton({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () => context.read<UserModel>().setName('Bob'), child: const Text('Change Name'));
  }
}

class FavoriteModel extends ChangeNotifier {
  bool isLiked = false;
  void toggle() {
    isLiked = !isLiked;
    notifyListeners();
  }
}

class FavoriteProviderIcon extends StatelessWidget {
  const FavoriteProviderIcon({super.key});
  @override
  Widget build(BuildContext context) {
    final liked = context.watch<FavoriteModel>().isLiked;
    return IconButton(iconSize: 64, icon: Icon(liked ? Icons.favorite : Icons.favorite_border), onPressed: () => context.read<FavoriteModel>().toggle());
  }
}

class FavoriteProviderScreen extends StatelessWidget {
  const FavoriteProviderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Favorite via Provider')), body: const Center(child: FavoriteProviderIcon()));
  }
}

class CartModel extends ChangeNotifier {
  final List<String> items = [];
  void add(String p) {
    items.add(p);
    notifyListeners();
  }
  void removeAt(int i) {
    items.removeAt(i);
    notifyListeners();
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final products = ['Apple', 'Banana', 'Orange', 'Grapes'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen())),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(products[i]),
          trailing: ElevatedButton(onPressed: () => context.read<CartModel>().add(products[i]), child: const Text('Add to Cart')),
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = context.watch<CartModel>().items;
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: items.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(items[i]),
                trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => context.read<CartModel>().removeAt(i)),
              ),
            ),
    );
  }
}

class AsyncModel extends ChangeNotifier {
  bool isLoading = false;
  String data = '';
  Future<void> fetch() async {
    isLoading = true;
    data = '';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    data = 'Loaded data';
    isLoading = false;
    notifyListeners();
  }
}

class AsyncModelScreen extends StatelessWidget {
  const AsyncModelScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final m = context.watch<AsyncModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Async Model')),
      body: Center(child: m.isLoading ? const CircularProgressIndicator() : Text(m.data.isEmpty ? 'Press Load' : m.data)),
      floatingActionButton: FloatingActionButton(onPressed: () => context.read<AsyncModel>().fetch(), child: const Icon(Icons.cloud_download)),
    );
  }
}

class SettingsModel extends ChangeNotifier {
  bool notificationsEnabled = true;
  double volumeLevel = 0.5;
  void toggleNotifications(bool v) {
    notificationsEnabled = v;
    notifyListeners();
  }
  void setVolume(double v) {
    volumeLevel = v;
    notifyListeners();
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Notifications'),
            Switch(value: s.notificationsEnabled, onChanged: (v) => context.read<SettingsModel>().toggleNotifications(v)),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            const Text('Volume'),
            Expanded(child: Slider(value: s.volumeLevel, onChanged: (v) => context.read<SettingsModel>().setVolume(v))),
          ])
        ]),
      ),
    );
  }
}

