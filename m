Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3610B14F
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 15:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0O3r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 09:29:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10830 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0O3r (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 09:29:47 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NNT410cYz9v0wR;
        Wed, 27 Nov 2019 15:29:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rYJczCvJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 98grrAO57arH; Wed, 27 Nov 2019 15:29:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NNT373Z1z9v0wP;
        Wed, 27 Nov 2019 15:29:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574864984; bh=muXKaZ6jgUY6RAFPnrDsPdJo2Ku8sbUfRybI9HofgPw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rYJczCvJ98rg+SmmmPAe8DNmT8e4aJZEddPWfQarlac6rPu2LbIObEHmsjBNkGrsI
         kEXFHyZSnX823EeaIgm1CMG/odu0IMr6ROPhCHPwtPn8sHRuIw1CUj9GQKfAcOplH0
         2s04Kdnyf047v6qA0J/Up1zpqYY3uEACkxnCCP1Q=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 541218B864;
        Wed, 27 Nov 2019 15:29:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KlPyQKuJgAWd; Wed, 27 Nov 2019 15:29:45 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 92F258B862;
        Wed, 27 Nov 2019 15:29:44 +0100 (CET)
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
 <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr>
 <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr>
 <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
 <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr>
 <CACRpkda-wjRm7UYsFTX_xFfNPT29U1PTMyuU4AP=WShiC_vV9g@mail.gmail.com>
 <b2925217-9cbd-2f4e-c92f-9e1c92824193@c-s.fr>
 <CACRpkdaKg45uHMZ9mz6OGkAUqYX7GzhTrjrAc1feVhn68ZXrqg@mail.gmail.com>
 <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr>
 <CACRpkdb15n4DpxAGEw+Av89XZDxi7Amh1XEyJEzWBd4tet7C2Q@mail.gmail.com>
 <8b50ce56-0600-373d-178c-92aa780e5376@c-s.fr>
 <CACRpkdZRWojQAgHtBaNWdjKqv8aX3P-KjatgoG+DLCcYeJ7ztg@mail.gmail.com>
 <99f48a7e-e4f4-2a77-657c-452d7a656ec5@c-s.fr>
 <CACRpkdat-qtxCn=e1sqPMFF7urue0OoJJcixUwL1=nAT-F+H3Q@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c3090d62-d049-5c9b-d48e-380b71755bfb@c-s.fr>
Date:   Wed, 27 Nov 2019 15:29:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdat-qtxCn=e1sqPMFF7urue0OoJJcixUwL1=nAT-F+H3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 27/11/2019 à 14:56, Linus Walleij a écrit :
> On Wed, Nov 27, 2019 at 2:54 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> Le 27/11/2019 à 14:52, Linus Walleij a écrit :
>>> On Wed, Nov 27, 2019 at 2:45 PM Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>> Le 27/11/2019 à 14:00, Linus Walleij a écrit :
>>>
>>>>> Try to remove the "spi-cs-high" bool flag from your nodes,
>>>>> because it seems like the old code was ignoring them.
>>>>>
>>>>> Does that solve the problem?
>>>>
>>>> Yes it does. Many thanks. I let you manage the packaging of fixes.
>>>
>>> OK I will send a final batch of 3 patches fixing this.
>>>
>>> Do you have these old device trees deployed so that we
>>> also need to make sure that old device trees that have this
>>> ambigous syntax will force precendence for the flag on the
>>> GPIO line if both are specified for the "fsl,spi" instances?
>>>
>>
>> No, we deliver device trees together with Linux kernel (embedded in an
>> Uboot ITS/ITB image) so no worry on old device trees.
> 
> OK thanks!
> 
> I sent three patches, can you apply them on a clean tree
> and confirm it solves the problem (fingers crossed...)
> 
> Thanks a lot for helping me fix this!

The series is OK if using 'cs-gpios'.

With 'gpios' in the DTS, I get:

[    3.154747] fsl_spi ff000a80.spi: cs1 >= max 1
[    3.159207] spi_master spi0: spi_device register error 
/soc@ff000000/cpm@9c0/spi@a80/lm74@1
[    3.167344] spi_master spi0: Failed to create SPI device for 
/soc@ff000000/cpm@9c0/spi@a80/lm74@1
[    3.176303] fsl_spi ff000a80.spi: cs2 >= max 1
[    3.180626] spi_master spi0: spi_device register error 
/soc@ff000000/cpm@9c0/spi@a80/sicofi_gw@2
[    3.189329] spi_master spi0: Failed to create SPI device for 
/soc@ff000000/cpm@9c0/spi@a80/sicofi_gw@2
[    3.198574] fsl_spi ff000a80.spi: cs3 >= max 1
[    3.202788] spi_master spi0: spi_device register error 
/soc@ff000000/cpm@9c0/spi@a80/eeprom@3
[    3.211364] spi_master spi0: Failed to create SPI device for 
/soc@ff000000/cpm@9c0/spi@a80/eeprom@3
[    3.220361] fsl_spi ff000a80.spi: cs4 >= max 1
[    3.224561] spi_master spi0: spi_device register error 
/soc@ff000000/cpm@9c0/spi@a80/sicofi@4
[    3.233137] spi_master spi0: Failed to create SPI device for 
/soc@ff000000/cpm@9c0/spi@a80/sicofi@4
[    3.242120] fsl_spi ff000a80.spi: cs5 >= max 1
[    3.246336] spi_master spi0: spi_device register error 
/soc@ff000000/cpm@9c0/spi@a80/lm74@5
[    3.254740] spi_master spi0: Failed to create SPI device for 
/soc@ff000000/cpm@9c0/spi@a80/lm74@5
[    3.263552] fsl_spi ff000a80.spi: cs6 >= max 1
[    3.267764] spi_master spi0: spi_device register error 
/soc@ff000000/cpm@9c0/spi@a80/eeprom@6
[    3.276342] spi_master spi0: Failed to create SPI device for 
/soc@ff000000/cpm@9c0/spi@a80/eeprom@6
[    3.285328] fsl_spi ff000a80.spi: cs7 >= max 1
[    3.289667] spi_master spi0: spi_device register error 
/soc@ff000000/cpm@9c0/spi@a80/csfavgw@7
[    3.298070] spi_master spi0: Failed to create SPI device for 
/soc@ff000000/cpm@9c0/spi@a80/csfavgw@7


Christophe
