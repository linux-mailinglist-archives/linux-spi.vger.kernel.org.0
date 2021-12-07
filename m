Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C455646BDBF
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 15:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhLGOfE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 09:35:04 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45320 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhLGOfD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 09:35:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED063CE1B1A;
        Tue,  7 Dec 2021 14:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950E9C341C1;
        Tue,  7 Dec 2021 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638887490;
        bh=2Bh4lh5Rkbfd222vBGTTXMX5WNUB+LpWa4lBwnCFCk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUKm/3ZOViVMPj/2iSbnfYwuu6LUpqK1EKt5eWIRgJX17jQchbt+HGore89+qOtWZ
         VLsP4wguNH8jcjCJ+wNCw9FgPorPt2pwgAKtAQxddV579euQjkY+lmD+Zs+sakTKu1
         jndGPhRLP+rrq65xNVohCzLFoHenMcE7zz71mJjx01q2MJ7Xj8Mbyi8hCeQSoAP0i8
         e4ZhUd39Z5Fjd65MHUn2ZooMTHw1YEHHXPz7raS/S8RnQp/Jv9iXS0Or17je5kXvtg
         zO6DBaa1Am2BHFuXyBDxQofq7pNyXzM+ZOvaSh8psUp4acI0zBVfPyVgZRaq1NBeCU
         WGTno7r0a66iA==
Date:   Tue, 7 Dec 2021 14:31:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 0/3] Stacked/parallel memories bindings
Message-ID: <Ya9wPJRbXU/PPQyE@sirena.org.uk>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
 <Ya6BNGHhflkXOItV@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7A/CUCjAopGcjyUx"
Content-Disposition: inline
In-Reply-To: <Ya6BNGHhflkXOItV@robh.at.kernel.org>
X-Cookie: Only God can make random selections.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7A/CUCjAopGcjyUx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 03:31:32PM -0600, Rob Herring wrote:

> Mark, can you either provide a stable branch with this or apply the=20
> series? Note that there's going to be some other patches needing=20
> spi-peripheral-props.yaml, so providing a branch might be better if you=
=20
> don't want to collect the patches.

I'll apply the series but there's still debate about it so it looks like
there will be further revisions.  Unfortunately the patch is buried in
the middle of history so it's hard to pull out a sensible stable branch,
Linus gets upset about topic branches which makes doing this sort of
thing retroactively painful.

--7A/CUCjAopGcjyUx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGvcDsACgkQJNaLcl1U
h9DvkAf/WNSVex+DPxkrNpBCMq//Q078vBs2gu5YblTGl1/Q+9SZj7itBvS7nhkR
UivBWCuOjGetI9o9Hk2iaMdmOkB+pKMyZrgcNlPG1gN/R5ATuxQbXWpClPD0vieU
ycB/OZkrPm65/8+7W3cnKvjafg1Hp6xsSiJjKSLobR50WqecnA8sc2SemIB4JR2U
7PKBkhK9TJsTrLmAWp43f0oQ6RX5vL537cA8bM8VlalX1L2zCpGfYNB3tzhAQwWe
7vfJqkFJrl0vu6Cr2ai9oVeFfjA8marBUVlAlHzDsaVSoh3FRPXp33QArxm9uTMk
cBICj53P2du8lFyzrfYDBsoRumowAw==
=lecr
-----END PGP SIGNATURE-----

--7A/CUCjAopGcjyUx--
