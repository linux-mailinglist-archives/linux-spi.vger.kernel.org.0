Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0F186C06
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 14:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgCPN26 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 09:28:58 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:49460 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgCPN26 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 09:28:58 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1788080475;
        Mon, 16 Mar 2020 14:28:46 +0100 (CET)
Date:   Mon, 16 Mar 2020 14:28:44 +0100
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
Message-ID: <20200316132844.GA22822@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
 <20200316120239.GC5010@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316120239.GC5010@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=vD5-ug2-evzQM-DbIjUA:9 a=CjuIK1q_8ugA:10
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark.

On Mon, Mar 16, 2020 at 12:02:41PM +0000, Mark Brown wrote:
> On Sun, Mar 15, 2020 at 02:43:42PM +0100, Sam Ravnborg wrote:
> 
> > Independent bindings can be SPI slaves which for example is
> > the case for several panel bindings.
> 
> What is an "independent binding"?

For several panels we have device trees that looks like this:

spi {
    #address-cells = <1>;
    #size-cells = <0>;

    panel@0 {
        compatible = "kingdisplay,kd035g6-54nt";
        reg = <0>;

        spi-max-frequency = <3125000>;
        spi-3wire;
        spi-cs-high;
	...


The bindings are child of the spi controller node, but not specified
in the same binding file as the spi controller node.

A lot of bindings repeats the descriptions of (some of) the
pi-slave properties.
To avoid introducing yet another set of redundant and maybe incomplete
SPI slave property descriptions I moved the relevant properties
from spi-controller.yaml to spi-slave.yaml.

So SPI slaves can now reference spi-slave.yaml to get access to
the SPI slave properties - and the copies can be avoided.
Likewise spi-controller.yml now references spi-slave.yaml.

This was the best way I saw it could be done.

This approach is used in several bindings in this patch set.

	Sam
