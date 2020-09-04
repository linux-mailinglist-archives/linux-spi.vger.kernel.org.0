Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138FE25D94B
	for <lists+linux-spi@lfdr.de>; Fri,  4 Sep 2020 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgIDNLN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Sep 2020 09:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbgIDNLI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Sep 2020 09:11:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5EB206F2;
        Fri,  4 Sep 2020 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599225056;
        bh=o3vMmFMOelqR+HH3uQoaVBSBJla+WpWFuQVl0HAoJzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fcrm5zp3fjfm3ezecfHz0/BxJh+6KrON8w4iogR/LIm5cX+b59hQp4kMYPUbF3r9m
         5kz16y5JsSfugIS/FunM7+d8/EWPWDseL2nKvNvoPCa0/z9fySiACSE9urN3kLstfo
         pDXwPJdkQqNHhggHqXT5koIk8oaYWupKAeXMjdmo=
Date:   Fri, 4 Sep 2020 14:10:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi-imx: remove num-cs support, set num_chipselect to 4
Message-ID: <20200904131014.GF4625@sirena.org.uk>
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
X-Cookie: Heisenberg might have been here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2020 at 09:35:38AM -0300, Fabio Estevam wrote:
> On Thu, Sep 3, 2020 at 11:40 AM Matthias Schiffer

> > +       master->num_chipselect = 4;

> On an imx6q-sabresd, which only has one SPI chip-select via GPIO, this
> makes the SPI core to understand that it has 4 chip selects.

We shouldn't do anything with the extra chip selects though?

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9SPLYACgkQJNaLcl1U
h9CPVwf/Ql3lZK0EZhriIHFw8zQwmBJXZnBrY0W0xOBNDnpj+9GPY6G9G4uh3bVu
v65omDnMgdTgvIZRJmgbMvZPWsU8BXVzHVyZhIVKrgcWTp3x3p4OKJ6Gz5iTipxZ
jlHq/whlCBURzx0kKx62hxwB2c6YIk3WKET9KtMNsEr84RadH9E4y5UNW5n0gVvp
uDu+f6WLsLfJAiylY1pKKrVQS7JDU0cz8PwEUpZQkSKe91NJ9vxbpq0BfdS7hXBP
84XGcQ8k2m8sLQpRtLBdGZ48VKgXhB4sF+RYNCwPhKsIFPv6N2aRkRbtwMjw1e4F
c5SBuVDahtEqM3OHe22bScmJ9La20g==
=Oyxe
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
