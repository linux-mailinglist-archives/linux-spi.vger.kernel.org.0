Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0826196F98
	for <lists+linux-spi@lfdr.de>; Sun, 29 Mar 2020 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgC2TEE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Mar 2020 15:04:04 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:57418 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC2TEE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Mar 2020 15:04:04 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D9D85804FC;
        Sun, 29 Mar 2020 21:03:53 +0200 (CEST)
Date:   Sun, 29 Mar 2020 21:03:52 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
        Marek Belisko <marek@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Peter Rosin <peda@axentia.se>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: Re: [PATCH v1 32/36] dt-bindings: display: convert sharp,ls037v7dw01
 to DT Schema
Message-ID: <20200329190352.GA21479@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-33-sam@ravnborg.org>
 <20200319030734.GH29911@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319030734.GH29911@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=8lPrDCVDlfZqt0RlNdoA:9 a=CjuIK1q_8ugA:10
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob.

> > +
> > +  mode-gpios:
> > +    description: |
> > +      GPIO ordered MO, LR, and UD as specified in LS037V7DW01.pdf
> 
> 3 or...
> 
> > +      change configuration between QVGA and VGA mode and the
> > +      scan direction. As these pins can be also configured
> > +      with external pulls, all the GPIOs are considered
> > +      optional with holes in the array.
> 
> minItems: 3
> maxItems: 5

This binding can specify up to three GPIOs like this:


> > +        mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH        /* gpio154, lcd MO */
> > +                      &gpio1 2 GPIO_ACTIVE_HIGH         /* gpio2, lcd LR */
> > +                      &gpio1 3 GPIO_ACTIVE_HIGH>;       /* gpio3, lcd UD */

They are in the linux kernel driver accessed like this:

    devm_gpiod_get_index(&pdev->dev, "mode", 2, GPIOD_OUT_LOW);

The following is OK in the DT file:

    mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>;

    mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH
                  &gpio1 2 GPIO_ACTIVE_HIGH>;
		  
    mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH
                  &gpio1 2 GPIO_ACTIVE_HIGH
                  &gpio1 3 GPIO_ACTIVE_HIGH>;

But the following is not OK:
    mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>, <&gpio1 2 GPIO_ACTIVE_HIGH>;

Any hints how to specify the binding to prevent the above?
I have tried a few combinations - but they do not catch this.
So my binding attempts are not restrictive enough.

Any hints how to describe this properly?

	Sam
