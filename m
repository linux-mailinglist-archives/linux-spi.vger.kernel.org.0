Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D064EB156
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiC2QIU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiC2QH4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 12:07:56 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754BE97BB4
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 09:06:13 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2e68c95e0f9so189251667b3.0
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkwu5nMt5lyABdN42XmXBThrITVPhMffDtFl7/j3P4c=;
        b=eGMtBivog064mr0p/kYZ/v3hn+soYTTsCw4+G8/dtn+TqQPTA7YcCx8yCSX04dip6G
         TgcF698xC8W4Auzek1u9v24hT6X/qt24thsTk6shN3Np+18OaGrx6GPm4/LVJs9rdPGU
         BZSJIt4YadFFsh0GawtyCjAliNY9k04f+W0oQvuYPBDIQzfmyaNkx6QOvjR7Fbw3Y7XI
         T9B2sXxXE16/u3o494g0tWJLsp9KRq25i6nTAkWWMSVhWavM+38k3mjios/o5zSQuRrU
         OMLA+brp1LQh2Qa2qYUHHdlm6Z3vfLee8rnbtaH7zuVW4TTv+4kWKEl8B4Yc+NU8P5e6
         5ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkwu5nMt5lyABdN42XmXBThrITVPhMffDtFl7/j3P4c=;
        b=JGEfu/uorfz5Y89eGOUyHSKvcsGuxtOIdaYQ8lkWbdqCeZoM8xBE6wa+L0lTkYO5Er
         Fg2G9yE9FoBcLB14r6Id7FvWEPLOtCyE8ErQcG+LBQZxoc/cqaC4aWuWL5waPWeQv1zl
         Wh26y7qsxK7maIaxRRq0YaXDSY0rYDAuZ6WE648itWlA2s+quob8wlReM7DJzjnzFuVj
         pnM+j31KIw9X78aqHvCp82//j4syLtHwTDG4Suq5MOZLqE50IC2952/DenPv0r9hpwvH
         Txozu7mcJ6AH7oW5IiX9z5v88+avAdd8LNQC/+zC9LsoMb8OK2c9+GMw258MsheZwW7d
         q4cg==
X-Gm-Message-State: AOAM530J+e/h25ielzAi8djI3OhiSdIRcSnJWZCi1YpQFdEjU3kYAct7
        K/y5SvkyM65+Yzlv/HgeDyh231Uy6RiVXm+1wvKQJ3P2ERNKeg==
X-Google-Smtp-Source: ABdhPJw/3vGN6XhCkkomus3xyfNmhdLN5HKweehSUR59hS/3JOxK3Cg2RX+fQK3gjZVYbeYP+skdSrtcoD5SDFjtxA0=
X-Received: by 2002:a81:5706:0:b0:2e5:c451:b257 with SMTP id
 l6-20020a815706000000b002e5c451b257mr32707185ywb.126.1648569972545; Tue, 29
 Mar 2022 09:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220328190104.GA11946@localhost>
In-Reply-To: <20220328190104.GA11946@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Mar 2022 18:06:01 +0200
Message-ID: <CACRpkdY2ynzAyQz3q2gHnZMA+Opr-b=w=dA4YMqH=i0Rv+OYcg@mail.gmail.com>
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

On Mon, Mar 28, 2022 at 9:01 PM Trevor Woerner <twoerner@gmail.com> wrote:

> I'm wondering if anyone is successfully using the current spi-pl022 driver to
> interact with an SPI device (preferably on a lpc32xx-based machine)?

I'm using it in with the Cypress CY8CTMA340 touchscreen in
arch/arm/boot/dts/ste-href-tvk1281618-r3.dtsi
like this:

              spi@80111000 {
                        compatible = "arm,pl022", "arm,primecell";
                        reg = <0x80111000 0x1000>;
                        interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
                        #address-cells = <1>;
                        #size-cells = <0>;

                        /* Same clock wired to kernel and pclk */
                        clocks = <&prcc_pclk 2 1>, <&prcc_pclk 2 1>;
                        clock-names = "sspclk", "apb_pclk";
                        dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
                               <&dma 33 0 0x0>; /* Logical - MemToDev */
                        dma-names = "rx", "tx";
                        power-domains = <&pm_domains DOMAIN_VAPE>;
                        num-cs = <1>;
                        cs-gpios = <&gpio6 24 GPIO_ACTIVE_LOW>;
                        pinctrl-names = "default";
                        pinctrl-0 = <&spi2_default_mode>;

                        touchscreen@0 {
                                compatible = "cypress,cy8ctma340";
                                /*
                                 * Actually the max frequency is 6
MHz, but over 2 MHz the
                                 * data rate needs to be restricted to
max 2Mbps which the
                                 * SPI framework cannot handle.
                                 */
                                spi-max-frequency = <2000000>;
                                reg = <0>;
                                interrupt-parent = <&gpio2>;
                                interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
                                vcpin-supply = <&ab8500_ldo_aux1_reg>;
                                vdd-supply = <&db8500_vsmps2_reg>;
                                reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
                                touchscreen-size-x = <480>;
                                touchscreen-size-y = <854>;
                                active-interval-ms = <0>;
                                touch-timeout-ms = <255>;
                                lowpower-interval-ms = <10>;
                                bootloader-key = /bits/ 8 <0x00 0x01
0x02 0x03 0x04 0x05 0x06 0x07>;
                                pinctrl-names = "default";
                                pinctrl-0 = <&cyttsp_tvk_mode>;
                        };
                };

It works just fine with DMA and all.

> I've spent the better part of the last week poking at this. I've tried many
> combinations of device tree, but what I think should work is:
>
>         &ssp0 {
>                 status = "okay";

The main definition of the SSP is elsewhere in the node with ssp0:, so I
have no idea how this is configured really.

>                 num-cs = <1>;
>                 cs-gpios = <&gpio 3 4 1>;

Use #include <dt-bindings/gpio/gpio.h> and GPIO_ACTIVE_LOW
for the flag so it gets readable.

>                 m25p16@0 {
>                         compatible = "jedec,spi-nor";
>                         reg = <0>;
>                         spi-max-frequency = <500000>;
>
>                         pl022,interface = <0>;
>                         pl022,com-mode = <1>;

com-mode 1 (polling) really? Why? Are interrupts broken
on your silicon?

I made zero default on both in
commit 413c601e8fd0e4adab67e0775dd84e63be6d803e
"spi: pl022: User more sensible defaults"

So the first one can be omitted.

> The pl-022 driver is quite aggressive about shutting off the SSP and raising
> the chip select after a message is sent, so I modified my driver to leave the
> SSP enabled and keeping the (active-low) chip select low (in case those were
> affecting the reply) but there's no change.

These things should be fine. It's tested on quite a lot of systems.

Yours,
Linus Walleij
