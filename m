Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90DC1ACF19
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgDPRth (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgDPRtf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Apr 2020 13:49:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3FF221EB;
        Thu, 16 Apr 2020 17:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587059375;
        bh=BkIiYOu1Vu7EfNRs0GBJIMd9H0ATsB/nAoxMx8uYOmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZfbcQ//SCMfp4mqoQo4YfMqs8yyM80ZL7TXKn37X20PwC0Cmo8dF6RBuFEUqHv6Z
         J9+oq1qxGTjaJRQXSOOxoOp0E0SF8L/fNQSvJMGUCnKJihl78qa7qpjOA1y0nVtLWS
         7hBGIPAkBt+LNkGOBf0h9BiceJbC7bFdwOX059rA=
Date:   Thu, 16 Apr 2020 18:49:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/9] spi: bcm-qspi: Handle clock probe deferral
Message-ID: <20200416174932.GP5354@sirena.org.uk>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Content-Disposition: inline
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 01:43:01PM -0400, Kamal Dasu wrote:
> The clock provider may not be ready by the time spi-bcm-qspi gets
> probed, handle probe deferral using devm_clk_get_optional().
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Did Florian author this patch or you?  The signoffs look like it was
him.

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YmqsACgkQJNaLcl1U
h9C+wQf/QFckkRzTU4FhkTKvuTAukrQpq3Cm/fZK+SW6HHTZjqN6M1Of3Awj8bbv
wuPtmvGzDfLDSwXBMPIP1geBYMjeJSdwPZ9zCszePU4WjUqvIq1DSfYCm6ix4FWA
Bku0MBsYrGlHL5hW1PhxRb8qo2/9od/moXRwVITavaUx8fW4PxdKaeFKUagAnzly
3/TyCdQ+sQLI4oycHL95TtJJmrL2luK4D5H0T8LicG7tFyL2JO8nF6m6qSpVeYX8
o5apHJ6wrWX01h3md6Q9C4Kl4vax5GoYA7OqFO8QZllrFU5BQGb6S1yEUXqwf/td
V6q12nxW5p7mhQetqyR6sUFDs3F46A==
=UmiJ
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--
