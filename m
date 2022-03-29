Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3F4EAE33
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiC2NRC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiC2NRB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 09:17:01 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75B536335
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 06:15:18 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w141so13703305qkb.6
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iaSsccXhbXzdErEnS5Vhb154e7GbhXIuQhQSe9D7dGQ=;
        b=gx1Vwp+xJZfFBG0/EmC0z89XXciWI4ATF4qBmGlHMvTG9HHiLInWnXVsDUF+upD5CS
         b7nDC1VLhbb8/+hsBQ4RXty0D4fX9Z0GhUjnVKQhxPXX05KgmSVTP4S4uoZ3uj5DTdh/
         8JIPkPQhHDW4YKyc+HPcDblBDlQj/WCF7J57+nmHgX/CtmWgxU6sstuL+mkOXF57ehb6
         BRl5SRYnhG8bIXOqPRax58huwxUpYMJnx8tVivdzlmqy3rFk/M7SDGxQdt3RvWlxfgIe
         XJAfpCC7bbdi2dFzX4xwZiMs3b2qx0rR49cXykaQIiXkLUB79zVEKCYbpnedeDcRmhgW
         HCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iaSsccXhbXzdErEnS5Vhb154e7GbhXIuQhQSe9D7dGQ=;
        b=vsANyl67gbWra7RyMmhemfejSpWWX/ms/Ab2CB8rEdiMoXdG4Ne3/TTzBs1h+w27rR
         qKrk8/98q26XskIF7EkV71RhzZ3VU2TGpR9AFDL9nc9vCaxDmMN7y/5+5Qf8J6ImHQj+
         LKez7XpD+kLZVLxi56TmFiRCcnNudbXiMy1oZw5ysXAOhhHrm4HHr7FUIG+HDixALZFs
         gwDEUwBRCDA+joN0lTB1oBhPvXVViOoY64rglOmnqIKy8fDWq5upuDUmQ8bM4a13aNyj
         GhY/NQiaf9GCIit3kxDH9qpEMRAEZ3C4x/n5QHmbX9BbGhBwCbJvdMH6UK/DZzD3XYtG
         doIw==
X-Gm-Message-State: AOAM533b+oHgcdEqKrnn0140A5jpSwaCagUA1hR1XEVUTSP8gszrZMTl
        wJYF/aih1q5TG14gI1e+kQ0Hi4m/Zg0=
X-Google-Smtp-Source: ABdhPJx6Ge+JUal19uvo4Hy0en07trLzOb2NKQ+AHA95e/sbE2ozrTzjQZLuW2+Ewo+9jvyEKXMy6w==
X-Received: by 2002:a05:620a:38e:b0:67d:31cc:d718 with SMTP id q14-20020a05620a038e00b0067d31ccd718mr19933254qkm.617.1648559717468;
        Tue, 29 Mar 2022 06:15:17 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002e16389b501sm15013009qta.96.2022.03.29.06.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:15:16 -0700 (PDT)
Date:   Tue, 29 Mar 2022 09:15:15 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-spi@vger.kernel.org, linus.walleij@linaro.org, vz@mleia.com
Subject: Re: spi-pl022 on lpc32xx
Message-ID: <20220329131515.GA11352@localhost>
References: <20220328190104.GA11946@localhost>
 <YkIWA9QuLR7VbMhv@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkIWA9QuLR7VbMhv@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Alexandre,

On Mon 2022-03-28 @ 10:09:39 PM, Alexandre Belloni wrote:
> Hello,
> 
> On 28/03/2022 15:01:04-0400, Trevor Woerner wrote:
> > Hi,
> > 
> > I have a spi-nor chip (m25p16) connected to the SPI1 bus of an LPC32xx-based
> > machine that I can't get working.
> > 
> > The LPC32xx has both an SPI controller and an SSP controller, but only one can
> > be active at a time. The SSP is an ARM primecell component which is a "SPI on
> > steroids" device. The SSP can be run in several modes, one of which is "SPI"
> > mode.
> > 
> > The LPC32xx machine does not have a SPI driver in the kernel, but it does have
> > a driver for the SSP controller. Since there is no SPI driver, I'm using the
> > SSP driver in "SPI" mode, but not having much luck.
> > 
> > I can see the SPI subsystem sending the 0x9f command (READ ID), the spi-pl022
> > driver writes the command to the SSP data register, but the flag in the SSP
> > status register to say data has been received never goes up.
> > 
> > I'm wondering if anyone is successfully using the current spi-pl022 driver to
> > interact with an SPI device (preferably on a lpc32xx-based machine)?
> > 
> > I've spent the better part of the last week poking at this. I've tried many
> > combinations of device tree, but what I think should work is:
> > 
> > 	&ssp0 {
> > 		status = "okay";
> > 		num-cs = <1>;
> > 		cs-gpios = <&gpio 3 4 1>;
> > 
> > 		m25p16@0 {
> > 			compatible = "jedec,spi-nor";
> > 			reg = <0>;
> > 			spi-max-frequency = <500000>;
> > 
> > 			pl022,interface = <0>;
> > 			pl022,com-mode = <1>;
> > 		};
> > 	};
> > 
> > I've tried a couple other compatible strings ("micron,m25p16", "st,m25p16"),
> > I've tried a range of frequencies (from 0.5MHz to 33MHz). The 3 options for
> > interface are 0 (SPI), 1 (TI), or 2 (Microwire) and I've tried all of them. I
> > don't believe the DMA system works generically on the lpc32xx but I've tried
> > both interrupt <0> and polling <1> for the com-mode. I believe SPI1 and SSP0
> > are the same and SPI2 and SSP1 are the same (which is why I'm using SSP0
> > here).
> > 
> > The pl-022 driver is quite aggressive about shutting off the SSP and raising
> > the chip select after a message is sent, so I modified my driver to leave the
> > SSP enabled and keeping the (active-low) chip select low (in case those were
> > affecting the reply) but there's no change.
> > 
> > One thing that's curious is that the platform_info->bus_id is -1. This bus
> > number comes from the parent device (spi core). I wonder if this driver is not
> > registering itself correctly with the spi core?
> > 
> 
> On our side, we use ssp0 with spidev and ssp1 that way:
> 
> &ssp1 {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         num-cs = <1>;
>         status = "okay";
>         ads8344: adc@0 {
>                 compatible = "ti,ads8344";
>                 /* mode spi */
>                 pl022,interface = <0>;
>                 reg = <0>;
>                 spi-max-frequency = <2000000>;
>                 #io-channel-cells = <1>;
>                 vref-supply = <&vcc_2_5>;
>         };
> };
> 
> We do ave a workaround to disable DMA because IIRC, it doesn't work
> alongside DMA for the NAND:
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index d1776fea287e..989b4a980b35 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2106,7 +2106,7 @@ pl022_platform_data_dt_get(struct device *dev)
>                 return NULL;
>  
>         pd->bus_id = -1;
> -       pd->enable_dma = 1;
> +       pd->enable_dma = 0;
>         of_property_read_u32(np, "num-cs", &tmp);
>         pd->num_chipselect = tmp;
>         of_property_read_u32(np, "pl022,autosuspend-delay",
> 
> I hope that helps!

It is extremely helpful knowing that someone is currently using the SSP driver
and that it is working for them (i.e. it hasn't bitrotted to the point of not
working). I wonder what version of the kernel you're using?

I'm explicitly setting the pl022,com-mode of my setup to "polling" so the DMA
shouldn't be an issue. I added your patch anyway and am in the same position.

I made an interesting discovery: one of my bootloaders is enabling the SPI
controller, U-Boot doesn't touch it and neither does Linux. But when my Linux
system runs, the SPI system is running. I was hoping that was the source of my
problems, but turning off its clocks doesn't get SSP going for me. Maybe I
need to check more controllers, pinmuxing, and gpio direction registers.

Maybe it would be faster for me to try to get an SPI driver written? lol

Best regards,
	Trevor
