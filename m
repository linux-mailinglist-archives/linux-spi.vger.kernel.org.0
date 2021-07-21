Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B93D144A
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhGUP4d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 11:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232058AbhGUP4N (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Jul 2021 11:56:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 231E960FF3;
        Wed, 21 Jul 2021 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626885397;
        bh=WsjJBo4afn/pkXwR0TGBYswKrxFtVdVbtqvGm7KtQkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQSTx+64qYrOdGqcdj/Wj4m+Ahchdgab8p5JRbQcFZRRoPUowGYpLyH5JzZscM/8K
         c2+VUHOhxQ+PNd8b33CGRJ0Y8BsT8fFeGeOAM/sjA0F8ExWJV1DGMoDzjEcGUSAKsJ
         0ukEP5ENiMpy5cFh+srH4vFT3YKeQwC1aqvRJfKaiYC3PXNk6Ju3WuzDOmnNNqqpnR
         0bW7gl53ocg1+X3PGSxtBnT0zqnqACaYOABcNXng7Zs0DAkKp4AH3Tyd01azqM79sx
         mH9+d56vjrKl8SHaTKxgB4qZNRes1eSFFtK5Cq5Y/6XQA3IZ2lX4nA+V83JC/exY9P
         3WaK0Cg+IVXkA==
Date:   Wed, 21 Jul 2021 17:36:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Nandan, Apurva" <a-nandan@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/2] spi: cadence-quadspi: Fix check condition for DTR
 ops
Message-ID: <20210721163632.GG4259@sirena.org.uk>
References: <20210716232504.182-1-a-nandan@ti.com>
 <20210716232504.182-3-a-nandan@ti.com>
 <c6bb03ff-1192-5276-4034-4a021e4f6923@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Content-Disposition: inline
In-Reply-To: <c6bb03ff-1192-5276-4034-4a021e4f6923@ti.com>
X-Cookie: Many pages make a thick book.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 21, 2021 at 08:23:30PM +0530, Nandan, Apurva wrote:

> Could you please have a look, I fixed the comments as you suggested.

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

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD4TQ8ACgkQJNaLcl1U
h9CgOAf/fOLQf4WweqflaqQwEyqHq4ElWpi+VgTktiz4cCeRbScuI6RQ9aBa70pb
s3GXbBLogiJ6f4AP4JZytkcNvemBVRuupxsJVd11brVfzYoycHf1Gib1PQXpugPH
L/OgmpOPYGXuWmbZdv1mM8ZbPMAte36h0WqDo9bThesjqgUlrfAnKHQLrlm2CcQ7
iAAPGYbl9008YJEEySbFNkH6sHqXug0RntFzk33Z1yHqrwoVP3PRnyEI+3Z+PChZ
BWKPt73K5uBIasssP/EldVzjy5q60QHl3FSpF9zkmyZ7cDx2CKZQZ384Qq4ezDQ1
GGHjywJHFYFFkYelxphw80cFAvvpLQ==
=Unbc
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--
