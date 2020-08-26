Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC625277A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgHZGjI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgHZGjE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 02:39:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E7C061574;
        Tue, 25 Aug 2020 23:39:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id si26so1271621ejb.12;
        Tue, 25 Aug 2020 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IE/AAgK2p00IDwlXwcCa+q5LrPFFg/3cF0TQP/Q5Iuk=;
        b=eyBoBIyDYMpLNujHnBTEBv/WV3w3ncqJ15ps+uITEQQPzIdrR8SyNRWoXvuutGo37s
         xzumD2MZRGQpQKSYgnmCrheTDVN1CHGeFiYkho1FtiqGkCZ5GWFQ5sYCLjRklAImhtiM
         7Z/5Whz1VWSYXVrc3vT1ia8zFg0e0NMR6K6YpXTEfeEVo2+V0OLpuuiNhWEOxJLBxTCU
         ksCpyFxlNj7UtqPEa8UlGBb/MXiwlOCctHAaK6a3wdAX8ovl/nZ9e85Rx7Ih4Ykju7m8
         RnVzDszL6UmxGwSWNewvnOPRHKb4Iuh0luHowzR0dLIlDDcYCHTF8Hr8XtNM0fuTMFIU
         ELSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IE/AAgK2p00IDwlXwcCa+q5LrPFFg/3cF0TQP/Q5Iuk=;
        b=cPANFQSYGQ1XFfi5kbcXyYN4gKBj3iWI22E1L3hOqAIcQKQgk/zyQGXxKy01EeniFT
         WKeHvmOo6oHZsd0zqBRKf0OwtzbFP6b2duGUO6HoWVT8m8i1lQS8cAhoo1K3xbLy81ok
         4wtPxsgwSUsTUTHjHsDqG7gxZs8SERRXsu28NB2t1QfCa89PKlDgLzmxGPfap1fNTTuX
         zf0yCgvSbd9pryoSevgimjb1IHAkzgN59Q6/wUDOwNfzjqP8wkZp8tbhCCLdqJN5Skd2
         G+sLFSwREFNOFYTT3g/AboMRHQMTH++DaLZYEflkagyfHSUE1LgNFMoyXPCys2z6CnEv
         oZjA==
X-Gm-Message-State: AOAM530YYBwH96vsZbp4zNM5pdxLEoTYxXGN8q/8j1FNlYqIp4GpnTO9
        gjNfcAzhuQTes2lwfZe83D40yfuwf586EQ==
X-Google-Smtp-Source: ABdhPJyt9I/A4Vwfb8ZB1s33PbZZ3CP160n78L60WtrlfNWNqMD1rOj/2Q3djU7Qxo1yDr66Jp8B9Q==
X-Received: by 2002:a17:906:7f99:: with SMTP id f25mr715988ejr.307.1598423942000;
        Tue, 25 Aug 2020 23:39:02 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:843d:b7c1:fb34:c675? (p200300ea8f235700843db7c1fb34c675.dip0.t-ipconnect.de. [2003:ea:8f23:5700:843d:b7c1:fb34:c675])
        by smtp.googlemail.com with ESMTPSA id e14sm1201250edl.86.2020.08.25.23.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 23:39:01 -0700 (PDT)
Subject: Re: fsl_espi errors on v5.7.15
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <42107721-614b-96e8-68d9-4b888206562e@alliedtelesis.co.nz>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <1020029e-4cb9-62ba-c6d6-e6b9bdf93aac@gmail.com>
Date:   Wed, 26 Aug 2020 08:38:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <42107721-614b-96e8-68d9-4b888206562e@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26.08.2020 08:07, Chris Packham wrote:
> 
> On 26/08/20 1:48 pm, Chris Packham wrote:
>>
>> On 26/08/20 10:22 am, Chris Packham wrote:
>>> On 25/08/20 7:22 pm, Heiner Kallweit wrote:
>>>
>>> <snip>
>>>> I've been staring at spi-fsl-espi.c for while now and I think I've
>>>>> identified a couple of deficiencies that may or may not be related 
>>>>> to my
>>>>> issue.
>>>>>
>>>>> First I think the 'Transfer done but SPIE_DON isn't set' message 
>>>>> can be
>>>>> generated spuriously. In fsl_espi_irq() we read the ESPI_SPIE 
>>>>> register.
>>>>> We also write back to it to clear the current events. We re-read it in
>>>>> fsl_espi_cpu_irq() and complain when SPIE_DON is not set. But we can
>>>>> naturally end up in that situation if we're doing a large read. 
>>>>> Consider
>>>>> the messages for reading a block of data from a spi-nor chip
>>>>>
>>>>>    tx = READ_OP + ADDR
>>>>>    rx = data
>>>>>
>>>>> We setup the transfer and pump out the tx_buf. The first interrupt 
>>>>> goes
>>>>> off and ESPI_SPIE has SPIM_DON and SPIM_RXT set. We empty the rx fifo,
>>>>> clear ESPI_SPIE and wait for the next interrupt. The next interrupt
>>>>> fires and this time we have ESPI_SPIE with just SPIM_RXT set. This
>>>>> continues until we've received all the data and we finish with 
>>>>> ESPI_SPIE
>>>>> having only SPIM_RXT set. When we re-read it we complain that SPIE_DON
>>>>> isn't set.
>>>>>
>>>>> The other deficiency is that we only get an interrupt when the 
>>>>> amount of
>>>>> data in the rx fifo is above FSL_ESPI_RXTHR. If there are fewer than
>>>>> FSL_ESPI_RXTHR left to be received we will never pull them out of 
>>>>> the fifo.
>>>>>
>>>> SPIM_DON will trigger an interrupt once the last characters have been
>>>> transferred, and read the remaining characters from the FIFO.
>>>
>>> The T2080RM that I have says the following about the DON bit
>>>
>>> "Last character was transmitted. The last character was transmitted 
>>> and a new command can be written for the next frame."
>>>
>>> That does at least seem to fit with my assertion that it's all about 
>>> the TX direction. But the fact that it doesn't happen all the time 
>>> throws some doubt on it.
>>>
>>>> I think the reason I'm seeing some variability is because of how fast
>>>>> (or slow) the interrupts get processed and how fast the spi-nor 
>>>>> chip can
>>>>> fill the CPUs rx fifo.
>>>>>
>>>> To rule out timing issues at high bus frequencies I initially asked
>>>> for re-testing at lower frequencies. If you e.g. limit the bus to 1 MHz
>>>> or even less, then timing shouldn't be an issue.
>>> Yes I've currently got spi-max-frequency = <1000000>; in my dts. I 
>>> would also expect a slower frequency would fit my "DON is for TX" 
>>> narrative.
>>>> Last relevant functional changes have been done almost 4 years ago.
>>>> And yours is the first such report I see. So question is what could 
>>>> be so
>>>> special with your setup that it seems you're the only one being 
>>>> affected.
>>>> The scenarios you describe are standard, therefore much more people
>>>> should be affected in case of a driver bug.
>>> Agreed. But even on my hardware (which may have a latent issue 
>>> despite being in the field for going on 5 years) the issue only 
>>> triggers under some fairly specific circumstances.
>>>> You said that kernel config impacts how frequently the issue happens.
>>>> Therefore question is what's the diff in kernel config, and how could
>>>> the differences be related to SPI.
>>>
>>> It did seem to be somewhat random. Things like CONFIG_PREEMPT have an 
>>> impact but every time I found something that seemed to be having an 
>>> impact I've been able to disprove it. I actually think its about how 
>>> busy the system is which may or may not affect when we get round to 
>>> processing the interrupts.
>>>
>>> I have managed to get the 'Transfer done but SPIE_DON isn't set!' to 
>>> occur on the T2080RDB.
>>>
>>> I've had to add the following to expose the environment as a mtd 
>>> partition
>>>
>>> diff --git a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi 
>>> b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
>>> index ff87e67c70da..fbf95fc1fd68 100644
>>> --- a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
>>> +++ b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
>>> @@ -116,6 +116,15 @@ flash@0 {
>>>                                 compatible = "micron,n25q512ax3", 
>>> "jedec,spi-nor";
>>>                                 reg = <0>;
>>>                                 spi-max-frequency = <10000000>; /* 
>>> input clock */
>>> +
>>> +                               partition@u-boot {
>>> +                                        reg = <0x00000000 0x00100000>;
>>> +                                        label = "u-boot";
>>> +                                };
>>> +                                partition@u-boot-env {
>>> +                                        reg = <0x00100000 0x00010000>;
>>> +                                        label = "u-boot-env";
>>> +                                };
>>>                         };
>>>                 };
>>>
>>> And I'm using the following script to poke at the environment 
>>> (warning if anyone does try this and the bug hits it can render your 
>>> u-boot environment invalid).
>>>
>>> cat flash/fw_env_test.sh
>>> #!/bin/sh
>>>
>>> generate_fw_env_config()
>>> {
>>>   cat /proc/mtd | sed 's/[:"]//g' | while read dev size erasesize 
>>> name ; do
>>>      echo "$dev $size $erasesize $name"
>>>      [ "$name" = "u-boot-env" ] && echo "/dev/$dev 0x0000 0x2000 
>>> $erasesize" >/flash/fw_env.config
>>>   done
>>> }
>>>
>>> cycles=10
>>> [ $# -ge 1 ] && cycles=$1
>>>
>>> generate_fw_env_config
>>>
>>> fw_printenv -c /flash/fw_env.config
>>>
>>> dmesg -c >/dev/null
>>> x=0
>>> while [ $x -lt $cycles ]; do
>>>     fw_printenv -c /flash/fw_env.config >/dev/null || break
>>>     fw_setenv -c /flash/fw_env.config foo $RANDOM || break;
>>>     dmesg -c | grep -q fsl_espi && break;
>>>     let x=x+1
>>> done
>>>
>>> echo "Ran $x cycles"
>>
>> I've also now seen the RX FIFO not empty error on the T2080RDB
>>
>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>
>> With my current workaround of emptying the RX FIFO. It seems 
>> survivable. Interestingly it only ever seems to be 1 extra byte in the 
>> RX FIFO and it seems to be after either a READ_SR or a READ_FSR.
>>
>> fsl_espi ffe110000.spi: tx 70
>> fsl_espi ffe110000.spi: rx 03
>> fsl_espi ffe110000.spi: Extra RX 00
>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>> fsl_espi ffe110000.spi: tx 05
>> fsl_espi ffe110000.spi: rx 00
>> fsl_espi ffe110000.spi: Extra RX 03
>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>> fsl_espi ffe110000.spi: tx 05
>> fsl_espi ffe110000.spi: rx 00
>> fsl_espi ffe110000.spi: Extra RX 03
>>
>> From all the Micron SPI-NOR datasheets I've got access to it is 
>> possible to continually read the SR/FSR. But I've no idea why it 
>> happens some times and not others.
> 
> So I think I've got a reproduction and I think I've bisected the problem 
> to commit 3282a3da25bd ("powerpc/64: Implement soft interrupt replay in 
> C"). My day is just finishing now so I haven't applied too much scrutiny 
> to this result. Given the various rabbit holes I've been down on this 
> issue already I'd take this information with a good degree of skepticism.
> 
OK, so an easy test should be to re-test with a 5.4 kernel.
It doesn't have yet the change you're referring to, and the fsl-espi driver
is basically the same as in 5.7 (just two small changes in 5.7).

> Thanks,
> Chris
> 

