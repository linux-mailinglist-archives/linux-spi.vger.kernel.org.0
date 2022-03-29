Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0614EB586
	for <lists+linux-spi@lfdr.de>; Wed, 30 Mar 2022 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiC2WF3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiC2WF2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 18:05:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC025C57
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 15:03:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v13so15279404qkv.3
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tpp4LWNnENRha7KdmZZr6co+V/h/5vqZKb1jYKyq1y0=;
        b=iJy1SETeOxLzR38U/SylARthnAnEO7DOLN4xjRReO1RIuf5g8vCY51ql5SSf5dEhGA
         6O9iaRrG+US2pLmBxHToB3q4ICfYJXR3oOj/KAu1uk4S8JyUywLSbVTg13D6gGsvlRSp
         q542UokcfjkE7M2IsY93JN0R0q5s5kqMJvD+t1owIDJjt3qe3MEqf1+ZW1cQHaUxr6Kz
         opvxof87lNsN57oeQ1wDrHstsURJ/grGzbBjwXKFqipMVyOv75c2IWGCx7IEx3uu/a3D
         k3UO4GXH+ILur/dRLI+2PIV89Eg20ZVayRxxfu++2ngg8V5lsEfjrZj59dwS1LYLdH20
         t5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tpp4LWNnENRha7KdmZZr6co+V/h/5vqZKb1jYKyq1y0=;
        b=fuJrWIpDw0B6aDXF+IqlZk3D1Gdl/FmKbogSZVOjRWcz3Vo+O3KzH1oBaLTZ0t9qEe
         vjPGNNbNYI6ffRCupVGrbbmbZhmdPtGRwOYksLCWLxpAtW4d/SwRyasz7H0tSh11SgT2
         CZZ/RQ6wAfzr+xCs9CATOkTdCcFouFmWi8vVspfA8i5lopbP1tys2auUENVzGDlCCFyW
         ZTszKsIJHVLKtN+9JlFfML37+6gemgaCSvG02sHSzQV80+5HBPsZ5ZOJI84WKoxl0mEc
         p5TVnvOcqIGilF2qHuzcoMsSyOOaIz5/eIO3+bxC2UQdMZdmEgUEzwb4/Gt5u9P8GM8+
         WkWQ==
X-Gm-Message-State: AOAM530Svemfaj/fOTQWoPfgMVMlr/hEGk/A5psxJase5GXbiINqlRAO
        /b4sm2K+k0WCeVrFp71M/Y/NeblQcVQ=
X-Google-Smtp-Source: ABdhPJwkdYZSl3W5BxuKs4Atq7PuSGtLhRiezTpGm891yU1+JPMku8C6kUkafn05XTbL7WatRBxa0w==
X-Received: by 2002:ae9:e501:0:b0:67d:370f:b9b5 with SMTP id w1-20020ae9e501000000b0067d370fb9b5mr21487703qkf.536.1648591422795;
        Tue, 29 Mar 2022 15:03:42 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm16822070qta.40.2022.03.29.15.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:03:42 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:03:40 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, vz@mleia.com,
        alexandre.belloni@bootlin.com
Subject: Re: spi-pl022 on lpc32xx
Message-ID: <20220329220340.GA22159@localhost>
References: <20220328190104.GA11946@localhost>
 <CACRpkdY2ynzAyQz3q2gHnZMA+Opr-b=w=dA4YMqH=i0Rv+OYcg@mail.gmail.com>
 <20220329183135.GA6427@localhost>
 <CACRpkdZUW0wQrJxnA1pcJ9AO6-FOVEx6pXczg0iz2UnQMCEWpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdZUW0wQrJxnA1pcJ9AO6-FOVEx6pXczg0iz2UnQMCEWpw@mail.gmail.com>
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

Hi Linus,

Amazing! It's like you're looking over my shoulder (in a good way) :-)

On Tue 2022-03-29 @ 11:33:48 PM, Linus Walleij wrote:
> On Tue, Mar 29, 2022 at 8:31 PM Trevor Woerner <twoerner@gmail.com> wrote:
> 
> > > >         &ssp0 {
> > > >                 status = "okay";
> > >
> > > The main definition of the SSP is elsewhere in the node with ssp0:, so I
> > > have no idea how this is configured really.
> >
> > I'm not sure what you mean here. lpc32xx.dtsi defines the ssp0 node and
> > disables it.
> 
> Yeah that is what I'm asking about. So now that I look at that:
> 
>                         ssp0: spi@20084000 {
>                                 compatible = "arm,pl022", "arm,primecell";
>                                 reg = <0x20084000 0x1000>;
>                                 interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&clk LPC32XX_CLK_SSP0>;
>                                 clock-names = "apb_pclk";
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
>                                 status = "disabled";
>                         };
> 
> Just apb_pclk? You need sspclk as well. If the same clock is used for
> both then add the same clock with the name "sspclk" *before* the
> apb_pclk, so:
> 
> clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
> clock-names = "sspclk", "apb_pclk";
> 
> NOTE: I don't know if this is what the SoC is actually routing to the SSP.
> Consult the LPC32xx docs to figure out which clock is actually connected
> to the SSPCLK input of the PL022.

We're having that exact conversation here:
	http://lists.infradead.org/pipermail/linux-arm-kernel/2022-March/724702.html

On the lpc32xx this device is an APB peripheral meaning its configuration
registers are on the APB bus which are driven by PERIPH_CLK. *However*, the
clock source used to derive the SPI/SSP clock itself (i.e. not the clock used
to communicate with its registers) comes from the HCLK (which is the clock
usually used to drive AHB peripherals on this SoC).

My understanding is that "LPC32XX_CLK_SSP0 is aliased to HCLK, so that should
be fine. apb_pclk, however, is wrong (I believe), unless that dts stanza is
talking about the clock used to communicate with the controller itself.

> > > >                 m25p16@0 {
> > > >                         compatible = "jedec,spi-nor";
> > > >                         reg = <0>;
> > > >                         spi-max-frequency = <500000>;
> > > >
> > > >                         pl022,interface = <0>;
> > > >                         pl022,com-mode = <1>;
> > >
> > > com-mode 1 (polling) really? Why? Are interrupts broken
> > > on your silicon?
> >
> > Right now I'm getting nothing back from the spi-nor. I see the SPI subsystem
> > sending out the 0x9f, I see the pl022 driver writing it to the data register,
> > I've added some code to the pl022 driver to print out the status register, and
> > the "receive FIFO not empty flag" (RNE) never goes up. In polling mode it'll
> > eventually time out and I'll get to a prompt (to reflash and reboot). In
> > interrupt mode I'd have to yank the power, boot to a different image, flash
> > from there, and reboot. So polling mode make the build/flash/reboot cycle
> > faster :-)
> 
> I'd bet on the clock (which is obviously wrong) and if you have a pin
> controller then inspect the pin multiplexing too. You have
> drivers/pinctrl/pinctrl-lpc18xx.c
> but there is no driver for lpc32xx? So how is pin multiplexing
> actually set up on this platform?

I've been zeroing in on that exact same question myself.

In my particular case the first bootloader to run on my device is an old,
in-house, bootloader written 20 years ago. That bootloader configures and runs
SPI, but then never unconfigures it. My U-Boot doesn't do anything with
SPI, and Linux doesn't have an SPI driver. Therefore the first bootloader
configures SPI and then nothing turns it off again (as far as I can tell).

I noticed that the pinmuxing was wrong and I was going to ask the other people
using this device (Alexandre and Vladimir) if they could use something like
devmem2 to tell me what their register 0x40028108 contains. I believe theirs
should contain either 0x0000_1760 or 0x0000_1600 or 0x0000_0160 (depending on
which of ssp0 and/or ssp1 they have enabled). But mine is 0.

I was looking at various registers and wondering about pinmuxing. In fact I
was about to ask if anyone knew how it was being done on the lpc32xx, because
I couldn't find it (but assumed I wasn't looking for the right things).

> How are these two SPI and SSP controllers actually sharing these
> pins without any configuration anywhere? It just gives me the feel
> that an lpc32xx pin control driver is missing.

They can't. On the lpc32xx you can use either the SPI controller or the SSP
controller, but you can't have both enabled at the same time since they both
use the same external pins.

> On LPC18xx it looks like this:
> 
>                pinctrl: pinctrl@40086000 {
>                         compatible = "nxp,lpc1850-scu";
>                         reg = <0x40086000 0x1000>;
>                         clocks = <&ccu1 CLK_CPU_SCU>;
>                 };
> 
> SCU sounds like "system control unit" doesn't LPC32xx have one
> of these? Where is that configured then?

The lpc32xx doesn't have an SCU, but it does have a set of registers used to
set, clear, or show the current state of various pinmuxing arrangements.
Unfortunately some of the pinmuxing configurations are interspersed with
various controllers' control registers as well (e.g. uart, lcd, ethernet mac,
sd card).

This SoC can use some attention, and it has my attention :-) It's also a
32-bit ARM device which could use some more attention too (as I understand
it).

Best regards,
	Trevor
