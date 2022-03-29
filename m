Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061674EB557
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 23:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiC2Vfo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiC2Vfo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 17:35:44 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F91229A6
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 14:34:00 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2e612af95e3so198009307b3.9
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TH+R0rHsAW32pS3GaG5BSxBxFN4RQRPmHuWERv6wems=;
        b=wZCBBSBss0/GGQ9mkMlBeQ3DsJt2FFEEv4YAfe9/l5dSyIgbHVSO5GgdybOOHoyNXc
         pDUDrwmeROYUTA1RC+4wtm1ASoayvcvNBh12sdL/gexZ0s9ZIG/509133vshPawKdA8n
         X3pEiqxC1QFWamMEvmtzNwTxGzwEghCwdt2JN3xzB45c55Et2iD9b1OyyRMmc46Yn1Ot
         F/lujm4+6SPJcwEcXAtoBzbZqAufZ0keysb1bc6y9vDt91D1T2HUrQ7arYlOtLb9YB6c
         mMc4iutI4n6UvJSl/tU6n6s33h9hr7VBGNFtoCAduaQpzx4mK1Wk8FXRR2/i8jjX+g7x
         pNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TH+R0rHsAW32pS3GaG5BSxBxFN4RQRPmHuWERv6wems=;
        b=A7NgklbzybsknPH5Szmp8aROwnBzDS5v4W1glh/0yiORz6rzR+3sXUcsKKxfv0juzN
         nUnpHphal4S37huISCI1tg3kOxJUWLHLq5uVRyYiVUSYuQNXsug4CcbNlnXazOsTJaWi
         DM+cC4NgHI91wsf6QySDuG1xEjeN1HsYvRg7ZYJC9kOMyb01wOCDh0f3me2+s9jjZ7lW
         9Phov1UAQOyBR1xP/J2VoUFcLR1TJG4VTogEERRvtXv67PyCYIZeb70olfBV4YDWLdlw
         mVw9Emc0ebv9QzrzVA5JUSDsVgUpsmUtyHbOdWfAtiZp7fQsRDpc4rpXm/yRw9IfutxD
         7A0Q==
X-Gm-Message-State: AOAM530ZgcFqp1lBcd/RHoww+Z+MeUXGF+QhxSEsVe2/YT3XZaXV34Dm
        NAm1WcVFp2kqcVDc+Pr7pdStFMX80kPnxVmxNCk9FQ==
X-Google-Smtp-Source: ABdhPJy+XLRldg+9R6WcePCkkl3AJbBZ/wnWlzPeUnrUx5gNhJjajv+pkA9dDL6PjVobiaermYp+7/USNP22BBVykeE=
X-Received: by 2002:a81:484f:0:b0:2e9:e015:2444 with SMTP id
 v76-20020a81484f000000b002e9e0152444mr22637948ywa.448.1648589639813; Tue, 29
 Mar 2022 14:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220328190104.GA11946@localhost> <CACRpkdY2ynzAyQz3q2gHnZMA+Opr-b=w=dA4YMqH=i0Rv+OYcg@mail.gmail.com>
 <20220329183135.GA6427@localhost>
In-Reply-To: <20220329183135.GA6427@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Mar 2022 23:33:48 +0200
Message-ID: <CACRpkdZUW0wQrJxnA1pcJ9AO6-FOVEx6pXczg0iz2UnQMCEWpw@mail.gmail.com>
Subject: Re: spi-pl022 on lpc32xx
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-spi@vger.kernel.org, vz@mleia.com,
        alexandre.belloni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 29, 2022 at 8:31 PM Trevor Woerner <twoerner@gmail.com> wrote:

> > >         &ssp0 {
> > >                 status = "okay";
> >
> > The main definition of the SSP is elsewhere in the node with ssp0:, so I
> > have no idea how this is configured really.
>
> I'm not sure what you mean here. lpc32xx.dtsi defines the ssp0 node and
> disables it.

Yeah that is what I'm asking about. So now that I look at that:

                        ssp0: spi@20084000 {
                                compatible = "arm,pl022", "arm,primecell";
                                reg = <0x20084000 0x1000>;
                                interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
                                clocks = <&clk LPC32XX_CLK_SSP0>;
                                clock-names = "apb_pclk";
                                #address-cells = <1>;
                                #size-cells = <0>;
                                status = "disabled";
                        };

Just apb_pclk? You need sspclk as well. If the same clock is used for
both then add the same clock with the name "sspclk" *before* the
apb_pclk, so:

clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
clock-names = "sspclk", "apb_pclk";

NOTE: I don't know if this is what the SoC is actually routing to the SSP.
Consult the LPC32xx docs to figure out which clock is actually connected
to the SSPCLK input of the PL022.

> > >                 m25p16@0 {
> > >                         compatible = "jedec,spi-nor";
> > >                         reg = <0>;
> > >                         spi-max-frequency = <500000>;
> > >
> > >                         pl022,interface = <0>;
> > >                         pl022,com-mode = <1>;
> >
> > com-mode 1 (polling) really? Why? Are interrupts broken
> > on your silicon?
>
> Right now I'm getting nothing back from the spi-nor. I see the SPI subsystem
> sending out the 0x9f, I see the pl022 driver writing it to the data register,
> I've added some code to the pl022 driver to print out the status register, and
> the "receive FIFO not empty flag" (RNE) never goes up. In polling mode it'll
> eventually time out and I'll get to a prompt (to reflash and reboot). In
> interrupt mode I'd have to yank the power, boot to a different image, flash
> from there, and reboot. So polling mode make the build/flash/reboot cycle
> faster :-)

I'd bet on the clock (which is obviously wrong) and if you have a pin
controller then inspect the pin multiplexing too. You have
drivers/pinctrl/pinctrl-lpc18xx.c
but there is no driver for lpc32xx? So how is pin multiplexing
actually set up on this platform?

How are these two SPI and SSP controllers actually sharing these
pins without any configuration anywhere? It just gives me the feel
that an lpc32xx pin control driver is missing.

On LPC18xx it looks like this:

               pinctrl: pinctrl@40086000 {
                        compatible = "nxp,lpc1850-scu";
                        reg = <0x40086000 0x1000>;
                        clocks = <&ccu1 CLK_CPU_SCU>;
                };

SCU sounds like "system control unit" doesn't LPC32xx have one
of these? Where is that configured then?

Yours,
Linus Walleij
