Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E37251FE
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfEUO3c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 10:29:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34209 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfEUO3c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 10:29:32 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4347A60003;
        Tue, 21 May 2019 14:29:26 +0000 (UTC)
Date:   Tue, 21 May 2019 16:29:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ARM: dts: sun6i: Add default address and size
 cells for SPI
Message-ID: <20190521142925.bryspvr7gtits5yl@flea>
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
 <622e3d2ece14e5b84a7975026bb1a981228ee3ab.1558363790.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hidp36y4x4lmbvra"
Content-Disposition: inline
In-Reply-To: <622e3d2ece14e5b84a7975026bb1a981228ee3ab.1558363790.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hidp36y4x4lmbvra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 04:50:36PM +0200, Maxime Ripard wrote:
> The SPI controller bindings require an address cell size of 1, and a size
> cell size of 0. Let's put it at the DTSI level to make sure that's properly
> enforced.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied for 5.3

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hidp36y4x4lmbvra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOQLRQAKCRDj7w1vZxhR
xa4tAP90agmm4bwpSelFojJE/k2pi16ny4VH2dp4uVgB35fCdAD/WErlps7dg9uQ
517cMenZoCTA7hr+o7V2P9I/TKr9cQs=
=7tJA
-----END PGP SIGNATURE-----

--hidp36y4x4lmbvra--
