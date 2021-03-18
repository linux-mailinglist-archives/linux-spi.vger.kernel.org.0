Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D30340752
	for <lists+linux-spi@lfdr.de>; Thu, 18 Mar 2021 14:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCRN7L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Mar 2021 09:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhCRN6u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Mar 2021 09:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E96DD64E64;
        Thu, 18 Mar 2021 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616075930;
        bh=+PHjaGcitdsritbuBb/Tp/4x45eBgYWL/1+sCUmmtxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmUrLz0KFTPudMBPJAaiTUVoZ1bz7AmpldaYeEtNzq7vtPiQdCj2Jn0ZonkQR63/L
         QOtiC+ZXuvq0xXrnSGMy2K8GT2BUgN9BKp6pgv2ygsFO4v89TFaK91mDiszHtDN77y
         MBLghQTmaB+rMIDwbB0QUryzBMCUDyWJmHtAYi5PLzXzAaBkyz2Q4589Ydp4WtjlwU
         2WGlaMxX4h7EYPgsEPbdLI+ZXifbdjoTJbCtjFX9alypaZSQGhbIuTSbZuk46lBpnL
         NfQhgxMupFWNEEnmGxaNhqisDtUDj/r8dS7OZsMymDhDiZ0N1+qMyJbtlOR3DxhcZ7
         aPXUivknX5hug==
Date:   Thu, 18 Mar 2021 13:58:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com
Subject: Re: [PATCH 1/2] spi: spi-zynq-qspi: Fix kernel-doc warning
Message-ID: <20210318135846.GA25741@sirena.org.uk>
References: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
 <20210318102446.25142-2-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20210318102446.25142-2-amit.kumar-mahapatra@xilinx.com>
X-Cookie: He who laughs last didn't get the joke.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 04:24:45AM -0600, Amit Kumar Mahapatra wrote:
> Fix kernel-doc warning.
>=20
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> ---

Applying: spi: spi-zynq-qspi: Fix kernel-doc warning
Using index info to reconstruct a base tree...
error: patch failed: drivers/spi/spi-zynq-qspi.c:367
error: drivers/spi/spi-zynq-qspi.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTXJUACgkQJNaLcl1U
h9B+NQf/XTN5H3yzrkQ/bNrZhh0eGjMegkf7G42olyL0MnjwxBuUNFxgsoEOU24v
SYEHHaQUSfLHOwDQ6Y2QzgeIQDgrckTxtOJmgWztlO73uo026Rw2olvwLRXGo963
yR6pRRANus99U1FlFq3dWXxQNkDOPSm/4+9lZeSHpS4IFnkWK15Fa75V70f0rVKo
6gXLnE2oEcUsXwrP8v9lGrUdCW+9sUwc4Ff7XDejD7C2g9XZvkHQlTVMBNvGrE6x
qobAqEtGPX+/l4bbyj0nFJcSpA/0+5e0c1jiMPq5QhuOn+s1MgxMaHQrfooZYfmy
Sf8mgl+vGDGHc5UuQVYjzMiLOnACpw==
=g0sG
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
