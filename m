Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29C5368FFE
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhDWKEF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 06:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbhDWKEE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Apr 2021 06:04:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5FC06174A
        for <linux-spi@vger.kernel.org>; Fri, 23 Apr 2021 03:03:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s7so47683616wru.6
        for <linux-spi@vger.kernel.org>; Fri, 23 Apr 2021 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language;
        bh=HKL1mkJYoMnoGjLRHkZI5ubcj6lt7L1hgGPwJaa/O+s=;
        b=TAM90DjiP1mFuwXCN05lzFpFCubdfxAA4g9vRzQZEMjZK/DOV7c+dgL1BurqGdLVDW
         lbgqk3L3DgEZw7aGHUnWQNg7LV6tQLjcBOXfMgsjYFO9OYCg6q8+OfFx0OofEq+3o/vh
         Pjv0dfx1Apz5lpqcIn8fW2zEiP810b6+qoXG1+X9OgeF+5TtXt6HOEsRq2NhWnwsED71
         +3LKFvAdCxCL5CzPFg0V/FzpBtUgXuNZtqJbFDvDqi9Nr6U7ZmOCkC/AUKA8+ApDIgwk
         2qqfAzRTzL9BiJNGF7WIyEGN7O9/7kmeyGGEmkGe8ASq6kQPjp9RV/XdZsLNh1PLy+Gy
         qoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=HKL1mkJYoMnoGjLRHkZI5ubcj6lt7L1hgGPwJaa/O+s=;
        b=WWfLNEoITX6AxjtDWe3RhrXOgS2W92Snqq5T4cz6jgTxzd7/2huJYWg1Cny5LbovI1
         PpqNQzVfTUrN/614kExmQS+HWRw2pGIO1kZYLMGeqRjgwxVLmt9yn0qdC33Fh2ZNMw6j
         0jh4Zxql4H7tYf0U5WpEaEHeVIPCHUc32nzLzSANto4iNa6UW9AVi4qttTX0+hOGuTXG
         E8Fl/M2ehBttIiFfQwGb881wMKbL+IQ9WWgrKgrbbHsB201lbJUwtNnPRg5hkiNrvIE3
         hQh6tilYtV26i5zhLn1WMRm6o7xn6rOzz9tdaUVGDE2HhKrsrJNDa3URS5Zx0Coq/uBU
         ncjw==
X-Gm-Message-State: AOAM531EmkGw2i0vOpPQhHm3Hrok74UMxCEU1XAeIwZGPw09wqjhhLUA
        yyIRqRz/jnr7sCxpb42GFOHz1Q==
X-Google-Smtp-Source: ABdhPJwwmlKrJGU8ou4ISVehBg4YQXU5KWnu5rjIFMqp+AhJV8WyIwtdUKUTCXfw+Y8Xyj8x2XrCRw==
X-Received: by 2002:a05:6000:12cb:: with SMTP id l11mr3627909wrx.267.1619172204366;
        Fri, 23 Apr 2021 03:03:24 -0700 (PDT)
Received: from [192.168.200.229] (static-84-9-134-242.vodafonexdsl.co.uk. [84.9.134.242])
        by smtp.gmail.com with ESMTPSA id o17sm8087870wrv.16.2021.04.23.03.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 03:03:23 -0700 (PDT)
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nsaenz@kernel.org
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
 <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
 <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
Message-ID: <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
Date:   Fri, 23 Apr 2021 11:03:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------28900068CB36B9C1831BE1A2"
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a multi-part message in MIME format.
--------------28900068CB36B9C1831BE1A2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 23/04/2021 00:49, Florian Fainelli wrote:
> On 4/22/2021 1:10 PM, Joe Burmeister wrote:
>>> On 4/20/2021 1:34 AM, Joe Burmeister wrote:
>>>> It was previoulsy possible to have a device tree with more chips tha=
n
>>>> the driver supports and go off the end of CS arrays.
>>> Do you mind walking me through the code how that could have happened?=20
We
>>> have spi_register_controller() call of_spi_get_gpio_numbers() which h=
as
>>> the following:
>>>
>>> ctlr->num_chipselect =3D max_t(int, nb, ctlr->num_chipselect);
>>>
>>> such that what the controller has is the maximum between the number o=
f
>>> 'cs-gpios' properties parsed and what was already populated in
>>> ctrl->num_chipselect during bcm2835_spi_probe(), which for this drive=
r
>>> is BCM2835_SPI_NUM_CS (3).
>> If you make a initial device tree (or add overlay in the rpi's=20
>> config.txt) with more on the bus than BCM2835_SPI_NUM_CS (in my case 8=

>> devices), you get into this trampling memory state. As the devices are=

>> added, once the chip_select is equal to or greater than
>> BCM2835_SPI_NUM_CS, it's writing off the end of the arrays.
> OK.
>
>> There is no protection from this happening. By the looks of it, this
>> isn't the only driver this could happen with, but it is the one I have=

>> hardware for to test. There are also drivers that look like they don't=

>> have a problem going well beyond the limit they gave.
> Right, which means that we should probably seek a solution within the
> SPI core itself, even if you can only test with spi-bcm2835.c chances
> are that the fix would be applicable for other controllers if done in
> the core.

I'm not sure it's possible to do in the core alone. The numb of the
issue is the core changes ctlr->num_chipselect to what is in the device
tree and some drivers are cool with that overs quietly stomp memory.

If we stop the core changing ctlr->num_chipselect then sod's law says
that we'd break existing devices which exceed the drivers num_chipselect
without a problem.

I've got a simple little patch to warn when the core expands
ctlr->num_chipselect. This warning won't go off in bcm2835 with my patch
because I am also extending ctlr->num_chipselect to the amount in the
device tree before the core does that expansion. Hopefully that new
warning would make people investigate and fix problem drivers.


>> There is protection in spi_add_device, which will catch extra added
>> later, but not ones in the device tree when the spi controller was
>> registered.
> Not sure I follow you, if we have the overlay before
> spi_register_controller() is called, how can the check there not
> trigger? And if we load the overlay later when the SPI controller is
> already registered, why does not spi_add_device()'s check work?

I think it might be a RPI thing. I think it is merging in the overlay
and giving Linux one already merged.


> How would I go about reproducing this on a Pi4?

Attached is a device tree overlay. If you compile that up and stick it
in /boot/overlays and add dtoverlay=3Drpi-bug to your config.txt, you can=

get into this state.

If you do dtoverlay, you don't see anything, but if you do:

ls /dev/spi*

You can see all the spidev added by this are added. 2 of which go beyond
the drivers CS arrays.


>>>> This patches inforces CS limit but sets that limit to the max of the=

>>>> default limit and what is in the device tree when driver is loaded.
>>>>
>>>> Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
>>> You have changed many more things that just enforcing a limit on
>>> BCM2835_SPI_NUM_CS you have now made all chip-select related data
>>> structuresd dynamically allocated and you have changed a number of
>>> prints to use the shorthand "dev" instead of &pdev->dev.
>> The change to dynamic allocated arrays is just to support what is give=
n
>> in the device=C2=A0 tree rather than increase and enforce the CS limit=20
just
>> for my case.
>>
>> The shorthand is of course not required. I'll drop it on resubmitting.=

>>
>> Regards,
>>
>> Joe
>>
>>

--------------28900068CB36B9C1831BE1A2
Content-Type: audio/vnd.dts;
 name="rpi-bug-overlay.dts"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="rpi-bug-overlay.dts"

L2R0cy12MS87Ci9wbHVnaW4vOwoKLyB7CiAgICBjb21wYXRpYmxlID0gImJyY20sYmNtMjcw
OCIsICJicmNtLGJjbTI3MDkiLCAiYnJjbSxiY20yNzB4IiwgImJyY20sYmNtMjcxMCIsICJi
cmNtLGJjbTI3MTEiLCAiYnJjbSxiY20yNzF4IiwgImJyY20sYmNtMjgzNSIsICJicmNtLGJj
bTI4MzYiLCAiYnJjbSxiY20yODM3IiwgImJyY20sYmNtMjgzeCI7CgogICAgZnJhZ21lbnRA
OSB7CiAgICAgICAgdGFyZ2V0ID0gPCZncGlvPjsKICAgICAgICBfX292ZXJsYXlfXyB7CiAg
ICAgICAgICAgIHRlc3RfY3NfcGluczogdGVzdF9jc19waW5zIHsKICAgICAgICAgICAgICAg
IGJyY20scGlucyA9IDwxNCAxNSAxNiAxNyAxOCAxOT47CiAgICAgICAgICAgICAgICBicmNt
LGZ1bmN0aW9uID0gPDE+OyAvKiBvdXRwdXQgKi8KICAgICAgICAgICAgfTsKICAgICAgICB9
OwogICAgfTsKCiAgICBmcmFnbWVudEAxIHsKICAgICAgICB0YXJnZXQgPSA8JnNwaTA+Owog
ICAgICAgIF9fb3ZlcmxheV9fIHsKICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
CiAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+OwogICAgICAgICAgICBzdGF0dXMgPSAi
b2theSI7CiAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CiAgICAgICAg
ICAgIHBpbmN0cmwtMCA9IDwmc3BpMF9waW5zICZ0ZXN0X2NzX3BpbnM+OwogICAgICAgICAg
ICBjcy1ncGlvcyA9IDwmZ3BpbyAxNCAxPiwgPCZncGlvIDE1IDE+LAogICAgICAgICAgICAg
ICAgICAgICAgIDwmZ3BpbyAxNiAxPiwgPCZncGlvIDE3IDE+LAogICAgICAgICAgICAgICAg
ICAgICAgIDwmZ3BpbyAxOCAxPiwgPCZncGlvIDE5IDE+OwogICAgICAgICAgICBjc190ZXN0
XzA6IGNzX3Rlc3RfMEAwIHsKICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic3BpZGV2
IjsKICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDA+OwogICAg
ICAgICAgICAgICAgcmVnID0gPDA+OwogICAgICAgICAgICB9OwogICAgICAgICAgICBjc190
ZXN0XzE6IGNzX3Rlc3RfMUAxIHsKICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic3Bp
ZGV2IjsKICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDA+Owog
ICAgICAgICAgICAgICAgcmVnID0gPDE+OwogICAgICAgICAgICB9OwogICAgICAgICAgICBj
c190ZXN0XzI6IGNzX3Rlc3RfMkAyIHsKICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
c3BpZGV2IjsKICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDA+
OwogICAgICAgICAgICAgICAgcmVnID0gPDI+OwogICAgICAgICAgICB9OwogICAgICAgICAg
ICBjc190ZXN0XzM6IGNzX3Rlc3RfM0AzIHsKICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAic3BpZGV2IjsKICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAw
MDA+OwogICAgICAgICAgICAgICAgcmVnID0gPDM+OwogICAgICAgICAgICB9OwogICAgICAg
ICAgICBjc190ZXN0XzQ6IGNzX3Rlc3RfNEA0IHsKICAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAic3BpZGV2IjsKICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUw
MDAwMDA+OwogICAgICAgICAgICAgICAgcmVnID0gPDQ+OwogICAgICAgICAgICB9OwogICAg
ICAgICAgICBjc190ZXN0XzU6IGNzX3Rlc3RfNUA1IHsKICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAic3BpZGV2IjsKICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0g
PDUwMDAwMDA+OwogICAgICAgICAgICAgICAgcmVnID0gPDU+OwogICAgICAgICAgICB9Owog
ICAgICAgIH07CiAgICB9Owp9Owo=
--------------28900068CB36B9C1831BE1A2--
