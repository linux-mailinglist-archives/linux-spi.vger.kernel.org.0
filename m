Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA44350725
	for <lists+linux-spi@lfdr.de>; Wed, 31 Mar 2021 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhCaTL7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Mar 2021 15:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236082AbhCaTLt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 31 Mar 2021 15:11:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60B976101E;
        Wed, 31 Mar 2021 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617217909;
        bh=Olfz4Koh1GX/7jYYda3mu/A+pOcDvP8Ry+jA1/HnMwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtpufNiCGaobQA0Ff0lGGp3iQUlEJVv7Z+SJImc0Kybcygy2adWMKGM8a00hozn2a
         FMFqgDplPR3yYRVUhG3LFse0vk7idxOsDD/shh2TGEQKvjUei6lFJjqP09yLEN3CwY
         fbScwcK28PFUrZH58PVjNlojRSMMh2AGpInOMFthFEJaRHpZhgxjqWqrO24VXDIsRn
         B3yUBmEu50BdWX6lZnOq4FltYEk4CS99x/KOxaMeztMkKxfT/0RG77rUuTJD/gFbBL
         B/Z0b30ED84qTizOm5iiFyNUfQ5jHfpgZQ8nDY4+QA32jBtgwFgbLxk8lwk+NCxMbY
         2ObdQ/Bzz1QGQ==
Date:   Wed, 31 Mar 2021 20:11:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20210331191135.GF4758@sirena.org.uk>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <20210326130034.15231-5-p.yadav@ti.com>
X-Cookie: You can't take damsel here now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 06:30:34PM +0530, Pratyush Yadav wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel=
=2Ecom>
>=20
> There is no way as of now to have a parent or bus defining properties
> for child nodes. For now, avoid it in the example to silence warnings on
> dt_schema_check. We can figure out how to deal with actual dts files
> later.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBkyWcACgkQJNaLcl1U
h9AXwAf/fRZBoTnVG0BfNgQ2befGLzGtWUX2O1T04d886Y2ch/gYfOUy8hgclpI9
kT2H5uKYcYD3g+q8wzBadNgQ+CCi68QpIF0i0jaqynVHDwSfWLhWbUtI8c01u9UK
QZAtCKIeOid+YbFrSXDwx7PJNPzpqderUIVtRJFf7NOD08YQLcXWdQMB475nemUE
nHbZY3vVnFcc1BZVLleS6HqqFKaT6YmhYXWWSV985uf31myTIfxY1bmw9ZBj6Ejq
VPLemuamF8samQj/FzWdOxNXLC0bNtg5EQ7B8fd/ZneSaIPD+o/jsR0jcNF8rGZV
QY2AYvvRh5/cc9xvdMzZZU6kw12rAQ==
=Qe4U
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
