# kata-project
Для решения поставленной задачи использовал TDD.\
Поэтому перед рефакторингом покрыл весь код тестами, сначала сгенерировал файл с 50 примерами записей, написал тесты 
с помощью него, а также покрыл все части кода обычными тестам.\
После чего начал рефакторинг, сначала использовал rubocop для автоматического упрощения и устранения стилистических недостатков.\
Далее начал разделять имеющуюся логику на методы, дорабатывая каждый до прохождения всех тестов.\
После разделения всех частей на методы, стало понятно, что можно попробовать создать классы под соответсвующие айтемы.\
Здесь я решил использовать Item как родительский класс, от которого (тк по условиям задания не мог вносить изменения в item.rb) 
наследовал RegularItem.В котором реализовал необходимый метод обновления item-ов.\
После чего уже создал остальные класс для каждого из типов item-ов наследуясь от RegularItem.\
На данном этапе увидел,что некоторые из действий хорошо было бы внести в отдельные блоки,что я и сделал, добавив нашему
родительскому классу RegularItem соответвующие методы по(старению продукта, уменьшению/увеличению качества и тд.).

Далее оформил тесты немного красивее и сконфигурировал rubocop.


# Запуск проекта
1.Склонировать к себе репозиторий \
2.Установить нужную версию ruby(2.7.8)\
3.Установить bundler\
4.Поставить все необходимые гемы(bundle intstall)\
5.Теперь можно запусть тесты(rspec или bundle exec rspec)\
6.Можно запустить демонстрационную программу (ruby texttest_fixture.rb 50 )