
/**
* Generator object, used to generate a new image
*/
var Generator = function(){
  this.frameWidth = window.innerWidth;    // image width
  this.frameHeight = window.innerHeight;  // image height
  this.maxIter = 1000;                    // number of logos
  this.maxRotat = 360;                    // maximum rotation
  this.scale = 1;                         // scale of the logos
  this.color0 = '#000000';
  this.color1 = '#FFE74C';
  this.color2 = '#FF5964';
  this.color3 = '#6BF178';
  this.color4 = '#35A7FF';

  this.colors = [
    this.color0,
    this.color1,
    this.color2,
    this.color3,
    this.color4
  ];

  this.paper = Raphael(0,0,this.frameWidth, this.frameHeight);
}

/**
 * Get a random number inside a range
 * 
 * @param  {Number}   min   minimum number in the range
 * @param  {Number}   max   maximum number in the range
 * @return {Number}   a random number in the range
 */
function getRandomInRange(min, max) {
  return Math.random() * (max - min) + min;
}

/**
 * Render a new image
 */
Generator.prototype.render = function () {
  // Logo Ebull
  var logo = "M30.121,35.582 116.934,35.582 130.121,77.89 72.703,77.89 72.703,103.989 112.264,103.989 112.264,146.297 72.703,146.297 72.703,172.121 136.989,172.121 123.527,214.429 30.121,214.429 z";

  for (var i = 0; i < this.maxIter; i++) {
    var translate = 't' + getRandomInRange(-200,this.frameWidth) + 
                    ',' + getRandomInRange(-200,this.frameHeight);
    var scale = translate + 's' + this.scale;
    var rotate = scale + 'r' + getRandomInRange(0,this.maxRotat);

    var logoPath = this.paper.path(logo);
    logoPath.attr({
      fill: this.colors[i%this.colors.length],
      'stroke-width': '0',
      'stroke-opacity': '1'
    })
    .data('id', 'logoPath');
    logoPath.transform(rotate).data('id', 'logoPath');
  }
};

/**
 * Update the colors according to the UI and re-render the image
 */
Generator.prototype.rerender = function () {
  this.paper.clear();
  this.colors = [
    this.color0,
    this.color1,
    this.color2,
    this.color3,
    this.color4
  ];
  this.render();
};

/**
 * Export the canvas to an SVG file
 */
Generator.prototype.saveSVG = function () {
  var imgHeader = '<?xml version="1.0" encoding="utf-8"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">';
  var image = imgHeader + document.getElementsByTagName('svg')[0].outerHTML;

  window.open('data:image/svg+xml;charset=UTF-8,' + image);
}
