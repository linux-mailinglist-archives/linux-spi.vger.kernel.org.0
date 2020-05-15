Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37E1D560A
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOQaE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 12:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgEOQaD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 12:30:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC34C206D8;
        Fri, 15 May 2020 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589560203;
        bh=kcABlY96zZuuvxknCuTu6y2BzoSb5JZQAgWATiaGH4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EL6CeV32YvSHnEsKtk8Rffu6tdx7k2g/NyPIG4QkZYRI0A3/ee1IlcLWAAwVO+pJv
         e1dJznSYnTpgXY9LCzdUKesJyZcN792o1oDIfEy1pWzRrlbRDJ5FEg6rsbb/ooFxOQ
         CPE4Ha3+8L+26Sxh5lF/+efjTyMIUpID/C1AZABw=
Date:   Fri, 15 May 2020 17:30:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] spi: Document devm_spi_register_controller() gotcha
Message-ID: <20200515163000.GI5066@sirena.org.uk>
References: <cover.1589557526.git.lukas@wunner.de>
 <d0dcbd098401b5d2a486eee7cf2f9dcabacf9605.1589557526.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline
In-Reply-To: <d0dcbd098401b5d2a486eee7cf2f9dcabacf9605.1589557526.git.lukas@wunner.de>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 05:58:05PM +0200, Lukas Wunner wrote:
> As a rule, devm_spi_register_controller() must not be used if the
> driver's ->remove() hook performs teardown steps which shall be
> performed after unbinding of slaves.
>=20
> Dozens of drivers are doing it wrong.  Document this gotcha to
> hopefully prevent further misuse.

This is something that needs to be documented at the devm level, it
applies to pretty much every managed API.

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+w4cACgkQJNaLcl1U
h9DZ2Af+PBsyttZqul8Zsvsfo0lBAKRdPEmmL6COZKHi1rjKqORzv0CfupBvogg3
B9jgHgEQH730rdi+qFk6suEMguq/E/K4jBj9n6L3+8JnlZjgEvqRVm4Ey0j4pDIr
Kt7OHSGauAwsM1TfALIugEvvu5L5rM3QS1+zxKcCARBUNR+G0XyI+DeVEUMmSCUN
137NZfCgmA6hXfRUC5fNgmhcTPSjfJp8FFp4BYL3Ma97LQPXTQSNWl93XqbJzmMm
wCAN74QoTOz2hrbHu7XRcf8V68A0jtjEXmbZ0bFZ7VQztQhOEB2BduArwqatJcmp
eQcRj5PV+gugrI/WLqTYvrSiGy1DVA==
=nEt8
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--
