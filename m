Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA571294EFF
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442789AbgJUOrE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 10:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443730AbgJUOrD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Oct 2020 10:47:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0EE1222C8;
        Wed, 21 Oct 2020 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603291622;
        bh=0NLUXsL5nZSTu+tt4TPTX6Sh3M6zxBuxgNfiiDG7Fpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bfvo/x5A8xKQQpTGJw8BZgjqA4Ld52q97GDNBC4BKcfuqnVOPbW2H0ZWQx+qbPYIY
         tc6PtJ4QA6KnRX5ASSliuqK10I1I/kQ4Uah+LNxYrcrE04zoAvHjx6agj6PhA24ZVX
         l6OJo54sJI5gSwQOM46j1vUX7Np2h3VU0ZifM3Rc=
Date:   Wed, 21 Oct 2020 15:46:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v2 3/6] spi: cadence-quadspi: Add multi-chipselect
 support for Intel LGM SoC
Message-ID: <20201021144650.GG4497@sirena.org.uk>
References: <20201021025507.51001-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021025507.51001-4-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline
In-Reply-To: <20201021025507.51001-4-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: That does not compute.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 21, 2020 at 10:55:04AM +0800, Ramuthevar,Vadivel MuruganX wrote:

> Add multiple chipselect support for Intel LGM SoCs,
> currently QSPI-NOR and QSPI-NAND supported.

> +	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT)
> +		master->num_chipselect = cqspi->num_chipselect;

I'm not seeing anywhere else where we reference num_chipselect in this
patch - we parse the value, set it in the SPI controller and then never
otherwise use it?  This makes me wonder if the property is really
mandatory.  If it is then there should be something in the binding
document saying that it's required when the compatible is your new
compatible string, that way the validation can verify that the property
is present in DTs including this controller.

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+QSdoACgkQJNaLcl1U
h9BCUAf9HN/1ZjEGsiutV1X75aof27IiVliID+mogMUMJjQFl3XjdW3Aw87evS9v
WHiFPZ97HYyVjogF7gHKUA26LPqa3k7RL816DcD2F4yMIMizhiaCcMBtfpdBE73E
rkPpiv+/coyx4Z4OxEN2BeVAHxWorDwUXylWEHV9QBWGVyborj+Ltcr2+0iAfKuy
8uiKsr/tK8N1RJ4Yk7FqSjUSZPslq3sOjBnWs4tzgfLnLszmbzI6id7E/hg3+4YH
dqCe7aFU/MV0v91lO37TxoXQzwaEpzl2NyPUFzuHXPVy5sfUq/ldKSt5z/zfHxV0
yge74zz8U4bkVoDwq1R4+6vJxYqRgg==
=ABDR
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
