Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2826A29098E
	for <lists+linux-spi@lfdr.de>; Fri, 16 Oct 2020 18:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410757AbgJPQSy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Oct 2020 12:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410751AbgJPQSx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Oct 2020 12:18:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C4B6207BC;
        Fri, 16 Oct 2020 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602865132;
        bh=HtlLolkp5hR0VMPg+WOgBQp8RKSusLTKuW8c46vYJgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8k+vRIxvh61Veg2Pz/2x2LvRjPmAfLnbPI2iNgowenQOJ70GBvDl+swG2TyuLs0h
         D+QDG8CafsI9cukSFGGmGitp8e6auM5WFBJ29IH0hdsCDqQdFX5DltteNIyGoF0Ti2
         zbfPzBFxz4B0GShvjBu7klo7MtA9rVfVJtaOaw0Y=
Date:   Fri, 16 Oct 2020 17:18:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 2/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20201016161844.GH5274@sirena.org.uk>
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016093138.28871-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Content-Disposition: inline
In-Reply-To: <20201016093138.28871-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: Pournelle must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 05:31:34PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel=
=2Ecom>
>=20
> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/

Please make YAML conversions the last thing in any patch series -
there's sometimes a backlog on reviews as the DT maintainers are very
busy so this means that delays with them don't hold the rest of the
series up.

--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Jx+MACgkQJNaLcl1U
h9Dndgf/WIBohsik4TAsHbT7NjLwWhhyd6itL+7pmlPnRG87WCHo6txvKu/HYUxr
dgYts7F7r8iGhaXdSgFVybwbdDOYPKMClFPAwDulQKt/ieAm86VS35Wu9i4hsgx8
hsRg3aF7GsYTqqkMHRjVGPUxLiGfIbEHzG87WGVQVpSIdwwS8tubDD1sIUiQ6NaI
szsC8tP5EMyz2aR+hsAXReAl3H3X/EWZkAiQLzqF40+DIb4r9ZTI7jvH256kHba0
nfnsbFLq+N1hh5yNnbcRYARtusmhbuYRJN3qI3cFw8remiBsWXzVrAJFPhreCMrw
2bWhyivezbTpl0HPqc+ZO+SUSDOWvg==
=eZL+
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--
