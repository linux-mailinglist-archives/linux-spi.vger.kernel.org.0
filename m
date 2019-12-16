Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9EF121AEF
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 21:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLPUb4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 15:31:56 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:34816 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPUb4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Dec 2019 15:31:56 -0500
Received: by mail-lj1-f181.google.com with SMTP id j6so8290353lja.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Dec 2019 12:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kqkP+bLz+4zX9IYzuOP7bDum2RXqD8QlV40L+IupHuk=;
        b=BlZp+sNkTAAOcDuYHY0xtAjMFENDINPJ+Cw4e4LjzdqeIjvGCtfDwx6oCY02wAZp2H
         lVE/VqaZ0Mb70TeD0kVh/uYI4rwfhfRGz7MfdYUSpxLSWikHXmlsa6GpSzCpBcDfGYtE
         +ueM6rxG9jSVoUFi/4z1O4lzpOZk2/45vtcmz8T3oqP6SyMn9UYluvxK91+g5rVn8ZB4
         myIxvogiRZH5ofNoLioyrytaR164/TouoNGBq1zyi3chhcFU9cXB4X3Xd4C9JrE33aAn
         WvKEXq3svKCWElj2V+MoIhdR4zyFby9vbUfhi0ciVjOP2mVa0/hh9REqpbOSOL7MVrW+
         JsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kqkP+bLz+4zX9IYzuOP7bDum2RXqD8QlV40L+IupHuk=;
        b=cnYf24xj9iNQxUkS8SZ0nx1QeZ6Uq1HVXbh6CaPCpJJlwnqI9u2DP/DqHfEAO1u6Jy
         JAI/JhMj8KaOR1Yop5YfW5eItewU9w4D2lCruJFUHXpCfRWou/lF/SFBs08ksSiFF7W3
         0CGyHsG5UpWqdw+qWnAO3iwTmvsYhOQONFQlQGZq8REjqm600ev3DTlTINlqsW34hHn0
         48Ih0ptSP6aynHl8gAvekU4sodkNmlwNx5jGiWtqgqs9Xu1C9tjLbu1fHMMME6L1OBnI
         9+iYhLkt6i2yxDhoFGcY5KSVnnAvpSkk2kPQb21hbNZdBxrcIikgx8hBnNiMON2bf2ms
         pgAA==
X-Gm-Message-State: APjAAAV0vxehV+susltfob5/8AkrKvmsyRsNm+jpTYjYUZm/3dwrZQMs
        EPvHBz2fvSe5UwDJ35ZT0Zx32Q==
X-Google-Smtp-Source: APXvYqwNiQF/a14TNjCZvXtr7uxBBPfhynEJcUfG0R6/wmpWE2SsHhVlxd4hzycytTWvhz31euGWQw==
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr710273ljj.130.1576528313769;
        Mon, 16 Dec 2019 12:31:53 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48df:e424:ff05:dd96:8970:d4c9])
        by smtp.gmail.com with ESMTPSA id w2sm11308501ljo.61.2019.12.16.12.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 12:31:53 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Organization: Cogent Embedded
Message-ID: <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
Date:   Mon, 16 Dec 2019 23:31:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 12/12/2019 05:29 PM, Chris Brandt wrote:

>>> Since QSPI, HyperFlash and OctaFlash are all 'serial' Flash
>>> technologies, I would be find with a driver name of "SBSC" ("Serial
>>> Bus Space
>>> Controller") which at least looks closer to what is in all the
>>> hardware manuals.
>>
>>    How about "Serial Flash Controller" instead?
> 
> I would like that better than "RPC". At least it describes what it is.
> RPC seems like a stupid name to me (but maybe that's just because I know
> how that name was chosen...)
> https://www.cypress.com/news/cypress-simplifies-embedded-system-design-new-low-pin-count-hyperram-memory
>  "The HyperRAM and HyperFlash solution reduces pin count by at least 28 pins, ..."
> 
> As a side note, there is another HW block in Renesas that does the same 
> thing as the SPI-BSC that they use in the MCU devices. That one they 

   MCU?

> just named "QSPI".

   I thought QSPI stands for quad SPI?

>>>>> This driver has been tested on an RZ/A1H RSK and RZ/A2M EVB.
>>>>
>>>>    In the SPI mode only, I assume?
>>>
>>> Yes. At the moment, there are only requests from users for QSPI flash
>>> access (RZ/A and RZ/G users).
>>
>>    I keep being told by the management that we need HyperFlash too. :-) In
>> our BSP development, our engineers went "same hardware, 2 drivers"
>> way (with different "compatibles" per driver)...
> 
> My plan was same HW, same "compatibles", same driver...but the driver 
> would either register a SPI controller or a Hyperflash controller.

   I don't think this is a very good idea (and where to place such a driver,
in drives/memory/?... With the separate driver files, you can only build the
needed driver, SPI or HyperFash (or both -- which would be the only choice
with your approach?).

> Note that the MMC/SDHI is the same HW but can act like 2 different peripherals.

   Hm, not sure I understand... Isn't MMC and SD driven by the same subsystem?

> We also have USB that can be either host or peripheral.

   I know...

>>>>> The testing mostly consisted of formatting an area as JFFS2 and
>>>>> doing copying of files and such.
>>>>
>>>>    Did the same (or at least tried to :-) and I must admit that
>>>> writing doesn't work with any of the front ends... I still need to get
>> this fixed.
>>
>>    The last word from our BSP people was that JFFS2 doesn't work with the
>> HyperFLash dedicated BSP driver... :-/

   The BSP driver was initially written for H3/M3 SoCs and did work there...
But on V3H this driver fails...

> Is that why this "RPC" patch series is taking so long?
> It's a fairly simple piece of hardware.

   No. I didn't really use our BSP drivers as a base, so basically had to
write the HyperFLash part from scratch and fix the issues as they appeared...

> When I first saw the series on the mailing list, my plan was to just wait
> and then add RZ/A1 and RZ/A2 support. But....it looks like it all died.

   No. :-) It was worked on during all these months... I just finally decided
to stop, take a deep breath, and post what patches I had accumulated, without
the whole driver suite working first... I'm sorry it took so long....

> So, I thought I would at least put in my own driver for SPI flash now, 
> and then go back and add HyperFlash/OctaFlash once I get the chips 
> swapped out on one of my RZ/A2 boards.

   Ah! My HyperFlash driver is ready, just the HyperBus core needs some
fixing (I have a draft patch for that)...

>>> However, the driver I posted is pretty simple and works. Does the
>>> HyperFlash MTD
>>
>>    There's no HF library, only front end driver.
>>    The real library covers both SPI and HF. The only difference between the
>> two is the h/w setup (minor difference).
> 
> But is this "library" something specific to Renesas devices?

   Yes, it covers only RPC-IF (as described in the gen3 manual).

> That's what I'm trying to understand.
> 
> My understanding is that HyperFlash uses standard CFI commands, so all 

   The CFI command set driver needed some changes too (e.g. using the status
register to determine if a command is done).

> we need to do is register a CFI device in the driver, just like we 
> register a serial flash device.

> (I guess I could go look at the sample code for our RTOS package and find out)
> 
>>> library that you are proposing have a very different API than just
>>> 'send bytes' and 'receive bytes'?
>>
>>    There's "prepare" and "transfer" APIs and also "direct map read" API.

  The 1st one prepares the values to be written in either SPI mode or direct
read mode registers. Then you can call "transfer" or "direct mao read" which
would write out the register values into either set...

> I wonder what is the value of the "direct map read" (other than XIP in 
> RZ/A systems). If you really want to directly access the flash (no 
> buffering though the MTD layer), you need to register as a mtd-rom device, 
> and then you don't really need an API at all.

  I'd leave this question to Boris, else I never complete this msg. :-) 

> Chris

MBR, Sergei
