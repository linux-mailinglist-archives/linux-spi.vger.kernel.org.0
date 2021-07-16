Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559893CB756
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhGPM0i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 08:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbhGPM0h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 08:26:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3E1613CF;
        Fri, 16 Jul 2021 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626438223;
        bh=cdii/MaA1B+J8espMm4DZvZtsIfLSoFVo5Vl1WSOhkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bu0OhRWCm+LU2ZIkIEY93+HjKmNIi8oeScKiVkUmwrE3swRztA84nZJEWdfWSlkIJ
         1KJIJa0zr3W/2eEmcpepQqURHHeqMhPp5CM6s2vymXXLCEsFE9FCTnVC7nMeFVf0aT
         leGbabo8XGTxkUKLQ4GapjncX62bkVgzUKHK+Ed1iTi6k0Cv3MBrM9HSJWRX7RhU0g
         HrV/fks8VqvNduQgNl49jOHDhVeqBn2gJ6qMU4dMMtynuTJPrz+p8sI1rfHeHtBJN5
         iYBZslxmPyK24QxgLayfvjboxjlD7pm2Vz/nMaNzdQUZbf/UwMhdHnoBUXRCmKvGu5
         VVuziYrxOfhDQ==
Date:   Fri, 16 Jul 2021 13:23:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v4 1/2] spi: spi-cadence-quadspi: Revert "Fix division by
 zero warning"
Message-ID: <20210716122305.GA4137@sirena.org.uk>
References: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
 <760be709-74d1-14cc-fecf-433786e123aa@nskint.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <760be709-74d1-14cc-fecf-433786e123aa@nskint.co.jp>
X-Cookie: do {
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 16, 2021 at 03:07:21AM +0000, Yoshitaka Ikeda wrote:
> Revert to change to a better code.
>=20
> This reverts commit 55cef88bbf12f3bfbe5c2379a8868a034707e755.
> ---
>  drivers/spi/spi-cadence-quadspi.c | 10 ++++------

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDxeigACgkQJNaLcl1U
h9BfJAf/aEmhksqkfIzib/VuGlzPmigShGb//sfhgOH1cqR7T6f6aVT+9mjoPXFh
NJcAhyQGwhlDxJhFJ9jmXeUb8CuCXu6y5LAKFeMz2aKVuDpvXHmF93D+r6z3ahhV
QqJcFg6gEPlStUva2KBNvri89W+KQM67qgmRp+1gnTyhfvV41VXHvOVgVeiLA2BS
YTLQY90xHGMWKVnCWT7Gus5V5DikSxEM77rOVz0V0MyjsBCVeMuT5NlYpWfXF8B+
D+td/bnGguh5DlrL9PAzTt10prY53KwrnzncZlU/YFBO0BTMMyNHiedSuMZsRAeg
9Ta9grvcnys9RKJg6aJZNoqIfcjKew==
=uKij
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
