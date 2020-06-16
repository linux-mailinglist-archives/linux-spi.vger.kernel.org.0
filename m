Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904521FBC63
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgFPRH2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgFPRH1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 13:07:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455C020B1F;
        Tue, 16 Jun 2020 17:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592327246;
        bh=t0dF5gqUwXzjgY8Hq7zWYu2xi/32wRxgBLr94n6++N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeWaa3CMea0W+DXMha2w5q/BvYwDS0MFzufsW4NHfPyCD7SgYxsiu7t8o+z8DdhRS
         WhshWRASYNuLR2pCz/NbsJx/UwnVRMjAWIxwbEAQlfd7UdgmIVmls5jW9PrAlzlfUx
         EU+TS2HtHhZzuuQgAt09iaQSRE4q+w+e85TY1H0Q=
Date:   Tue, 16 Jun 2020 18:07:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] spi: bcm63xx-spi: allow building for BMIPS
Message-ID: <20200616170724.GT4447@sirena.org.uk>
References: <20200616070223.3401282-1-noltari@gmail.com>
 <20200616070223.3401282-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zRW3mUn8fSI0is1a"
Content-Disposition: inline
In-Reply-To: <20200616070223.3401282-3-noltari@gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zRW3mUn8fSI0is1a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 09:02:21AM +0200, =C1lvaro Fern=E1ndez Rojas wrote:
> bcm63xx-spi controller is present on several BMIPS SoCs (BCM6358, BCM6362,
> BCM6368 and BCM63268).

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--zRW3mUn8fSI0is1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7o/EsACgkQJNaLcl1U
h9DsuAf+JzDVfdxvzclLEL9j69hB/V/w7Fom3MnMJuSBdrOBXlSvGR8yENQthQ5E
t2HDh+xMBncUP4yab1SLVL7YFqAe0CIf+B5F+dbwTHqWmzNlDW7pnSldJtxb5XlG
T4GxSiK5HksPFQm5AAiUxiGJsmNjXfYvDshqyfyhqlnkMzEhz/GMOPq6rdEOa3tE
b9HnmAZsukGNPPuDf2Q/WORbGMsTr0X/fmz0oHFAsbSCjMdl/VDZuylKWdWYq+fo
xQJYrR5KHfcfZBvj4GXM47Lqx5CFfioELYew/+BeO0/bmPhmrVERjCPXxj8W+rti
HRGT9h8idQyfwy1Vo12Pjbus5bvFkg==
=ojte
-----END PGP SIGNATURE-----

--zRW3mUn8fSI0is1a--
