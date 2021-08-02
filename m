Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2922B3DDE90
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhHBRcw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 13:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhHBRcv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Aug 2021 13:32:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADD3E60F9C;
        Mon,  2 Aug 2021 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627925562;
        bh=nzMkdhv3POtG3zvpzV0a8euM5ymp9crTb0VXJfr2NZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9SORd0CcnUnzpwtu7poOMOuyVEbiH8QHjn7je2PHslgUlcOSxVKOUZY+kUpROehU
         kVJOcoqGNrV7kbwchIFOQmQ/USYaewlVIBEojdG6VUmqsaArOTt/UGQ7IG7t2/kTQi
         cKs3aK4M7ztNjf2/z+hwhFSAPu3pslD9jRErNrjkrg2mrhiJOWwy1Wn5O0rBdVuvJ5
         AdiFnDj5Ww+G1qrGSCiAeQ3jP2NprHqgdQ4hLiAIZyLbInO7Uz4N16gpRT3UD5bFuu
         Q9BpyOz7H7uAo7ZHBKx4yQedWAmqsv1+w+6sZsm8amy1nttmrHaIwy85acm6Y/0tRb
         aOwXwM67DUJig==
Date:   Mon, 2 Aug 2021 18:32:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     lukas@wunner.de, linux-spi@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        jpawar@cadence.com
Subject: Re: [PATCH v2 0/2] add support for Cadence's XSPI controller
Message-ID: <20210802173228.GM4668@sirena.org.uk>
References: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5V5c01chtBAiSHoy"
Content-Disposition: inline
In-Reply-To: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5V5c01chtBAiSHoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 21, 2021 at 10:11:58AM +0200, Parshuram Thombare wrote:
> This patch series adds support for Cadence's XSPI controller.
> This controller supports multiple work modes e.g.
> STIG (Software Triggered Instruction Generator) mode, ACMD PIO
> and CDMA modes, direct mode.

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--5V5c01chtBAiSHoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEILCsACgkQJNaLcl1U
h9AVPAgAhRJUXOi+h6EXJmyUxnpM+7zHQGYvjPHZYv2VvWol6cE/pvYU5OEjXIEq
aqw/qknfIlHY1yxEY5y1f4aK5in4j7WdnZ/13CgloX9JXBYBQ0SCMqiuySpc1Ie3
OjrT+Z9a/R7rDqYqiD9TVQfJ12FyujH/rzgN8KUP45rpgXNZe4bSpPRpVRnXEMh4
eoi1YkKS3sDCYSXWEiMEq6zQ+lnrjnJ3mvs5noBsA5C5FTLNC3HRQUURK+teGbvp
4CneGudGAUqZ+iPq8OgYg9lt4ArYvOeQNJ1oWmEaK/MXGhGR9aDhYNYWfLlmBuGY
Jg26IVTRp7BuKDpEo86/jk6GZA7SiQ==
=QJL2
-----END PGP SIGNATURE-----

--5V5c01chtBAiSHoy--
