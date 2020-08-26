Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43925312D
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHZOY1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 10:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgHZOXu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 10:23:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2ECB221E2;
        Wed, 26 Aug 2020 14:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598451829;
        bh=A8bT4gpJk+PvJm80XkjyjxOjjrEqUwRY+LaS3YZKKto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpGZhQOGxjeYLKpWhS/cSaND/Zxo/Y4JV7DyqpYiQS+CQUgIokFuJR0X6IW9ebNef
         jvwWLwrxfcfutVgmJ4TLnHWyfEovinhD0nVQ1fm/s+b8eVnGF7SFgN6fZM3T/MIjDs
         78NbKiVfVl3Yo7k4FR8GRGUerM63SADzP4OMGIWM=
Date:   Wed, 26 Aug 2020 15:23:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826142312.GH4965@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Content-Disposition: inline
In-Reply-To: <20200826114758.4agph53ag2fin6um@skbuf>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 02:47:58PM +0300, Vladimir Oltean wrote:

> - The compatible string plays an integral part in the functionality of
>   the spi-fsl-dspi driver. I want to see a solution for ACPI where the
>   driver knows on which SoC it's running on. Otherwise it doesn't know
>   what are the silicon parameters of the DSPI module (XSPI present or
>   not, DMA present or not, FIFO depth). I don't see that now. I just see
>   something hardcoded for:
>   { "NXP0005", .driver_data = (kernel_ulong_t)&devtype_data[LS2085A], }

Based on some other stuff I've seen with ACPI on NXP stuff it looks like
they're following the same scheme but only caring about that one SoC for
the time being.

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GcFAACgkQJNaLcl1U
h9DWBwf/RbhMMV43CmV4B9YAHIO3SYiuzAS57g1dZwgEy/b+D0qN7NofL/c/M61q
ehswXZ8kG1o4U3U7Kveb+CPOVLNDL0JGlf7RT7oX2027ER32kBqC6LbqhXm/blGA
4xOws3MJmy9fZHyPTMqGJPHjVyJFE0HU6yy3PjOuHDMP/+AvJs7/ZQed0DXUYULF
qPPFeN/O2uhl/4ODq/CpyyNjqIXnZzF7AGGd8vqLX5FP6FJH2CM8F2hoOu/SKKCy
HsQcxOG2yp3XmjxlloubFteSpuMOQ3XVP1H+xG1HvgXt8iqWQvlb767LBqK8qOBv
duwtA0RdsVc7n504Un0QlpgQz/f3eg==
=AqXf
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
