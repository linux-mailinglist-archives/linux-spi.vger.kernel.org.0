Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1043687B5
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 22:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhDVULB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 16:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhDVULA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Apr 2021 16:11:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66872C06174A
        for <linux-spi@vger.kernel.org>; Thu, 22 Apr 2021 13:10:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so70671014ejo.13
        for <linux-spi@vger.kernel.org>; Thu, 22 Apr 2021 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=wgmYy/LMkr3JJRVe6OWv2xNNfb7j4siB1GggwwkeZVY=;
        b=Hw87f0vKJX6ikFIsxEDefV4hQCKQ/vDut2bwg0vXNIh02gg65hFiBF8sTw4f7o7GjG
         Z6FyVx2oJzlAM46oSFZaHsQ1l5+O7fhOnITZ2wIAflJbhrXnu6PY3n0fpltOy2TsIHfw
         4Dl7frgNDQer60q80SPZ9Y2Wqek58dYaAsRLL7HEq9z6fwLEB/aHF2TkaGMSvLpYcf9u
         Xlw01V5fLlPeiDKRF08xi4RVvTG5UtNFskloYRI5kplwujmNACwwz7MdJ/tcgqVa7XAp
         7QBli3aWPsi9+nLsuaIAAGEg1lkHXLlXysOq+3OKixqzv28oqv8zVIFPrlZ7CfvO85MN
         sejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wgmYy/LMkr3JJRVe6OWv2xNNfb7j4siB1GggwwkeZVY=;
        b=QcZunsyy/MrSG/9+B4bdHvZGK6WlkkujK6hZNpdD4sQkbbglX3Nkh/Pcm+fl4vEsIS
         yQUYpc+pk8vGvf0cHvNeEXA53fBAiQPuFKeXTrNp/zUN85vqIfiwicD8WQZSQxNMXVFo
         jknzFRR946luDXqEYhQBwDksddbTSuAO69dXkii1eSU4WIpImL/OtY0/FCKCoZft3bmi
         lgwlc2SWj/KOAx/FaasKpSV/yihZVLYCTK4e5AzvPnTlUrRHlqJX2W4fB5hSFUnzPcZH
         GiBt+0Kj3uPepbyFOnkDYIhGld/dz9NDBMDeDlhr5XWQhrPQiwrry+/hISnCtAmA6/FP
         M3oA==
X-Gm-Message-State: AOAM533ukrPTv5/HlPQD/9A/agVfq0T1NPHpH5KZO7ITka4uOIWkx43J
        JdPZnpb5MimtV9wk7NUaia+UqQ==
X-Google-Smtp-Source: ABdhPJyr+v8k/4PLnbIB4vbVJAw1m+H3To/oRAKVv86ZmcoWNyGn87iWvOyaqdHU3uqN8C0Pels1mQ==
X-Received: by 2002:a17:906:6896:: with SMTP id n22mr461659ejr.316.1619122224095;
        Thu, 22 Apr 2021 13:10:24 -0700 (PDT)
Received: from ?IPv6:2a02:8010:673b:0:65cb:937a:e25b:18a9? ([2a02:8010:673b:0:65cb:937a:e25b:18a9])
        by smtp.gmail.com with ESMTPSA id s9sm2833911edd.16.2021.04.22.13.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 13:10:23 -0700 (PDT)
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
Message-ID: <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
Date:   Thu, 22 Apr 2021 21:10:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> On 4/20/2021 1:34 AM, Joe Burmeister wrote:
>> It was previoulsy possible to have a device tree with more chips than
>> the driver supports and go off the end of CS arrays.
> Do you mind walking me through the code how that could have happened? W=
e
> have spi_register_controller() call of_spi_get_gpio_numbers() which has=

> the following:
>
> ctlr->num_chipselect =3D max_t(int, nb, ctlr->num_chipselect);
>
> such that what the controller has is the maximum between the number of
> 'cs-gpios' properties parsed and what was already populated in
> ctrl->num_chipselect during bcm2835_spi_probe(), which for this driver
> is BCM2835_SPI_NUM_CS (3).

If you make a initial device tree (or add overlay in the rpi's=20
config.txt) with more on the bus than BCM2835_SPI_NUM_CS (in my case 8
devices), you get into this trampling memory state. As the devices are
added, once the chip_select is equal to or greater than
BCM2835_SPI_NUM_CS, it's writing off the end of the arrays.

There is no protection from this happening. By the looks of it, this
isn't the only driver this could happen with, but it is the one I have
hardware for to test. There are also drivers that look like they don't
have a problem going well beyond the limit they gave.

There is protection in spi_add_device, which will catch extra added
later, but not ones in the device tree when the spi controller was
registered.

>> This patches inforces CS limit but sets that limit to the max of the
>> default limit and what is in the device tree when driver is loaded.
>>
>> Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
> You have changed many more things that just enforcing a limit on
> BCM2835_SPI_NUM_CS you have now made all chip-select related data
> structuresd dynamically allocated and you have changed a number of
> prints to use the shorthand "dev" instead of &pdev->dev.
The change to dynamic allocated arrays is just to support what is given
in the device=C2=A0 tree rather than increase and enforce the CS limit ju=
st
for my case.

The shorthand is of course not required. I'll drop it on resubmitting.

Regards,

Joe


