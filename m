Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62C186662
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 09:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgCPI0V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 04:26:21 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:41546 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPI0V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 04:26:21 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 42BBB2002E;
        Mon, 16 Mar 2020 09:26:08 +0100 (CET)
Date:   Mon, 16 Mar 2020 09:26:07 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
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
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: Re: [PATCH v1 35/36] dt-bindings: display: convert
 lgphilips,lb035q02 to DT Schema
Message-ID: <20200316082607.GA18510@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-36-sam@ravnborg.org>
 <a73da9d3-43b2-3ce7-85e9-8135dbf48e98@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a73da9d3-43b2-3ce7-85e9-8135dbf48e98@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=sozttTNsAAAA:8 a=pGLkceISAAAA:8 a=IAW4dMXMqXHR358p9ncA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=aeg5Gbbo78KNqacMgKqU:22
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tomi.

Thanks for your feedback.

On Mon, Mar 16, 2020 at 09:57:57AM +0200, Tomi Valkeinen wrote:
> Hi Sam,
> 
> On 15/03/2020 15:44, Sam Ravnborg wrote:
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > ---
> >   .../display/panel/lgphilips,lb035q02.txt      | 33 ------------
> >   .../display/panel/lgphilips,lb035q02.yaml     | 54 +++++++++++++++++++
> >   2 files changed, 54 insertions(+), 33 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
> >   create mode 100644 Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
> > deleted file mode 100644
> > index 1a1e653e5407..000000000000
> > --- a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -LG.Philips LB035Q02 Panel
> > -=========================
> > -
> > -Required properties:
> > -- compatible: "lgphilips,lb035q02"
> > -- enable-gpios: panel enable gpio
> > -
> > -Optional properties:
> > -- label: a symbolic name for the panel
> > -
> > -Required nodes:
> > -- Video port for DPI input
> 
> Isn't this also compatible with panel-simple bindings? 'label' is the only
> one not in panel-simple, but that's optional and has never been used by the
> panel driver.
The panel is a SPI slave - which is not too obvious from the old
binding.

The new DT Schema includes spi/spi-slave.yaml to give the binding
proper access to the spi slave properties.

That would not be possible with panel-simple binding as no further
properties are allowed with the panel-simple binding.

I hope this explains why there is a dedicated binding for this panel.

	Sam
