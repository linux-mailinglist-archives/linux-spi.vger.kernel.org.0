Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5BE10AC4F
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 09:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfK0I5r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 03:57:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31627 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfK0I5r (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 03:57:47 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NF601J3Vz9tydr;
        Wed, 27 Nov 2019 09:57:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=j0MckliF; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9m4vZ68HVwkr; Wed, 27 Nov 2019 09:57:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NF5z6jYSz9tydq;
        Wed, 27 Nov 2019 09:57:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574845063; bh=gCwUvDzDURO74LpAmz0JfCZQVgCBaxWbk0sBrkY2YIA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j0MckliFiO0oNqaWcoWNduzvyVeSdqhJwOQ+h9Z68bNCktl8Kmy1yTWKRBo7fFYo4
         nE/ohXK5512zsbJbGvKgCdFIuG2teUovbhuub6MFpi2X6FBdvnlz9BYiV1ZuB+NcEu
         w0knGLO08hPpb9I92b/PS/WuuUaSUqYgx6QgG0Ko=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E98518B770;
        Wed, 27 Nov 2019 09:57:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nevtZ_8nwAKs; Wed, 27 Nov 2019 09:57:44 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B4DE8B845;
        Wed, 27 Nov 2019 09:57:44 +0100 (CET)
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
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2a65f209-0e69-aaf5-d664-97d7c0c2678e@c-s.fr>
Date:   Wed, 27 Nov 2019 09:57:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 27/11/2019 à 09:26, Linus Walleij a écrit :
> On Tue, Nov 26, 2019 at 8:14 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> 
>>> Digging a bit further, I see that devm_spi_register_master() fails in
>>> spi_register_controler() because ctlr->num_chipselect is 0
> 
> Aha, I see what the problem is I think. The old code for mpc8xxx had this:
> 
>         ngpios = of_gpio_count(np);
>         ngpios = max(ngpios, 0);
>         if (ngpios == 0 && !spisel_boot) {
>                 /*
>                  * SPI w/o chip-select line. One SPI device is still permitted
>                  * though.
>                  */
>                 pdata->max_chipselect = 1;
>                 return 0;
>         }
> (...)
>        master->num_chipselect = pdata->max_chipselect;
> 
> But the new code in the core has this:
> 
>      nb = gpiod_count(dev, "cs");
>      ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
> 
> So it relied on inspecting the device tree and set  this to 1
> if it didn't find anything.
> 
> I will send a patch to test!
> 

I don't think that's the problem. In my device tree I have several gpios 
defined for the node:

spi: spi@a80 {
	#address-cells = <1>;
	#size-cells = <0>;
	cell-index = <0>;
	compatible = "fsl,spi", "fsl,cpm1-spi";
	reg = <0xa80 0x30 0x3d80 0x30>;
	interrupts = <5>;
	interrupt-parent = <&CPM_PIC>;
	mode = "cpu";
	gpios = <&CPM1_PIO_C 4 1	/* SICOFI 1 */
		 &CPM1_PIO_B 23 1	/* TEMP MCR */
		 &CPM1_PIO_C 8 1	/* SICOFI 2 */
		 &CPM1_PIO_C 12 1	/* EEPROM MIAE */
		 &CPM1_PIO_D 6 1	/* SICOFI 3 */
		 &CPM1_PIO_B 14 1	/* TEMP MPC885 */
		 &CPM1_PIO_B 21 1	/* EEPROM CMPC885 */
		 &FAV_CS_SPI 0 1	/* FAV SPI */
		 &FAV_CS_SPI 2 1>;	/* FAV POSTE FPGA */

	};

	sicofi@0 {
		compatible = "infineon,sicofi";
		spi-max-frequency = <1000000>;
		reg = <0>;
		spi-cs-high;
		spi-cpha;
	};

	lm74@1 {
		compatible = "ns,lm74";
		spi-max-frequency = <1000000>;
		reg = <1>;
		spi-cs-high;
	};

	sicofi@2 {
		compatible = "infineon,sicofi";
		spi-max-frequency = <1000000>;
		reg = <2>;
		spi-cs-high;
		spi-cpha;
	};

	eeprom@3 {
		compatible = "atmel,at25";
		spi-max-frequency = <1000000>;
		reg = <3>;
		spi-cs-high;
		at25,byte-len = <1024>;
		at25,addr-mode = <2>;
		at25,page-size = <32>;
	};

	sicofi@4 {
		compatible = "infineon,sicofi";
		spi-max-frequency = <1000000>;
		reg = <4>;
		spi-cs-high;
		spi-cpha;
	};

	lm74@5 {
		compatible = "ns,lm74";
		spi-max-frequency = <1000000>;
		reg = <5>;
		spi-cs-high;
	};

	eeprom@6 {
		compatible = "atmel,at25";
		spi-max-frequency = <1000000>;
		reg = <6>;
		spi-cs-high;
		at25,byte-len = <1024>;
		at25,addr-mode = <2>;
		at25,page-size = <32>;
	};

	iio: csfav@7 {
		compatible = "iio,ad7923";
		spi-max-frequency = <1000000>;
		reg = <7>;
		spi-cs-high;
		spi-cpol;
		#io-channel-cells = <1>;
	};

	csfavfpga@8 {
		compatible = "cs,fpga-poste";
		spi-max-frequency = <1000000>;
		reg = <8>;
		spi-cs-high;
	};
};

Christophe
