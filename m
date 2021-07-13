Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC93C768B
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 20:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhGMSmi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 14:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234179AbhGMSm3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 14:42:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF4D61175;
        Tue, 13 Jul 2021 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626201579;
        bh=ubA7uHxdE1SyiCkT+7s0waoDpBAfPaD5yVbqUZVcML8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOlnTcMr74IExyFpOoT519KFz61keGVAqq48xsqYnFWDqRdrO2APsJDG9uT7FQOWt
         eMzuLtIdPGWWhZ35nv/8h68CQQ3/63Lkw6Ay+tw9XczoLYaT4AWoakYHN5gAKibzQ5
         DB3kqQJIJx41PYmLFnTg8wE5jQF0x5B4pB8c8WH53qzeHo6YT3FjnEDSx1AZIZArqx
         rCAREy8B/rAyhKIZGavKwCWTbyzBLFGLruJVJguRn04fZyJWhb9TqWYijMxbuMGw9Q
         hSQCCELJVo7R43F+SdAnnozFtkdHhIBTcWCsK5xcnCUcDBD8nEEmz2NKl2NM0ivQa0
         1/oWveJlz22qg==
Date:   Tue, 13 Jul 2021 19:39:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Fix check condition for DTR ops
Message-ID: <20210713183903.GH4098@sirena.org.uk>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Content-Disposition: inline
In-Reply-To: <20210713125743.1540-3-a-nandan@ti.com>
X-Cookie: Keep away from fire or flame.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 12:57:42PM +0000, Apurva Nandan wrote:

> +	f_pdata->dtr = op->cmd.dtr &&
> +		       (op->addr.dtr || !op->addr.nbytes) &&
> +		       (op->data.dtr || !op->data.nbytes);

I'm not sure anyone reading this code is going to figure out what it's
doing without thinking about it, the combination of writing the bytes
check with a !, putting it after the check for .dtr and not having any
comments is a bit obscure.  Something like

	(op->addr.nbytes && op.addr.dtr)

might be a bit clearer, or a comment explicitly spelling it out.

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDt3cYACgkQJNaLcl1U
h9AkBAf9HBtavcaFb5fGRZa9jwV4sz1G1ZGGhYDjn+JTd/S/oMPd/BMpXsO4y1M+
5PBqgnG0bvl1hq/FQjupbs7BaiTTLWWAQjPYHIZaXoHIEiuSq7JI+Ryki0N+LFta
0YzL5ammBlGcvF2ZPfAm95dMaV83sBqkXJmdqzy8mVABe2Rw1iw9kx6kinLzk9X4
tBZnXOej3AhXr3FHjInBmZeWun/6TZ3dHQ4fKLvAWcnCeC8E5Z3lMG9VEYWDEbpd
SiT6VtjFsGDLzzV2+3eCVtnxU9Kzr5CmDhLsl2zBQ4nkq0s+8xIdUG9Op11V6yA6
BpdtzeCL+W0U7+YfEiSNFnvO/vHmEw==
=YkZ7
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--
