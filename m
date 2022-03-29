Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168724EB35C
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiC2SdW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 14:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbiC2SdW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 14:33:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EF5179B05
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 11:31:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b18so16039674qtk.13
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W/oK6sM4ly8ciPv3HqbUf+UoHjKVAuJvmsGxf7C07XM=;
        b=AkqJ8FvnClT5W9pqnSQ5ailNTDbLT6CMlSToNZS33c/RnqCN/NYE9xMZyx+U2xntTa
         jUe2rJFjFOcRdxYH2GSOxSDBaK22UDBX2uBtT7/XtAZ2oYhlJ0mbCGsDJyAYAaVNCwSA
         jk8lxriks1hBWyR14C/xYJUH14kk99O8a2UbaP9Nvorx5s2M4yfn/qUTVUOJt7NhPiul
         t5QFtZ3JFbtuNR0qarOeckpYT9upUjvjJZ6LMDjrp2oRNVIZZxuIEwTft0RmQa2LHIlJ
         K87OMzBL2sAqbJZjOKkmoHBOxdxtFBd/K8JDX8Ns9W8JVStO2/+qK4HxX2+7j5ezC+Ks
         kkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W/oK6sM4ly8ciPv3HqbUf+UoHjKVAuJvmsGxf7C07XM=;
        b=VzylxzVwTICjALnnlR2oWX59fqqWWtsINnEljvRauA3b6A6d5FfsWk7RWwJy64niN+
         kkXKyg2XztvqkS5VNdQVT6yNwVU2htupRDKituoEP2Fc7SFF98oZBHjYkH60taVrcJbg
         tqW84TemnT20tHLZ5RjvpgnCk5T+GYDJD2aLGexn98nGMngT6568RpiFzrJKz6EfT3Ft
         iNUAHOAjRXBuAWbuxUgaEafy4z5oLluvPmHTxrTEJJEaTmm+V73iuaDEbBOzhSiIJfPD
         K1XLB+0U1iNj6uTT/eyKjuMNqSsZuQW2YIhVOaSHuD1yoJg22BjrMSGsheV/Z/GVGWKt
         LvRA==
X-Gm-Message-State: AOAM532MRIpXUVLr8wi9cZIE3ZAGPvGcPQ1Gfb+tZ2J4bKMHR80Fhog5
        hbxhyhVrSHmG3rU94dM+Mj54uaalqnQ=
X-Google-Smtp-Source: ABdhPJzc6GTuCd9vwE/MxZxx0hOL4zRXY3OvwF3mJDjDNo788w0P3JGrauUFTh5tjXhM20UyeFMkTQ==
X-Received: by 2002:ac8:5787:0:b0:2e1:c602:cff2 with SMTP id v7-20020ac85787000000b002e1c602cff2mr29941487qta.133.1648578697500;
        Tue, 29 Mar 2022 11:31:37 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id f8-20020ac859c8000000b002e232e04cafsm16461384qtf.88.2022.03.29.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:31:37 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:31:35 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, vz@mleia.com,
        alexandre.belloni@bootlin.com
Subject: Re: spi-pl022 on lpc32xx
Message-ID: <20220329183135.GA6427@localhost>
References: <20220328190104.GA11946@localhost>
 <CACRpkdY2ynzAyQz3q2gHnZMA+Opr-b=w=dA4YMqH=i0Rv+OYcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdY2ynzAyQz3q2gHnZMA+Opr-b=w=dA4YMqH=i0Rv+OYcg@mail.gmail.com>
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

On Tue 2022-03-29 @ 06:06:01 PM, Linus Walleij wrote:
> On Mon, Mar 28, 2022 at 9:01 PM Trevor Woerner <twoerner@gmail.com> wrote:
> 
> > I'm wondering if anyone is successfully using the current spi-pl022 driver to
> > interact with an SPI device (preferably on a lpc32xx-based machine)?
> 
> I'm using it in with the Cypress CY8CTMA340 touchscreen in
> arch/arm/boot/dts/ste-href-tvk1281618-r3.dtsi
> like this:
> 
>               spi@80111000 {
>                         compatible = "arm,pl022", "arm,primecell";
>                         reg = <0x80111000 0x1000>;
>                         interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         /* Same clock wired to kernel and pclk */
>                         clocks = <&prcc_pclk 2 1>, <&prcc_pclk 2 1>;
>                         clock-names = "sspclk", "apb_pclk";
>                         dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
>                                <&dma 33 0 0x0>; /* Logical - MemToDev */
>                         dma-names = "rx", "tx";
>                         power-domains = <&pm_domains DOMAIN_VAPE>;
>                         num-cs = <1>;
>                         cs-gpios = <&gpio6 24 GPIO_ACTIVE_LOW>;
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&spi2_default_mode>;
> 
>                         touchscreen@0 {
>                                 compatible = "cypress,cy8ctma340";
>                                 /*
>                                  * Actually the max frequency is 6
> MHz, but over 2 MHz the
>                                  * data rate needs to be restricted to
> max 2Mbps which the
>                                  * SPI framework cannot handle.
>                                  */
>                                 spi-max-frequency = <2000000>;
>                                 reg = <0>;
>                                 interrupt-parent = <&gpio2>;
>                                 interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
>                                 vcpin-supply = <&ab8500_ldo_aux1_reg>;
>                                 vdd-supply = <&db8500_vsmps2_reg>;
>                                 reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
>                                 touchscreen-size-x = <480>;
>                                 touchscreen-size-y = <854>;
>                                 active-interval-ms = <0>;
>                                 touch-timeout-ms = <255>;
>                                 lowpower-interval-ms = <10>;
>                                 bootloader-key = /bits/ 8 <0x00 0x01
> 0x02 0x03 0x04 0x05 0x06 0x07>;
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&cyttsp_tvk_mode>;
>                         };
>                 };
> 
> It works just fine with DMA and all.

Okay, thanks for the reply! It's good to know this driver is being used.

> > I've spent the better part of the last week poking at this. I've tried many
> > combinations of device tree, but what I think should work is:
> >
> >         &ssp0 {
> >                 status = "okay";
> 
> The main definition of the SSP is elsewhere in the node with ssp0:, so I
> have no idea how this is configured really.

I'm not sure what you mean here. lpc32xx.dtsi defines the ssp0 node and
disables it. On the lpc32xx one must choose between spi and ssp since this SoC
has controllers for both. However the Linux kernel only has a driver for ssp
(i.e. the spi-pl022 driver).

> >                 num-cs = <1>;
> >                 cs-gpios = <&gpio 3 4 1>;
> 
> Use #include <dt-bindings/gpio/gpio.h> and GPIO_ACTIVE_LOW
> for the flag so it gets readable.

Awesome, thanks!

> >                 m25p16@0 {
> >                         compatible = "jedec,spi-nor";
> >                         reg = <0>;
> >                         spi-max-frequency = <500000>;
> >
> >                         pl022,interface = <0>;
> >                         pl022,com-mode = <1>;
> 
> com-mode 1 (polling) really? Why? Are interrupts broken
> on your silicon?

Right now I'm getting nothing back from the spi-nor. I see the SPI subsystem
sending out the 0x9f, I see the pl022 driver writing it to the data register,
I've added some code to the pl022 driver to print out the status register, and
the "receive FIFO not empty flag" (RNE) never goes up. In polling mode it'll
eventually time out and I'll get to a prompt (to reflash and reboot). In
interrupt mode I'd have to yank the power, boot to a different image, flash
from there, and reboot. So polling mode make the build/flash/reboot cycle
faster :-)

> I made zero default on both in
> commit 413c601e8fd0e4adab67e0775dd84e63be6d803e
> "spi: pl022: User more sensible defaults"
> 
> So the first one can be omitted.
> 
> > The pl-022 driver is quite aggressive about shutting off the SSP and raising
> > the chip select after a message is sent, so I modified my driver to leave the
> > SSP enabled and keeping the (active-low) chip select low (in case those were
> > affecting the reply) but there's no change.
> 
> These things should be fine. It's tested on quite a lot of systems.

Thanks, good to know.

Best regards,
	Trevor
