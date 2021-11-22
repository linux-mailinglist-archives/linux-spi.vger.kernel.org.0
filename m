Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC17E45919B
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 16:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhKVPvE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 10:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239994AbhKVPvD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 10:51:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 396E160F50;
        Mon, 22 Nov 2021 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637596077;
        bh=coG1lVPGdNUMGzA0WSI5lrzbJGCJcGknXTWKVgL1jMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrCSo6m/1i8cNP7jGkFxesXBzfUzd1tIbQjLPeTITTBS27fSca78OAPQbxfG6rEoD
         O+j8J3/zSGH96LiWqhEzWbmq7WrupXr4j4RRtxTGBzyjW8F4meXPdPXgOInTACfqKM
         /u0eiDqQZJX6jElovK6JAFCMlB5dXiZMjgkPI3O/25Pjrg6ZwimmSvDkxDylhN2jM5
         moAVOuivwVXc5XvPmo9/Q0umaQdLJnxBsEki8Gx2Jdw8daLYzaO6whbDD9wl5IaoJa
         9zM3DK7Xhx8R4LLJa0R/+rmnoLYcihQ+NBT2rZElUGTrq7nvbeSKojhxWtN2JIdwb2
         KK1l/qaZhqwvg==
Date:   Mon, 22 Nov 2021 15:47:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: Fix multi-line comment style
Message-ID: <YZu7qWKYbWnmy20q@sirena.org.uk>
References: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
 <20211119173718.52938-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4uRR4lEApAfCq+Eb"
Content-Disposition: inline
In-Reply-To: <20211119173718.52938-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Neutrinos have bad breadth.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4uRR4lEApAfCq+Eb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 19, 2021 at 07:37:18PM +0200, Andy Shevchenko wrote:
>   /*
>    * Fix multi-line comment style as in this short example. Pay attention
>    * to the capitalization, period and starting line of the text.
>    */
>=20
> While at it, split the (supposedly short) description of couple of functi=
ons
> to summary (short description) and (long) description.

This doesn't apply against current code, please check and resend.

--4uRR4lEApAfCq+Eb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGbu6gACgkQJNaLcl1U
h9Bz0gf/SbXpl6cBivIjgq1t4hhTzW1gr4X0wcKwWMcuo0reAf9G4um/3VWgaO0m
j+aWYW/lzxXliCZX8lscRPNmUcydNGS2fdwwtWpCs2rA8nShfsqbSuQLwfxNxN73
iuR9wWgA94nPfZ7fanNEWlXTLQYQCQND5lHbaDhMFjs2v0nAf1hG1nKuaZ8cxeM4
Ow1+k9u1YSbYSVyHRU0WZL0b71iNMivqQdFLKwl+rmS0eKwXTBfSW5ZC8oaii4hs
kJbB41wqn4NC/gfc1+Ua/W0aUMJCpANiisk9SoU2a8pyi3C6TdYPDaDUhs+xP+By
2n6Ya3LyVR5upP+qmjA2qj1Vxyn2rg==
=yjzK
-----END PGP SIGNATURE-----

--4uRR4lEApAfCq+Eb--
