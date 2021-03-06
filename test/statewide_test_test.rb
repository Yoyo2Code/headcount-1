require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_test'

class StatewideTestTest < Minitest::Test

  def setup
    @statewide_test = StatewideTest.new(
    {:name => "ACADEMY 20",

    :third_grade =>
      {2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671},
       2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706},
       2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662},
       2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678},
       2012=>{:reading=>0.87, :math=>0.83, :writing=>0.655},
       2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668},
       2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}},

    :eighth_grade =>
      {2008=>{:math=>0.64, :reading=>0.843, :writing=>0.734},
      2009=>{:math=>0.656, :reading=>0.825, :writing=>0.701},
      2010=>{:math=>0.672, :reading=>0.863, :writing=>0.754},
      2011=>{:reading=>0.832, :math=>0.653, :writing=>0.745},
      2012=>{:math=>0.681, :writing=>0.738, :reading=>0.833},
      2013=>{:math=>0.661, :reading=>0.852, :writing=>0.75},
      2014=>{:math=>0.684, :reading=>0.827, :writing=>0.747}},

    :math =>
      {:all_students=>{2011=>0.68, 2012=>0.689, 2013=>0.696, 2014=>0.699},
      :asian=>{2011=>0.816, 2012=>0.818, 2013=>0.805, 2014=>0.8},
      :black=>{2011=>0.424, 2012=>0.424, 2013=>0.44, 2014=>0.42},
      :pacific_islander=>{2011=>0.568, 2012=>0.571, 2013=>0.683, 2014=>0.681},
      :hispanic=>{2011=>0.568, 2012=>0.572, 2013=>0.588, 2014=>0.604},
      :native_american=>{2011=>0.614, 2012=>0.571, 2013=>0.593, 2014=>0.543},
      :two_or_more=>{2011=>0.677, 2012=>0.689, 2013=>0.696, 2014=>0.693},
      :white=>{2011=>0.706, 2012=>0.713, 2013=>0.72, 2014=>0.723}},

    :reading =>
      {:all_students=>{2011=>0.83, 2012=>0.845, 2013=>0.845, 2014=>0.841},
       :asian=>{2011=>0.897, 2012=>0.893, 2013=>0.901, 2014=>0.855},
       :black=>{2011=>0.662, 2012=>0.694, 2013=>0.669, 2014=>0.703},
       :pacific_islander=>{2011=>0.745, 2012=>0.833, 2013=>0.866, 2014=>0.931},
       :hispanic=>{2011=>0.748, 2012=>0.771, 2013=>0.772, 2014=>0.007},
       :native_american=>{2011=>0.816, 2012=>0.785, 2013=>0.813, 2014=>0.007},
       :two_or_more=>{2011=>0.841, 2012=>0.845, 2013=>0.855, 2014=>0.008},
       :white=>{2011=>0.851, 2012=>0.861, 2013=>0.86, 2014=>0.008}},

    :writing =>
      {:all_students=>{2011=>0.719, 2012=>0.705, 2013=>0.72, 2014=>0.715},
      :asian=>{2011=>0.826, 2012=>0.808, 2013=>0.81, 2014=>0.789},
      :black=>{2011=>0.515, 2012=>0.504, 2013=>0.481, 2014=>0.519},
      :pacific_islander=>{2011=>0.725, 2012=>0.683, 2013=>0.716, 2014=>0.727},
      :hispanic=>{2011=>0.606, 2012=>0.597, 2013=>0.623, 2014=>0.624},
      :native_american=>{2011=>0.6, 2012=>0.589, 2013=>0.61, 2014=>0.62},
      :two_or_more=>{2011=>0.727, 2012=>0.718, 2013=>0.747, 2014=>0.731},
      :white=>{2011=>0.74, 2012=>0.726, 2013=>0.74, 2014=>0.734}}})
  end

  def test_proficient_by_grade
    expected =
    { 2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671},
      2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706},
      2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662},
      2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678},
      2012=>{:reading=>0.87, :math=>0.83, :writing=>0.655},
      2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668},
      2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}
    }

     assert_equal expected, @statewide_test.proficient_by_grade(3)
  end

  def test_proficient_by_unknown_grade_returns_error
    assert_raises UnknownDataError do
      @statewide_test.proficient_by_grade(1)
    end
  end

  def test_proficient_by_race_or_ethnicity
    expected =
    { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
      2012 => {math: 0.818, reading: 0.893, writing: 0.808},
      2013 => {math: 0.805, reading: 0.901, writing: 0.810},
      2014 => {math: 0.800, reading: 0.855, writing: 0.789},
    }

     assert_equal expected, @statewide_test.proficient_by_race_or_ethnicity(:asian)
  end

  def test_third_grade_proficiency_for_math_in_2008
    assert_equal 0.857, @statewide_test.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_eighth_grade_proficiency_for_writing_in_2013
    assert_equal 0.75, @statewide_test.proficient_for_subject_by_grade_in_year(:writing, 8, 2013)
  end

  def test_third_grade_proficiency_for_reading_in_2010
    assert_equal 0.864, @statewide_test.proficient_for_subject_by_grade_in_year(:reading, 3, 2010)
  end

  def test_invalid_year_for_proficient_for_subject_by_grade_in_year
    assert_raises UnknownDataError do
      @statewide_test.proficient_for_subject_by_grade_in_year(:reading, 3, 1998)
    end
  end

  def test_invalid_subject_for_proficient_for_subject_by_grade_in_year
    assert_raises UnknownDataError do
      @statewide_test.proficient_for_subject_by_grade_in_year(:awesomeness, 3, 2010)
    end
  end

  def test_invalid_grade_for_proficient_for_subject_by_grade_in_year
    assert_raises UnknownDataError do
      @statewide_test.proficient_for_subject_by_grade_in_year(:reading, 9, 2010)
    end
  end

  def test_proficiency_for_asian_students_in_math_in_2012
    assert_equal 0.818, @statewide_test.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
  end

  def test_proficiency_for_native_american_students_in_writing_in_2011
    assert_equal 0.6, @statewide_test.proficient_for_subject_by_race_in_year(:writing, :native_american, 2011)
  end

  def test_proficiency_for_pacific_islander_students_in_reading_in_2013
    assert_equal 0.866, @statewide_test.proficient_for_subject_by_race_in_year(:reading, :pacific_islander, 2013)
  end

  def test_invalid_subject_for_proficient_for_subject_by_race_in_year
    assert_raises UnknownDataError do
      @statewide_test.proficient_for_subject_by_race_in_year(:hello, :black, 2012)
    end
  end

  def test_invalid_ethnicity_for_proficient_for_subject_by_race_in_year
    assert_raises UnknownDataError do
      @statewide_test.proficient_for_subject_by_race_in_year(:reading, :butterscotch, 2012)
    end
  end

  def test_invalid_year_for_proficient_for_subject_by_race_in_year
    assert_raises UnknownDataError do
      @statewide_test.proficient_for_subject_by_race_in_year(:reading, :white, 2000)
    end
  end
end
