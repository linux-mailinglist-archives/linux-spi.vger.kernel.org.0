Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892464EB3EC
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 21:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiC2TLc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 15:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240852AbiC2TLc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 15:11:32 -0400
X-Greylist: delayed 638 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 12:09:48 PDT
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1312AF1DF
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1648580348; bh=zxM3pn+KIF9KAbgXNUU2mWVIVmI13y2vEetlzWdhaMc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BdAptG5zJq2fUy+zuPBdfXL6/5rWYhJJXO8OxSJHy1UiKP5n/qXLE90aYh40HzNFP
         qu5UW4XOGAopJZjErrcdAVgaRDH0vNAokfCvkBGL+7szWrd/Vw8dWCp/bZCWbXL4QW
         +G0s8Itfyo5fRNmsrgTj0NnKLnXkIYsvLEUeY5oGkag0QtTm6XXjmLZ0YympCMv1Kp
         Waz+lec3ZKXsPlO92HyQJZwPd8MTJJFqtkgdnC3VcSmgnbvHpubscjLQR0Vj9bUYgS
         S9q48d7eCdl5//mLIn/5bGydirTuW5l2/c4rM1DyosTOcL9YrbOFST6yuX7JtzSEyW
         SMBs75XuNT8tA==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 8843C3A3A17;
        Tue, 29 Mar 2022 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1648580348; bh=zxM3pn+KIF9KAbgXNUU2mWVIVmI13y2vEetlzWdhaMc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BdAptG5zJq2fUy+zuPBdfXL6/5rWYhJJXO8OxSJHy1UiKP5n/qXLE90aYh40HzNFP
         qu5UW4XOGAopJZjErrcdAVgaRDH0vNAokfCvkBGL+7szWrd/Vw8dWCp/bZCWbXL4QW
         +G0s8Itfyo5fRNmsrgTj0NnKLnXkIYsvLEUeY5oGkag0QtTm6XXjmLZ0YympCMv1Kp
         Waz+lec3ZKXsPlO92HyQJZwPd8MTJJFqtkgdnC3VcSmgnbvHpubscjLQR0Vj9bUYgS
         S9q48d7eCdl5//mLIn/5bGydirTuW5l2/c4rM1DyosTOcL9YrbOFST6yuX7JtzSEyW
         SMBs75XuNT8tA==
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 45D4B3A3A05;
        Tue, 29 Mar 2022 18:59:08 +0000 (UTC)
Message-ID: <c796837e-7cd8-517f-dbd0-85ec3dbc4b86@mleia.com>
Date:   Tue, 29 Mar 2022 21:59:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: spi-pl022 on lpc32xx
Content-Language: en-US
To:     Trevor Woerner <twoerner@gmail.com>, linux-spi@vger.kernel.org
Cc:     linus.walleij@linaro.org, alexandre.belloni@bootlin.com
References: <20220328190104.GA11946@localhost>
From:   Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20220328190104.GA11946@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220329_185908_577425_F6B826EB 
X-CRM114-Status: GOOD (  32.84  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Trevor,

On 3/28/22 22:01, Trevor Woerner wrote:
> Hi,
> 
> I have a spi-nor chip (m25p16) connected to the SPI1 bus of an LPC32xx-based
> machine that I can't get working.
> 
> The LPC32xx has both an SPI controller and an SSP controller, but only one can
> be active at a time. The SSP is an ARM primecell component which is a "SPI on
> steroids" device. The SSP can be run in several modes, one of which is "SPI"
> mode.
> 
> The LPC32xx machine does not have a SPI driver in the kernel, but it does have
> a driver for the SSP controller. Since there is no SPI driver, I'm using the
> SSP driver in "SPI" mode, but not having much luck.

I have a feeling that Sylvain Lemieux once reported that the PrimeCell SPI
driver worked for him, but here I might be wrong.

> I can see the SPI subsystem sending the 0x9f command (READ ID), the spi-pl022
> driver writes the command to the SSP data register, but the flag in the SSP
> status register to say data has been received never goes up.
> 
> I'm wondering if anyone is successfully using the current spi-pl022 driver to
> interact with an SPI device (preferably on a lpc32xx-based machine)?
> 
> I've spent the better part of the last week poking at this. I've tried many
> combinations of device tree, but what I think should work is:
> 
> 	&ssp0 {
> 		status = "okay";
> 		num-cs = <1>;
> 		cs-gpios = <&gpio 3 4 1>;
> 
> 		m25p16@0 {
> 			compatible = "jedec,spi-nor";
> 			reg = <0>;
> 			spi-max-frequency = <500000>;
> 
> 			pl022,interface = <0>;
> 			pl022,com-mode = <1>;
> 		};
> 	};
> 

FWIW on my board I do use both SSP0 and SSP1 at once, but I didn't rebase
the dts/kernel for a long time, so the examples might be outdated:

&ssp0 {
	num-cs = <1>;
	cs-gpios = <&gpio 3 5 GPIO_ACTIVE_HIGH>; /* SSEL0 */

	sc16is752@0 {
		compatible = "nxp,sc16is752";
		reg = <0>;
		spi-max-frequency = <4000000>;

		/* 18.432 MHz external oscillator */
		clocks = <&xtal_18432k>;

		/* Interrupt to GPI_07 */
		interrupt-parent = <&sic2>;
		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
	};
};

&ssp1 {
	num-cs = <1>;
	cs-gpios = <&gpio 3 4 GPIO_ACTIVE_HIGH>;

	s25fl216k@0 {
		compatible = "s25fl216k", "jedec,spi-nor";
		reg = <0>;
		spi-max-frequency = <150000>;
		spi-cpol;
		spi-cpha;
	};
};

Also SSP0 is enabled on PhyTec phy3250 board, there is an at25 eeprom on it,
I've just briefly checked the device tree node, and apparently it contains
some references/properties specific to the PL022 SPI driver.

> I've tried a couple other compatible strings ("micron,m25p16", "st,m25p16"),
> I've tried a range of frequencies (from 0.5MHz to 33MHz). The 3 options for
> interface are 0 (SPI), 1 (TI), or 2 (Microwire) and I've tried all of them. I
> don't believe the DMA system works generically on the lpc32xx but I've tried
> both interrupt <0> and polling <1> for the com-mode. I believe SPI1 and SSP0
> are the same and SPI2 and SSP1 are the same (which is why I'm using SSP0
> here).
> 
> The pl-022 driver is quite aggressive about shutting off the SSP and raising
> the chip select after a message is sent, so I modified my driver to leave the
> SSP enabled and keeping the (active-low) chip select low (in case those were
> affecting the reply) but there's no change.
> 
> One thing that's curious is that the platform_info->bus_id is -1. This bus
> number comes from the parent device (spi core). I wonder if this driver is not
> registering itself correctly with the spi core?
> 
> Best regards,
>   	Trevor

--
Best wishes,
Vladimir
