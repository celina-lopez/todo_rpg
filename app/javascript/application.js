// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import GameHelpers from './game_helpers';

window.GameHelpers = GameHelpers;

