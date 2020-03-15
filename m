Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94649185F94
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 20:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgCOTZE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 15:25:04 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:35604 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgCOTZD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 15:25:03 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 92E482003A;
        Sun, 15 Mar 2020 20:24:53 +0100 (CET)
Date:   Sun, 15 Mar 2020 20:24:52 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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
        linux-spi <linux-spi@vger.kernel.org>,
        Marco Franchi <marco.franchi@nxp.com>,
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
Subject: Re: [PATCH v1 06/36] dt-bindings: display: convert ilitek,ili9322 to
 DT Schema
Message-ID: <20200315192452.GA29182@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-7-sam@ravnborg.org>
 <CACRpkdYVrTBKxuHSGpd9=03oD4=JVxzJf8fOcQ8uu5eRt9PgAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYVrTBKxuHSGpd9=03oD4=JVxzJf8fOcQ8uu5eRt9PgAg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=WN0NcwN0bJFRE13tjSgA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=cvBusfyB2V15izCimMoJ:22
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Linus.

On Sun, Mar 15, 2020 at 07:54:38PM +0100, Linus Walleij wrote:
> On Sun, Mar 15, 2020 at 2:44 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > The .txt binding explains:
> >
> > "
> >     The following optional properties only apply to
> >     RGB and YUV input modes and
> >     can be omitted for BT.656 input modes:
> > "
> >
> > This constraint is not implmented in the DT Schema.
> >
> > The original binding from the .txt file referenced
> > properties that is included in panel-timing.yaml.
> > These properties are kept here as we want as close to a 1:1
> > conversion as we can. If the properties should be dropped
> > from the binding then this is a follow-up patch.
> >
> > The properties in question are:
> >   - pixelclk-active
> >   - de-active
> >   - hsync-active
> >   - vsync-active
> 
> Sorry about that. They should be dropped, but certainly it
> is fine to do with a follow up patch.

I changed my mind - lets try to avoid too many patches.
So if you do not mind I will do it in this patch - and note it in the
changelog.

	Sam

> 
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
