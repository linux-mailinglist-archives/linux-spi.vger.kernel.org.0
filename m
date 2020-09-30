Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F327ED9E
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgI3Pmv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 11:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731080AbgI3Pmt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Sep 2020 11:42:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307F720738;
        Wed, 30 Sep 2020 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601480568;
        bh=8sQ6NvdMplUJ15wo7baIF5gA6jk6LfkU0g0LGqWLZ9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pU9E6k3qs/t0wtWzba1fZXB/rImUqcxEsd7bbAhtq4TiYglsyfR565UInryXv2aiO
         31/LQUqJK4hgbKhiH+5sQ4RNtwXh9iHZ0EFI1pOprExqaVgt/oxIkAyjZ6mDKaey+f
         a0FPCMTGJako9VMNcXkVpt0v4fujiUx17ZUVJrjM=
Date:   Wed, 30 Sep 2020 16:41:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/30] spi: dw: Add DWC SSI capability
Message-ID: <20200930154149.GL4974@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-12-Sergey.Semin@baikalelectronics.ru>
 <20200929135233.GG4799@sirena.org.uk>
 <20200929221737.fiwjr4y3vhme4546@mobilestation>
 <20200930150312.ipt724uihixblr3a@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vJI8q/aziP9idhqk"
Content-Disposition: inline
In-Reply-To: <20200930150312.ipt724uihixblr3a@mobilestation>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vJI8q/aziP9idhqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 06:03:12PM +0300, Serge Semin wrote:
> On Wed, Sep 30, 2020 at 01:17:37AM +0300, Serge Semin wrote:

> > > > -	/*
> > > > -	 * SPI mode (SCPOL|SCPH)
> > > > -	 * CTRLR0[ 8] Serial Clock Phase
> > > > -	 * CTRLR0[ 9] Serial Clock Polarity
> > > > -	 */
> > > > -	cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;

> anyway. If you are agree with me having that done here, then please, accept the
> patch the way it is. If you disagree, or have any other though, please give me
> your answer, why.

Those comments did seem to help mitigate the wall of acronym soup issue
that the code has, it seems a shame to drop them.

--vJI8q/aziP9idhqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90pzwACgkQJNaLcl1U
h9DtaQf+IE0e8PMo8R/Mn/5c7o/Vw0Ff+UAnhxcFz6fcO+sj/anDoDYnBOB1JDp+
4+MzAIQqQnVNE06WjW3K4cd937uS0LjyTmtNoJJqotM/4E00vEp11+Q8DjaCeQTb
4GURVxfNh6oDRS495wgKfE1IjEqslrEKBWV0nn3vZpWywbK6GhvPzxTcndTPxEWR
wUV5YU/Cz7qVDyBHHnpKhRWA8NuFaynwdqH9seDbEzdtFa4FounrWbv38eLRIN48
xYto958NpQQKEwuWh2PDF5GzFrYjZq/wP8XpSN65nC8Moay4CMED64IWMakpGawe
32l1C3SCcWlblxlxeruavP0MWwVUNQ==
=SeQr
-----END PGP SIGNATURE-----

--vJI8q/aziP9idhqk--
