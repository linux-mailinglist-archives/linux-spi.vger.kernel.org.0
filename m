Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65E3C28FE
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jul 2021 20:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGIS3Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Jul 2021 14:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhGIS3Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Jul 2021 14:29:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02A27613BF;
        Fri,  9 Jul 2021 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625855200;
        bh=bq7hES9922zgTAyN+l6SWN2Mf5iaz95IRfUV+Ls16ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=muxar4b5zjX8knNvBMU1JB3Fq1hkzWEGjTVVbmSEmNmDwmQeBxbUtZRz5Vb8Wr6IQ
         LsOKiwSf6DiSITdFPvms+EQe1fJvkam2xUwL29h3BHfKwcaYzkk+3hCTRAsHnnAtZn
         PQmcHMW0WAflzGDI51CORrUucCd06C3umoS2tVG18sMJgCh+uDaPqSrxb/ePskfSiB
         lco8qKkzSaXICfgsYkPLQIXn4QyVKJFXhYNSeVd35V1RUOeVEs4b8kFn5XXoFDhf8R
         8YChKLlpt4G7A9RmZFzA4FKiVsfgvSWWmwoXBAhlJmgHK70mWrAlQjZGMiemP0nkUs
         /AmeTrvdadxdw==
Date:   Fri, 9 Jul 2021 19:26:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        leilk.liu@mediatek.com, wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/2] spi: mediatek: update spi master bingdings for
 MT6893 SOC
Message-ID: <20210709182606.GH4112@sirena.org.uk>
References: <20210629101310.21045-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
In-Reply-To: <20210629101310.21045-1-mason.zhang@mediatek.com>
X-Cookie: This fortune intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 29, 2021 at 06:13:11PM +0800, Mason Zhang wrote:

> Change-Id: Iaa2840f7e89db83f9505302b50b449f8885a14c1

Please don't include noise like this in upstream patch submissions.

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDolL4ACgkQJNaLcl1U
h9AGuQf/fiCaDqWym+z4bphEMW/sreSQaMhUPsX89q9L53pDipBgT9J5f7DiTPNJ
NmM66kiRq9S7lp9aENzPFdHRj16H2oY/Z2R+ZkhSBl9eIX2bfSrT0iAZugxIRgb/
9LiihnkiKENv1488qf82H7geFWjUCJ3uOa8o85+B5Hc4/4PomUZRhmES+nTneMpd
RjJphzjpC2I/jYhW1YcyjSH7bA/vtSlZ1noq1SuB+NImujAzJ2M1zWxes61HvdTL
dw0yWHYBLiUSRgDSb2bd4e0eke0mAPzz5XZUgRT9UNk+4pH9XsOTw1LnnDYayAJd
z5KQ/Bake3q0K0jl0otdp1oaLsyLZQ==
=L+oc
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
