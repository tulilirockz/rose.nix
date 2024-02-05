{config, ...}:
with config.colorScheme.palette; ''
  window {
  margin: 0px;
  border: 1px solid #${base05};
  background-color: #${base00};
  }

  #input {
  margin: 5px;
  border: none;
  color: #${base05};
  background-color: #${base00};
  }

  #inner-box {
  margin: 5px;
  border: none;
  background-color: #${base00};
  }

  #outer-box {
  margin: 5px;
  border: none;
  background-color: #${base00};
  }

  #scroll {
  margin: 0px;
  border: none;
  }

  #text {
  margin: 5px;
  border: none;
  color: #${base05};
  }

  #entry:selected {
  background-color: #${base01};
  }''
