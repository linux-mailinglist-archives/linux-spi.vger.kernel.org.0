Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6597D6662F3
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jan 2023 19:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjAKSo2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Jan 2023 13:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjAKSo1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Jan 2023 13:44:27 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53EDF26
        for <linux-spi@vger.kernel.org>; Wed, 11 Jan 2023 10:44:25 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 36so11152960pgp.10
        for <linux-spi@vger.kernel.org>; Wed, 11 Jan 2023 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=rm/TekH17MYWhc83FXhY1OZ8K681O6BF5vC2qvnXAak=;
        b=ESlw244f7OSwOedLwEIBmeY74JyVjBBO5cw/H32bX+9Yv922t5mW+uqcw3aGANx7/y
         1XV0Q1j8sWDvoqnvb8pnddTzpxCi2/3jba2ytZ+9XngwudA4G/GzVpNPJ+kWKvbFEp96
         NBQine42ifpxaGVKGy7y1+bxUHPQb7rxKvkuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm/TekH17MYWhc83FXhY1OZ8K681O6BF5vC2qvnXAak=;
        b=7WhkixfhJiDVPujVgZT6dyXxGo9TRlXH7bXWykDYoJfNvRFZ81SjKgElPjWTWp7xP8
         sHafT627AJM6TQdnirGbGNn3irz/ijQJpyN23dWqDd2DdkkNQQPQRxCUtJz/Pux69Fuk
         Z6TtIrSnOER3ByAd7mCiquReNt9mEqV61Jt/GhOa2TUkLBq7gr1Ko4UMeDN85m63X3I2
         CKUZLhZC1iRqeH1GJS1fPIU4qOPeYwIZ4RCZGgEAfQPtoY+1RaVJjieFXMdYSeOj/gVr
         taocojyVAVn3qd71D9FN4Yut0eqC4DayWtbkrjWnCkHEMKGNs2OwkwSnzT425QWEpKOE
         l+PA==
X-Gm-Message-State: AFqh2kqY0Ty0VzJ3hfXZ64jubkyztLW3D2haAohtodATDW49ODCFVyuF
        s4PDp8zRivmw7EkjmlYJtQIE1Q==
X-Google-Smtp-Source: AMrXdXsrn2eI8eeQVpslDkNqDRG+ZZlMr1sgJv3/TClnObVN/UtD03GHAO6AOAU30jL+h/7GfZJwcA==
X-Received: by 2002:aa7:9796:0:b0:58a:66a8:edf5 with SMTP id o22-20020aa79796000000b0058a66a8edf5mr7576017pfp.3.1673462665132;
        Wed, 11 Jan 2023 10:44:25 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7942f000000b00587e3bd696dsm7190396pfo.90.2023.01.11.10.44.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 10:44:24 -0800 (PST)
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        jonas.gorski@gmail.com, kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-3-william.zhang@broadcom.com>
 <b529a53b-d00c-063d-a58d-e64b0300605d@linaro.org>
 <5dfac2d7-3b4b-9ded-0dde-26b289c604d0@broadcom.com>
 <99b01e96-3b96-6692-c5e1-87db49295e6d@linaro.org>
 <49925933-aacc-4f0d-a1ca-e1bd45b05eee@broadcom.com>
 <b246a81f-e465-5e52-f0ce-65e0a82fc3e1@linaro.org>
 <32a464f8-6a4b-6777-9775-f17e990e0c6a@gmail.com>
 <71c2e796-f0fb-90cd-4599-13c9718f41d5@linaro.org>
 <31644849-dc69-ddfc-a6b6-6ffd37d64d2b@broadcom.com>
 <f0a50234-bc8c-09c4-e2c1-22cbeaba5c15@linaro.org>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <e99a71b2-0b05-1a53-1c29-3778b49a3b86@broadcom.com>
Date:   Wed, 11 Jan 2023 10:44:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <f0a50234-bc8c-09c4-e2c1-22cbeaba5c15@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b9023705f20163a6"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--000000000000b9023705f20163a6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/11/2023 10:12 AM, Krzysztof Kozlowski wrote:
> On 11/01/2023 19:04, William Zhang wrote:
>>
>>
>> On 01/11/2023 01:02 AM, Krzysztof Kozlowski wrote:
>>> On 10/01/2023 23:18, Florian Fainelli wrote:
>>>> On 1/10/23 00:40, Krzysztof Kozlowski wrote:
>>>>>>> No, it is discouraged in such forms. Family or IP block compatibles
>>>>>>> should be prepended with a specific compatible. There were many issues
>>>>>>> when people insisted on generic or family compatibles...
>>>>>>>
>>>>>>>> Otherwise we will have to have a compatible string with chip model for
>>>>>>>> each SoC even they share the same IP. We already have more than ten of
>>>>>>>> SoCs and the list will increase.  I don't see this is a good solution too.
>>>>>>>
>>>>>>> You will have to do it anyway even with generic fallback, so I don't get
>>>>>>> what is here to gain... I also don't get why Broadcom should be here
>>>>>>> special, different than others. Why it is not a good solution for
>>>>>>> Broadcom SoCs but it is for others?
>>>>>>>
>>>>>> I saw a few other vendors like these qcom ones:
>>>>>>      qcom,spi-qup.yaml
>>>>>>          - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
>>>>>>          - qcom,spi-qup-v2.1.1 # for 8974 and later
>>>>>>          - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
>>>>>>      qcom,spi-qup.yaml
>>>>>>          const: qcom,geni-spi
>>>>>
>>>>> IP block version numbers are allowed when there is clear mapping between
>>>>> version and SoCs using it. This is the case for Qualcomm because there
>>>>> is such clear mapping documented and available for Qualcomm engineers
>>>>> and also some of us (although not public).
>>>>>
>>>>>> I guess when individual who only has one particular board/chip and is
>>>>>> not aware of the IP family,  it is understandable to use the chip
>>>>>> specific compatible string.
>>>>>
>>>>> Family of devices is not a versioned IP block.
>>>>
>>>> Would it be acceptable to define for instance:
>>>>
>>>> - compatible = "brcm,bcm6868-hsspi", "brcm,bcmbca-hsspi";
>>>
>>> Yes, this is perfectly valid. Although it does not solve William
>>> concerns because it requires defining specific compatibles for all of
>>> the SoCs.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> As I mentioned in another email,  I would be okay to use these
>> compatibles to differentiate by ip rev and to conforms to brcm convention:
>> "brcm,bcmXYZ-hsspi", "brcm,bcmbca-hsspi-v1.0", "brcm,bcmbca-hsspi";
>> "brcm,bcmXYZ-hsspi", "brcm,bcmbca-hsspi-v1.1", "brcm,bcmbca-hsspi";
> 
> 
> Drop the version in such case, no benefits. I assume XYZ is the SoC
> model, so for example 6868.
> 
Yes XYZ is the SoC model
>>
>> In the two drivers I included in this series, it will be bound to
>> brcm,bcmbca-hsspi-v1.0 (in additional to brcm,bcm6328-hsspi) and
>> brcm,bcmbca-hsspi-v1.1 respectively.  This way we don't need to update
>> the driver with a new soc specific compatible whenever a new chips comes
>> out.
> 
> I don't understand why do you bring it now as an argument. You defined
> before that your driver will bind to the generic bcmbca compatible, so
> now it is not enough?
> 
No as we are adding chip model specific info here.  The existing driver 
spi-bcm63xx-hsspi.c only binds to brcm,bcm6328-hsspi. This driver 
supports all the chips with rev1.0 controller so I am using this 6328 
string for other chips with v1.0 in the dts patch, which is not ideal.
Now I have to add more compatible to this driver and for each new chip 
with 1.0 in the future if any.

With all the thoughts from you and Florian,  I think it is better to use 
rev compatible in the driver but add on chip model compatible in the dts.



> Best regards,
> Krzysztof
> 

--000000000000b9023705f20163a6
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPt6jCv3WfzRLoP/WY+sic5M7lvU
Er5xihcrGqPZ6ULUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDExMTE4NDQyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBIRXSRpSeSdqbQmhpHDMiEWjNrwzQh2BY4ckT/3a1Oupkg
6ZkEBJn384MFPxS4s+KwYXaFBRMTq/I5QVXcr6jlK+hk6nFQSvnR+EC9b0fBlge4xINovQZVIOuQ
0IBeT3GA6n+5GKSpWRqDdqX2KIApwGfmqeCWG/DhXdhtS4S8duZQMyxIEHoku/NzoQmB/C54k8ZN
aWzsSGkT2MjIubHcuonVJRou9crfiic3gGnxTc0Pm9MbfPGCAB9JzCwJbWk7htvs83bp5Kb5FgJD
QFPwLuQsKMJRZhwhpXcROEvzzcE0J+xDj81o2ojcbjWb2FG6wA8hSjN1UOto+UPRmX3+
--000000000000b9023705f20163a6--
