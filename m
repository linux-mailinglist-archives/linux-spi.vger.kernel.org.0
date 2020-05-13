Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA921D16E6
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbgEMODL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387608AbgEMODL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 May 2020 10:03:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18692064E;
        Wed, 13 May 2020 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589378590;
        bh=Eufhx3dlqqgouxXOOXWIHlrYL0mU5lBnSfOCmIEp3Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0MdU5zsTd7ve9RlyN3XfHy/AJ43Nj4J4J62DwwgSTzTcA8x8VxoDauR/tEsXmcv7q
         NJ6UyyO4gjb2WaPXu01c6Y8jNGvZwZMdKq7Xhbg3rNxR6otHnF9G5IlB1aQ+fVnwxd
         tuOOeeuhw+QHhj+kPL4w7M336rEi/oQ8bppMd8Qw=
Date:   Wed, 13 May 2020 15:03:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 1/5] spi: dt-bindings: sifive: Add missing 2nd register
 region
Message-ID: <20200513140307.GG4803@sirena.org.uk>
References: <20200512204543.22090-1-robh@kernel.org>
 <158937185132.39109.17103954100758193517.b4-ty@kernel.org>
 <CAL_Jsq+KfngSTEnP3eh6Zr9H4GUuSbyZCGXs=skbwQK0j4ZJnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+KfngSTEnP3eh6Zr9H4GUuSbyZCGXs=skbwQK0j4ZJnA@mail.gmail.com>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2020 at 08:02:14AM -0500, Rob Herring wrote:
> On Wed, May 13, 2020 at 7:10 AM Mark Brown <broonie@kernel.org> wrote:

> > [1/1] spi: dt-bindings: sifive: Add missing 2nd register region
> >       commit: b265b5a0ba15b6e00abce9bf162926e84b4323b4

> You missed my ask for an ack. This is a dependency for patch 5.

Ah, there was no cover letter.=20

Acked-by: Mark Brown <broonie@kernel.org>

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl67/hoACgkQJNaLcl1U
h9AiNAf/VxSFKe5eGeiXNh8NQ9o1DuI+ryYYh8J5t4bHHaX/ukfZxOjzM1emHxVY
dK91QCGiu/6HrZOrx7SNr/ZsJaSqIHg7le2mJWvu4g6uJ/SaPTKCGjUfL5gPeG28
FHa34V2fwOUoRil6nEiHnvrbQTQQmtwMw13zeYi38ltLK6qchlfCmFT7gjiYHmtm
netlxcnM2YKr/vblKt1hnDTffvAs2THEpNh8lJ0bA7IBEWsdRPH8PVROjIaBQpME
JzEW1cFXZTEeuuiNkYS1GMk/ShIxSiD19aAhfOzbomVXqMjenusxBN1jAd5VfoA2
9TnqOxwFFTKo84Gi3jhJlFaTkx5IRQ==
=KsV3
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
