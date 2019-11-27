Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF710AF3A
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 13:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfK0MFA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 07:05:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:60849 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfK0MFA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 07:05:00 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NKFy1zVqz9tyRL;
        Wed, 27 Nov 2019 13:04:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=KYmvJSUg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4FMUXxvGT2-E; Wed, 27 Nov 2019 13:04:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NKFy0vZ2z9tyQf;
        Wed, 27 Nov 2019 13:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574856294; bh=YrapcC/HVg6e8aDsKuBNC2m/96JAN3UPdGnslNUtr+Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KYmvJSUg7KxC1oZgZIuZq8bsZpMJ3r2Z9Md0D12CRHAstrNmLnBCdwnrnfqd2Rr/D
         Lrjtfj9gFbe/UA/p3AtNdT076AarDAS9/eDxc5PpgyYfNIpqhdYsm1NTvdTScp/T8I
         s87T2CelqX9kYrl81aad1+GWucr6UTv53V7LSkAw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 53CA78B856;
        Wed, 27 Nov 2019 13:04:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZkzIjcslfA-7; Wed, 27 Nov 2019 13:04:55 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE0428B855;
        Wed, 27 Nov 2019 13:04:54 +0100 (CET)
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
 <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr>
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
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr>
Date:   Wed, 27 Nov 2019 13:04:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdaKg45uHMZ9mz6OGkAUqYX7GzhTrjrAc1feVhn68ZXrqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 27/11/2019 à 11:55, Linus Walleij a écrit :
> On Wed, Nov 27, 2019 at 11:39 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> Le 27/11/2019 à 11:02, Linus Walleij a écrit :
>>> On Wed, Nov 27, 2019 at 10:34 AM Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>
>>>> In the meantime, I have tried changing "gpios" by "cs-gpios" in the
>>>> device tree, and I get the following warning:
>>> (...)
>>>> [    3.156654] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-fsl-spi.c:716
>>>> fsl_spi_cs_control+0x64/0x7c
>>>
>>> That should be this one:
>>>
>>> if (WARN_ON_ONCE(!pinfo->immr_spi_cs))
>>>      return;
>>>
>>> That happens when spi->cs_gpiod is NULL so the
>>> chipselect isn't found and assigned, and the code
>>> goes on to check the native CS and find that this isn't
>>> available either and issues the warning.
>>
>> That's in spi_add_device(), it is spi->cs_gpio and not spi->cs_gpiod
>> which is assigned, so spi->cs_gpiod remains NULL.
> 
> That's weird, because when ->use_gpio_descriptors is set
> (as for this driver) the core only attempts to look up
> spi->cs_gpiods and not spi->cs_gpios, and consequently
> can only assign spi->cd_gpiod and not spi->cs_gpio:

That's it. ->use_gpio_descriptors isn't set for the FSL driver:

[root@po16098vm linux-powerpc]# git grep use_gpio_descriptors drivers/spi/
drivers/spi/spi-ath79.c:	master->use_gpio_descriptors = true;
drivers/spi/spi-atmel.c:	master->use_gpio_descriptors = true;
drivers/spi/spi-bcm2835.c:	 * as the flag use_gpio_descriptors enforces 
SPI_CS_HIGH.
drivers/spi/spi-bcm2835.c:	ctlr->use_gpio_descriptors = true;
drivers/spi/spi-cadence.c:	master->use_gpio_descriptors = true;
drivers/spi/spi-clps711x.c:	master->use_gpio_descriptors = true;
drivers/spi/spi-davinci.c:	master->use_gpio_descriptors = true;
drivers/spi/spi-dw.c:	master->use_gpio_descriptors = true;
drivers/spi/spi-ep93xx.c:	master->use_gpio_descriptors = true;
drivers/spi/spi-gpio.c:	master->use_gpio_descriptors = true;
drivers/spi/spi-sh-msiof.c:	ctlr->use_gpio_descriptors = true;
drivers/spi/spi-tegra114.c:	master->use_gpio_descriptors = true;
drivers/spi/spi.c:	if (ctlr->use_gpio_descriptors)
drivers/spi/spi.c:		if (ctlr->use_gpio_descriptors) {

I have now added it, together with the DTS cs-gpios name change (without 
your counting patch with crashes), and I get something which is almost 
working: I get temperature back into sensors, but temperature is 0°C !!!

root@vgoip:~# sensors
lm74-spi-0-5
Adapter: SPI adapter
Temperature processeur:   +0.0 C

lm74-spi-0-1
Adapter: SPI adapter
Temperature MIAE:   +0.0 C


Looking into dmesg, I see:

[    3.153521] lm74@1 GPIO handle specifies active low - ignored
[    3.178093] lm74@5 GPIO handle specifies active low - ignored

Any link with the problem ?

Christophe

> 
> if (ctlr->use_gpio_descriptors) {
>      status = spi_get_gpio_descs(ctlr);
> (...)
> } else {
> (....)
>      status = of_spi_get_gpio_numbers(ctlr);
> }
> (...)
> /* Descriptors take precedence */
> if (ctlr->cs_gpiods)
>      spi->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
> else if (ctlr->cs_gpios)
>      spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
> 
> So I'm a bit confused...
> 
> Yours,
> Linus Walleij
> 
