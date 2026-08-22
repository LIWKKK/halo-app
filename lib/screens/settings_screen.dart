import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _urlController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('halo_url') ?? 'https://liweike.site';
    _urlController.text = url;
    
    if (mounted) {
      context.read<ApiService>().setBaseUrl(url);
    }
  }

  Future<void> _saveSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final url = _urlController.text.trim();
      
      await prefs.setString('halo_url', url);
      context.read<ApiService>().setBaseUrl(url);
      
      // 测试连接
      await context.read<ApiService>().refresh();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('设置已保存')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 服务器设置
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '服务器设置',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: 'Halo 服务器地址',
                    hintText: 'http://192.168.3.88:28090',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.link),
                  ),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveSettings,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('保存设置'),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 关于
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '关于',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('版本'),
                  subtitle: const Text('1.0.0'),
                ),
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('开源协议'),
                  subtitle: const Text('MIT License'),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('官方网站'),
                  subtitle: const Text('https://halo.run'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    // TODO: 打开浏览器
                  },
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 功能说明
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '功能说明',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const ListTile(
                  leading: Icon(Icons.article),
                  title: Text('文章浏览'),
                  subtitle: Text('查看文章列表和详情'),
                ),
                const ListTile(
                  leading: Icon(Icons.category),
                  title: Text('分类管理'),
                  subtitle: Text('浏览文章分类'),
                ),
                const ListTile(
                  leading: Icon(Icons.tag),
                  title: Text('标签管理'),
                  subtitle: Text('浏览文章标签'),
                ),
                const ListTile(
                  leading: Icon(Icons.sync),
                  title: Text('实时同步'),
                  subtitle: Text('自动同步服务器上的最新内容'),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.orange),
                  title: Text('编辑功能'),
                  subtitle: Text('需要配置认证才能使用创建、编辑、删除功能'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
