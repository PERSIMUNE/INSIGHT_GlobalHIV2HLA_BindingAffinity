## <span id="help-top">Help</span>

Welcome to the companion app for: Zucco, A.G. et al. (2022). Associations of functional Human Leucocyte Antigen (HLA) class I nodes to HIV viral load in a heterogeneous cohort.

You are free to explore and download the data (*see data disclaimer below*). We only ask that you cite the main paper if you find any of the results or provided data elements useful. You may find the full reference in the About section available from the menu toward the top-left of the app.

You may close this panel at any time by clicking on the <span style="color: green;">green **question**</span> icon <img src="./help/greenquestion.jpg" height="30px" /> in this menu group <img src="./help/menu.jpg" height="30px" /> toward the top left of the map.

### Contents

This help panel will guide you through the following topics:

- [<span id="help-top">Help</span>](#help)
  - [Contents](#contents)
  - [<span id="help-disclaimer">Data disclaimer and download</span>](#data-disclaimer-and-download)
  - [<span id="help-navigation">App navigation</span>](#app-navigation)
  - [<span id="help-settings">Map settings</span>](#map-settings)
  - [<span id="help-plots">Available plots</span>](#available-plots)


### <span id="help-disclaimer">Data disclaimer and download</span>

This app only allows you to explore a portion of the published data. Specifically, it is the portion of all peptides where there is at least one imputed HLA class I allele that might bind it. Also, some countries have HIV samples (and therefore peptides) but no imputed HLA haplotypes. We have therefore not exposed data from these countries in this app. However, when you download data from this resource you ARE downloading ALL available data from the publication. To download data click the <span style="color: red;">red **gear**</span> icon <img src="./help/redgear.jpg" height="30px" /> in the menu group <img src="./help/menu.jpg" height="30px" />).

### <span id="help-navigation">App navigation</span>
<div style="text-align: right"><i><a href="#help-top">top</a></i></div>

When you first open the application a loading screen will appear while the data is being cached on your machine. This will help you to explore the data rapidly without waiting too long for new calculations.

Refer to the table below for a detailed guide. In summary, yellow countries are already selected and click on any purple country to switch your selection to it. All data displayed is relative to the selected geography.

Screenshot | Description
---: | ---
<img src="./help/help1.appEntry.jpg" width="250px" /> | The first thing you will see is a map of the world with one of the countries selected (in this example it is the UK). The country is randomly chosen each time you return to the app. We also track data for all <span style="color: purple">**purple**</span> colored countries. All other countries are either not available in this app (*see data disclaimer above*) or not included in the cohort. Clicking on the same selected country will select the entire dataset and set the geographic region to "World". In this **mode**, countries are highlighted by a yellow outline.<br />
<img src="./help/mouse.jpg" width="150px" /> | Interacting with the map is done using your mouse. Left-click and drag to move the map. Right-click and drag to rotate the map. Use your scroll-wheel to zoom in and out. Left-click a country to select it. Left-click the same country to select all countries.
<img src="./help/help2.infoBox.jpg" width="250px" /> | The information pane will on the bottom left of the app window displays several statistics for the geographic region selected. These statistics are the number of HIV samples obtained for the region, the number of HLA haplotypes imputed, and the number of HIV peptides who's HLA binding affinities were predicted.<br />
<img src="./help/menu.jpg" width="75px" /> | Toward the top-left of the app window you will see the menu cluster that allows you to edit settings (the red gear icon), view this help screen (the green info icon), or explore the data for the selected country (the blue graph icon).

### <span id="help-settings">Map settings</span>
<div style="text-align: right"><i><a href="#help-top">top</a></i></div>

You can edit what data is projected onto the map in several ways. The default projection is the country selected that will simply highlight the selected country. To change these settings click on the <span style="color: red;">red **gear**</span> icon <img src="./help/redgear.jpg" height="30px" /> in the menu group <img src="./help/menu.jpg" height="30px" />.

Screenshot | Description
---: | ---
<img src="./help/help4.settings.jpg" width="250px" /> | <div>Opening the settings menu allows you to edit the choropleth mapping for several country-level statistics. We provide access to 3 types: <ol><li>Geography - which allows you to color the map by what you've selected "Selection" (default), by country "Country", or by the number of patients represented in the cohort "Patients".</li><li>Human Leukocyte Antigen - which allows you to color the map by three measures of allelic diversity including the Simpson index, the inverse Simpson index, and Shannon entropy.</li><li>Human Immunodeficiency Virus - which allows you to color the map by three measure of diversity on HIV subtypes.</li></ol></div>

### <span id="help-plots">Available plots</span>
<div style="text-align: right"><i><a href="#help-top">top</a></i></div>

To view plots click on the <span style="color: blue;">blue **graph**</span> icon <img src="./help/bluegraph.jpg" height="30px" /> in the menu group <img src="./help/menu.jpg" height="30px" />. We provide access to three data views. Make sure to switch the view on by clicking on the appropriate switches (<img src="./help/switches.jpg" height="30px" />).

1. **HIV subtypes** - On by default. The HIV view provides HIV subtype frequencies for the selected geography.
2. **HLA alleles** - Off by default. The HLA view provides HLA imputation frequencies for the selected geography.
3. **Binding affinity** - Off by default. The BIND view provides predicted (HLA)allele:peptide(HIV) binding frequencies. These frequencies are binned into three categories relative to the selected geography:
   1. **Inactive** - The number of *globally sampled* peptides for which no imputed alleles *within* the geography were predicted to bind.
   2. **Exogenous** - The number of *globally sampled* peptides for which *at least one* imputed allele *within* the geography was predicted to bind.
   3. **Endogenous** - The number of *locally sampled* peptides for which *at least one* imputed allele *within* the geography was predicted to bind.
   
   > **NOTE**: The sum of these are the same across geographies and it is only their proportions that will change.
4. **Detailed binding** - Off by default. View by first turning the simple *binding affinity* view on. This view presents endogenously binding peptides for the selected geography by their amino acid position for structural (gag, pol, env), essential (tat, rev), and accessory (nef, vpr, vif, vpu, asp) HIV proteins.
5. **Functional HLA clustering** - Off by default. Shows a dendogram for all HLA alleles based on their predicted binding affinities to 173,792 HIV peptides.
