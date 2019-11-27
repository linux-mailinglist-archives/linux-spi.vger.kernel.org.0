Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BD410B081
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0NpB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:45:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:37052 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK0NpB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 08:45:01 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NMTQ1sFmz9v0wq;
        Wed, 27 Nov 2019 14:44:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ShTvlugf; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ENn_jj3h8UeY; Wed, 27 Nov 2019 14:44:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NMTQ0bgqz9v0wn;
        Wed, 27 Nov 2019 14:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574862298; bh=vIF+bsP6733JjFfpCyH8lIQAEa6doRmjS3lsnlabj6E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ShTvlugfrAHTIKNLtvXGEmhLgprcg0MrSUVn27owAmCfOLGoad35bnZf5hLa7XuCB
         TdMUCCICZVqCj7WcZJLwuWyYHfMonzk2A86G4VaU3uhuspJUCQmyOhlBuM5DTOGjSv
         TTKSWIX8eQuDFrVD7Ougz7xMBZEc2FqnSUCI3iNo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CDFD8B861;
        Wed, 27 Nov 2019 14:44:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id K4abGNeQMrvX; Wed, 27 Nov 2019 14:44:59 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 00E378B85A;
        Wed, 27 Nov 2019 14:44:58 +0100 (CET)
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
 <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr>
 <CACRpkdb15n4DpxAGEw+Av89XZDxi7Amh1XEyJEzWBd4tet7C2Q@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8b50ce56-0600-373d-178c-92aa780e5376@c-s.fr>
Date:   Wed, 27 Nov 2019 14:44:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdb15n4DpxAGEw+Av89XZDxi7Amh1XEyJEzWBd4tet7C2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 27/11/2019 à 14:00, Linus Walleij a écrit :
> On Wed, Nov 27, 2019 at 1:05 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> Le 27/11/2019 à 11:55, Linus Walleij a écrit :
> 
>>> That's weird, because when ->use_gpio_descriptors is set
>>> (as for this driver) the core only attempts to look up
>>> spi->cs_gpiods and not spi->cs_gpios, and consequently
>>> can only assign spi->cd_gpiod and not spi->cs_gpio:
>>
>> That's it. ->use_gpio_descriptors isn't set for the FSL driver:
> 
> Oh, my coding mistake. :(
> 
> And an especially stupid one too. OK I make a separate patch
> in the series to fix that too.
> 
>> I have now added it, together with the DTS cs-gpios name change (without
>> your counting patch with crashes), and I get something which is almost
>> working: I get temperature back into sensors, but temperature is 0°C !!!
> 
> OK we almost fixed it I think. It is probably better to test with
> all three patches (will send out soon) that rely on the gpiolib
> to do appropriate counting of the gpiod's and so on.
> 
>> Looking into dmesg, I see:
>>
>> [    3.153521] lm74@1 GPIO handle specifies active low - ignored
>> [    3.178093] lm74@5 GPIO handle specifies active low - ignored
>>
>> Any link with the problem ?
> 
> This is because your GPIO handles look like this:
> 
>          gpios = <&CPM1_PIO_C 4 1        /* SICOFI 1 */
>                   &CPM1_PIO_B 23 1       /* TEMP MCR */
>                   &CPM1_PIO_C 8 1        /* SICOFI 2 */
>                   &CPM1_PIO_C 12 1       /* EEPROM MIAE */
>                   &CPM1_PIO_D 6 1        /* SICOFI 3 */
>                   &CPM1_PIO_B 14 1       /* TEMP MPC885 */
>                   &CPM1_PIO_B 21 1       /* EEPROM CMPC885 */
>                   &FAV_CS_SPI 0 1        /* FAV SPI */
>                   &FAV_CS_SPI 2 1>;      /* FAV POSTE FPGA */
> 
> That "1" at the end of each GPIO phandle means "active low"
> as can be seen in <dt-bindings/gpio/gpio.h>
> 
> /* Bit 0 express polarity */
> #define GPIO_ACTIVE_HIGH 0
> #define GPIO_ACTIVE_LOW 1
> 
> But your child nodes look like this:
> 
>         sicofi@0 {
>                  compatible = "infineon,sicofi";
>                  spi-max-frequency = <1000000>;
>                  reg = <0>;
>                  spi-cs-high;
>                  spi-cpha;
>          };
> 
>          lm74@1 {
>                  compatible = "ns,lm74";
>                  spi-max-frequency = <1000000>;
>                  reg = <1>;
>                  spi-cs-high;
>          };
> 
> And the spi-cs-high in the child node takes precedence.
> 
> That's a bit ambigous so that is what the warning is about.
> 
> Try to remove the "spi-cs-high" bool flag from your nodes,
> because it seems like the old code was ignoring them.
> 
> Does that solve the problem?

Yes it does. Many thanks. I let you manage the packaging of fixes.

Christophe

> 
> Yours,
> Linus Walleij
> 
