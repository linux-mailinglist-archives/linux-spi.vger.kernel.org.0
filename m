Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22134EB611
	for <lists+linux-spi@lfdr.de>; Wed, 30 Mar 2022 00:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiC2Wfy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 18:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiC2Wfx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 18:35:53 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E4FEBB9B
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 15:34:10 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id b18so16612588qtk.13
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kyN4GwHGaogj8na818epj0OLS952lM/GXoCU3XjhgP0=;
        b=FWTjqsZJsWWQZidf1W0RCQ4P207LUxqwI7xbr/TtuWsnFAODf0QFMG1mRKJqot/A7K
         UG8e2K0PH88ajL2umQeIReYAWGfHSsUrJGhdsMg27VWt4ihniBBW7kfMxe9OrmCbszOC
         t07sXmBqOgESvbcIxU/7CgUnE5ufvYa2VKo3/EZIRBbvBi+HLc57Sdldl18YlX0whn4+
         Onnqh0nBX/XR5mY36j7H/B5goJV6dSLXMP7e/Bn4nj1Rt3PJuzMiW7x2fGc2i7QH9Wsw
         V9aNOmeTfXbCnelR1nMHOerZN6E94wZxooe0/I7eGWOOw4BewfiPYa5vYWeCzFfScwWv
         dCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kyN4GwHGaogj8na818epj0OLS952lM/GXoCU3XjhgP0=;
        b=TaI1hKFoXWgtDpdKDj0BwEFjwev8qPAQiN7vF/R7v1fI5FoLYpexuMnW5r/hzieOHx
         ekKQYcM2opPFU8LH0Kt58d4UXb+zKJrzMKsOhbfysRqzfvTGdafb6Txc2WqBUg/I0RXC
         ai/P/hMUG8uKK78icJjKu038ZkpiiLxLoFRroKOgHLCxUBLzrjqUfXZqlbGGzvfR+Cyh
         lWbuSVDMnsjMoBqX6oQ9U3aXE7UhL4Su34cL77POZ9ioS1ILtZzutvvNpmr9r+6eHmKE
         J1T0dsLsta3LPJskDlMdcNBPdkYSZo8zQfN/SirN7u8biogDLsjHd/c8EwwOD1qTB5+G
         uSvw==
X-Gm-Message-State: AOAM531kFqyJrW026z33U2eiKqamJWqVdi7jb80F4fnc67tJJnCQzJgT
        FevivKsDioqzWHPOP2K8BL4rVF8+aew=
X-Google-Smtp-Source: ABdhPJzHr8UXnXzuxF4IDIpCv23SiiWfk1JAH39v2bXt8l9rpoyivUlBQkVxaBq/drizQRT+3xjHuA==
X-Received: by 2002:a05:622a:1a0b:b0:2e1:b574:f50b with SMTP id f11-20020a05622a1a0b00b002e1b574f50bmr30602741qtb.156.1648593249227;
        Tue, 29 Mar 2022 15:34:09 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id a9-20020ac85b89000000b002e2072c9dedsm16928843qta.67.2022.03.29.15.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:34:08 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:34:06 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-spi@vger.kernel.org, linus.walleij@linaro.org,
        alexandre.belloni@bootlin.com
Subject: Re: spi-pl022 on lpc32xx
Message-ID: <20220329223406.GB22159@localhost>
References: <20220328190104.GA11946@localhost>
 <c796837e-7cd8-517f-dbd0-85ec3dbc4b86@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c796837e-7cd8-517f-dbd0-85ec3dbc4b86@mleia.com>
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

Hi Vladimir,

This is great: I've now heard from the driver's maintainer, and the 2 other
people (other than me) still using this SoC ;-)

On Tue 2022-03-29 @ 09:59:07 PM, Vladimir Zapolskiy wrote:
> FWIW on my board I do use both SSP0 and SSP1 at once, but I didn't rebase
> the dts/kernel for a long time, so the examples might be outdated:
> 
> &ssp0 {
> 	num-cs = <1>;
> 	cs-gpios = <&gpio 3 5 GPIO_ACTIVE_HIGH>; /* SSEL0 */
> 
> 	sc16is752@0 {
> 		compatible = "nxp,sc16is752";
> 		reg = <0>;
> 		spi-max-frequency = <4000000>;
> 
> 		/* 18.432 MHz external oscillator */
> 		clocks = <&xtal_18432k>;
> 
> 		/* Interrupt to GPI_07 */
> 		interrupt-parent = <&sic2>;
> 		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> 	};
> };
> 
> &ssp1 {
> 	num-cs = <1>;
> 	cs-gpios = <&gpio 3 4 GPIO_ACTIVE_HIGH>;

The chip selects of most SPI devices are active low (and the s25fl216k is
no exception), so *technically* this should probably be GPIO_ACTIVE_LOW.
Regardless, the spi-pl022 driver ignores this parameter anyway:
	https://elixir.bootlin.com/linux/v5.17.1/source/drivers/spi/spi-pl022.c#L458

> 	s25fl216k@0 {
> 		compatible = "s25fl216k", "jedec,spi-nor";
> 		reg = <0>;
> 		spi-max-frequency = <150000>;
> 		spi-cpol;
> 		spi-cpha;
> 	};
> };
> 
> Also SSP0 is enabled on PhyTec phy3250 board, there is an at25 eeprom on it,
> I've just briefly checked the device tree node, and apparently it contains
> some references/properties specific to the PL022 SPI driver.

Thanks for the report. Both you and Alexander are using SSP on this SoC
successfully, and it looks like your configurations are pretty much what I'm
using.

That means it's not the driver, and it's probably not my dts. I'm getting the
feeling that I'm being messed up by my 1st stage bootloader which is
configuring SPI and then leaving it running. I noticed that my SPI_CTRL
register is still setup with the SPI clocks running. Simply disabling the SPI
clocks on startup, however, doesn't seem to fix things. So then I started
looking at the various pinmuxing registers and noticed that nothing is setup
for SSP. The pins that are muxed for SSP are all left in their default
configurations on my device (which means they're all setup for SPI since SPI
is the default and SSP is the alternate).

Any chance either your or Alexander know what register 0x4002_8108 contains?
Maybe you have devmem2 available? Maybe you have bootloaders that are setting
up the pinmuxing for SSP mode for you?

The docs talk about how to configure SPI, and how to configure SSP. But they
don't talk about how to turn one off and enable the other (or if that's even
possible). If it's not possible for this SoC to switch between the two, then
my only option would be to write an SPI driver.

Best regards,
	Trevor
