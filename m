Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82FE3DE088
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 22:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhHBUQi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 16:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231287AbhHBUQi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Aug 2021 16:16:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5036E6100A;
        Mon,  2 Aug 2021 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627935388;
        bh=1ftJ9kb+Y2xAzoMqL2sOYtIko6amvbIbdc1OAEJxocA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVuyEfUv4izjaGIz+P+Ea3mknWUyuJyiQ2TQ2MdPkQucekEpoqrh68+Vyhlqgi70S
         jD9dXjdaPvkjS5V5fK59wOZ1hihrL48U5gOwd3JTEP8es04ssFJeXki1DdVG0YlBxr
         vf8kLCAoDA/clTyAowv8NtWEqohkyDwMIccbXn+4H3umMBVQJyHmXijrY7oL8jQmKZ
         PaKMvI4kgnmOQbFHY/6LB6cNW6uAJ9Gb+aXQjBWZ9diY2mC3HKCWf/Nr+JzQZZvrlU
         HlH2ZeCOwhXxQPs6Np1SEcUyECFxFFSEOsyLmt8lSocKr+k9sPKHnvqEU+HDxylBZX
         XxovNwQ/gV/sQ==
Date:   Mon, 2 Aug 2021 21:16:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        leilk.liu@mediatek.com, wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/3] spi: modify set_cs_timing parameter
Message-ID: <20210802201614.GA39900@sirena.org.uk>
References: <20210719091642.24633-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20210719091642.24633-1-mason.zhang@mediatek.com>
X-Cookie: hacker, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 05:16:43PM +0800, Mason Zhang wrote:
> From: Mason Zhang <Mason.Zhang@mediatek.com>
>=20
> No need pass in spi_delay to set_cs_timing callback.

This breaks the build:

/mnt/kernel/drivers/spi/spi-tegra114.c: In function 'tegra_spi_probe':
/mnt/kernel/drivers/spi/spi-tegra114.c:1328:24: error: assignment to 'int (=
*)(struct spi_device *)' from incompatible pointer type 'int (*)(struct spi=
_device *, struct spi_delay *, struct spi_delay *, struct spi_delay *)' [-W=
error=3Dincompatible-pointer-types]
  master->set_cs_timing =3D tegra_spi_set_hw_cs_timing;
                        ^

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEIUo0ACgkQJNaLcl1U
h9A9nAf9F1Go1sfPbVr4y4p+ywDUg5Wsr+MKi1rOBL4AbcQ1yxaoPt+Hy9u9SMos
0LRfPt0j7LOGZr7vifhjc3oUF1RlB9y6gUMBcLiim6+4pbUz+Tajw2porzvSiK94
MvdhImTpbS8LPsEKwhXkpogz2uBiOMzmIlGHJL/k2gsewC1xGlXmdORTM+UBfr9Q
EXPNo9RPLAJP4WGoHjenHIQ7iixQnoLHnikVJtzET2heloGFaTdm0XUL2KUSE7s8
vOe18JfW8HRf19mr0CNVp4cKg4jE1gQEzXS7s64laov5hmoaFpf6eXVDFX7F0/u+
EVjpgvgR5/Yb/J/BntGxYQQyaGxUHA==
=rKDf
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
