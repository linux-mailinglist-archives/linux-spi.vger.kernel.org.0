Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3221879D2
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 07:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgCQGqI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 02:46:08 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:34632 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgCQGqI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 02:46:08 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4CE492003F;
        Tue, 17 Mar 2020 07:46:00 +0100 (CET)
Date:   Tue, 17 Mar 2020 07:45:58 +0100
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
Message-ID: <20200317064558.GA30986@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-36-sam@ravnborg.org>
 <a73da9d3-43b2-3ce7-85e9-8135dbf48e98@ti.com>
 <20200316082607.GA18510@ravnborg.org>
 <a634d733-4b88-9d5a-09a1-c9551d8a077a@ti.com>
 <20200316085311.GA19201@ravnborg.org>
 <3bf96f0e-90a8-1513-800f-0168d912fd9f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf96f0e-90a8-1513-800f-0168d912fd9f@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=CgtwdvIipyfznNzOMf0A:9 a=CjuIK1q_8ugA:10
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tomi.

On Mon, Mar 16, 2020 at 11:11:15AM +0200, Tomi Valkeinen wrote:
> On 16/03/2020 10:53, Sam Ravnborg wrote:
> 
> > We have panel-simple-dsi for DSI simple based panels.
> > This binding includes the reg property.
> > 
> > If we have included DSI panels in panel-simple.yaml, and we likely have
> > by accident, then they should be moved to panel-simple-dsi.yaml.
> > 

> panel-simple.c has dsi_of_match, which lists DSI panels. I was looking at
> that when I said panel-simple binding has DSI panels. At least auo,b080uan01
> and osddisplays,osd101t2045-53ts are there, and earlier in this series you
> moved osddisplays,osd101t2587-53ts to panel-simple bindings.

I will clean this up as part of v2.
Thanks.

	Sam
