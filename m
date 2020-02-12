Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD615A8A4
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2020 13:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgBLMED (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Feb 2020 07:04:03 -0500
Received: from foss.arm.com ([217.140.110.172]:60214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgBLMED (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 Feb 2020 07:04:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D12930E;
        Wed, 12 Feb 2020 04:04:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A209D3F6CF;
        Wed, 12 Feb 2020 04:04:02 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:04:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 3/5] spi: spi-nxp-fspi: Enable the Octal Mode in MCR0
Message-ID: <20200212120401.GE4028@sirena.org.uk>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <20200202125950.1825013-3-aford173@gmail.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2020 at 06:59:48AM -0600, Adam Ford wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> Apply patch from NXP upstream repo to
> Enable the octal combination mode in MCR0

Why?

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D6bAACgkQJNaLcl1U
h9CgIwf/ezMdwaoI7eWJb0kxbrsXR4Iu1+k+a35+9ByMGx1XZCagF3G3bVKNnLpf
0SaPpCaTClK59wSe0U2dOhAl2RPWPALmBIbtkNZBBQ1PNCi9OLoE73wdIvYQG7sD
aODE6m2N3Cx35vwzIPiZi3q69DUmemTm06FUhLA6rJCS8p5tbb2fPl+uA0RHiesY
zI/4Zzc+0p0c4I0OA18OeqJ7bOXkxnI1rlsO/rKXl678EHczD/dcM2nDO9dgt2sW
G2dKA26ZoqVHwhy3RLiumLJBUztzC0+ct3UN5pgwcb8xfvm7fQPIalWj/M+v1Vri
L0bPRl9ffdKp87t3H8yGyH2nzS50Iw==
=rjjn
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
