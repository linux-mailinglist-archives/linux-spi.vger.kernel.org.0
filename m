Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C01FBCCA
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgFPRZh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgFPRZh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 13:25:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99715208D5;
        Tue, 16 Jun 2020 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592328337;
        bh=8EJ/ptyNfkF5APevUHjkOtt7qeq+ppRD+ZER+WQ7O+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ql73l9+ys9b5ydqVIAUnpPngpAwuu+4R8VoXAsTPejYPfQa+eYnVip34O0GDMzZdj
         bgEr3bZrcaqawblv/Xo2bF64SaiOvUlgcP28Bn22pHQ2kBswD5s00nSioyCgnSxPHI
         K3bvUwBxpRcAhDvt9GfjeXSBFSPTgvuBRIHQwtr8=
Date:   Tue, 16 Jun 2020 18:25:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] spi: bcm63xx-spi: allow building for BMIPS
Message-ID: <20200616172534.GU4447@sirena.org.uk>
References: <20200616070223.3401282-1-noltari@gmail.com>
 <20200616070223.3401282-3-noltari@gmail.com>
 <20200616170724.GT4447@sirena.org.uk>
 <a6edd50d-db3f-8988-157c-ff66e2fd474a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="csoOxBvjhnnTVlaS"
Content-Disposition: inline
In-Reply-To: <a6edd50d-db3f-8988-157c-ff66e2fd474a@gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--csoOxBvjhnnTVlaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 10:15:15AM -0700, Florian Fainelli wrote:
> On 6/16/2020 10:07 AM, Mark Brown wrote:

> > Please do not submit new versions of already applied patches, please
> > submit incremental updates to the existing code.  Modifying existing
> > commits creates problems for other users building on top of those
> > commits so it's best practice to only change pubished git commits if
> > absolutely essential.

> In Alvaro's defense, you applied the patches despite me requesting that
> specific changes be made (use the optional reset control API variant).

I applied only the two patches that you'd acked, not the reset patches
which had problems.

> Having a FAQ entry about what your expectations as a subsystem
> maintainer are (ala netdev-FAQ.rst) could save you time along the way.

Incremental updates are the default AFAICT?

--csoOxBvjhnnTVlaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7pAI0ACgkQJNaLcl1U
h9DMswgAgzZCxQ+zTpAfRYk+3xtjYpsaigrknTexpZFHf0A5bSI4JJBrdJmuJN0u
SuFGc+M7DRi7zvL1QrXmbRfgYzZZIbAHE0bocMbXXM20wxRWOsm4rJ8b+rMfup9/
9/bqmbwNOPjO/ajNBfx/f1sA67VtugkbhwSprOohWrEcz5WlP7gVUHZI4vaDGa0b
LlSt9MeyZm4nE5nQYM89NScC4It6MwaofpNmf8HskRVXXvdHHYaTfFJ8fAvG+1cg
VkvI2axlnUw0QZF3s/Nu4TaPbkgFPNoQijdhQZPKApUPVJvlTzQDgT3mvxPfeLqW
+1RrrQFh6VLlZ7kTwT6wi8MrsAzcZw==
=EFRd
-----END PGP SIGNATURE-----

--csoOxBvjhnnTVlaS--
