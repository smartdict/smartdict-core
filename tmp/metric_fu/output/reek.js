              var g = new Bluff.Line('graph', "1000x600");
      g.theme_37signals();
      g.tooltips = true;
      g.title_font_size = "24px"
      g.legend_font_size = "12px"
      g.marker_font_size = "10px"

        g.title = 'Reek: code smells';
        g.data('Duplication', [17])
g.data('IrresponsibleModule', [13])
g.data('LongMethod', [4])
g.data('LowCohesion', [4])
g.data('UncommunicativeName', [1])

        g.labels = {"0":"1/24"};
        g.draw();
