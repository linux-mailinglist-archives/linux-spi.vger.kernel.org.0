Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324B31235B6
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2019 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfLQTaH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Dec 2019 14:30:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36046 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLQTaG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Dec 2019 14:30:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so12278588ljg.3
        for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2019 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dt7nMF9lAkMR+CxlS7AwqAXWN5PCEwzjfiKWmOUTLlg=;
        b=Ns+AKACOV6e7e9TkvUXRNw8Wva+XCOU9aloQmpthLvLBSl6JESIcpisGlyuFN0JRWu
         ln/8BwL5r0jFtBfhVcW1SMD0HcLJggp8GPwd1xnttoIJU1yy8eiI9wKfodItjtwbK26l
         xPBrfg8nF7Wb7ZcZRrua07jxCmDqwfRfii5TIk1wWkgO6C+wpbiKkJ5gwZrEfJqmZogp
         e6glKtXnUgksZLkpbY9PxGArUy1yhm5IIpW3aROW4+7ThByK7XNxBJ54ecvWD2dC19Sw
         CjwcDG2mw3ejnYLKY/d2xlov04GLWFd2CzOMIzsiF0TA4nWAw69WcPBQR4s+tgd/rgHh
         3GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Dt7nMF9lAkMR+CxlS7AwqAXWN5PCEwzjfiKWmOUTLlg=;
        b=ZFXhoSuES7zNDNLcKVTGVG5Uzsw0t23Ae/gAeomR1kfDdbi2IbdcDhCkvNwZ1CX3WG
         ktmhh5Z5wwzv4QrIfEbTj+islC0yi9kreigWSHCdtEcJL0V1bS1SrUy/i6cW5wG5Arre
         qrryiWJQMIranRDzpZrIwspxWrAG/GRiezV1BS0gDP4fh43gZqUSOSRpqStC9A4QO2wI
         wiz3vaihNZ+EM3naI1gt7NeTXhzpG5gWrVqZLxql1a53uhsCn55uVmGIxMot1FYWWjL/
         Dbz1Wlr/wxUIXa7ldoZZnJK2cZieKIIN8gtu2+/OpKMLZGPttsGhnAyGPGrp/YaQCKOo
         T/3g==
X-Gm-Message-State: APjAAAXvtnBct8quH07xiSElsaSp1Yc/DlRKss3qzEKMdSSy9K764/yM
        GEGA9QTjaxgPncG12FvrFk1ynA==
X-Google-Smtp-Source: APXvYqwtdqLcLDLULkyXRPxe+Tq0eGIziCjfHWNA2pKHIBv1+qMr2mEGCl6NlJu00JcDH7T8xu6aUw==
X-Received: by 2002:a2e:9095:: with SMTP id l21mr4378074ljg.175.1576611004354;
        Tue, 17 Dec 2019 11:30:04 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:411:5312:624c:c19e:baea:21d3])
        by smtp.gmail.com with ESMTPSA id q25sm13291384lji.7.2019.12.17.11.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:30:03 -0800 (PST)
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
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
 <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
Date:   Tue, 17 Dec 2019 22:30:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 12/17/2019 01:21 AM, Chris Brandt wrote:

>>> As a side note, there is another HW block in Renesas that does the same
>>> thing as the SPI-BSC that they use in the MCU devices. That one they
>>
>>    MCU?
> Yup.
>   But...it has no significance to this discussion though :)

   But what does the acronym mean?

>>> When I first saw the series on the mailing list, my plan was to just wait
>>> and then add RZ/A1 and RZ/A2 support. But....it looks like it all died.
>>
>>    No. :-) It was worked on during all these months... I just finally decided
>> to stop, take a deep breath, and post what patches I had accumulated, without
>> the whole driver suite working first... I'm sorry it took so long....
> 
> So at the moment, there is nothing yet for me to 'try' on the RZ/A series, correct?

   Why, I can send you a working version of the SPI driver, and even HF one if you're
interested.
 
>>> My understanding is that HyperFlash uses standard CFI commands, so all
>>
>>    The CFI command set driver needed some changes too (e.g. using the status
>> register to determine if a command is done).
> 
> So the existing MTD-SPI layer knows how to talk to SPI devices.

   SPI-NOR does it with a help of drivers/spi/spi-mem.c... As for the HyperFlash,
it needs a HyperBus driver (that I have a working patch for)...

> And, you've fixed up the existing CFI layer to talk to HyperFlash evices.

   Mostly Boris B. did it... :-)

> But, you do not want these MTD layer to talk directly to a Renesas HW driver?

   Yes, because the SPI-NOR and HyperBus have different driver APIs.

> You want to put another software layer in between?

   Yes.

> I'm guessing that from this statement....

>>>>> library that you are proposing have a very different API than just
>>>>> 'send bytes' and 'receive bytes'?
>>>>
>>>>    There's "prepare" and "transfer" APIs and also "direct map read" API.
>>
>>   The 1st one prepares the values to be written in either SPI mode or direct
>> read mode registers. Then you can call "transfer" or "direct mao read" which
>> would write out the register values into either set...
> 
> ...that you want more control of the data stream being passed to the RPC-IF driver.
> Correct??
> 
> It all keeps sounding complicated, unless I'm just not understanding the code
> you are trying to implement.

   Well, it reflects the fact that the "SPI mode" and "direct read" register sets
are largely identical. The "preparation" stage sets up the register values, the 
other stages use that data to set up the real register sets and then do the
needed transfers...

> Chris

MBR, Sergei
