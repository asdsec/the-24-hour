gen:
		flutter pub run build_runner build

gendel:
		flutter pub run build_runner build --delete-conflicting-outputs

lang:
		flutter pub run easy_localization:generate  -O lib/product/init/language -f keys -o locale_keys.g.dart --source-dir assets/lang

.PHONY: gen gendel lang