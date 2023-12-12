require 'mustache'
require 'yaml'
class G1G2Export < Mustache

  self.template_path = __dir__

  def initialize(raw_test_data)
    @names = YAML.safe_load(File.read(File.expand_path('names.yml', __dir__)), aliases: true)
    @dob_map = {}
    @raw_test_data = JSON.parse(raw_test_data.to_json)
    @test_data_hash = {}
    @automated_steps = @raw_test_data['automated_steps']
    @test_data_hash['what'] = @raw_test_data
    set_up_row_data #if @raw_test_data['scenarios_have_providers'] == true
  end

  def set_up_row_data
    @row_scenarios = []
    return if @raw_test_data['scenarios'].nil?
    @raw_test_data['scenarios'].each do |scenario|
      row_scenario = { 'scenario_title' => scenario['scenario_title'],
                        'scenario_description' => scenario['scenario_description'],
                        'segments' => []  }
      scenario['segments'].each do |segment|
        next unless segment['segment_entries']
        patient_array = segment['segment_entries'][0]['entry_values'].map { |ev| ev['patient_id'] }
        row_segment = { 'segment_total' => segment['segment_total'],
                        'segment_title' => segment['segment_title'],
                        'segment_class' => segment_class(segment['segment_title']),
                        'segment_steps' => segment['segment_entries'].map.with_index  { |se, index| { 'step_title' =>  se['entry_title'], 'automatable_step' => se['automatable_step'], 'numer' => se['numer'], 'denom' => se['denom'], 'index' => index } },
                        'segment_providers' => [],
                        'segment_patients' => [] }
        if segment['segment_total']['providers']
          row_segment['provider_combinations'] = segment['segment_total']['providers'].map { |pro| { 'provider_name' => pro['provider'], 'programs' => pro['programs'] } }
        end
        patient_array.each do |patient|
          segment_patient = { 'patient_id' => patient,
                              'patient_details' => { name: patient, dob: dob_for_patient(patient), sex: sex_for_patient(patient) },
                              'entries' => []
                            }
          segment['segment_entries'].each do |se|
            entry = {}
            if row_segment['provider_combinations']
              entry = { 'automatable_step' => se['automatable_step'], 'entry_title' => se['entry_title'], 'providers' => se['entry_values'].select { |ev| ev['patient_id'] == patient }.first['providers'] }
              row_segment['segment_providers'] = entry['providers'].map { |pro| { 'provider_name' => pro['provider'] } } if row_segment['segment_providers'].empty?
            else
              entry = { 'automatable_step' => se['automatable_step'], 'entry_title' => se['entry_title'], 'entry_value' => se['entry_values'].select { |ev| ev['patient_id'] == patient }.first['entry_value'] }
            end
            segment_patient['entries'] << entry
          end
          if row_segment['provider_combinations']
            segment_patient['results'] = segment['segment_totals'][0]['total_values'].select { |tv| tv['patient_id'] == patient }.first['providers']
          else
            segment_patient['results'] = segment['segment_totals'][0]['total_values'].select { |tv| tv['patient_id'] == patient }
          end
          row_segment['segment_patients'] << segment_patient
        end
        row_segment['provider_combinations'].map! { |pc| { 'programs' => pc['programs'], 'provider_name' => pc['provider_name'], 'provider_display_name' => pc['provider_name'].gsub("/"," / ") } } if row_segment['provider_combinations']
        row_scenario['segments'] << row_segment
      end
      @row_scenarios << row_scenario
    end
  end

  def row_scenario_data
    JSON.parse(@row_scenarios.to_json)
  end

  def test_data
    JSON.parse(@test_data_hash.values.to_json)
  end

  def test_notes
  	test_data_notes = []
  	@raw_test_data['test_data_notes'].each_with_index do |value, index|
  		test_data_notes << { note_index: index + 1, note: value }
  	end
  	JSON.parse(test_data_notes.to_json)
  end

  def breadcrumbs
    b_crumbs = []
    b_crumbs << { title: "#{self['test_data'][0]['test_deck'].split(' ')[0]} home", ref: "../../index.html" }
    if self['test_data'][0]['index_page']
      b_crumbs << { title: "#{self['test_data'][0]['test_deck']}" }
    else
      b_crumbs << { title: "#{self['test_data'][0]['test_deck']}", ref: test_deck_link }
      b_crumbs << { title: "#{self['test_data'][0]['test_short_name']}" }
    end
    b_crumbs
  end

  def scenario_has_data
    !self['segments'][0]['segment_entries'].nil?
  end

  def row_scenario_has_data
    !self['segments'].empty?
  end

  def has_segment_patients
    !self['segment_entries'].nil?
  end

  def segment_patients
    self['segment_entries'].first['entry_values'].map { |ev| { name: ev['patient_id'], dob: dob_for_patient(ev['patient_id']), sex: sex_for_patient(ev['patient_id']) } }
  end

  def color_for_provider
    color_map = {
                  "Provider 1" => "provider_color_1",
                  "Provider 2" => "provider_color_2",
                  "TIN A/Provider 1" => "provider_color_3",
                  "TIN B/Provider 1" => "provider_color_4",
                  "TIN A/Provider 2" => "provider_color_5",
                  "TIN B/Provider 2" => "provider_color_6",
                  "Group/TIN A" => "provider_color_7",
                  "Group/TIN B" => "provider_color_8",
                  "Provider 1" => "provider_color_1",
                  "Provider 2" => "provider_color_2",
                  "TIN A / Provider 1" => "provider_color_3",
                  "TIN B / Provider 1" => "provider_color_4",
                  "TIN A / Provider 2" => "provider_color_5",
                  "TIN B / Provider 2" => "provider_color_6",
                  "Group / TIN A" => "provider_color_7",
                  "Group / TIN B" => "provider_color_8"
                }
    color_map[self['provider']]
  end

  def dob_for_patient(patient_name)
    if (!@dob_map.key?(patient_name))
      month = rand(1..12)
      day = rand(1..28)
      year = rand(1963..2001)
      @dob_map[patient_name] = "#{month}/#{day}/#{year}"
    end
    @dob_map[patient_name]
  end

  def sex_for_patient(patient_name)
    @names['first']['M'].include?(patient_name.split(' ')[0]) ? "M" : "F"
  end

  def first_denom_step
    self['segment_steps'].select{ |st| st['denom'] == true }[0,1]
  end

  def first_numer_step
    self['segment_steps'].select{ |st| st['numer'] == true }[0,1]
  end

  def denom_steps
    denom_count = self['segment_steps'].select{ |st| st['denom'] == true }.size
    "<th class='denom_color divTableBorderlessCell' colspan='#{denom_count}'>Denominator Criteria</th>"
  end

  def numer_steps
    numer_count = self['segment_steps'].select{ |st| st['numer'] == true }.size
    numerNone_count = self['segment_steps'].select{ |st| st['numer'] == true && st['automatable_step'].nil? }.size
    numer_strings = "<th class='numer_color divTableBorderlessCell numerAll' colspan='#{numer_count}'>Numerator Criteria</th>"
    return numer_strings unless self['automated_steps']
    as_counts = 0
    self['automated_steps'].each_with_index do |as, index|
      as_count = self['segment_steps'].select { |st| st['automatable_step'] && (st['automatable_step']['title'] == as['title']) }.size
      numer_strings += "<th class='numer_color divTableBorderlessCell numer#{as['index']}' colspan='#{as_count + numerNone_count}'>Numerator Criteria</th>"
      as_counts += as_count
    end
    if numerNone_count > 0
      numer_strings += "<th class='numer_color divTableBorderlessCell numerNone' colspan='#{numerNone_count}'>Numerator Criteria</th>"
    end
    numer_strings
  end

  def result_headers
    result_count = self['provider_combinations'].size
    medicaid_count = self['provider_combinations'].select{ |pc| pc['programs'] && pc['programs'].include?('medicaid_2020') }.size
    mips_count = self['provider_combinations'].select{ |pc| pc['programs'] && pc['programs'].include?('mips_2020') }.size
    results_strings = "<th class='result_color divTableBorderlessCell resultsAll' colspan='#{result_count}'>Results</th>"
    results_strings
  end

  def automatable_index
    @automated_steps.select { |as| as['title'] == self['title'] }.first['index']
  end

  def segment_class(segment_title)
    segment_map = {
                "Includes controlled substances" => "includesControlled",
                "Excludes controlled substances" => "excludesControlled"
                }
    segment_map[segment_title]
  end

  def segment_providers
    return self['entry_values'].first['providers'].map { |p| { 'provider' => p['provider'] } } if self['entry_values']&.first['providers'] 
    return []
  end

  def segment_providers_with_program
    provider_with_programs = []
    self['segment_providers'].each do |sp|
      if more_than_one_program?
        provider_with_programs << { 'provider' => sp, 'programs' => @row_scenarios.first['segments'][0]['provider_combinations'].select { |pc| pc['provider_name'] == sp['provider_name'] }.first['programs'] }
      else
        provider_with_programs << { 'provider' => sp }
      end
    end
    provider_with_programs
  end

  def test_array(test_deck)
    test_deck_link = test_deck.gsub(" ","_")
    [
      { 'test_short_name' => 'RT 1 ePrescribing', 'link' => "#{test_deck_link}_Required_Test_1.html" },
      { 'test_short_name' => 'RT 2a Provider Patient Exchange', 'link' => "#{test_deck_link}_Required_Test_2a_.html" },
      { 'test_short_name' => 'RT 2b Provider Patient Exchange', 'link' => "#{test_deck_link}_Required_Test_2b_.html" },
      { 'test_short_name' => 'RT 2c Provider Patient Exchange', 'link' => "#{test_deck_link}_Required_Test_2c_.html" },
      { 'test_short_name' => 'RT 7 Electronic Referral Loops', 'link' => "#{test_deck_link}_Required_Test_7.html" },
      { 'test_short_name' => 'RT 15 Receive & Reconcile', 'link' => "#{test_deck_link}_Required_Test_15.html" }
    ]
  end

  def next_test
    links = test_array(self['test_data'].first['test_deck'])
    current_page = self['test_data'].first['test_short_name']
    current_index = links.index { |x| x['test_short_name'] == current_page }
    return nil unless current_index
    next_index = current_index == (links.size - 1) ? 0 : current_index + 1
    links[next_index]
  end

  def last_test
    links = test_array(self['test_data'].first['test_deck'])
    current_page = self['test_data'].first['test_short_name']
    current_index = links.index { |x| x['test_short_name'] == current_page }
    return nil unless current_index
    links[current_index - 1]
  end

  def result_program_titles
    return false unless more_than_one_program?
    @row_scenarios.first['segments'][0]['provider_combinations'].select { |pc| pc['provider_name'] == self['provider'] }.first['programs']
  end

  def test_deck_link
    "#{self['test_data'][0]['test_deck'].gsub(" ","_")}_General_Notes.html"
  end

  def more_than_one_program?
    self['program_info'].size > 1
  end

  def has_automated_steps?
    return false unless self['automated_steps']
    !self['automated_steps'].empty?
  end

  def has_more_than_one_automated_step?
    self['automated_steps'].size > 1
  end

  def all_automated?
    self['title'] == 'All'
  end

  def mips_program?
    self['program_title'] == 'mips_2020'
  end

  def medicaid_program?
    self['program_title'] == 'medicaid_2020'
  end

  def has_automated_numerator_values?
    !self['automated_numerator_values'].nil?
  end

  def is_medicaid_program
    self['program_name'].include?('Medicaid')
  end

  def total_providers
    provider_totals = []
    if self['total_values']&.first['providers']
      providers = self['total_values'].first['providers'].map { |p| p['provider'] }
      providers.each do |provider|
        provider_totals << self['segment_total']['providers'].select { |p| p['provider'] == provider }.first
      end
    end
    return provider_totals
  end
end
