Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE6661F77
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jan 2023 08:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjAIHwd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Jan 2023 02:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjAIHwb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Jan 2023 02:52:31 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC328CE1E
        for <linux-spi@vger.kernel.org>; Sun,  8 Jan 2023 23:52:30 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y5so5496649pfe.2
        for <linux-spi@vger.kernel.org>; Sun, 08 Jan 2023 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=B76878Rlxls8OlpCtla2gw7eINru5yjC7pUPb1rZrbI=;
        b=VbzlyAqMArWNie8QaJO+K2xFMpYMg7pZV4Sp6/tit2sbm92wBLZofBJU2kB+VR33dj
         NJtOZZomu2w3Qx8lX5i0sz8sztP9K99SVqhjfEBK+XXCKp7JjjmELPswFRbkAzBhVC8S
         VlzTZnUvuenDEJeWQTXg3O8873KnLQFRZqYZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B76878Rlxls8OlpCtla2gw7eINru5yjC7pUPb1rZrbI=;
        b=PrFqUBt3pO9O45SsTF9I/MVFxVfEPqlArj9WaIXfjsT62twQIQ0J7M98PkeTJrTxhi
         fE5wtTcP+nzvtOUiZIVDg1TYADAAU5UMmK0rQKy591Tdl/ETEaaxuz3mKY3k6+0DBgDG
         j9wHLFaDR1BCTAaS6G2jmgm+pj1vnVvCm0Je4QGw26o4Flxmpz6A1l68GFQPYSYywQ4O
         YBJhjTz5L/PIDpGInlmX6c2ZkZ+v1Tk0nFsdgXVswdMEnN+SpG3F2IN2tGIUEZjSOvS8
         PUDST5ya34vDbyE9kaCg33o9mopWA73kjYSY6WRb7f80Ur4vy/sNanuVuKD4vBJlXM67
         YE3Q==
X-Gm-Message-State: AFqh2kqXcgQWecDJSBZTZiWWDBUubm/y6LL5C3mnDRYz+c9jhSwh0N/S
        7CMioGc5mVgzDjqrjo5HTYQYOA==
X-Google-Smtp-Source: AMrXdXs+8TvU0Tlzl6ScXUaVvcYgTmGtqao53cartaneTaDbKKvRRhPtX+LYtaVd5eJui/9+FHQN5Q==
X-Received: by 2002:a05:6a00:35c5:b0:586:e399:9cd4 with SMTP id dc5-20020a056a0035c500b00586e3999cd4mr6687846pfb.25.1673250750308;
        Sun, 08 Jan 2023 23:52:30 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id b193-20020a621bca000000b005810c4286d6sm5437106pfb.0.2023.01.08.23.52.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jan 2023 23:52:29 -0800 (PST)
Subject: Re: [PATCH 01/16] dt-bindings: spi: Convert bcm63xx-hsspi bindings to
 json-schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-2-william.zhang@broadcom.com>
 <0581eeed-f7d1-caf2-0dba-be14a01d7c05@linaro.org>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <7828c353-e3f3-31d2-638d-3b11dc085a34@broadcom.com>
Date:   Sun, 8 Jan 2023 23:52:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0581eeed-f7d1-caf2-0dba-be14a01d7c05@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009cde3b05f1d00c1f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--0000000000009cde3b05f1d00c1f
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/07/2023 07:32 AM, Krzysztof Kozlowski wrote:
> On 06/01/2023 21:07, William Zhang wrote:
>> This is the preparation for updates on the bcm63xx hsspi driver. Convert
>> the text based bindings to json-schema per new dts requirement.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> ---
>>
>>   .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 52 +++++++++++++++++++
>>   .../bindings/spi/spi-bcm63xx-hsspi.txt        | 33 ------------
>>   2 files changed, 52 insertions(+), 33 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>> new file mode 100644
>> index 000000000000..45f1417b1213
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Broadcom BCM6328 High Speed SPI controller
>> +
>> +maintainers:
>> +  - Jonas Gorski <jonas.gorski@gmail.com>
>> +
> 
> Missing reference to spi-controller.
> 
This was word to word conversion from the text file. But I will update 
with this required reference.

>> +properties:
>> +  compatible:
>> +    const: brcm,bcm6328-hsspi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: spi master reference clock
>> +      - description: spi master pll clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: hsspi
>> +      - const: pll
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +
>> +unevaluatedProperties: false
> 
> This is for cases when you have reference to other schema.
> 
Will drop here. But will add back in patch 1 which produces the final 
version of this file and need this property.

> 
> Best regards,
> Krzysztof
> 

--0000000000009cde3b05f1d00c1f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKYphwkPcE0r5NdBQNj1GxOn8RAn
jdkyEp0JMHZEeKr3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDEwOTA3NTIzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQDDTNLpcFGXLUU4N94d562LOM38QzMmcCl81eD71UhOjjeB
5EFo3Hg2I+XpIKtOMDgiDvq+pHSZFQFX3FQlrgjsGUeju+vVv98L6hZzF5XORZIR1EmSilK6k1/L
SHLe9qNndsAK2Lth9B3dEg88PuCwkcI9wfWCwLUCvKe1wLjb33MNw7SJpFZSNwJ4yrrfNX+ZtP6c
ABI6rJCdBZcMf4skxz/560HC5u/0mMSzda+JoyScftaTH5lDK8nR3nlw+nISk289EbEDTZmHl3qf
msS6qWrfQ1YrPa20BHcXQVZgnbHNYnLQZ3COooH7xgl0JvoDQ3shXzoYWOWWR4CqFJ3F
--0000000000009cde3b05f1d00c1f--
