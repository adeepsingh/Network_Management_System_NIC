package com.nic.utility;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class RandomSaltGenerator {

    public static String generateSalt() throws NoSuchAlgorithmException {

        SecureRandom r = SecureRandom.getInstance("SHA1PRNG");;
        StringBuffer sb = new StringBuffer();
        while (sb.length() < 50) {
            sb.append(Integer.toHexString(r.nextInt()));
        }

        return sb.toString().substring(0, 50);

    }

}
