Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8941872D7
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 19:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbgCPS5p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 14:57:45 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:49872 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732353AbgCPS5o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 14:57:44 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A800C804DA;
        Mon, 16 Mar 2020 19:57:34 +0100 (CET)
Date:   Mon, 16 Mar 2020 19:57:33 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mark Brown <broonie@kernel.org>
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
Subject: Re: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as
 SPI slaves
Message-ID: <20200316185733.GA18307@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
 <20200316120239.GC5010@sirena.org.uk>
 <20200316132844.GA22822@ravnborg.org>
 <20200316163538.GJ5010@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316163538.GJ5010@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=lAQgYEA6ThzcfdfRarEA:9 a=CjuIK1q_8ugA:10
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark.

On Mon, Mar 16, 2020 at 04:35:38PM +0000, Mark Brown wrote:
> On Mon, Mar 16, 2020 at 02:28:44PM +0100, Sam Ravnborg wrote:
> > On Mon, Mar 16, 2020 at 12:02:41PM +0000, Mark Brown wrote:
> > > On Sun, Mar 15, 2020 at 02:43:42PM +0100, Sam Ravnborg wrote:
> 
> > > > Independent bindings can be SPI slaves which for example is
> > > > the case for several panel bindings.
> 
> > > What is an "independent binding"?
> 
> > For several panels we have device trees that looks like this:
> 
> So what you're trying to do is define a generic class for SPI slaves
> which are just normal children of SPI nodes?  I really can't get to
> there from your changelog so we need some work there - in particular
> "non-spi bindings" is *very* confusing as as far as I can see these are
> bindings for SPI devices.
> 
> > The bindings are child of the spi controller node, but not specified
> > in the same binding file as the spi controller node.
> 
> Of course not, this how all buses work isn't it?
> 
> > So SPI slaves can now reference spi-slave.yaml to get access to
> > the SPI slave properties - and the copies can be avoided.
> > Likewise spi-controller.yml now references spi-slave.yaml.
> 
> > This was the best way I saw it could be done.
> 
> Rob didn't do the binding conversion but he did review it - I'm a bit
> surprised that there's issues here?

For panels we have panel-common.yaml that list all the
typical properties used by a panel - so the individual
panel bindings shall not repeat them.
This is also aligned with the principle of re-using properties rather
than inventing new properties all over.

And with a number of bindings describing HW that is SPI slaves
the idea is to do something like we do for panels.

I look forward for Rob's feedback - but as he is on vacation this week
we may have to wait a week for that.

The simple way forward had been to do like we do in many other places
and include a few SPI properties and be done with it.
This is an attempt to do something better.
If there is push-back or a nack, then we can always do like we do in
other places and just duplicate the properties.

> Also shouldn't there be some constraint that these devices have to be
> the child of a SPI controller or something?  Just including a file
> doesn't look right for something like class definition.

It was the best I could come up with - and this patch was called out
for review in the hope there is a better way than this patch.

We have similar examples like:
  - pincfg-node.yaml
  - regulatro.yaml
  - dma-common.yaml

They are not exactly 1:1 to what we do with spi-slave.yaml, but they
served as inspiration.

	Sam
