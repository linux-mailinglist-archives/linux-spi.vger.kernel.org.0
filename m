Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765341CF99
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfENTGn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 15:06:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38489 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfENTGn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 15:06:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id y19so49260lfy.5
        for <linux-spi@vger.kernel.org>; Tue, 14 May 2019 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SPWmKpq6VDGUfyOzmQTA3tI7BJu0RPpA6WUx4ql1p0M=;
        b=MeFq+tmDozlVwHUa/pirnaQUyzHzhiC922oLEAd3VZSh7SQs/8lTjYBKazPc8OI/3f
         aD8IoPZ8mJx5iLrL+MCV/S9RnL1ffUq9tgdO6ubADK0wQj3lx2tIb2T9eO5FVg9jcnEV
         l48gJnNLj8cFsXg356nvAolyYevr0DwKfyW0dhSkz3vR3T0wCBP7RPDLfxZt50xi69l5
         u5zLWcDHJcPmasR54xK+MBfniS3Mh21UfWPTl7N6KLj8pwkK/rhJg8/W7QjH7+ex66Dm
         OamrI2TSVd9HUuywpc6pkUClP5OK0UHg6vlo0K4S2IF+L5a4DN5OMKLT2ucSF52OXx9s
         Sxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SPWmKpq6VDGUfyOzmQTA3tI7BJu0RPpA6WUx4ql1p0M=;
        b=Ipw44mOUDEeQ8rqGK5SGTXvlmaP/MM0N2KD4HRAvsNxMiP071pRKb9htidccNfBUqK
         LsBlcNXz7Fvc0bZuB44ABCcgPtDDl9sIkNGOIwfoirbTAqqzlVTz1oaJG0oOrdoOsgBY
         y6qAW7Wg9aOE94cNJHMHowGhQ3lI8h1r2IuzJVQS9lHJs4HEkFskfEToxgwFUyrVdjAz
         VqLADk2hlRONIsq6yIaaEHtG+dE45QLlIezEKDzZnW2cKZ5wXn5JjjaXwtQcJFLxQWZD
         8Uprd5iOuXr85h8nFZK37uR1nTSls1/NkzCO3AS8C+eizfZpI76wHilFuCA2RnFNNmrK
         rgyg==
X-Gm-Message-State: APjAAAXHMaRTIksa7hUt0J2NTSJWnixe5dipVYnywPMCBCxGTS+cu2yL
        UbR/tkLNUYqCsG62anxiRbm2Zg==
X-Google-Smtp-Source: APXvYqwRZdUgwLeaMIdAgHuhbJILXHkJsRzfX0+TBZ94IjzXws/h3v/fHnQlT4e7PoL8NqcM0zp2iA==
X-Received: by 2002:a19:1dc3:: with SMTP id d186mr17340891lfd.101.1557860800826;
        Tue, 14 May 2019 12:06:40 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.127])
        by smtp.gmail.com with ESMTPSA id j19sm3969610lfj.52.2019.05.14.12.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:06:40 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com>
 <cdee3d53-6ee3-4435-117e-8ba4a58ca72b@cogentembedded.com>
 <OF82CE76E9.E6395EF7-ON482583DD.000E37D7-482583DD.000E5077@mxic.com.tw>
 <3d334751-8fd4-7db1-9deb-e6c94936df13@cogentembedded.com>
 <OF4ABCC306.B053BA23-ON482583E0.000F480C-482583E0.000FAD4A@mxic.com.tw>
 <3971c669-9095-9d18-d029-37f9663a54b2@cogentembedded.com>
 <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9014077e-2648-adad-72c1-baf834f5a511@cogentembedded.com>
Date:   Tue, 14 May 2019 22:06:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 04/19/2019 08:38 AM, masonccyang@mxic.com.tw wrote:

>> >> >> >> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>> >> >> >>
>> >> >> >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >> >> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> >> >> > [...]
>> >> >> >> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-
>> >> renesas-rpc.c
>> >> >> >> new file mode 100644
>> >> >> >> index 0000000..037f273
>> >> >> >> --- /dev/null
>> >> >> >> +++ b/drivers/spi/spi-renesas-rpc.c
>> >> >> > [...]
>> >> >> >> +static int rpc_spi_probe(struct platform_device *pdev)
>> >> >> >> +{
>> >> >> >> +   struct spi_controller *ctlr;
>> >> >> >> +   struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
>> >> >> >> +   struct rpc_spi *rpc;
>> >> >> >> +   int ret;
>> >> >> >> +
>> >> >> >> +   ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
>> >> >> >> +   if (!ctlr)
>> >> >> >> +      return -ENOMEM;
>> >> >> >> +
>> >> >> >> +   platform_set_drvdata(pdev, ctlr);
>> >> >> >> +
>> >> >> >> +   rpc = spi_controller_get_devdata(ctlr);
>> >> >> >> +
>> >> >> >> +   ctlr->dev.of_node = pdev->dev.of_node;
>> >> >> > [...]
>> >> >> >> +
>> >> >> >> +   pm_runtime_enable(&pdev->dev);
>> >> >> >> +   ctlr->auto_runtime_pm = true;
>> >> >> >
>> >> >> >    I think this line no longer works as expected with the new
>> >> >> probing scheme.
>> >>
>> >>    That's because we added another (SPI) device under our MFD.
>> >
>> > Do you mean just to remove one line
>> > ctlr->auto_runtime_pm = true;
>> > ?
> 
> how did you test it ?
> what is your testing flow ?
> 
>>    No, you should explicitly call RPM for the MFD (not the SPI device).
> 
> okay, patch RPM to RPC MFD and will remove SPI RPM enable part.
> 
>>
>> >> >> > Have you tested reading? v8 patch still works while v9 patches
>> >> >> > hang on doing:
>> >> >> >
>> >> >> > $ cat /dev/mtd<n>...
>> >> >>
>> >> >>    Sorry, 'od -x', not 'cat'.
>> >> >
>> >> > root@draak:/# cat /proc/mtd
>> >> > dev:    size   erasesize  name
>> >> > mtd0: 00040000 00001000 "Bank 1 - Boot parameter"
>> >> > mtd1: 00140000 00001000 "Bank 1 - Loader-BL2"
>> >> > mtd2: 00040000 00001000 "Bank 1 - Certification"
>> >> > mtd3: 00080000 00001000 "Bank 1 - ARM Trusted FW"
>> >> > mtd4: 00400000 00001000 "Bank 1 - Reserved-1"
>> >> > mtd5: 00300000 00001000 "Bank 1 - U-Boot"
>> >> > mtd6: 00200000 00001000 "Bank 1 - Reserved-2"
>> >> > mtd7: 00480000 00001000 "Bank 1 - Splash"
>> >> > mtd8: 00040000 00001000 "Bank 1 - Device Tree"
>> >> > root@draak:/# od -x /dev/mtd1
>> >> > 0000000 0000 d280 0001 d280 0002 d280 0003 d280
>> >> > 0000020 0004 d280 0005 d280 0006 d280 0007 d280
>> >> > 0000040 0008 d280 0009 d280 000a d280 000b d280
>> >> > 0000060 000c d280 000d d280 000e d280 000f d280
>> >> > 0000100 0010 d280 0011 d280 0012 d280 0013 d280
>> >> > 0000120 0014 d280 0015 d280 0016 d280 0017 d280
>> >> > 0000140 0018 d280 0019 d280 001a d280 001b d280
>> >> > 0000160 001c d280 001d d280 001e d280 1000 d53e
>> >> > 0000200 f800 9266 1000 d51e 3fdf d503 3ba0 1005
>> >>
>> >>    Still hangs for me. After I patches spi-mem.c and the driver to
>> >> call RPM for the MFD, it started working again. Perhaps, that clock>> >> is still enabled on your target. What does the following print (for

   Even with these issues worked around, I still see strange behavior on
writes, e.g. after I mount JFFS2 partition, remove 1 file, unmount, re-mount,
and mount again, the removed file is back! :-/

[...]

> thanks & best regards,
> Mason

MBR, Sergei
