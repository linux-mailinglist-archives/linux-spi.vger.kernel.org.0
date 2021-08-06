Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC973E2AB9
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbhHFMkV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Aug 2021 08:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243783AbhHFMkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Aug 2021 08:40:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 641B161158;
        Fri,  6 Aug 2021 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628253604;
        bh=j6/zqyqykfTitJrzHg8qsQd96giVc/fOyETPbHK6xW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8NoQvg0GR60dYDI/2IFc3dXD/4NC3aulhC3wAaBk10x1pVUFZy6M/hXO9jiV3KsX
         B25wTjxYrgyspl+BNsWu0HVrvL8G9RljuotyYzzvGoe6qPKR6CGgupoX5DuxMxDk+s
         b6yDn02sPlpwLH7zAlChJenGR6ZJB5b7ibIlNKY6liOzmRsCR2geuleJGiL8fBQiYd
         mPivcppAbxbFyn3puVr7ZbmnpGT1XxP/dZ47prdtZqzD9vmVeseMHPZj1lSY1vFS89
         hyDxLllkNQ+agqBOJqeZmYjK+YVex6yaWRo9btY0EPaep/qbql7Rhl5/beIFKyBgmc
         lud3L75OMEdtA==
Date:   Fri, 6 Aug 2021 13:39:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH v6] spi: mxic: patch for octal DTR mode support
Message-ID: <20210806123948.GZ26252@sirena.org.uk>
References: <1628054827-458-1-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sF6X0tUrUrSWNIfp"
Content-Disposition: inline
In-Reply-To: <1628054827-458-1-git-send-email-zhengxunli@mxic.com.tw>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sF6X0tUrUrSWNIfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 01:27:07PM +0800, Zhengxun Li wrote:
> Driver patch for octal DTR mode support.
>=20
> Owing to the spi_mem_default_supports_op() is not support dtr
> operation. Based on commit <539cf68cd51b> (spi: spi-mem: add
> spi_mem_dtr_supports_op()) add spi_mem_dtr_supports_op()
> to support dtr and keep checking the buswidth and command bytes.
>=20
> Changes in v6:
> - Rebase on top of spi-next and modify comments.
> - Separate from the "Add octal DTR support for Macronix flash" series
>=20
> Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---

As covered in submitting-patches.rst inter-version changelogs go after
the --- so they don't end up making noise in git.

--sF6X0tUrUrSWNIfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmENLZMACgkQJNaLcl1U
h9AjjQf+M/Opts4bWCI08Tv3p4EBsyq4bPjpAtwHw3Tokq6EV1TR0xsp8SDNoaNw
qNjJAa3hK+Y1Y1pEumhTDEy31n8r3N2Y5euh836RxZBvGcV3NbVLAX6iMingKBJD
IQbMnMYW6n4mn00+Jy9iWEB9iBfobrbEi4fsmaN5ZTbZyUs2f4kZiciSWIJzazcD
AM7r+FPNGpdZ365kA1KWZoLWII3IEUnIE3+/FrA6J/eZKMZal5tznDPySbe8NuYN
Jb4GAXTi2bTziex7d4GCNz4/3Y4zkfMOSc/oy7ywqCyDPKg1U+EWT4Vk/T7epVg9
ja6X+5t9ekzkbAPSh5Ko6x/O6jHr+g==
=0Q/o
-----END PGP SIGNATURE-----

--sF6X0tUrUrSWNIfp--
