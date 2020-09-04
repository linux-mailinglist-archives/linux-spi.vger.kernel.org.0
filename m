Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC025DCC0
	for <lists+linux-spi@lfdr.de>; Fri,  4 Sep 2020 17:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgIDPFd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Sep 2020 11:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbgIDPFc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Sep 2020 11:05:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88652073B;
        Fri,  4 Sep 2020 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231932;
        bh=867FjhOk+mzHQgUnh6jMHK3GbZREmVppDKTnz4YHiq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FekxRTd2x6gQ4TtWuiFI+cEd5fmAFAzgyGZb88EY+xVmwWiE09tnrKzmtNj1/yrtc
         J5zeKexjYhQeEqx7lPj1ifV1iffHJ9oPjwkmEqqese1+1Rh1/wa8tpBi8qnW3TTfvd
         EZ4/4ukg147oLEFRSNswQYVxTX0jvPWgzbcCmcjY=
Date:   Fri, 4 Sep 2020 16:04:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH] spi-imx: remove num-cs support, set
 num_chipselect to 4
Message-ID: <20200904150450.GG4625@sirena.org.uk>
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
 <e1431dd2653dbffdfec39a2e7167db07836e30ac.camel@ew.tq-group.com>
 <CAOMZO5C7yyA11EOQvU0Fq-uDd5RK-B7WmbtvAy8OtPzfThYXRg@mail.gmail.com>
 <f753882996235439b9ef53747d24382e896dc4e7.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Content-Disposition: inline
In-Reply-To: <f753882996235439b9ef53747d24382e896dc4e7.camel@ew.tq-group.com>
X-Cookie: Heisenberg might have been here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2020 at 04:34:43PM +0200, Matthias Schiffer wrote:

> Nevertheless, I don't see why we should deliberately remove the native
> CS support - my understanding was that we try to avoid breaking changes
> to DT interpretation even for unknown/out-of-tree DTS.

Yes, we should try to maintain compatibility for anyone that was using
it.

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9SV5EACgkQJNaLcl1U
h9DcEAf8CHYTzODfyhZC8xzQ9RJpGDI4cIHVRdmq3YrWs9MR+mGvb5pqZkHODFtN
4kq9H7VMntoIotqG/LujjH6ipEqEBz6Byt+b9Rn9WvVs6BOP3jzhjfYoC3GbO5wa
orr/piK+EB5hQoqSbylQr2FTNoEc+8ZlzQYHNMayfMYChox+4LJhYtkohhZsjsxs
Ga5eXRQZJm3GJgiRd/lzhkawa1U9BzYb4DyRaQlsN0AT6fcgtuAP14m/FrsBw1nJ
n6yZbU06fN1OwOGbBkVP4uItNuEpmIwDvjdJ4fg7eUG+6IojuLbobeg0/fxXqYXl
B8aZVacFCvgnSvtuNdpJfp4JBdq6CA==
=xWyE
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
