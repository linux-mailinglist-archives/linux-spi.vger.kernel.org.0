Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DA21A861E
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 18:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391237AbgDNQyS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 12:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391183AbgDNQyO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 12:54:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF0DC2074D;
        Tue, 14 Apr 2020 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586883254;
        bh=xlHJWks6qOP5nSm1EhRE7DQL41dwmEhs+KL2QMTW7YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZHuKMfxx+Vsl0dArDpDVMC82H+nkz2g07ycCte6YNwFeQJgbxPyJZI8+adyhAEFd
         VFJsMhPrneosGJZ5PvDAkmX5fuYjA0VlWMPbktjJclNqI69RldfwlUAjTSb/WUdu1r
         ys0s8T4hyL520KJEtXC9gQQUCC+Sna+6o11WxW38=
Date:   Tue, 14 Apr 2020 17:54:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 18/33] docs: spi: spi.h: fix a doc building warning
Message-ID: <20200414165411.GF5412@sirena.org.uk>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
 <1c701b3ac903dc0bc304dca958fbdee53bd38dc3.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <1c701b3ac903dc0bc304dca958fbdee53bd38dc3.1586881715.git.mchehab+huawei@kernel.org>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 06:48:44PM +0200, Mauro Carvalho Chehab wrote:
> We need to add a blank line to avoid this warning:
>=20
> 	./include/linux/spi/spi.h:401: WARNING: Unexpected indentation.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/linux/spi/spi.h | 1 +

I thought I'd acked this previously?

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6V6rMACgkQJNaLcl1U
h9DsNwf/XHI3tLwo6AEck5iQILDT6ARxZ3Hyb4atCbyNCJOPH/3VFDbANgIah+es
iPQAhuoWcCJiXZ47xTQAfCSXE26KYIPplmBo6lYEjCrNL1drYn1PIQ55PVqu7R/l
vhoUAMZI+5/q0d/rqbqTC3Fe72mYtEV9zVG5rzwyjpXNGAce9RpY5hMaiKzwN3zj
wU1WhxHB8n5qMQPFsfIDBfpGYTCgzQpv9tunvOGi34KqXoLqVT+4+yBGkyt1eug/
aV+Gb4jxwjnNzCqmq4p7e/XokHHpeOBbArBGBVE3AUQpaJmVUw4HH4XybEn9mRuF
1mImFIlu2/AlGTRAcSLKM+7laMPJtw==
=zkPe
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
