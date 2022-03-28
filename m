Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF64EA125
	for <lists+linux-spi@lfdr.de>; Mon, 28 Mar 2022 22:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbiC1UL1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Mar 2022 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiC1UL0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Mar 2022 16:11:26 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54E5372C
        for <linux-spi@vger.kernel.org>; Mon, 28 Mar 2022 13:09:44 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5958B1BF20A;
        Mon, 28 Mar 2022 20:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648498179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fUjS60nAe2yHQxUuVCTTRpviQSYgGoD01WVm1rNcDCQ=;
        b=pDwa8w17f+07ET3iZK9GJWeBiuU8DITlAXpfcPDcLvQ+BnXke/s1+NPrSyj7AqPogsfHFl
        hU0hkUh1Ba6SuoL0Uq42Ow+w+ygmmxgXEly9bcGdppX/z9uTxn6fsFjsXD7cG9620vRo01
        xr4mXlv0f8IRXMnKU79ABIDnOa9mYDacettP3SOCKLLr9X8KxY3S/oocj6LWWw4PS9J2TP
        sdWQJA2WNlOvEYHHkpaP8q6DNYLUB271y4iBMklIUE8fsoFFlO4EcPHHEZl8sPaJ9ubYbk
        anEoSp9K7I3WQplbmpNEYDiJGUfckcBErVj4WwmFTPpQd5csrsvEUD2pm7m/kA==
Date:   Mon, 28 Mar 2022 22:09:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-spi@vger.kernel.org, linus.walleij@linaro.org, vz@mleia.com
Subject: Re: spi-pl022 on lpc32xx
Message-ID: <YkIWA9QuLR7VbMhv@piout.net>
References: <20220328190104.GA11946@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328190104.GA11946@localhost>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

On 28/03/2022 15:01:04-0400, Trevor Woerner wrote:
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
> 
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

On our side, we use ssp0 with spidev and ssp1 that way:

&ssp1 {
        #address-cells = <1>;
        #size-cells = <0>;
        num-cs = <1>;
        status = "okay";
        ads8344: adc@0 {
                compatible = "ti,ads8344";
                /* mode spi */
                pl022,interface = <0>;
                reg = <0>;
                spi-max-frequency = <2000000>;
                #io-channel-cells = <1>;
                vref-supply = <&vcc_2_5>;
        };
};

We do ave a workaround to disable DMA because IIRC, it doesn't work
alongside DMA for the NAND:

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index d1776fea287e..989b4a980b35 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2106,7 +2106,7 @@ pl022_platform_data_dt_get(struct device *dev)
                return NULL;
 
        pd->bus_id = -1;
-       pd->enable_dma = 1;
+       pd->enable_dma = 0;
        of_property_read_u32(np, "num-cs", &tmp);
        pd->num_chipselect = tmp;
        of_property_read_u32(np, "pl022,autosuspend-delay",

I hope that helps!

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
