local SELECTIVE_BREEDER_TINT = {1; 0.7; 0.7}

local iron_forestry_item = data.raw["item"]["iron-forestry"]
local iron_forestry_entity = data.raw["furnace"]["iron-forestry"]
local iron_forestry_recipe = data.raw["recipe"]["iron-forestry"]
local rubber_growth_recipe = data.raw["recipe"]["rubber-growth"]
local wood_growth_recipe = data.raw["recipe"]["wood-growth"]

local crafting_category = {type = "recipe-category"; name = "selection"}
data:extend({crafting_category})

local selective_breeder_item = table.deepcopy(iron_forestry_item)
for k, v in pairs({
  name = "selective-breeder";
  order = iron_forestry_item.order .. "-1";
  icons = {{icon = selective_breeder_item.icon; tint = SELECTIVE_BREEDER_TINT}};
  place_result = nil;
}) do selective_breeder_item[k] = v end
data:extend({selective_breeder_item})

local selective_breeder_entity = table.deepcopy(iron_forestry_entity)
for k, v in pairs({
  name = "selective-breeder";
  crafting_categories = {crafting_category.name};
  result_inventory_size = 2;
  icons = {{icon = selective_breeder_entity.icon; tint = SELECTIVE_BREEDER_TINT}};
  next_upgrade = iron_forestry_entity.name;
  placeable_by = {item = selective_breeder_item.name; count = 1};
}) do selective_breeder_entity[k] = v end
selective_breeder_entity.animation.tint = SELECTIVE_BREEDER_TINT
for _, working_visualisation in pairs(selective_breeder_entity.working_visualisations) do
  working_visualisation.animation.tint = SELECTIVE_BREEDER_TINT
end
data:extend({selective_breeder_entity})

selective_breeder_item.place_result = selective_breeder_entity.name

local selective_breeder_recipe = {
  type = "recipe";
  name = "selective-breeder";
  order = iron_forestry_recipe.order .. "-1";
  subgroup = "ir2-machines-resources";
  result = selective_breeder_item.name;
  category = "crafting";
  enabled = false;
  ingredients = {{name = iron_forestry_item.name; amount = 1}};
  energy_required = 2 * DIR.standard_crafting_time;
}
data:extend({selective_breeder_recipe})

local rubber_tree_selection_recipe = table.deepcopy(wood_growth_recipe)
for k, v in pairs({
  name = "rubber-tree-selection";
  category = crafting_category.name;
  order = rubber_growth_recipe.order .. "-1";
  results = {
    {type = "item"; name = "wood"; amount_min = 1; amount_max = 2};
    {type = "item"; name = "rubber-wood"; amount = 1; probability = 0.01};
  };
  icons = {
    {
      icon = DIR.get_icon_path("forestry-background");
      icon_size = DIR.icon_size;
      icon_mipmaps = DIR.icon_mipmaps;
      tint = {1; 0; 0};
    };
    {icon = DIR.get_icon_path("rubber-wood"); icon_size = DIR.icon_size; icon_mipmaps = DIR.icon_mipmaps; scale = 0.45};
  };
}) do rubber_tree_selection_recipe[k] = v end
data:extend({rubber_tree_selection_recipe})

local rubber_tree_selection_tech = {
  name = "rubber-tree-selection-tech";
  type = "technology";
  prerequisites = {"ir2-iron-forestry"};
  effects = {
    {type = "unlock-recipe"; recipe = "rubber-tree-selection"};
    {type = "unlock-recipe"; recipe = "selective-breeder"};
  };
  unit = {
    count_formula = "2^(L-1)*200";
    time = 60;
    ingredients = {
      {name = DIR.science_packs["automation"]; type = "item"; amount = 1};
      {name = DIR.science_packs["logistics"]; type = "item"; amount = 1};
    };
  };
  icons = {
    {
      icon = DIR.get_icon_path("iron-forestry");
      icon_size = DIR.icon_size;
      icon_mipmaps = DIR.icon_mipmaps;
      tint = SELECTIVE_BREEDER_TINT;
    };
    {icon = DIR.get_icon_path("rubber-wood"); icon_size = DIR.icon_size; icon_mipmaps = DIR.icon_mipmaps; scale = 0.5};
  };
  icon_size = DIR.icon_size;
}
data:extend({rubber_tree_selection_tech})
