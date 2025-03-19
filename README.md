## SOS 3: Startovací skripty a CRON

---

### Úkol 1:

Vytvořte **startovací skript**.

Skript projde všechny složky v adresáři `/home`. Do každé složky přidá soubor info, který bude obsahovat informaci o tom, kdy byl systém spuštěn.

**Soubory:**

-   zdrojový kod spouštěného skriptu s názvem: `BOJ0043.bash`
-   zdrojový kod jednotky, která se bude jmenovat `unit_BOJ0043`.service
-   soubor `BOJ0043.txt`, kde bude uveden výpis statusu jednotky po jejím zavedení `systemctl status unit_BOJ0043`

### Úkol 2:

Vymyslete vlastní příklad na kterém budete demonstrovat funkci systému **CRON**. Konfiguraci kromu prosím proveďte ve standardním konfiguračním souboru.

**Soubory:**

-   zdrojový kod spouštěného skriptu s názvem `cron_BOJ0043.bash`
-   konfigirační soubor sytému CRON jako soubor `cron_BOJ0043`
