Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670A028E05D
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 14:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJNMPX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 08:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgJNMPX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Oct 2020 08:15:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2EA20848;
        Wed, 14 Oct 2020 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602677722;
        bh=yETVNI5s7LYmlp9L289M/LmjigeEclC9l6plIX3ewg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYKsQmwwFkCy7VY2LDKEhsHW8x5OtAUYuZvjZALD9q3+lm4fl6J8H4b1YOZLAG7o2
         OmdyO5CWadhNwMdGcjQtXvsk10LlB0TdqbGpGffBjFUpk4xQhLczWh7z+PBYqX1urX
         a5pyJJGXQNx8kVFrxrbpdbCFcJTAnVdC9XziMrmM=
Date:   Wed, 14 Oct 2020 13:15:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Christian Eggers <ceggers@arri.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Message-ID: <20201014121516.GB4580@sirena.org.uk>
References: <20201009042738.26602-1-ceggers@arri.de>
 <20201009073944.GA11648@pengutronix.de>
 <6367849.hfWVFoRi9M@n95hx1g2>
 <20201012140753.GF12463@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20201012140753.GF12463@pengutronix.de>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 04:07:53PM +0200, Sascha Hauer wrote:

> > can also try to fix it myself, but this will take until next week.
>=20
> Here we go. The patch basically works, but I am also not very confident
> with pm_runtime, so please have a close look ;)

Sasha could you post this patch normally please - none of my automation
can cope with things buried in the middle of other e-mails?

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+G69MACgkQJNaLcl1U
h9AtVgf/bZSnQWy8dbbKKPW8PEzdSynLrKVisREqH2SZ+hjHZmNnBKGG7gamIMUy
IVnWXmW4ehMvWkObA89RvCQ/+VxlKX0o4/QDdsLOIGL1BXrIbbdt5YzCaIn28jUQ
eB1vwjIT39PNfwblH+S70uerj1Jk2ZXpV3oySGhZZ2uyLdZdTKYSEBT4Rs/SJCXf
mkJBiQN45oFSLiOw/o+mdvTqgErl8Qzrt3YW9+FrisSNkHw3bRF1UowEpVMP50de
J2dSitH+rIwYvJgqALJLZPvNfYQflJ8wxXrJdu8MahCPdpSmDymja3rY2wNCeN9g
POeXmi4qHR3B7E584a6hRd4aPWiTow==
=hDhv
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
