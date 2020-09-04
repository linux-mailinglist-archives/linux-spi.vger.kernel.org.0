Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2AE25DE08
	for <lists+linux-spi@lfdr.de>; Fri,  4 Sep 2020 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIDPnA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Sep 2020 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgIDPmv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Sep 2020 11:42:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4284C061244;
        Fri,  4 Sep 2020 08:42:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b19so8453326lji.11;
        Fri, 04 Sep 2020 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yiryn+cueMpZ9rgxKt1g+WZ6OWiHzbsq73ksEtl7T5Q=;
        b=RbiZjmqF79ncHO10ryXSsRXUA1u3CEqE4416UFJL3OmBUtaZSBqjMNZTuhN1LenC3u
         yypX9dKwxO+CVE5FDt08lEUCWf1/fOl+8PzxCMHpwg+Qbdbl+a3m5+yC792XM5T6xfoC
         Xe+noOAbZ51OoRLtBFa379OLu4kmFZz17xrQ7KuuHpGL0RuiNlsvw1Do3Tdl0X1NnF4Z
         K5fMDzFaOyK4FmEWmcnCKKBINnIBMxuGPp2wbcTZT3j60zcBWd3jjxxCmFSRkOZc2rgM
         +7RMuYQbun9ywUNkALSqpTsZjgbGm5BCF5e3JBzXgt987y1U06hJC97sq3ediisSTlUr
         B/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yiryn+cueMpZ9rgxKt1g+WZ6OWiHzbsq73ksEtl7T5Q=;
        b=NHk+bWoUaNZm70p4V5q3MHxLVWlN47KbaNSYEd9ZVLGBZVxx9c4J+5pC9yvXnwKmff
         bZwR8XcqKdlEWYhIKgN+dh+owGcJFNIlJNAu+7AwdSr58o8am9S9ZR0K96uEGg898Bev
         PG29XTQ0uJTjdN0dp6q1L/FVQrryp3gPFDTVutV3hyB7It6n+uPvoqMfcR5HHrf1Idsg
         PD+W6GlRC807jH/RD/ZcOrEV2p4GsKuqGy5kOu+SoYgWlNt2AoVOCzExfCvThr7Q0lDg
         Np3LzrcH1Zdvv62iN76nKJp3uJGJxAEMhcVyHvz/DcGvaYPVmjxArEt1foUivBF6AyBr
         hMOw==
X-Gm-Message-State: AOAM533G5mA5SkL/nejgmPkMoSOvzX/CyBNVHIhzJOJO4QDq+bUnuNUU
        cO8jdlH2gnIZkO+pi0VLj1lx3zFQGk7I1X7eREqgwkth30I=
X-Google-Smtp-Source: ABdhPJyWeGqQVaIc+VLOaxxe98ywP1hMqh2t9ALDWj8r1ymvnSb+cCVjXnoTCEzHbIBktmr7RMlGGBtXHW+9X3LyZvo=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr4326904ljb.452.1599234169093;
 Fri, 04 Sep 2020 08:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
 <e1431dd2653dbffdfec39a2e7167db07836e30ac.camel@ew.tq-group.com>
 <CAOMZO5C7yyA11EOQvU0Fq-uDd5RK-B7WmbtvAy8OtPzfThYXRg@mail.gmail.com>
 <f753882996235439b9ef53747d24382e896dc4e7.camel@ew.tq-group.com> <20200904150450.GG4625@sirena.org.uk>
In-Reply-To: <20200904150450.GG4625@sirena.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 4 Sep 2020 12:42:37 -0300
Message-ID: <CAOMZO5DNE9dEqXMN3SkB2Xr_BZ2iFM=LJit0hp1sBCb8Htvr1g@mail.gmail.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH] spi-imx: remove num-cs support, set
 num_chipselect to 4
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Fri, Sep 4, 2020 at 12:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Sep 04, 2020 at 04:34:43PM +0200, Matthias Schiffer wrote:
>
> > Nevertheless, I don't see why we should deliberately remove the native
> > CS support - my understanding was that we try to avoid breaking changes
> > to DT interpretation even for unknown/out-of-tree DTS.
>
> Yes, we should try to maintain compatibility for anyone that was using
> it.

We are not breaking compatibility.

Prior to 8cdcd8aeee281 ("spi: imx/fsl-lpspi: Convert to GPIO
descriptors")  num_chipselect was 1 for all device tree users.
i.MX board files will be removed, so we don't need to worry about them.

What will cause breakage is to say that the driver supports the native
chip-select.

I have just done a quick test on an imx6q-sabresd.

With the original dts that uses cs-gpios the SPI NOR is correctly probed:

[    5.402627] spi-nor spi0.0: m25p32 (4096 Kbytes)

However, using native chip select with this dts change:

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -189,7 +189,6 @@
 };

 &ecspi1 {
-       cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_ecspi1>;
        status = "okay";
@@ -506,7 +505,7 @@
                                MX6QDL_PAD_KEY_COL1__ECSPI1_MISO        0x100b1
                                MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI        0x100b1
                                MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK        0x100b1
-                               MX6QDL_PAD_KEY_ROW1__GPIO4_IO09         0x1b0b0
+                               MX6QDL_PAD_KEY_ROW1__ECSPI1_SS0         0x1b0b0
                        >;
                };

Causes SPI NOR probe to fail:

[    5.388704] spi-nor spi0.0: unrecognized JEDEC id bytes: 00 00 00 00 00 00

That's why I prefer we do not advertise that we can use the native
chip-select with this driver.
