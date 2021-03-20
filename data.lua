local SELECTIVE_BREEDER_TINT = {1; 0.7; 0.7}

local crafting_category = {type = "recipe-category"; name = "selection"}

local entity = table.deepcopy(data.raw["furnace"]["iron-forestry"])
entity.name = "selective-breeder"
entity.crafting_categories = {crafting_category.name}
entity.result_inventory_size = 2
entity.animation.tint = SELECTIVE_BREEDER_TINT
entity.icons = {{icon = entity.icon; tint = SELECTIVE_BREEDER_TINT}}
for _, working_visualisation in pairs(entity.working_visualisations) do
  working_visualisation.animation.tint = SELECTIVE_BREEDER_TINT
end
entity.minable.results = nil
entity.minable.result = "selective-breeder"
entity.next_upgrade = "iron-forestry"
entity.placeable_by = {item = "selective-breeder"; count = 1}

DIR.add_new_machine("selective-breeder", {
  ingredients = {{"iron-plate"; 24}; {"iron-stick"; 32}; {"glass"; 16}; {"wood-chips"; 16}; {"small-lamp"; 4}};
  enabled = false;
  subgroup = "ir2-machines-resources";
  time = 6;
  icon = "iron-forestry";
})

local selective_breeder_item = data.raw["item"]["selective-breeder"]
selective_breeder_item.icons = {{icon = selective_breeder_item.icon; tint = SELECTIVE_BREEDER_TINT}}

local selective_breeder_recipe = data.raw["recipe"]["selective-breeder"]
selective_breeder_recipe.icons = selective_breeder_item.icons;
selective_breeder_recipe.icon_size = selective_breeder_item.icon_size;

local recipe = {
  name = "rubber-tree-selection";
  type = "recipe";
  category = crafting_category.name;
  subgroup = "wood";
  order = "zb";
  always_show_made_in = true;
  allow_decomposition = false;
  show_amount_in_title = false;
  always_show_products = true;
  enabled = false;
  ingredients = {{type = "item"; name = "wood"; amount = 1}};
  results = {
    {type = "item"; name = "wood"; amount_min = 1; amount_max = 2};
    {type = "item"; name = "rubber-wood"; amount = 1; probability = 0.01};
  };
  energy_required = DIR.forestry_cycle;
  icons = {
    {
      icon = DIR.get_icon_path("forestry-background");
      icon_size = DIR.icon_size;
      icon_mipmaps = DIR.icon_mipmaps;
      tint = {1; 0; 0};
    };
    {icon = DIR.get_icon_path("rubber-wood"); icon_size = DIR.icon_size; icon_mipmaps = DIR.icon_mipmaps; scale = 0.45};
  };
}

local technology = {
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

data:extend({crafting_category; entity; recipe; technology})
