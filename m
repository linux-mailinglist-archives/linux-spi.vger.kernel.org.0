Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59B1873DA
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 21:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbgCPUOL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 16:14:11 -0400
Received: from foss.arm.com ([217.140.110.172]:56604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732486AbgCPUOL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Mar 2020 16:14:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D1E1FB;
        Mon, 16 Mar 2020 13:14:10 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7A5C3F52E;
        Mon, 16 Mar 2020 13:14:09 -0700 (PDT)
Date:   Mon, 16 Mar 2020 20:14:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
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
Message-ID: <20200316201408.GK5010@sirena.org.uk>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
 <20200316120239.GC5010@sirena.org.uk>
 <20200316132844.GA22822@ravnborg.org>
 <20200316163538.GJ5010@sirena.org.uk>
 <20200316185733.GA18307@ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
Content-Disposition: inline
In-Reply-To: <20200316185733.GA18307@ravnborg.org>
X-Cookie: I thought YOU silenced the guard!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2020 at 07:57:33PM +0100, Sam Ravnborg wrote:

> It was the best I could come up with - and this patch was called out
> for review in the hope there is a better way than this patch.

It definitely seems like a useful thing, just a bit surprised it's not
already there and if this is the best way to do it.

> We have similar examples like:
>   - pincfg-node.yaml
>   - regulatro.yaml

I'm curious what properties your consumers have for regulators - I'd
expect them to just have simple pointers to the regualtors with no
configuration.

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5v3g8ACgkQJNaLcl1U
h9CQ3gf/ckkj/FyMuU25wpmw52sUNJySLmtRn6yJPOc2AMPbRhW2r1LrNNzxczyh
THPGUrBiVpjZ6eXQy9R+zAOFmQXHPpR2dErQ8z5M+/PH1oxwwcztLW5RXcVXbyBW
QP2qJ+sXzqYQIp1aRXEgD5Nt/ePqsLUvgkYj7SpG5Txx5hRQiesNzVovCJeaBAU6
CtYsvXOAfFvWhL9qNX5P9y+ULs+db7xySoOz/5wOK+e2TlWkOjTNlH5wtvY3D6oO
zS6VHPjaCy/wCfjjXUZhXbGRb+M2ZF3bwMD5dJ6Dw2rjFUXwa33L6BhpgAcTdP/P
QxPkPAvZsQX/9DwEs48aA5CckvRVKQ==
=VIU6
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
