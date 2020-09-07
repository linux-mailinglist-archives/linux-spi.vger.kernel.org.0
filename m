Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B472025F8CE
	for <lists+linux-spi@lfdr.de>; Mon,  7 Sep 2020 12:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgIGKt7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Sep 2020 06:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbgIGKt6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Sep 2020 06:49:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D2420768;
        Mon,  7 Sep 2020 10:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599475798;
        bh=NuwFW124IW2EVqJqpRxyDtUXYuNaDZRelBDQr1MQYBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T25s/uXJ2BM6eT4azqvHVQWsLGvRPZrs2I1N1Rp5ZA3krvAmHl/AOZ/l1x5Neh3o0
         GAfixYfj9gJlXXd8+RcgnEWnI8TSj94q9gxhAwhBrRBp9mVRf7Wbbrx3DlL9tHCzkp
         aE3tPM0XfCGupmpvzftgf7Z0RM/bC4yePFvQf4/o=
Date:   Mon, 7 Sep 2020 11:49:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gustav Wiklander <gustav.wiklander@axis.com>
Cc:     linux-spi@vger.kernel.org, kernel@axis.com,
        Gustav Wiklander <gustavwi@axis.com>
Subject: Re: [PATCH] spi: Fix memory leak on splited transfers
Message-ID: <20200907104914.GB4907@sirena.org.uk>
References: <20200905201421.29495-1-gustav.wiklander@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20200905201421.29495-1-gustav.wiklander@axis.com>
X-Cookie: Elevators smell different to midgets.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 05, 2020 at 10:14:21PM +0200, Gustav Wiklander wrote:
> From: Gustav Wiklander <gustavwi@axis.com>
>=20
> In the prepare_message callback the bus driver has the
> opportunity to split a transfer into smaller chunks.
> spi_map_msg is done after prepare_message.

You've not included a signed-off-by so I can't do anything with this,
see submitting-patches.rst for details on what this means and why it's
important.

> [   76.611642][  T170] kmemleak: unreferenced object 0xfffffff06ef81480
> (size 128):
> [   76.618965][  T170] kmemleak:   comm "insmod", pid 493, jiffies
> 4294941102 (age 38.540s)
> [   76.627031][  T170] kmemleak:   backtrace:
> [   76.631206][  T170] kmemleak:     [<ffffffa542c5f8f8>]

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9WECkACgkQJNaLcl1U
h9Cergf/aIhYGAmgCE+KGlOPvHcVtnh+/Rj7CnfWzzykp8mCNMypwvk/hJ9LwDLA
EUBEXfPnpbWFT+N9hZjG+a6Mw8sPgH4l0KwWf357qSRaM6ZT6WOjr8C/EFnN7vfe
vQf0RPbuccc//6CqlJl4iekr/4jcRjLnte3jnGyXmKc6cD6dlGvNA3Z2VUw0kRTb
LNV15OglO5Xa2dVpGg+w1yQBbTtvVCcaxujson4eyTQTzXxITcrWONili8Hhw8OT
HAl0MwQujmlcpXhrECE6BHrSJtDYzwfZ8bAp/bjLjwXbm1k30Nwi1orwLcI5syAG
YEVAkM2Eu4yE5t/b9D1LKl1Qjo4k1w==
=hkCM
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
