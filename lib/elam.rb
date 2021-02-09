require "elam/version"

module Elam
  class Error < StandardError; end

  class Indicative

    attr_accessor :modes, :tenses, :types, :verb_forms, :negation, :pronouns, :auxiliar, :modal, :verbs, :subjects, :verb_list

    def initialize
    	@modes = [:afirmative, :negative, :interrogative]
    	@tenses = [:present, :past, :future]
      @types = [:simple, :continuous]
      @verb_forms = [:infinitive, :simple, :past, :third, :gerund, :participle]
      @negation = { en: 'not', es: 'no' }
      @subjects = ['pronoun', 'verb_form', 'auxiliar', 'simple', 'continuous', 'simple_perfect', 'continuous_perfect', 'modal', 'indicative']
    	@pronouns = {
        singular_1st: { en: 'I', es: 'yo' },
        singular_2nd: { en: 'you(s)', es: 'tú' },
        singular_3rd_m: { en: 'he', es: 'él' }, 
        singular_3rd_f: { en: 'she', es: 'élla' }, 
        singular_3rd_n: { en: 'it', es: 'éso' },
        plural_1st: { en: 'we', es: 'nosotros'},
        plural_2nd: { en: 'you(p)', es: 'ustédes' },
        plural_3rd: { en: 'they', es: 'éllos' }       
      }
      @auxiliar = {
        en: {
          simple: { 
            present: { 0 => 'do', 1 => 'do', 3 => 'does' },
            past: { 0 => 'did', 1 => 'did', 3 => 'did' },
            future: { 0 => 'will', 1 => 'will', 3 => 'will' }
          },
          continuous: { 
            present: { 0 => 'are', 1 => 'am', 3 => 'is' },
            past: { 0 => 'were', 1 => 'was',  3 => 'was' },
            future: { 0 => 'will', 1 => 'will', 3 => 'will' },
            complement: 'be'
          },
          perfective: {
            present: { 0 => 'have', 1 => 'have', 3 => 'has' },
            past: { 0 => 'had', 1 => 'had', 3 => 'had' },
            future: { 0 => 'will', 1 => 'will', 3 => 'will' },
            complement: 'have'
          }
        },
        es: {
          simple: { 
          	present: { 0 => nil, 1 => nil, 3 => nil },
          	past: { 0 => nil, 1 => nil, 3 => nil }, 
          	future: { 0 => nil, 1 => nil, 3 => nil } 
          },
          continuous: { 
            present: { 1 => 'estoy', 2 => 'estas', 3 => 'esta', 6 => 'estamos', 8 => 'estan' },
            past: { 
              1 => 'estaba estuve estuviera estuviese',
              2 => 'estabas estuviste estuvieras estuvieses',
              3 => 'estaba estuvo estuviera estuviese',
              6 => 'estabamos estuvimos estuvieramos estuviesemos',
              8 => 'estaban estuvieron estuvieran estuviesen',
            },
            future: { 1 => 'estaré', 2 => 'estarás', 3 => 'estará', 6 => 'estaremos', 8 => 'estarán' },
          },
          perfective: {
            present: { 1 => 'he', 2 => 'has', 3 => 'ha', 6 => 'hemos', 8  => 'han' },
            past: { 
              1 => 'hube había hubiera hubiese',
              2 => 'hubiste habías hubieras hubieses',
              3 => 'hubo había hubiera hubiese',
              6 => 'hubimos habíamos hubieramos hubiesemos',
              8 => 'hubieron habían hubieran hubiesen'
            },
            future: { 1 => 'habré', 2 => 'habrás', 3 => 'habrá', 6 => 'habremos', 8 => 'habrán' },
            complement: 'estado'
          }
        }
      }
      @must = { 0 => 'deber', 1 => 'debo', 2 => 'debes', 3 => 'debe', 6 => 'debemos', 8 => 'deben' }
      @should = @shall = @ought_to = { 0 => 'deber', 1 => 'deberia', 2 => 'deberias', 3 => 'deberia', 6 => 'deberiamos', 8 => 'deberian' }
      @can = { 0 => 'poder', 1 => 'puedo', 2 => 'puedes', 3 => 'puede', 6 => 'podemos', 8 => 'pueden' }
      @could = @may = @might = { 0 => 'poder', 1 => 'podria', 2 => 'podrias', 3 => 'podria', 6 => 'podriamos', 8 => 'podrian' }
      @modal = {
        en: {
        	name: { would: 'would', can: 'can', could: 'could', may: 'may', might: 'might', must: 'must', should: 'should', shall: 'shall', ought_to: 'ought to' },
        	continuous: 'be',
        	perfective: { infinitive: 'have', complement: 'been' }
        },
        es: {
          simple: {
            singular_1st: { would: nil, can: @can[1], could: @could[1], may: @may[1], might: @might[1], must: @must[1], shall: @shall[1], should: @should[1], ought_to: @ought_to[1] },
            singular_2nd: { would: nil, can: @can[2], could: @could[2], may: @may[2], might: @might[2], must: @must[2], shall: @shall[2], should: @should[2], ought_to: @ought_to[2] },
            singular_3rd_m: { would: nil, can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            singular_3rd_f: { would: nil, can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            singular_3rd_n: { would: nil, can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            plural_1st: { would: nil, can: @can[6], could: @could[6], may: @may[6], might: @might[6], must: @must[6], shall: @shall[6], should: @should[6], ought_to: @ought_to[6] },
            plural_2nd: { would: nil, can: @can[8], could: @could[8], may: @may[8], might: @might[8], must: @must[8], shall: @shall[8], should: @should[8], ought_to: @ought_to[8] },
            plural_3rd: { would: nil, can: @can[8], could: @could[8], may: @may[8], might: @might[8], must: @must[8], shall: @shall[8], should: @should[8], ought_to: @ought_to[8] }},
          continuous: {
          	infinitive: 'estar',
            singular_1st: { would: 'estaría', can: @can[1], could: @could[1], may: @may[1], might: @might[1], must: @must[1], shall: @shall[1], should: @should[1], ought_to: @ought_to[1] },
            singular_2nd: { would: 'estarías', can: @can[2], could: @could[2], may: @may[2], might: @might[2], must: @must[2], shall: @shall[2], should: @should[2], ought_to: @ought_to[2] },
            singular_3rd_m: { would: 'estaría', can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            singular_3rd_f: { would: 'estaría', can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            singular_3rd_n: { would: 'estaría', can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            plural_1st: { would: 'estaríamos', can: @can[6], could: @could[6], may: @may[6], might: @might[6], must: @must[6], shall: @shall[6], should: @should[6], ought_to: @ought_to[6] },
            plural_2nd: { would: 'estarían', can: @can[8], could: @could[8], may: @may[8], might: @might[8], must: @must[8], shall: @shall[8], should: @should[8], ought_to: @ought_to[8] },
            plural_3rd: { would: 'estarían', can: @can[8], could: @could[8], may: @may[8], might: @might[8], must: @must[8], shall: @shall[8], should: @should[8], ought_to: @ought_to[8] }},
          perfective: {
          	infinitive: 'haber', complement: 'estado',
            singular_1st: { would: 'habría', can: @can[1], could: @could[1], may: @may[1], might: @might[1], must: @must[1], shall: @shall[1], should: @should[1], ought_to: @ought_to[1] },
            singular_2nd: { would: 'habrías', can: @can[2], could: @could[2], may: @may[2], might: @might[2], must: @must[2], shall: @shall[2], should: @should[2], ought_to: @ought_to[2] },
            singular_3rd_m: { would: 'habría', can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            singular_3rd_f: { would: 'habría', can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            singular_3rd_n: { would: 'habría', can: @can[3], could: @could[3], may: @may[3], might: @might[3], must: @must[3], shall: @shall[3], should: @should[3], ought_to: @ought_to[3] },
            plural_1st: { would: 'habríamos', can: @can[6], could: @could[6], may: @may[6], might: @might[6], must: @must[6], shall: @shall[6], should: @should[6], ought_to: @ought_to[6] },
            plural_2nd: { would: 'habrían', can: @can[8], could: @could[8], may: @may[8], might: @might[8], must: @must[8], shall: @shall[8], should: @should[8], ought_to: @ought_to[8] },
            plural_3rd: { would: 'habrían', can: @can[8], could: @could[8], may: @may[8], might: @might[8], must: @must[8], shall: @shall[8], should: @should[8], ought_to: @ought_to[8] }}
        }
      }
      @verbs = {
        root: { 
          # verb: ['en_root', :en_conjugation, es_present_conj, es_past_conj, es_future_conj, es_modal_conj, 'es_root', es_infinitive, es_gerund, es_participle]
          # => regulars
          to_repel: ['repel', :reg1, 2, 2, 2, 2, 'repel', 2, 2, 2],
          to_open: ['open', :reg1, 3, 2, 3, 3, 'abr', 3, 2, 'abier-to'],
          to_applaud: ['applaud', :reg1, 3, 2, 3, 3, 'aplaud', 3, 2, 2],
          to_asist: ['asist', :reg1, 3, 2, 3, 3, 'asist', 3, 2, 2],
          to_depart: ['depart', :reg1, 3, 2, 3, 3, 'depart', 3, 2, 2],
          to_allow: ['allow', :reg1, 3, 2, 3, 3, 'permit', 3, 2, 2],
          to_succumb: ['succumb', :reg1, 3, 2, 3, 3, 'sucumb', 3, 2, 2],
          to_suffer: ['suffer', :reg1, 3, 2, 3, 3, 'sufr', 3, 2, 2],
          to_need: ['need', :reg1, 1, 2, 1, 1, 'necesit', 1, 1, 1],
          to_work: ['work', :reg1, 1, 1, 1, 1, 'trabaj', 1, 1, 1],
          to_smoke: ['smoke', :reg1, 1, 1, 1, 1, 'fum', 1, 1, 1],
          to_arrive: ['arrive', :reg1, 1, 1, 1, 1, 'lleg', 1, 1, 1],
          to_use: ['use', :reg1, 1, 1, 1, 1, 'us', 1, 1, 1],
          to_travel: ['travel', :reg1, 1, 1, 1, 1, 'viaj', 1, 1, 1],
          to_kick: ['kick', :reg1, 1, 1, 1, 1, 'pate', 1, 1, 1],
          to_listen: ['listen', :reg1, 1, 1, 1, 1, 'escuch', 1, 1, 1],
          to_park: ['park', :reg1, 1, 1, 1, 1, 'estacion', 1, 1, 1],
          to_call: ['call', :reg1, 1, 1, 1, 1, 'llam', 1, 1, 1],
          to_blink: ['blink', :reg1, 1, 1, 1, 1, 'parpad', 1, 1, 1],
          to_trade: ['trade', :reg2, 1, 1, 1, 1, 'comerci', 1, 1, 1],
          to_like: ['like', :reg2, 1, 1, 1, 1, 'gust', 1, 1, 1],
          to_participate: ['participate', :reg2, 1, 1, 1, 1, '', 1, 1, 1],
          to_wash: ['wash', :reg5, 1, 1, 1, 1, 'lav', 1, 1, 1],
          to_paint: ['paint', :reg1, 1, 1, 1, 'pint', 1, 1, 1],
          to_ask: ['ask', :reg1, 1, 1, 1, 'pregunt', 1, 1, 1],
          to_introduce: ['introduce', :reg2, 1, 1, 1, 'present', 1, 1, 1],
          to_process: ['process', :reg5, 1, 1, 1, 'proces', 1, 1, 1],
          to_claim: ['claim', :reg1, 1, 1, 1, 'reclam', 1, 1, 1],
          to_salute: ['salute', :reg2, 1, 1, 1, 'salud', 1, 1, 1],
          to_stamp: ['stamp', :reg1, 1, 1, 1, 'estamp', 1, 1, 1],
          to_watch: ['watch', :reg5, 1, 1, 1, 1, 'mir', 1, 1, 1],
          to_end: ['end', :reg1, 1, 1, 1, 1, 'acab', 1, 1, 1],
          to_align: ['align', :reg1, 1, 1, 1, 1, 'aline', 1, 1, 1],
          to_block: ['block', :reg1, 1, 1, 1, 1, 'bloque', 1, 1, 1],
          to_walk: ['walk', :reg1, 1, 1, 1, 1, 'camin', 1, 1, 1],
          to_cook: ['cook', :reg1, 1, 1, 1, 1, 'cocin', 1, 1, 1],
          to_connect: ['connect', :reg1, 1, 1, 1, 1, 'conect', 1, 1, 1],
          to_confirm: ['confirm', :reg1, 1, 1, 1, 1, 'confirm', 1, 1, 1],
          to_consolidate: ['consolidate', :reg1, 1, 1, 1, 1, 'consolid', 1, 1, 1],
          to_control: ['control', :reg1, 1, 1, 1, 1, 'control', 1, 1, 1],
          to_harvest: ['harvest', :reg1, 1, 1, 1, 1, 'cosech', 1, 1, 1],
          to_debut: ['debut', :reg1, 1, 1, 1, 1, 'debut', 1, 1, 1],
          to_defeat: ['defeat', :reg1, 1, 1, 1, 1, 'derrot', 1, 1, 1],
          to_rest: ['rest', :reg1, 1, 1, 1, 1, 'descans', 1, 1, 1],
          to_love: ['love', :reg2, 1, 1, 1, 1, 'am', 1, 1, 1],
          to_dance: ['dance', :reg2, 1, 1, 1, 1, 'bail', 1, 1, 1],
          to_change: ['change', :reg2, 1, 1, 1, 1, 'cambi', 1, 1, 1],
          to_charge: ['charge', :reg2, 1, 1, 1, 1, 'cobr', 1, 1, 1],
          to_share: ['share', :reg2, 3, 2, 3, 3, 'compart', 3, 2, 2],
          to_create: ['create', :reg2, 1, 1, 1, 1, 'cre', 1, 1, 1],
          to_leave: ['leave', :reg2, 1, 1, 1, 1, 'dej', 1, 1, 1],
          to_dispute: ['dispute', :reg2, 1, 1, 1, 1, 'disput', 1, 1, 1],
          to_terminate: ['terminate', :reg2, 1, 1, 1, 1, 'elimin', 1, 1, 1],
          to_wish: ['wish', :reg3, 1, 1, 1, 1, 'dese', 1, 1, 1],
          to_finish: ['finish', :reg3, 1, 1, 1, 1, 'termin', 1, 1, 1],
          # => irregulars
          to_hurt: ['hurt', :irr, 1, 1, 1, 1, 'lastim', 1, 1, 1],
          to_sweat: ['sweat', :irr, 1, 1, 1, 1, 'sud', 1, 1, 1],
          to_bend: ['bend', :irr, 1, 1, 1, 1, 'dobl', 1, 1, 1],
          to_spend: ['spend', :irr, 1, 1, 1, 1, 'gast', 1, 1, 1],
          to_throw: ['trow', :irr, 1, 1, 1, 1, 'arroj', 1, 1, 1],
          to_take: ['take', :irr, 1, 1, 1, 1, 'tom', 1, 1, 1],
          to_win: ['win', :irr, 1, 1, 1, 1, 'gan', 1, 1, 1],
          to_hit: ['hit', :irr, 1, 1, 1, 1, 'golp', 1, 1, 1],
          to_speak: ['speak', :irr, 1, 1, 1, 1, 'habl', 1, 1, 1],
          to_stop: ['stop', :irr, 1, 1, 1, 1, 'par', 1, 1, 1],
          to_lead: ['lead', :irr, 1, 1, 1, 1, 'lider', 1, 1, 1],
          to_swim: ['swim', :irr, 1, 1, 1, 1, 'nad', 1, 1, 1],
          to_sing: ['sing', :irr, 1, 1, 1, 1, 'cant', 1, 1, 1],
          to_study: ['study', :irr, 1, 1, 1, 1, 'estudi', 1, 1, 1],
          to_try: ['try', :irr, 1, 1, 1, 1, 'trat', 1, 1, 1],
          to_buy: ['buy', :irr, 1, 1, 1, 1, 'compr', 1, 1, 1],
          to_cut: ['cut', :irr, 1, 1, 1, 1, 'cort', 1, 1, 1],
          to_leap: ['leap', :irr, 1, 1, 1, 1, 'brinc', 1, 1, 1],
          to_sum: ['sum', :irr, 1, 1, 1, 1, 'sum', 1, 1, 1],
          to_overcome: ['overcome', :irr, 1, 1, 1, 1, 'recuper', 1, 1, 1],
        },
        en: { # => en_conjugations
            reg1: { past: 'ed', gerund: 'ing', participle: 'ed', third: 's' },
            reg2: { past: 'd', gerund: 'ing', participle: 'd', third: 's' },
            reg3: { past: 'ied', gerund: 'ing', participle: 'ied', third: 'ies' },
            reg4: { past: 'ed', gerund: 'ing', participle: 'ed', third: 's' },
            reg5: { past: 'ed', gerund: 'ing', participle: 'ed', third: 'es' },
            irr: {
              to_hurt: { past: 'hurt', gerund: 'ing', participle: 'hurt', third: 's' },
              to_sweat: { past: 'sweat', gerund: 'ing', participle: 'sweat', third: 's' },
              to_bend: { past: 'bent', gerund: 'ing', participle: 'bent', third: 's' },
              to_spend: { past: 'spent', gerund: 'ing', participle: 'spent', third: 's' },
              to_throw: { past: 'threw', gerund: 'ing', participle: 'thrown', third: 's' },
              to_take: { past: 'took', gerund: 'ing', participle: 'taken', third: 's' },
              to_win: { past: 'won', gerund: 'ning', participle: 'won', third: 's' },
              to_hit: { past: 'hit', gerund: 'ting', participle: 'hit', third: 's' },
              to_speak: { past: 'spoke', gerund: 'ing', participle: 'spoken', third: 's' },
              to_stop: { past: 'stopped', gerund: 'ping', participle: 'stopped', third: 's' },
              to_lead: { past: 'led', gerund: 'ing', participle: 'led', third: 's' },
              to_swim: { past: 'swam', gerund: 'ming', participle: 'swum', third: 's' },
              to_sing: { past: 'sang', gerund: 'ing', participle: 'sung', third: 's' },
              to_buy: { past: 'bought', gerund: 'ing', participle: 'bought', third: 's' },
              to_study: { past: 'studied', gerund: 'ing', participle: 'studied', third: 's' },
              to_try: { past: 'tried', gerund: 'ing', participle: 'tried', third: 's' },
              to_cut: { past: 'cut', gerund: 'ing', participle: 'cut', third: 's' },
              to_leap: { past: 'leapt', gerund: 'ing', participle: 'leapt', third: 's' },
              to_sum: { past: 'summed', gerund: 'ming', participle: 'summed', third: 's' },
              to_overcome: { past: 'overcame', gerund: 'ing', participle: 'overcome', third: 's' },
            }
        },
        es: { # => es_conjugations
          infinitive: { 1=>'ar', 2=>'er', 3=>'ir' },
          gerund: { 1=>'ando', 2=>'iendo' },
          participle: { 1=>'ado', 2=>'ido', 3=>'to', 4=>'so', 5=>'cho'},
          present: { 
              1=> { 1=>'o', 2=>'as', 3=>'a', 6=>'amos', 8=>'an' },
              2=> { 1=>'o', 2=>'es', 3=>'e', 6=>'emos', 8=>'en' },
              3=> { 1=>'o', 2=>'es', 3=>'e', 6=>'imos', 8=>'en' },
              4=> { 1=>'e', 2=>'es', 3=>'e', 6=>'emos', 8=>'en' },
          },
          past: {
              1=> {
              1=>{ 1=>'é', 2=>'áste', 3=>'ó', 6=>'amos', 8=>'aron' },
              2=>{ 1=>'ába', 2=>'abas',  3=>'ába',  6=>'abamos', 8=>'aban' },
              3=>{ 1=>'ára', 2=>'aras',  3=>'ára', 6=>'aramos', 8=>'aran' },
              4=>{ 1=>'áse', 2=>'ases',  3=>'áse',  6=>'asemos', 8=>'asen' }
              },
              2=> {
              1=>{ 1=>'í', 2=>'íste', 3=>'ió', 6=>'imos', 8=>'ieron' },
              2=>{ 1=>'ía', 2=>'ías',  3=>'ía', 6=>'iamos', 8=>'ian' },
              3=>{ 1=>'iera', 2=>'ieras',  3=>'iera', 6=>'ieramos', 8=>'ieran' },
              4=>{ 1=>'iese', 2=>'ieses',  3=>'iese', 6=>'iesemos', 8=>'iesen' }
              },
              3=> {
              1=>{ 1=>'e', 2=>'íste', 3=>'ió', 6=>'ímos', 8=>'iéron' },
              2=>{ 1=>'ía', 2=>'ías',  3=>'ía', 6=>'íamos', 8=>'ían' },
              3=>{ 1=>'iera', 2=>'ieras',  3=>'iera', 6=>'ieramos', 8=>'ieran' },
              4=>{ 1=>'iese', 2=>'iases',  3=>'iase', 6=>'iasemos', 8=>'iasen' }
              }
          },
          future: {
              1=> { 1=>'aré', 2=>'arás', 3=>'ará', 6=>'arémos', 8=>'arán' },
              2=>  { 1=>'eré', 2=>'erás',   3=>'erá',  6=>'eremos', 8=>'eran' },
              3=>  { 1=>'iré', 2=>'irás',   3=>'irá',  6=>'iremos', 8=>'irán' },
          },
          would: {
              1=> { 1=>'aría', 2=>'arías', 3=>'aría', 6=>'aríamos', 8=>'arían' },
              2=> { 1=>'ería', 2=>'erías',  3=>'ería', 6=>'eríamos', 8=>'erían' },
              3=> { 1=>'iría', 2=>'irías',  3=>'iría', 6=>'iríamos', 8=>'irían' }
          }
        }
      }
      @verb_list = {
      	test: [:to_consolidate, :to_control, :to_harvest, :to_debut, :to_defeat, :to_rest, :to_love, :to_dance, :to_change, :to_charge],
        reg1: [:to_repel, :to_open, :to_applaud, :to_asist, :to_depart, :to_allow, :to_succumb, :to_suffer, :to_need, :to_work],
        reg2: [:to_smoke, :to_arrive, :to_use, :to_travel, :to_kick, :to_listen, :to_park, :to_call, :to_blink, :to_trade],
        reg3: [:to_like, :to_participate, :to_study, :to_try, :to_wash, :to_paint, :to_ask, :to_introduce, :to_process],
        reg4: [:to_salute, :to_stamp, :to_watch, :to_end, :to_align, :to_block, :to_walk, :to_cook, :to_connect, :to_confirm, :to_claim],
        reg5: [:to_consolidate, :to_control, :to_harvest, :to_debut, :to_defeat, :to_rest, :to_love, :to_dance, :to_change, :to_charge],
        irr1: [:to_bend, :to_spend, :to_throw, :to_take, :to_sweat, :to_hurt, :to_win, :to_hit, :to_speak, :to_stop],
        irr2: [:to_share, :to_create, :to_leave, :to_dispute, :to_terminate, :to_wish, :to_finish, :to_finish],
      }
    end


    def quiz subject, quiz_items: false, student: false, type: false, output: false
    	quiz_items = 1 if quiz_items == false
    	student = nil if student == false
      route = Proc.new { |file| "lib/questionnaire/english/indicative/#{file}.xlsx" }
    	quiz = { 
    		subject: subject, quiz_items: quiz_items, student: student, date: "#{DateTime.now.strftime("%d/%m/%Y-%H:%M")}",
    		theory: Hash.new, practice: Hash.new
    	 }

    	theory = Proc.new do
        quiz_items.times do |i|
    	    if subject == 'pronoun' then quiz[:theory].store(i, theory(route['01_pronombres_personales'])) end
    	    if subject == 'verb_form' then quiz[:theory].store(i, theory(route['02_formas_verbales'])) end
    	    if subject == 'auxiliar' then quiz[:theory].store(i, theory(route['03_auxiliares'])) end
    	    if subject == 'simple' then quiz[:theory].store(i, theory(route['04_tiempos_simples'])) end
    	    if subject == 'continuous' then quiz[:theory].store(i, theory(route['05_tiempos_continuos'])) end
    	    if subject == 'simple_perfect' then quiz[:theory].store(i, theory(route['06_tiempos_perfectos_simples'])) end
    	    if subject == 'continuous_perfect' then quiz[:theory].store(i, theory(route['07_tiempos_perfectos_continuos'])) end
    	    if subject == 'modal' then quiz[:theory].store(i, theory(route['08_modal_verbs'])) end
    	    if subject == 'indicative' then quiz[:theory].store(i, theory(route['09_practica'])) end
        end
    	end

    	practice = Proc.new do
    	  quiz_items.times do |i|
    	    if subject == 'pronoun' then quiz[:practice].store(i, pronoun) end
    	    if subject == 'verb_form' then quiz[:practice].store(i, verb_form(@verb_list[:reg1])) end
    	    if subject == 'auxiliar' then quiz[:practice].store(i, auxiliar) end
    	    if subject == 'simple'
            quiz[:practice].store(i, practice(type: :simple, tense: @tenses.sample, mode: @modes.sample, noun: @pronouns.keys.sample)) 
          end
    	    if subject == 'continuous'
            quiz[:practice].store(i, practice(type: :continuous, tense: @tenses.sample, mode: @modes.sample, noun: @pronouns.keys.sample)) 
          end
    	    if subject == 'simple_perfect'
            quiz[:practice].store(i, practice(perfective: :simple, tense: @tenses.sample, mode: @modes.sample, noun: @pronouns.keys.sample)) 
          end
    	  	if subject == 'continuous_perfect'
            quiz[:practice].store(i, practice(perfective: :continuous, tense: @tenses.sample, mode: @modes.sample, noun: @pronouns.keys.sample)) 
          end
    	  	if subject == 'indicative'
            case rand(2)
            when 0 # => non perfectives
              type == @types.sample
            when 1 # => perfectives
              perfective = @types.sample
            end
            case rand(2)
            when 0 # => :present, :past, :future
              tense = @tenses.sample
            when 1 # => :modal
              modal = @modal[:en][:name].keys.sample
            end
            if tense
              if perfective
                quiz[:practice].store(i, practice(perfective: :simple, tense: tense, mode: @modes.sample, noun: @pronouns.keys.sample))
              else
                quiz[:practice].store(i, practice(type: :simple, tense: tense, mode: @modes.sample, noun: @pronouns.keys.sample))
              end
            else # => modal
              if perfective
                quiz[:practice].store(i, practice(perfective: :simple, modal: modal, mode: @modes.sample, noun: @pronouns.keys.sample))
              else
                quiz[:practice].store(i, practice(type: :simple, modal: modal, mode: @modes.sample, noun: @pronouns.keys.sample))
              end
            end
          end
          if subject == 'modal'
    	  		modal = @modal[:en][:name].keys.sample
    	  		perfective = @types.sample
    	  		case rand(2)
    	  		when 0 # => perfective
    	  		  quiz[:practice].store(i, practice(perfective: perfective, modal: modal, mode: @modes.sample, noun: @pronouns.keys.sample))
    	  		when 1 # => non perfective
    	  			quiz[:practice].store(i, practice(type: perfective, modal: modal, mode: @modes.sample, noun: @pronouns.keys.sample))
    	  		end
    	  	end
    	  end
    	end

    	case type
    	when :theory
    		theory.call
    		quiz.delete(:practice)
    	when :practice
    		practice.call
    		quiz.delete(:theory)
    	when :both
    		theory.call
    		practice.call
    	end
      return set_output quiz, output: output
    end


    def pronoun
      aux, pronoun = @pronouns.keys.sample.to_sym, nil
      opt1, option1 = @pronouns.keys.sample.to_sym, nil
      opt2, option2 = @pronouns.keys.sample.to_sym, nil
      
      until aux != opt1 && aux != opt2 && opt1 != opt2
        opt1, opt2 = @pronouns.keys.sample, @pronouns.keys.sample
      end
      
      @pronouns.each do |key, value|
        pronoun = { key => value } if aux == key
        option1 = { key => value } if opt1 == key
        option2 = { key => value } if opt2 == key
      end
      
      question = { question: nil, answer: nil, options: Array.new }
      
      case rand(3)
        when 0 # => english
        question[:question] = pronoun[aux][:en]
        question[:answer] = "#{pronoun[aux][:es]} - #{aux}"
        option1 = "#{option1[opt1][:es]} - #{opt1}"
        option2 = "#{option2[opt2][:es]} - #{opt2}"
        when 1 # => spanish
        question[:question] = pronoun[aux][:es]
        question[:answer] = "#{pronoun[aux][:en]} - #{aux}"
        option1 = "#{option1[opt1][:en]} - #{opt1}"
        option2 = "#{option2[opt2][:en]} - #{opt2}"
        when 2 # => grammar name
        question[:question] = aux
        question[:answer] = "#{pronoun[aux][:en]} - #{pronoun[aux][:es]}"
        option1 = "#{option1[opt1][:en]} - #{option1[opt1][:es]}"
        option2 = "#{option2[opt2][:en]} - #{option2[opt2][:es]}"
      end
      
      position = rand(3)
      question[:options][position] = question[:answer]
      question[:options][1], question[:options][2] = option1, option2 if position == 0
      question[:options][0], question[:options][2] = option1, option2 if position == 1
      question[:options][0], question[:options][1] = option1, option2 if position == 2
      
      return question
    end

    
    def verb_form list
      selected_form, verb = @verb_forms.sample, list.sample
      answer = get_verb verb, form: selected_form

      { 
        question: { form: selected_form, verb: verb },
        answer: { en: answer[:en], es: answer[:es] }
      }
    end


    def auxiliar
      tense, type, noun = @tenses.sample, @types.sample, @pronouns.keys.sample
      
      case rand(2)
        when 0 # => non-perfective
          auxiliar = get_auxiliar tense: tense, type: type, noun: noun
        when 1 # => perfective
          auxiliar = get_auxiliar tense: tense, perfective: type, noun: noun
          type = "#{type}_perfect".to_sym
      end
      
      question = {
      	question: { type: type, tense: tense, noun: noun },
      	answer: { en: auxiliar[:en], es: auxiliar[:es] }
      }

      return question
    end


    def practice type: false, perfective: false, tense: false, modal: false, mode: false, noun:false, modal_only: false, verb: false
      aux, noun = noun, get_pronoun(noun)
      # => :plural_1st, {:plural_1st=>{:en=>"we", :es=>"nosotros"}}

      unless verb
        verb = @verb_list[:reg1].sample if type == :simple
        verb = @verb_list[:reg2].sample if type == :continuous
        verb = @verb_list[:reg3].sample if perfective == :simple
        verb = @verb_list[:reg4].sample if perfective == :continuous
        verb = @verb_list[:reg5].sample if modal_only == true
      end
      # => to_succumb (Symbol)
      
      if tense # => :present, :past, :future
        if perfective # => perfective tenses
          auxiliar = get_auxiliar tense: tense, perfective: perfective, noun: aux
          question = {
            question: { type: "#{perfective}_perfect".to_sym, tense: tense, mode: mode, noun: aux, verb: verb },
            answer: { en: nil, es: nil }
          }
        else # => non perfective tenses
          auxiliar = get_auxiliar tense: tense, type: type, noun: aux
          question = {
            question: { type: type, tense: tense, mode: mode, noun: aux, verb: verb },
            answer: { en: nil, es: nil }
          }
        end
      else # => :modal
        if perfective # => perfective tenses
          auxiliar = get_modal modal: modal, perfective: perfective, noun: aux
          question = {
            question: { type: "#{perfective}_perfect_modal".to_sym, modal: modal, mode: mode, noun: aux, verb: verb },
            answer: { en: nil, es: nil }
          }
        else # => non perfective tenses
          auxiliar = get_modal modal: modal, type: type, noun: aux
          question = {
            question: { type: "#{type}_modal".to_sym, modal: modal, mode: mode, noun: aux, verb: verb },
            answer: { en: nil, es: nil }
          }
        end
      end
      # => {:en=>["will"], :es=>[]}

      if perfective
        case perfective
        when :simple
          conjugation = @verbs[:root][verb][1]
          simple_form = get_verb verb, form: :participle
          verb = get_verb verb, form: :participle
          case mode
          when :afirmative
            if tense
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], verb: verb[:en] }
              if tense == :future then question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en], verb: verb[:en] } end
              question[:answer][:es] = { noun: noun[aux][:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
            end
            if modal
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en], verb: verb[:en] }
              question[:answer][:es] = { noun: noun[aux][:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
            end
          when :negative
            question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], negation: @negation[:en], verb: verb[:en] }
            if tense == :future or modal
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], negation: @negation[:en], complement: auxiliar[:en][1], verb: verb[:en] }
              if modal == :ought_to
                question[:answer][:en] = { 
                  noun: noun[aux][:en], 
                  auxiliar: auxiliar[:en][0].split(' ').to_a[0], negation: @negation[:en], complement: "#{auxiliar[:en][0].split(' ').to_a[1]} have", 
                  verb: verb[:en] 
                }
              end
            end
            question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
          when :interrogative
            if tense == :future
              question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], complement: auxiliar[:en][1], verb: verb[:en] }
            else
               question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], verb: verb[:en] }
            end
            if modal
              question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], complement: auxiliar[:en][1], verb: verb[:en] }
              if modal == :ought_to
                question[:answer][:en] = { 
                  auxiliar: auxiliar[:en][0].split(' ').to_a[0], noun: noun[aux][:en], complement: "#{auxiliar[:en][0].split(' ').to_a[1]} have", 
                  verb: verb[:en]
                }
              end
             end
            question[:answer][:es] = { auxiliar: auxiliar[:es].join(' '), noun: noun[aux][:es], verb: verb[:es] }
          end
        when :continuous
          verb = get_verb verb, form: :gerund
          verb[:en][:root].chomp!('e') if verb[:en][:root][-1] == 'e'
          case mode
          when :afirmative
            if tense == :future then 
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], complement: "#{auxiliar[:en][1]} been", verb: verb[:en] }
            else 
              question[:answer][:en] = { noun: noun[aux][:en], complement: "#{auxiliar[:en][0]} been", verb: verb[:en] }
            end
            question[:answer][:es] = { noun: noun[aux][:es], auxiliar: "#{auxiliar[:es][0]} estado", verb: verb[:es] }
            if modal
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], complement: "#{auxiliar[:en][1]}", verb: verb[:en] }
              unless modal == :would then question[:answer][:es] = { noun: noun[aux][:es], auxiliar: "#{auxiliar[:es][0]} haber estado", verb: verb[:es] } end
            end
          when :negative
            question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], negation: @negation[:en], complement: "#{auxiliar[:en][1]} been", verb: verb[:en] }
            unless tense == :future
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], negation: @negation[:en], complement: 'been', verb: verb[:en] }
            end
            question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], auxiliar: "#{auxiliar[:es][0]} estado", verb: verb[:es] }
            if modal
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], negation: @negation[:en], complement: 'have been', verb: verb[:en] }
              question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], auxiliar: "#{auxiliar[:es][0]} haber estado", verb: verb[:es] }
              if modal == :would
                question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], auxiliar: "#{auxiliar[:es][0]} estado", verb: verb[:es] }
              end
              if modal == :ought_to
                question[:answer][:en] = { 
                  noun: noun[aux][:en], 
                  auxiliar: auxiliar[:en][0].split(' ').to_a[0], negation: @negation[:en], complement: "#{auxiliar[:en][0].split(' ').to_a[1]} have been", 
                  verb: verb[:en]
                }
              end
            end
          when :interrogative
            if tense
              question[:answer][:es] = { noun: noun[aux][:es], auxiliar: auxiliar[:es][0], complement: 'estado', verb: verb[:es] }
              if tense == :future
                question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], complement: "#{auxiliar[:en][1]} been", verb: verb[:en] }
              else
                question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], complement: 'been', verb: verb[:en] }
              end
            end
            if modal
              question[:answer][:es] = { noun: noun[aux][:es], auxiliar: auxiliar[:es][0], complement: 'haber estado', verb: verb[:es] }
              question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], complement: "#{auxiliar[:en][1]}", verb: verb[:en] }
              if modal == :ought_to
                question[:answer][:en] = { 
                  auxiliar: auxiliar[:en][0].split(' ').to_a[0], 
                  noun: noun[aux][:en], complement: "#{auxiliar[:en][0].split(' ').to_a[1]} have been", 
                  verb: verb[:en]
                }
              end
            end
          end
        end
      else # => non perfective
        case type
        when :simple
          if tense
            conjugation = @verbs[:root][verb][1]
            simple_form = get_verb verb, form: :simple, noun: noun.keys[0].to_sym
            verb = get_verb verb, form: tense, noun: noun.keys[0].to_sym if tense
          else # => if modal
            if modal == :would
              verb = get_verb verb, form: :would, noun: noun.keys[0].to_sym
            else
              verb = get_verb verb, form: :simple
            end
          end
          case mode
          when :afirmative
            if tense
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), verb: verb[:en] }
              if tense == :present
                if aux == :singular_3rd_m or aux == :singular_3rd_f or aux == :singular_3rd_n
                  question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), verb: { root: verb[:en][:root] } }
                end
              end
              if tense == :past
                if conjugation == :irr
                  question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), verb: { root: simple_form[:en] } }
                else
                  question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), verb: { root: verb[:en][:root] } }
                end
              end
              unless tense == :future then question[:answer].store(:no_aux, { pronoun: noun[aux][:en], verb: verb[:en] }) end
              question[:answer][:es] = { noun: noun[aux][:es], verb: verb[:es] }
            end
            if modal
              if modal == :would 
                question[:answer][:en] = { pronoun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), verb: verb[:en] }
                question[:answer][:es] = { noun: noun[aux][:es], verb: verb[:es] }
              else
                question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), verb: verb[:en] }
                question[:answer][:es] = { noun: noun[aux][:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
              end
            end
          when :negative
            if tense
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), negation: @negation[:en], verb: verb[:en] }
              if tense == :present or tense == :past
                question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), negation: @negation[:en], verb: { root: verb[:en][:root] } }
              end
              question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], verb: verb[:es] }
            end
            if modal
              if modal == :would 
                question[:answer][:en] = { pronoun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), negation: @negation[:en], verb: { root: verb[:en][:root] } }
                question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], verb: verb[:es] }
              else
                if modal == :ought_to
                  question[:answer][:en] = { 
                    pronoun: noun[aux][:en], 
                    auxiliar: auxiliar[:en][0].split(' ').to_a[0], negation: @negation[:en], complement: auxiliar[:en][0].split(' ').to_a[1], 
                    verb: { root: verb[:en][:root] } 
                  }
                else
                  question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en].join(' '), negation: @negation[:en], verb: { root: verb[:en][:root] } }
                end
                question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], auxiliar: auxiliar[:es], verb: verb[:es] }
              end
            end
          when :interrogative
            if tense
              question[:answer][:en] = { auxiliar: auxiliar[:en].join(' '), noun: noun[aux][:en], verb: verb[:en] }
              if tense == :present or tense == :past
                question[:answer][:en] = { auxiliar: auxiliar[:en].join(' '), noun: noun[aux][:en], verb: { root: verb[:en][:root] } }
              end
              question[:answer][:es] = { noun: noun[aux][:es], verb: verb[:es] }
            end
            if modal
              if modal == :would 
                question[:answer][:en] = { auxiliar: auxiliar[:en].join(' '), pronoun: noun[aux][:en], verb: verb[:en] }
                question[:answer][:es] = { noun: noun[aux][:es], verb: verb[:es] }
              else
               if modal == :ought_to
                  question[:answer][:en] = { 
                    auxiliar: auxiliar[:en][0].split(' ').to_a[0], pronoun: noun[aux][:en], complement: auxiliar[:en][0].split(' ').to_a[1], 
                    verb: verb[:en] 
                  }
                else
                  question[:answer][:en] = { auxiliar: auxiliar[:en].join(' '), noun: noun[aux][:en], verb: verb[:en] }
                end
                question[:answer][:es] = { auxiliar: auxiliar[:es], noun: noun[aux][:es], verb: verb[:es] }
              end
            end
          end
        when :continuous
          verb = get_verb verb, form: :gerund
          verb[:en][:root].chomp!('e') if verb[:en][:root][-1] == 'e'
          case mode
          when :afirmative
            if tense
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], verb: verb[:en] }
              if tense == :future then question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en], verb: verb[:en] } end
              question[:answer][:es] = { noun: noun[aux][:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
            end
            if modal
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en], verb: verb[:en] }
              question[:answer][:es] = { noun: noun[aux][:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
            end
          when :negative
            if tense
              if tense == :future
                question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], negation: @negation[:en], complement: auxiliar[:en][1], verb: verb[:en] }
              else
                question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], negation: @negation[:en], verb: verb[:en] }
              end
              question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
            end
            if modal
              question[:answer][:en] = { noun: noun[aux][:en], auxiliar: auxiliar[:en][0], negation: @negation[:en], complement: auxiliar[:en][1], verb: verb[:en] }
              if modal == :ought_to
                question[:answer][:en] = { 
                  noun: noun[aux][:en], 
                  auxiliar: auxiliar[:en][0].split(' ').to_a[0], negation: @negation[:en], complement: "#{auxiliar[:en][0].split(' ').to_a[1]} be",
                  verb: verb[:en]
                }
              end
              question[:answer][:es] = { noun: noun[aux][:es], negation: @negation[:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
            end
          when :interrogative
            if tense
              if tense == :future
               question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], complement: auxiliar[:en][1], verb: verb[:en] }
              else
                question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], verb: verb[:en] }
              end
              question[:answer][:es] = { auxiliar: auxiliar[:es].join(' '), noun: noun[aux][:es], verb: verb[:es] }
            end
            if modal
              if modal == :would 
                question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], complement: auxiliar[:en][1], verb: verb[:en] }
                question[:answer][:es] = { noun: noun[aux][:es], auxiliar: auxiliar[:es].join(' '), verb: verb[:es] }
              else
                question[:answer][:en] = { auxiliar: auxiliar[:en][0], noun: noun[aux][:en], complement: auxiliar[:en][1], verb: verb[:en] }
                question[:answer][:es] = { auxiliar: auxiliar[:es][0], noun: noun[aux][:es], complement: auxiliar[:es][1], verb: verb[:es] }
              end
            end
          end
        end
      end

      return question
    end


    def set_output quiz, output: false
      case output
      when :html 
        return to_html quiz
      when :pdf
        return to_pdf quiz
      else
        return quiz
      end
    end

    private

    def get_pronoun(pronoun) { pronoun.to_sym => @pronouns.fetch(pronoun) } end


    def get_auxiliar tense: false, type: false, noun: false, perfective: false
      non_perfect = Proc.new do |tense, type, noun|
    		en_aux = @auxiliar[:en][type][tense][conjugation(noun)[:en]]
    		es_aux = @auxiliar[:es][type][tense][conjugation(noun)[:es]]
    		if type == :simple
    			en_comp = nil
    			es_comp = nil
        else # => continuous
    			en_comp = @auxiliar[:en][type][:complement] if tense == :future
    			es_comp = nil
    		end
    		return { en: [en_aux, en_comp].compact, es: [es_aux, es_comp].compact }
    	end

    	perfect = Proc.new do |tense, type, noun|
    		en_aux = @auxiliar[:en][:perfective][tense][conjugation(noun)[:en]]
    		es_aux = @auxiliar[:es][:perfective][tense][conjugation(noun)[:es]]
    		if type == :simple
        	en_comp = @auxiliar[:en][:perfective][:complement]
    			es_comp = nil
        else # => continuous
        	en_comp = @auxiliar[:en][:perfective][:complement]
    			es_comp = @auxiliar[:es][:perfective][:complement]
        end
        return { en: [en_aux, en_comp].compact, es: [es_aux, es_comp].compact }
    	end

    	if perfective
    		case perfective
    		  when  :simple
            perfect[tense, perfective, noun]
          when  :continuous
    			  perfect[tense, perfective, noun]
    		end
    	else
    	  non_perfect[tense, type, noun]
    	end
    end


    def get_modal modal: false,  type: false, noun: false, perfective: false
    	non_perfect = Proc.new do |modal, type, noun|
    		en_aux = @modal[:en][:name][modal]
    		es_aux = @modal[:es][type][noun][modal]
    		if type == :simple
    			en_comp = nil
    			es_comp = nil
        else # => continuous
    			en_comp = @modal[:en][type]
   				unless modal == :would then es_comp = @modal[:es][type][:infinitive] end
    		end
        return { en: [en_aux, en_comp].compact, es: [es_aux, es_comp].compact }
    	end
    	
    	perfect = Proc.new do |tense, perfective, noun|
    		en_aux = @modal[:en][:name][modal]
    		es_aux = @modal[:es][:perfective][noun][modal]
    		if perfective == :simple
        	en_comp = @modal[:en][:perfective][:infinitive]
    			unless modal == :would then es_comp = @modal[:es][:perfective][:infinitive] end
        else # => continuous
        	en_comp = "#{@modal[:en][:perfective][:infinitive]} #{@modal[:en][:perfective][:complement]}"
    			if modal == :would
    			  es_comp = "#{@modal[:es][:perfective][:complement]}"
    			 else
    			 	es_comp = "#{@modal[:es][:perfective][:infinitive]} #{@modal[:es][:perfective][:complement]}"
    			 end
        end
        return { en: [en_aux, en_comp].compact, es: [es_aux, es_comp].compact }
    	end
    	
    	if perfective
    		case perfective
    		  when  :simple
            perfect[modal, perfective, noun]
          when  :continuous
    			  perfect[modal, perfective, noun]
    		end
    	else
    	  non_perfect[modal, type, noun]
    	end
    end


    def get_verb verb, form: :present, noun: :singular_1st
      noun = conjugation(noun)[:es]
      spanish = Proc.new do |verb, form, noun|
        root = @verbs[:root][verb][6]
        infinitive = @verbs[:root][verb][7]
        gerund = @verbs[:root][verb][8]
        participle = @verbs[:root][verb][9]
        present = @verbs[:root][verb][2]
        past = @verbs[:root][verb][3] 
        future = @verbs[:root][verb][4]
        would = @verbs[:root][verb][5]
        case form
        when :present
          ending = @verbs[:es][:present][present][noun]
        when :past
          first = @verbs[:es][:past][past][1][noun]
          second = @verbs[:es][:past][past][2][noun]
          third = @verbs[:es][:past][past][3][noun]
          fourth = @verbs[:es][:past][past][4][noun]
          ending = "#{first} [#{second}-#{third}-#{fourth}]"
        when :future
          ending = @verbs[:es][:future][future][noun]
        when :would
          ending = @verbs[:es][:would][future][noun]
        when :infinitive
          ending = @verbs[:es][:infinitive][infinitive]
        when :simple
          ending = @verbs[:es][:infinitive][infinitive]
        when :third
          ending = @verbs[:es][:present][3][3]
        when :gerund
          ending = @verbs[:es][:gerund][gerund]
        when :participle
          ending = @verbs[:es][:participle][participle.to_i]
          if participle.class == String 
            # => irregular participle
            root =  participle.split('-')[0]
            ending = participle.split('-')[1]
          end
        end
        { root: root, ending: ending } # => return
      end

      english = Proc.new do |verb, form, noun|
        conjugation = @verbs[:root][verb][1]
        infinitive = @verbs[:root][verb][0]
        simple = infinitive.to_s.gsub('_','')
        if conjugation == :irr
          third = @verbs[:en][conjugation][verb][:third]
          past = @verbs[:en][conjugation][verb][:past]
          gerund = @verbs[:en][conjugation][verb][:gerund]
          participle = @verbs[:en][conjugation][verb][:participle]
        else
          third = @verbs[:en][conjugation][:third]
          past = @verbs[:en][conjugation][:past]
          gerund = @verbs[:en][conjugation][:gerund]
          participle = @verbs[:en][conjugation][:participle]
        end
        case form
        when :infinitive
          verb = { root: 'to ', ending: simple }
        when :simple
          verb = { root: simple }
        when :present
          verb = { root: simple, ending: third }
          unless noun == 3 then verb = { root: simple } end
        when :future
          verb = { root: simple }
        when :would
          verb = { root: simple }
        when :past
          verb = { root: simple, ending: past }
          if conjugation == :irr then verb = { root: past } end
        when :third
          verb = { root: simple, ending: third }
        when :gerund
          verb = { root: simple, ending: gerund }
        when :participle
          verb = { root: simple, ending: participle }
          if conjugation == :irr then verb = { root: participle } end
        end
        verb # => return
      end

      return { en: english[verb, form, noun], es: spanish[verb, form, noun] }
    end
   

    def conjugation noun
      # => converts :noun to the numbers use on get_auxiliar and get_verb
        return { en: 1, es: 1 } if noun == :singular_1st
        return { en: 0, es: 2 } if noun == :singular_2nd
        return { en: 3, es: 3 } if noun == :singular_3rd_m
        return { en: 3, es: 3 } if noun == :singular_3rd_f
        return { en: 3, es: 3 } if noun == :singular_3rd_n
        return { en: 0, es: 6 } if noun == :plural_1st
        return { en: 0, es: 8 } if noun == :plural_2nd
        return { en: 0, es: 8 } if noun == :plural_3rd
    end


    def theory xlsx_questionnaire_file
      file = Roo::Spreadsheet.open("#{xlsx_questionnaire_file}")
      file.default_sheet = file.sheets.first  
      list = Hash.new  
      file.last_row.to_i.times {|line| list.store(file.cell(line + 1, 1).to_s, file.cell(line + 1, 2).to_s)}      
      question, option1, option2, aux_questions = list.keys.sample, list.keys.sample, list.keys.sample, nil
      
      until question != option1 && question != option2 && option1 != option2 
        option1, option2 = list.keys.sample, list.keys.sample
      end

      list.each do |key, value|
        aux_questions = [key, value] if question == key
        option1 = value if option1 == key
        option2 = value if option2 == key
      end

      question = { question: nil, answer: nil, answers: [Array] }
      question[:question], question[:answer] = aux_questions[0], aux_questions[1]
      position = rand(3) 
      question[:answers][position] = question[:answer]
      question[:answers][1], question[:answers][2] = option1, option2 if position == 0
      question[:answers][0], question[:answers][2] = option1, option2 if position == 1
      question[:answers][0], question[:answers][1] = option1, option2 if position == 2

      return question
    end


    def to_pdf quiz
      document = Prawn::Document.new
      document.font("fonts/TragicMarker.otf")
      header = Proc.new do |section|
        document.image "images/logo_200x200_short_name.png", 
          :at => [450,730],
          :height => 100 
        document.font_size 14
        if quiz[:student]
          document.text "Student: #{quiz[:student]}\n", :color => "000000"
        else
          document.text "Student's name:___________________________________\n", :color => "000000"
        end
        document.text "#{quiz[:subject]}\n", :color => "404040"
        document.font_size 10
        document.text "Basic English\n", :color => "888888"
        document.text "#{quiz[:date]}\n", :color => "888888" 
        document.text "Teacher: Diego Mota\n", :color => "888888" 
        document.font_size 14
        document.text "#{section}.\n\n", :color => "404040"
        document.font_size 10
      end

      header['Theory']
      puts "Questionnaire of theory for #{quiz[:subject]}."
      quiz[:quiz_items].times do |i|
        document.text "#{i + 1}.(     ) #{quiz[:theory][i][:question]}\n", :color => "8358a0"
        document.indent(20) do
          document.text " A. #{quiz[:theory][i][:answers][0]}\n", :color => "808080"
          document.text " B. #{quiz[:theory][i][:answers][1]}\n", :color => "808080"
          document.text " C. #{quiz[:theory][i][:answers][2]}\n\n", :color => "808080"
        end
      end

      document.start_new_page
      header['Practice']
      puts "Practice exercises for #{quiz[:subject]}."
      quiz[:quiz_items].times do |i|
        if quiz[:subject] == 'pronoun'
          document.text "#{i + 1}.(     ) ¿Cuales son los correspondientes para #{quiz[:practice][i][:question]}?\n", :color => "8358a0"
          document.indent(20) do
            document.text " A. #{quiz[:practice][i][:options][0]}\n", :color => "808080"
            document.text " B. #{quiz[:practice][i][:options][1]}\n", :color => "808080"
            document.text " C. #{quiz[:practice][i][:options][2]}\n\n", :color => "808080"
          end
        end
        if quiz[:subject] == 'verb_form'
          document.text "#{i + 1}.- Escribe la forma #{quiz[:practice][i][:question][:form]} para #{quiz[:practice][i][:question][:verb]}", :color => "8358a0"
          document.indent(20) do
            document.text "en:________________________________________________\n", :color => "808080"
            document.text "es:________________________________________________\n\n", :color => "808080"
          end
        end
        if quiz[:subject] == 'auxiliar'
          document.text "#{i + 1}.- Escribe el auxiliar para #{quiz[:practice][i][:question][:type]} #{quiz[:practice][i][:question][:tense]} con #{quiz[:practice][i][:question][:noun]}.\n\n", :color => "8358a0"
          document.indent(20) do
            document.text "en:________________________________________________\n", :color => "808080"
            document.text "es:________________________________________________\n\n", :color => "808080"
          end
        end
        if quiz[:subject] == 'simple' || quiz[:subject] == 'continuous' || quiz[:subject] == 'simple_perfect' || quiz[:subject] == 'continuous_perfect' || quiz[:subject] == 'modal' || quiz[:subject] == 'indicative'
          document.text "#{i + 1}.- #{quiz[:practice][i][:question].values.join(' ')}.\n\n", :color => "8358a0"
          document.indent(20) do
            document.text "en:_________________________________________________________________\n", :color => "808080"
            document.text "es:_________________________________________________________________\n\n", :color => "808080"
          end
        end
      end

      document.start_new_page
      header['Answers']
      document.text "Theory.\n", :color => "8358a0"
      quiz[:quiz_items].times do |i|
        document.text "#{i + 1}.- #{quiz[:theory][i][:answer]}", :color => "888888" 
      end
      document.text "\nPractice.\n", :color => "8358a0"
      quiz[:quiz_items].times do |i|
        if quiz[:subject] == 'pronoun' then document.text "#{i + 1}.- #{quiz[:practice][i][:answer]}", :color => "888888" end
        if quiz[:subject] == 'verb_form' 
          if quiz[:practice][i][:answer][:en][:root] == 'to'
            document.text "#{i + 1}.- #{quiz[:practice][i][:answer][:en].values.join(' ')} - #{quiz[:practice][i][:answer][:es].values.join}", :color => "888888"
          else
            document.text "#{i + 1}.- #{quiz[:practice][i][:answer][:en].values.join} - #{quiz[:practice][i][:answer][:es].values.join}", :color => "888888"
          end
        end
        if quiz[:subject] == 'auxiliar' 
          if quiz[:practice][i][:answer][:es].nil? or quiz[:practice][i][:answer][:es].empty?
            document.text "#{i + 1}.- #{quiz[:practice][i][:answer][:en].join(' ')}}", :color => "888888" 
          else
            document.text "#{i + 1}.- #{quiz[:practice][i][:answer][:en].join(' ')} - #{quiz[:practice][i][:answer][:es].join(' ')}", :color => "888888" 
          end
        end
        if quiz[:subject] == 'simple' || quiz[:subject] == 'continuous' || quiz[:subject] == 'simple_perfect' || quiz[:subject] == 'continuous_perfect' || quiz[:subject] == 'modal' || quiz[:subject] == 'indicative'
          if quiz[:practice][i][:question][:mode] == :interrogative
            open_question, close_question = '¿', '?'
          else
            open_question, close_question = '', ''
          end
          quiz[:practice][i][:answer][:en][:verb] = quiz[:practice][i][:answer][:en][:verb].values.join
          quiz[:practice][i][:answer][:es][:verb] = quiz[:practice][i][:answer][:es][:verb].values.join
          if quiz[:practice][i][:answer][:no_aux].nil? or quiz[:practice][i][:answer][:no_aux].empty?
            document.text "#{i + 1}.en_ #{quiz[:practice][i][:answer][:en].values.join(' ')}#{close_question}", :color => "888888"
          else
            quiz[:practice][i][:answer][:no_aux][:verb] = quiz[:practice][i][:answer][:no_aux][:verb].values.join
            document.text "#{i + 1}.en_ #{quiz[:practice][i][:answer][:en].values.join(' ')}#{close_question} / #{quiz[:practice][i][:answer][:no_aux].values.join(' ')}#{close_question}", :color => "888888"
          end
          document.text "#{i + 1}.es_ #{open_question}#{quiz[:practice][i][:answer][:es].values.join(' ')}#{close_question}", :color => "888888"
        end
      end

      document.render_file "output/#{quiz[:subject]}_#{DateTime.now.strftime("%d%m%Y-%H%M%s")}.pdf"

      return "Made PDF for #{quiz[:subject]}."
    end


    def to_html quiz
      color = Proc.new { |color, data| data = "<font color='##{color}'>#{data}</font>" }

      puts "HTML of theory for #{quiz[:subject]}."
      quiz[:quiz_items].times do |i|
        quiz[:theory][i][:question] = color['808080', quiz[:theory][i][:question]]
        quiz[:theory][i][:answer] = color['808080', quiz[:theory][i][:answer]]
        quiz[:theory][i][:answers][0] = color['808080', quiz[:theory][i][:answers][0]]
        quiz[:theory][i][:answers][1] = color['808080', quiz[:theory][i][:answers][1]]
        quiz[:theory][i][:answers][2] = color['808080', quiz[:theory][i][:answers][2]]
      end

      puts "HTML of practice for #{quiz[:subject]}."
      quiz[:quiz_items].times do |i|
        case quiz[:subject]
        when 'pronoun'
          quiz[:practice][i][:question] = color ['ff1493', quiz[:practice][i][:question]]
          quiz[:practice][i][:answer] = color ['ff1493', quiz[:practice][i][:answer]]
          quiz[:practice][i][:options][0] = color ['ff1493', quiz[:practice][i][:options][0]]
          quiz[:practice][i][:options][1] = color ['ff1493', quiz[:practice][i][:options][1]]
          quiz[:practice][i][:options][2] = color ['ff1493', quiz[:practice][i][:options][2]]
        when 'verb_form'
          quiz[:practice][i][:question][:form] = color['8806f2', quiz[:practice][i][:question][:form]]
          quiz[:practice][i][:question][:verb] = color['047d7c', quiz[:practice][i][:question][:verb]]
          quiz[:practice][i][:answer][:en][:root] = color['047d7c', quiz[:practice][i][:answer][:en][:root]]
          quiz[:practice][i][:answer][:en][:ending] = color['8806f2', quiz[:practice][i][:answer][:en][:ending]]
          quiz[:practice][i][:answer][:es][:root] = color['047d7c', quiz[:practice][i][:answer][:es][:root]]
          quiz[:practice][i][:answer][:es][:ending] = color['8806f2', quiz[:practice][i][:answer][:es][:ending]]
        when 'auxiliar'
          quiz[:practice][i][:question][:type] = color['8806f2', quiz[:practice][i][:question][:type]]
          quiz[:practice][i][:question][:tense] = color['8806f2', quiz[:practice][i][:question][:tense]]
          quiz[:practice][i][:question][:noun] = color['ff1493', quiz[:practice][i][:question][:noun]]
          quiz[:practice][i][:answer][:en] = color['8806f2', quiz[:practice][i][:answer][:en].join(' ')]
          quiz[:practice][i][:answer][:es] = color['8806f2', quiz[:practice][i][:answer][:es].join(' ')]
        else
          quiz[:practice][i][:question][:type] = color['8806f2', quiz[:practice][i][:question][:type]]
          quiz[:practice][i][:question][:tense] = color['8806f2', quiz[:practice][i][:question][:tense]]
          quiz[:practice][i][:question][:mode] = color['808080', quiz[:practice][i][:question][:mode]]
          quiz[:practice][i][:question][:noun] = color['ff1493', quiz[:practice][i][:question][:noun]]
          quiz[:practice][i][:question][:verb] = color['047d7c', quiz[:practice][i][:question][:verb]]
          # => en
          quiz[:practice][i][:answer][:en][:noun] = color['ff1493', quiz[:practice][i][:answer][:en][:noun]]
          quiz[:practice][i][:answer][:en][:auxiliar] = color['8806f2', quiz[:practice][i][:answer][:en][:auxiliar]]
          unless quiz[:practice][i][:answer][:en][:negation].nil?
            quiz[:practice][i][:answer][:en][:negation] = color['ff0000', quiz[:practice][i][:answer][:en][:negation]]
          end
          unless quiz[:practice][i][:answer][:en][:complement].nil?
            quiz[:practice][i][:answer][:en][:complement] = color['8806f2', quiz[:practice][i][:answer][:en][:complement]]
          end
          quiz[:practice][i][:answer][:en][:verb][:root] = color['047d7c', quiz[:practice][i][:answer][:en][:verb][:root]]
          unless quiz[:practice][i][:answer][:en][:verb][:ending].nil?
            quiz[:practice][i][:answer][:en][:verb][:ending] = color['8806f2', quiz[:practice][i][:answer][:en][:verb][:ending]]
          end
          # => no_aux
          unless quiz[:practice][i][:answer][:no_aux].nil?
            quiz[:practice][i][:answer][:no_aux][:noun] = color['ff1493', quiz[:practice][i][:answer][:no_aux][:noun]]
            quiz[:practice][i][:answer][:no_aux][:verb][:root] = color['047d7c', quiz[:practice][i][:answer][:no_aux][:verb][:root]]
            unless quiz[:practice][i][:answer][:en][:verb][:ending].nil?
              quiz[:practice][i][:answer][:no_aux][:verb][:ending] = color['8806f2', quiz[:practice][i][:answer][:no_aux][:verb][:ending]]
            end
          end
          # => es
          quiz[:practice][i][:answer][:es][:noun] = color['ff1493', quiz[:practice][i][:answer][:es][:noun]]

          unless quiz[:practice][i][:answer][:es][:auxiliar].nil?
            quiz[:practice][i][:answer][:es][:auxiliar] = color['8806f2', quiz[:practice][i][:answer][:es][:auxiliar]]
          end

          unless quiz[:practice][i][:answer][:es][:negation].nil?
            quiz[:practice][i][:answer][:es][:negation] = color['ff0000', quiz[:practice][i][:answer][:es][:negation]]
          end
          unless quiz[:practice][i][:answer][:es][:complement].nil?
            quiz[:practice][i][:answer][:es][:complement] = color['8806f2', quiz[:practice][i][:answer][:es][:complement]]
          end
          quiz[:practice][i][:answer][:es][:verb][:root] = color['047d7c', quiz[:practice][i][:answer][:es][:verb][:root]]
          unless quiz[:practice][i][:answer][:es][:verb][:ending].nil?
            quiz[:practice][i][:answer][:es][:verb][:ending] = color['8806f2', quiz[:practice][i][:answer][:es][:verb][:ending]]
          end
        end
       end

      return quiz
    end

  end
end
