Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411FD49EB68
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jan 2022 20:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiA0T45 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jan 2022 14:56:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43426 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiA0T44 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jan 2022 14:56:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A992A611AD
        for <linux-spi@vger.kernel.org>; Thu, 27 Jan 2022 19:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95000C340EA;
        Thu, 27 Jan 2022 19:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643313416;
        bh=fQvPrDPY3P7I2OY/crq01C16Uf3nbOd3geYbps0hn84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLm16VNvPFiWZIIoLf1FQDiiHOveToQmehB+BhVemDz1yS1kQ7IPSmszcNptPiH5z
         NpjliAWaonia93XXetSQRsqz4mLOcUCjvWQM6OHDNeQ4yt1JYymALLHb9Z2ojNAcVd
         US+TqURO+o6akXygcjN+RxVaMS5rcfuKNge/E/ovmRVB4VEyxMe92Vq54YAxJ/wwIO
         dmX1dEXg0vSUPsherI3zMxFtTryd9akkUPDO/Z7vQB8ERGW3YgkrUJwqSyJAoIff96
         h1WSuuKj7geSMMr/89CDihkTJNl6sstVUMKibEHTVBr4yqLC6UU5e+MUPnCqz0ChBs
         lI63QNC61eXsA==
Date:   Thu, 27 Jan 2022 19:56:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v10 00/13] External ECC engines & Macronix support
Message-ID: <YfL5ApsG7c619+R0@sirena.org.uk>
References: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nk9jfp1SD/P4u818"
Content-Disposition: inline
In-Reply-To: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
X-Cookie: Stay on the trail.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Nk9jfp1SD/P4u818
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 27, 2022 at 10:17:55AM +0100, Miquel Raynal wrote:
> Hello all,
>=20
> I've applied the beginning of the series (bindings + ECC part) in a
> branch named spi-mem-ecc on the MTD korg repository. I already applied
> this second halve on top of the spi-mem-ecc branch but there was a
> misunderstanding and they ended up not being fully reviewed. Hence here
> there are once again, there are no changes since v9 beside the rebase.

This looks good, please send a pull request.

In general for future reference if there's patches for one of my
subsystems that I've not explicitly commented on I'm probably expecting
to apply them.

--Nk9jfp1SD/P4u818
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHy+QEACgkQJNaLcl1U
h9DEHQf/cWLgMk58qMhl3lNstMR2aWtfBWg68fuAosZWOfkMdKjQjcHst/p0dmB8
8WrJ0Iuou6xjLyLLAn6n5TyMxUddrlezcjSX6FE7nXqEHruqDfFQ+XYL33uGBO6B
gtfozdsxwUX1oHIo8EFCQOMkH8755bHuQNA8xDUDzkwSX2icjHM1cwfZqZTZVFuT
27TnqvoEIYPJBoBuFYOeltr/S4r1adZaHjpyn/573khI5gx9R4f/QxrlxLVNShvs
ZNWiSNn5r9Q8xNyEoQyyUa5AosUEQupoI/dYIjWB8N6a26H34fw0pJol8ZLs7m73
muR6cqfrBirPiVtGZsZkWdJmwPUUWw==
=J4gM
-----END PGP SIGNATURE-----

--Nk9jfp1SD/P4u818--
