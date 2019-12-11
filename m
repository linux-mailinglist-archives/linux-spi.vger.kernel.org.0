Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB5711BC87
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 20:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfLKTJu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 14:09:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46173 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfLKTJu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Dec 2019 14:09:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so16732234lfl.13
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2019 11:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F2hQxSbx80dzLoD4LOY/tQag3ZJk3szWSla+aYe1eXQ=;
        b=BAtcnlT6l6osRO74rPsAcoDcc7Pz5AYSWxMDHZnkVtqtiMNRq3KTghuXR3LRUeC9FN
         epR2ZIgbZ13gPSCJBuA6N8ySJ44OEe+ebev3VWjXhTbW/ub94AEPDCROZKc5xz7IXqDn
         gwQnZHAoJrzKOqKEh8YC9JUeyRRDgTzv8i7nIhwg0GXeIBeFMA1Qq/VTm7PCVN3a751T
         Qu2ryWBegnDr2vryhXyaVmH0gzRUMCWa0FmLXrrbYkZaPb89koL7AiwUKWJASsgMOT8l
         GGxqE8KFhs6DZkjKcVosiY39EC6rS5oN25gpJ7CrAtnxg+r/zENASUiAsNpNT2dEm9Wq
         xOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F2hQxSbx80dzLoD4LOY/tQag3ZJk3szWSla+aYe1eXQ=;
        b=ei3bNCeqcd5THOUTmEP4cb1hWXDPsx3DONi9y+TJT13XIgFYq3y9sz/ov8E3dk9IKy
         3Zva57Guis6xEzJ9/twvVgHCVGYB5BgR/Rr0MRC2VXuMION7TO4Af37rEFrpfNX4BKB8
         HvYRLwbjTolWvAK0RyJWMGEZj76JaAHP6T+qobBip6fN17iuTYwpQwlbJaFtcQGYsMDj
         63qk4M81N+sxUt7trUzNZT76bsB8+znrsUPM7tC33Hv3X4/3DYXLU7FtCpsk6TN1pYev
         I1jU/yYN6GikLbqrBczTKyT/frxXknLyUARcjiK3LbQf/RtDtyxAIk2e++ie9vN3jN/n
         Q8kQ==
X-Gm-Message-State: APjAAAU1qBZM2F6WY1FCHR9PAp64fD26H+vdTz3LyImt5tD1y1OqBltM
        B/5kyZi4Bo9xY8YL1IdK25S+pA==
X-Google-Smtp-Source: APXvYqwTP8Syk9MFdAQXoVHE+1eQSGVsmkwJrqYhkYsHqy4MBoe0ip6R2MXyz6m6Qk6ncdoSD8mJ+A==
X-Received: by 2002:a19:f10e:: with SMTP id p14mr3282287lfh.3.1576091387397;
        Wed, 11 Dec 2019 11:09:47 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:8d8:12fe:a87e:d4b8:621e:2b62])
        by smtp.gmail.com with ESMTPSA id i5sm1708098ljj.29.2019.12.11.11.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:09:46 -0800 (PST)
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
To:     Chris Brandt <Chris.Brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
Date:   Wed, 11 Dec 2019 22:09:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/09/2019 06:10 PM, Chris Brandt wrote:

>>> The Renesas SPI Bus Space Controller (SPIBSC) HW was specifically
>>> designed for accessing Serial flash devices (QSPI,
>>
>>    The initial design did only support SPI, hence the SPI in the name.
> 
> The more important part is the "Bus Space Controller". Meaning the main 
> purpose of this hardware was to allow the CPU to access serial flash 
> directly (as in, XIP).
> 
> "SPI-BSC" was the internal name for the HW but does not appear in any of
> the hardware manual. The hardware manuals (even the MCUs) only say "SPI
> Multi I/O Bus Controller".
> Even the R-car gen3 manual says 'SPI':  "SPI Multi I/O Bus Controller 
> (RPC)".
> 
> I have no idea why the R-Car people felt they needed to put "RPC" in the
> hardware manual as the title of the chapter. (Although, "Multi I/O" is 
> just as bad as a name)
>  
> I did make the request to the RZ/G team to not put "RPC" in the title of
> the chapter in any future RZ/G hardware manuals.
> 
> Since QSPI, HyperFlash and OctaFlash are all 'serial' Flash 
> technologies, I would be find with a driver name of "SBSC" ("Serial Bus Space 
> Controller") which at least looks closer to what is in all the hardware 
> manuals.

   How about "Serial Flash Controller" instead?

>>    SPIBSC is also misleading... RPC-IF seems misleading too as it's only
>> spelled out in the R-Car gen3 and RZ/A2H manuals.
> 
> In the RZ/A2 manual, "RPC" is only used to label the 3 new external pins
> that were added for HyperFlash.

   Sorry, I was to hasty to check the RZ/A2H manual before typing. :-/

>   RPC_RESET# , RPC_WP# , RPC_INT#
> But of course they were just copied from the R-Car manual.
> 
> But, maybe that's enough about the name for now.

   OK. :-)

>>> This driver has been tested on an RZ/A1H RSK and RZ/A2M EVB.
>>
>>    In the SPI mode only, I assume?
> 
> Yes. At the moment, there are only requests from users for QSPI flash access
> (RZ/A and RZ/G users).

   I keep being told by the management that we need HyperFlash too. :-)
In our BSP development, our engineers went "same hardware, 2 drivers"
way (with different "compatibles" per driver)...

> The RZ/A2M EVB was laid out to support all the different combinations of
> serial flashes (by populating different chips). That is why there is 
> already Segger J-link support for QSPI, Hyper and Octa for the RZ/A2.
> 
> I will admit, to developed this driver for the "SPI-BSC" HW, I have been
> using an XIP kernel (XIP from another HyperFlash / HyperRAM combo chip 
> on the board) because I didn't feel like moving all the switches to use 
> SDRAM and a uImage kernel.
> The RZ/A2M has a HyperFlash controller (for R/W), a OctaBus controller 
> (for R/W) and the SPI BSC (Read-only).

   Seen these...

>>    What I have now is the core driver (or rather a library) placed under
>> drivers/memory/ and the SPI and HyperFlash front ends in drivers/spi/ and
>> drivers/mtd/hyperbus/ respectfully.
>> I'm almost ready to post the core driver/bindings, the SPI driver still needs
>> some Mark Brown's comments addressed, and the HyperFlash driver is also ready
>> but needs the existing HyperBus infrastructure properly fixed up (having a
>> draft patch now)...

> But are these for the HyperBus controller? Or the SPI-BSC controller?
> They are 2 different controllers, so you would think they would have 2 different drivers.

   R-Car gen3 only has RPC-IF, no separate HyperBus controller, so the second case.

>>> The testing mostly consisted of formatting an area as JFFS2 and doing
>>> copying of files and such.
>>
>>    Did the same (or at least tried to :-) and I must admit that writing
>> doesn't work with any of the front ends... I still need to get this fixed.

   The last word from our BSP people was that JFFS2 doesn't work with the HyperFLash
dedicated BSP driver... :-/

> That's the part I'm confused about. I saw the last patch series that 
> made it up to v17 but still didn't get in. Although, it did look very 
> complicated.
> You can see from my SPI-BSC driver, it's basically 2 function: a SPI 

   I'll read/try it next thing...

> write and SPI read. The upper layer sends you down data to write, and you 
> just write it. In theory, if a HyperFlash MTD layer was sending down 
> data, the commands bytes would be different, but the procedure would be the 
> same.

   Yeah, the commands are different...

>>> While the HW changed a little between the RZ/A1 and RZ/A2 generations,
>>> the IP block in the RZ/A2M was taken from the R-Car H3 design, so in
>>> theory this driver should work for R-Car Gen3 as well.
>>
>>    I don't think it's a good idea to use the SPI dedicated driver on R-Car
>> gen3, I would rather see the RZ/A1 using the RPC-IF driver/library to reduce
>> the code duplication...
> 
> I agree on not having competing drivers. Especially since future RZ/A 
> and RZ/G devices will most likely continue to include this HW.

> However, the driver I posted is pretty simple and works. Does the 
> HyperFlash MTD

   There's no HF library, only front end driver.
   The real library covers both SPI and HF. The only difference between the two
is the h/w setup (minor difference).

> library that you are proposing have a very different API than 
> just 'send bytes' and 'receive bytes'?

   There's "prepare" and "transfer" APIs and also "direct map read" API.

> Chris

MBR, Sergei
