Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEE33C9E8A
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhGOM1f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 08:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236901AbhGOM1e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 08:27:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 382EF611AB;
        Thu, 15 Jul 2021 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626351881;
        bh=bJ3tq3brtjltku5oyz8HOKtmw5CPskYqXXl6jp2pz9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Boe6yC94UY6BEOqS89SmEndUUIfNERi3My4C8BiCzhDUXSn/UZ1euEehVkT9F5Yjc
         Ou3Tqa8m23/3CdwD14QtzsF+yC3zXnOMFBlZh2Io072Cna7sRzfMtAhKPsMuSUGUmB
         y+n+jX9IjfhQ0SGgc7JSWKVuYAr5KYTanV4P0kNW1HElXfaL8UyqoczNX8mGJ/IUfu
         D1P+3Oc0Tq4+oOfTaDOKUhQ0GJ9J2vJzCX0S7YTo7lf6kYEeGmAuvhVhYH+Nes5azv
         Wm33lzpAt1P34riei/oLM/XkK6blkv9lbJ7NR8MVT54VJ2LxOSzjEGY7XyALwcGskS
         i8I89f6+AG4zg==
Date:   Thu, 15 Jul 2021 13:24:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v2] spi: spi-cadence-quadspi: Fix division by zero warning
Message-ID: <20210715122404.GA12949@sirena.org.uk>
References: <362e0cbc-ed82-bf7d-025c-d586d11eaac2@nskint.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <362e0cbc-ed82-bf7d-025c-d586d11eaac2@nskint.co.jp>
X-Cookie: Programmers do it bit by bit.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 15, 2021 at 12:46:30AM +0000, Yoshitaka Ikeda wrote:
> Fix below division by zero warning:
> - Added an if statement because buswidth can be zero, resulting in division by zero.
> - The modified code was based on another driver (atmel-quadspi).

This doesn't apply against current code, please check and resend:

Applying: spi: spi-cadence-quadspi: Fix division by zero warning
Using index info to reconstruct a base tree...
error: patch failed: drivers/spi/spi-cadence-quadspi.c:307
error: drivers/spi/spi-cadence-quadspi.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0001 spi: spi-cadence-quadspi: Fix division by zero warning

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDwKOMACgkQJNaLcl1U
h9Cx3Qf/T0Cv0syZj/nwkBfoFSVoMip6yXp2zQc1m2Re7ulVZOWhhsaYj/4mbU/Z
i/RDZDb89Ht11zhmQL78jRvG0uXhxSwngOncrO10oXdRP5NLUoUtmKjnRaI8Wkwf
yQ+by1FYM8wvbDdNndXmFiPyuWk+EAS+Go3i9zVnA7Kv2s15/KSqR+VVRdsnPeAW
dQUTGlbVA8Jd0SFhBZOrGOlFLCSEkkDqQzXfG45S/yOz8MwtTYFnjnthgynWWeRp
F/zxG0CHTeiK7pIyIJL36RGc68J0ZEmQP4qTOys7jVX3BISaZKOfWxX/8WGDdIk7
1KSyF6rcDygsKzakpRRjEMIKfJQ5UA==
=EwzE
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
