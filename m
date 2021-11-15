Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329B5452197
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 02:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbhKPBFe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 20:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232833AbhKOTUo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 14:20:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE8363281;
        Mon, 15 Nov 2021 18:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637001402;
        bh=m25J7+O2hvMNLKMDJQayRDxFJN/yb87xSbgF9d58gsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbAR9YqSUsrMjA1DCECubq1pTmLtCT0SN9eCXT7F58ig3y5h6e65mmioMJ9IyBV52
         gvYAWytst8eRCTML2UxpCnv36XvjE5X8NMl5WoP55T8AYNk2ttfNWbpHGQulC64prY
         12jUYFmzBTpMj1flfj+8Wg2hEcaTDBJDqNX26/syUF2F6ybGY/E7Dwe1VnRHmKFqac
         lqYbS0kNfAWZJCF+pcq1tIeP4DXDr4bxavf3FJFH130rq0WLo+tT341ww4tOowY96p
         lQW0JQJ9qocJ9hNMk5Fq1OTVVssr0R/49IPoGJz22lY2xiDq/77ma35DTop2iyuaVY
         cvkAyzvF8tunw==
Date:   Mon, 15 Nov 2021 18:36:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     christopher tyerman <linuxkernel@fbautosys.co.uk>,
        Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: Remap, SPI and parity bit
Message-ID: <YZKotsvqQJDUSglx@sirena.org.uk>
References: <d9ef0f42-4ebe-b7db-f18f-8652dcf38ca0@fbautosys.co.uk>
 <CAHp75VeAJ5QBcWmXwcVs8A_nzy9DRQ-eGjK1iuN2F1k1mXiv8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hINotA3XJaBI928f"
Content-Disposition: inline
In-Reply-To: <CAHp75VeAJ5QBcWmXwcVs8A_nzy9DRQ-eGjK1iuN2F1k1mXiv8g@mail.gmail.com>
X-Cookie: Custer committed Siouxicide.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hINotA3XJaBI928f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 15, 2021 at 05:14:52PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 8:41 PM christopher tyerman
>=20
> > I'm trying to use regmaps where possible and I can define a regmap, e.g.

=2E..

> > however so far i cannot currently see how to automatically calculate it
> > without replacing large chunks of code

This seems like a sign that you should be extending the core so that it
supports having a parity bit, it looks like there's at least some other
parts with this functionality. The pattern seems to be a bit that that
it's a bit at some specified offset which is the parity of all other
non-pad bits in the write.

--hINotA3XJaBI928f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGSqLUACgkQJNaLcl1U
h9Ae7wf/SwUx7TKAjt0Sl/DunhfzUlM93AAInev9O5kAqfMoQWZZ5mwV9BQvB58n
Bt4E9as2IVx+oMwNYVZQ4kO3RHf7bAxa0jwVPRdZtMBUqNNfbDC9Ewbh6aKmvXPq
TZ+/5mlGBHSGC9vwhXq72CPAjt/9hU0WGj8PEXJZt/2iwsqvxwOpqJU4yg42lAox
qY+2UaeXfvF9gS+mOfV1BCxaJvW32oiNhgXZG3eI7UGOiRl8DNKZAOxVCP/24cWu
AOJJCeAavcggccYGgu+KqcDmoQQDQn0NKAdD0A/2hQs1PyGXOGRM77RwNQJrEUMR
ddmwL7Y6lzd/tzYhsf3mVj7yQbRXgQ==
=HhwD
-----END PGP SIGNATURE-----

--hINotA3XJaBI928f--
