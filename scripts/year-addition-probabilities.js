/**
 * From a brief non-sequitur discussion in class on 2024-04-18...
 * What is the probability distribution of possible values when performing the following
 * operation on a date:
 * YYYY-MM-DD = YY + YY + MM + DD
 * Ex.
 * 1914-07-28 = 19 + 14 + 7 + 28 = 68
 * 1939-09-01 = 19 + 39 + 9 + 1 = 68
 * 2022-02-24 = 20 + 22 + 2 + 24 = 68
 */

// Might not be that hard to exhaustively solve this...
const START_YEAR = 1900;
const END_YEAR = 2024;

/**
 * Identifies if a number is a leap year
 * @param {number} year
 */
const isALeapYear = (year) => {
  return year % 4 === 0 && year % 100 !== 0;
}

/**
 * Pads a number with 0s on the left so that it is two digits long
 * @param {number} num
 */
const padStart2 = (num) => {
  return num.toString().padStart(2, 0)
}

/**
 * Pads a number with 0s on the left so that it is four digits long
 * @param {number} num
 */
const padStart4 = (num) => {
  return num.toString().padStart(2, 0)
}

const sumHistogram = {}
let totalValues = 0;
for (let year = 1900; year <= 2024; year++) {
  // Split the year into two
  const yearPt1 = Number(year.toString().padStart(4, '0').slice(0, 2))
  const yearPt2 = Number(year.toString().padStart(4, '0').slice(2))

  // Now do the months
  for (let month = 1; month <= 12; month++) {

    // Now do the days... which are different depending on the month
    const monthToDaysMap = {
      1: 31,
      2: 28, // Common year
      3: 31,
      4: 30,
      5: 31,
      6: 30,
      7: 31,
      8: 31,
      9: 30,
      10: 31,
      11: 30,
      12: 31
    };
    if (isALeapYear(year)) {
      monthToDaysMap[2] = 29; // Leap year
    }
    const numberOfDays = monthToDaysMap[month];
    for (let day = 1; day <= numberOfDays; day++) {
      // Sum it all up and update the histogram!
      const sum = yearPt1 + yearPt2 + month + day;

      if (!sumHistogram[sum]) {
        sumHistogram[sum] = 1;
      } else {
        sumHistogram[sum]++;
      }

      totalValues++;
    }
  }
}

// Log as a csv
let csv = 'sum,sumCount,sumChance\n'
for (const sum in sumHistogram) {
  const sumCount = sumHistogram[sum];
  csv += `${sum},${sumCount},${(sumCount/totalValues*100).toFixed(2)}%\n`;
}

console.log(csv);
console.log(`Total values: ${totalValues.toLocaleString()}`);

/**
 * Results:
 * Of the 45,655 dates between 1900-01-01 and 2024-12-31, 532 sum to 68. This equates to a
 * chance of 1.17%. However, there is a wide range of possible results (21-161) and the value
 * 68 is one of the more common possible results, with the most common results being 57 and 58
 * with 632 instances each equating to a chance of 1.38%. Given that _some_ result must be
 * chosen when performing the operation in question, it should not be surprising that three
 * arbitrary dates sum to the same value of 68. In fact, it would not be difficult to identify
 * all the possible dates that share a sum, and then pick out interesting dates to compare as
 * a way to "reverse engineer" the question
 */
