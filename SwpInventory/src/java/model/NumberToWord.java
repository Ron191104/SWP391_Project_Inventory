/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class NumberToWord {
   private static final String[] numberText = {
        "không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"
    };

    public static String convert(long number) {
        if (number == 0) return "Không đồng";

        String s = "";
        int i = 0;
        String[] unit = {"", " nghìn", " triệu", " tỷ"};

        while (number > 0) {
            int threeDigits = (int)(number % 1000);
            if (threeDigits != 0) {
                s = readThreeDigits(threeDigits) + unit[i] + " " + s;
            }
            number /= 1000;
            i++;
        }

        return s.trim() + " đồng";
    }

    private static String readThreeDigits(int number) {
        int hundreds = number / 100;
        int tens = (number % 100) / 10;
        int units = number % 10;

        StringBuilder sb = new StringBuilder();

        if (hundreds > 0) {
            sb.append(numberText[hundreds]).append(" trăm ");
        } else if (tens > 0 || units > 0) {
            sb.append("không trăm ");
        }

        if (tens > 1) {
            sb.append(numberText[tens]).append(" mươi ");
            if (units == 1) {
                sb.append("mốt");
            } else if (units == 5) {
                sb.append("lăm");
            } else if (units > 0) {
                sb.append(numberText[units]);
            }
        } else if (tens == 1) {
            sb.append("mười ");
            if (units == 5) {
                sb.append("lăm");
            } else if (units > 0) {
                sb.append(numberText[units]);
            }
        } else if (units > 0) {
            sb.append("lẻ ").append(numberText[units]);
        }

        return sb.toString().trim();
    }
}
