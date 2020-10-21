Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81945294CE5
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442511AbgJUMk1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 08:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394405AbgJUMkZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Oct 2020 08:40:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD3F22275;
        Wed, 21 Oct 2020 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603284024;
        bh=+CBaQPUx7XVyQiN7FAvvUJkjEx6kAbYTgy2PMnvM5FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8wMoLURdOKef+AtsPQ7CoPpez8dprtmRsVugQlwldMlQdx5TPz+Kfq8czpCONMZ4
         iBpIBEiXSillx/F3z8d5scmYOwISdTLLg+xEmQD673nv0yjR5oZmFYH/+oVt3gUiaJ
         Dbx4QByh88bnZZ9ZW/OfLCPedWIRNbRf4F0MTumI=
Date:   Wed, 21 Oct 2020 13:40:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v2 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20201021124013.GE4497@sirena.org.uk>
References: <20201021025507.51001-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021025507.51001-6-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <20201021025507.51001-6-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: That does not compute.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 10:55:06AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel=
=2Ecom>
>=20
> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/

This is patch 5/6, not patch 6/6 as I suggested :/

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+QLCwACgkQJNaLcl1U
h9BbAAf/YM0k2iVJQk3ZZTpt3a7VpEFh1nmu2nQljnukDeA+/Gnk4Z+7JGxrMALJ
qJSvm+d9osWVrjn1a6gQHlGJJT2k/pQd/orYzmIi9pecL3FLj+Zl16pstQxjzpCS
5F8yhLiwm8CuB2q7YNtBgejkeBZFpmUkHmzwqYV3VoBmfEHWj6V2peux1nQrk27X
uw5BgnRFo+7yId3wCD+41ewPp3DO8/4FvfHMUn7cXy9ASM1EfWfjJDeIomxdA3GU
TkGCvLjNqf1q7zNyvF0kayMofN44C2lYaMp9mceULPByJByN53roLfHlcQslbo85
iKFs4JhaWtOjOZ7O7TbQiE9Q5qKapg==
=NlDZ
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
