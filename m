Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB92186703
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgCPIxU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 04:53:20 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43946 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbgCPIxT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 04:53:19 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A42282002E;
        Mon, 16 Mar 2020 09:53:12 +0100 (CET)
Date:   Mon, 16 Mar 2020 09:53:11 +0100
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
Message-ID: <20200316085311.GA19201@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-36-sam@ravnborg.org>
 <a73da9d3-43b2-3ce7-85e9-8135dbf48e98@ti.com>
 <20200316082607.GA18510@ravnborg.org>
 <a634d733-4b88-9d5a-09a1-c9551d8a077a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a634d733-4b88-9d5a-09a1-c9551d8a077a@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=nj24DLa8QVhGY9zhrUcA:9 a=CjuIK1q_8ugA:10
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tomi.

On Mon, Mar 16, 2020 at 10:42:45AM +0200, Tomi Valkeinen wrote:
> On 16/03/2020 10:26, Sam Ravnborg wrote:
> 
> > > Isn't this also compatible with panel-simple bindings? 'label' is the only
> > > one not in panel-simple, but that's optional and has never been used by the
> > > panel driver.
> > The panel is a SPI slave - which is not too obvious from the old
> > binding.
> > 
> > The new DT Schema includes spi/spi-slave.yaml to give the binding
> > proper access to the spi slave properties.
> > 
> > That would not be possible with panel-simple binding as no further
> > properties are allowed with the panel-simple binding.
> > 
> > I hope this explains why there is a dedicated binding for this panel.
> 
> Hmm, but how is this different than, say, DSI panels? There are DSI panels
> in panel-simple bindings, and those might require DSI bus parameters ('reg'
> in the minimum).


We have panel-simple-dsi for DSI simple based panels.
This binding includes the reg property.

If we have included DSI panels in panel-simple.yaml, and we likely have
by accident, then they should be moved to panel-simple-dsi.yaml.

If they requires anything else then they shall have their
own binding.

panel-simple.yaml and panel-simple.dsi.yaml are on purpose
only for the simple panels and they have:
"additionalProperties: false" to avoid that a lot
of extra sneaks in.

I actually considered shortly a panel-simple-spi.yaml,
but the few panels I looked at had different names
for the power-supply so that did not fly.
I did not check them all - we have today (with this patch-set)
9 bindings that references spi-slave.yaml.

	Sam
