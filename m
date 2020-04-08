Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6830A1A2645
	for <lists+linux-spi@lfdr.de>; Wed,  8 Apr 2020 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgDHPt2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Apr 2020 11:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbgDHPt2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Apr 2020 11:49:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A8B206F5;
        Wed,  8 Apr 2020 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360967;
        bh=ye2CgUYCSqFysyTcMZGbUC3+b/DeIcyAgFxFOsM0mDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBRoO4V7hIW80h+FrLth1k9gnfo/pigAPcZkkT5ZkTjJbS8GgTj635UeaXBKpoXkP
         EnXOzlCBUzPJySgR4/NX0KLXzf6+30jxMlD0nH7UIdoZUM/6xk632X5drsRdaSKcFe
         eQzK8/WJfZ6i/fXXdMjly0Kr6XblN6tODkkMxf38=
Date:   Wed, 8 Apr 2020 16:49:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 21/35] docs: spi: spi.h: fix a doc building warning
Message-ID: <20200408154925.GA5177@sirena.org.uk>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
 <d62f3f3536c0da2062bad87524fb184ad5a9a5f2.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <d62f3f3536c0da2062bad87524fb184ad5a9a5f2.1586359676.git.mchehab+huawei@kernel.org>
X-Cookie: Sank heaven for leetle curls.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 05:46:13PM +0200, Mauro Carvalho Chehab wrote:
> We need to add a blank line to avoid this warning:
>=20
> 	./include/linux/spi/spi.h:401: WARNING: Unexpected indentation.

>   * @transfer_one: transfer a single spi_transfer.
> + *
>   *                  - return 0 if the transfer is finished,
>   *                  - return 1 if the transfer is still in progress. When
>   *                    the driver is finished with this transfer it must

Are you sure this is a sensible fix?  The following lines should be part
of the documentation for transfer_one, will that be the case after your
change?

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6N8oQACgkQJNaLcl1U
h9ADFAf/fx8bDo5MrqjuRdoyjFCwBxM7HE0VHxtW2VKIbiMPUe21gNoyjVDF4ObX
shR/3FATGwbGRc8dSdaAQXnV7Lmjqjdbfgkt35XgWvmRxjeSWdFd2BM2WxutVzJr
/mOTN/gKM+8K3mgBxR+UOEoVI0WSNZGdx0pQZu1HGdsqKk3iQuWUzjonPiGpG/T8
e+ueC+FhaC7QDMwGXXpxP0FtRzLiOP95pAy03o1dYpWnf6ORiuwjl8Dz6sDzZpSa
N/RdEt23t/JFi1V96D5LsGh+TdjoTl8hPt1L68AbGIBSRSmhpt0+7aFQ+wpmWBSJ
HBqe97rqeLS2mxqM8cwp8CjoKvKy0Q==
=h6Sg
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
