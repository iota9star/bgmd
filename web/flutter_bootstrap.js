{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
    onEntrypointLoaded:  function(engineInitializer) {
      engineInitializer.initializeEngine().then(function (runner) {
            return runner.runApp();
        }).finally(function (){
            document.getElementById("loading").remove();
      });
    }
});