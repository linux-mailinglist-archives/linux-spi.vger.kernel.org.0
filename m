Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0CF226032
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgGTMzE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 08:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgGTMzD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 08:55:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86CB22D02;
        Mon, 20 Jul 2020 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595249703;
        bh=y7RZr4EBxM8bRsCsBovfRFd7rWz4XGbu3I/ANJaXpBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTpcT+IeTaDp9SQ9Gj8yCeGkMQXxtWInWyx5lna0GMo70Obp2TX1pZsCQtMgBUZLT
         BfaEIva0Emhu/zXioODyNkWuua34Dm7GlfR6PAEJE9xlnkrwkCestrq5fBjSOxuHEU
         CldhOBTsvHDI8qClrM0wIYZoWv2H8/vf2MX/qYX0=
Date:   Mon, 20 Jul 2020 13:54:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shreyas Joshi <Shreyas.Joshi@biamp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-cadence: add support for chip select high
Message-ID: <20200720125450.GE4601@sirena.org.uk>
References: <20200710045140.458-1-shreyas.joshi@biamp.com>
 <20200710211655.1564-1-shreyas.joshi@biamp.com>
 <MN2PR17MB29743B1AE9419961F152EC73FC7B0@MN2PR17MB2974.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <MN2PR17MB29743B1AE9419961F152EC73FC7B0@MN2PR17MB2974.namprd17.prod.outlook.com>
X-Cookie: Be different: conform.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 03:55:55AM +0000, Shreyas Joshi wrote:
> Were you able to patch my driver successfully?
>=20
> -----Original Message-----

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8VlBoACgkQJNaLcl1U
h9CszQf/dvvg4/PSg8v9xouJCIhBeA2sD5wIubZbZPRUvb2X24FMR0f6nCUBRhAj
8bX8kO6BzYawwsYdhkbCYqOInpHOLeuJC4/nyU1a9CNxkZZmp6KXUyJP61lPUY/y
yK90QYS4Wm9eiPxOfsAbADdOkJ0vs7vUQbDOLrBzFIXzEa2bI/MzU9/nTQ5/vRIN
nOvnZP/xix+1GbD7W3Swe7VxRjNU5h6CdkNInPgId9DfsqAaw3QIdMJv5iYzivzE
XwM0/AekQx8cnV5WaWDjm/1SHfvwntt12KO5Hosew3DP82USfa5+AO+VjiAS8lzh
EHKRqc1+xmorIzoUUC0OtqOv761yMQ==
=6Wmy
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
