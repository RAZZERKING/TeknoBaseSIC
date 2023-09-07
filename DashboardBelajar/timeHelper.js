function addTime(hour11, minute11, minute22) {
    let hour1 = Number.parseInt(hour11)
    let minute1 = Number.parseInt(minute11)
    let minute2 = Number.parseInt(minute22)

    //let kelebihanMinute
    let newHour = hour1
    let newMinute = minute1

    console.log('start calculate')


    function calculate() {
        let tempCalculation = newMinute + minute2

        console.log('before calculating')
        console.log('hour ' + newHour + ' minuteCalculation ' + tempCalculation + ' minute2 ' + minute2)

        console.log('now calculating')

        if (tempCalculation >= 60) {
            console.log("more than 60")

            minute2 -= 60 - newMinute
            newHour++
            newMinute = 0
            calculate()

        } else {
            console.log("NOT more than 60")

            newMinute = tempCalculation
        }
    }

    calculate()

    return { 'jam': convertToTwoDigit(newHour), 'menit': convertToTwoDigit(newMinute) }
}

function convertToTwoDigit(number) {
    if (number < 10)
        return "0" + number
    else
        return number
}
