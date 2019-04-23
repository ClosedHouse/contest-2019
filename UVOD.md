## Úvod

My jsme **BaseOS QE** team, jehož hlavní zodpovědností je kvalita RHELu (Red Hat Enterprise Linux) - je to linuxová distribuce a nejstarší produkt Red Hatu. Testujeme RHEL, ale to neznamená, že cely den jen klikáme na tlačítka v GUI :)  V rámci testováni používáme různé nastroje nastroje (Bash, Python a jejich testovací frameworky, automatizace, statické analýzatory kódu apod.), pracujeme s terminálem, hodně automatizujeme a přicházíme do styku s širokým spektrem technologií.
 
V rámci této hry maté šanci si vyzkoušet pár z nich, konkretně budete hledat bezpečnostní díry, psát testy v testovacím frameworku v Pythonu Behave a hledát chybu v RPM bálíčku pomocí interního testovacího frameworku BeakerLib. 

Soutěž se skládá ze 3 levelů. V každém levelu potřebujete získat kód ve tvaru **OH19\_[A-Z1-9]** (neboli začínající OH19_). Jakmile kód získáte, level se považuje za splněný a máte nárok na dáreček :)

V domácím adresáři **/home/oh** najdete složky **level1/**, **level2/** a **level3/**:

```
$ cd /home/oh
$ ll
drwxrwxr-x. 2 oh oh 4.0K Apr 17 08:29 level1
drwxrwxr-x. 4 oh oh 4.0K Apr 17 08:29 level2
drwxrwxr-x. 2 oh oh 4.0K Apr 17 08:29 task-behave
```

Každý adresář obsahuje jednotlivé úkoly (levely), včetně souboru README. Doporučujeme začít jeho přečtením.
