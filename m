Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1B27CEB7
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgI2NNZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 09:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgI2NNZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 09:13:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997AA20848;
        Tue, 29 Sep 2020 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601385204;
        bh=6XpaI32bLsO0x+e+H8bay4mTioZkH6ibfYfxFmOmPx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kELx8PVTmcFE2nIQcHlOdOQV4RPHtL1KZkKq9wipTMzfm97pg3sV9cBHFqCaou8m5
         KwI92r3iHSPmM3zGcjMMDBW6PzQB2grJmteKMR8mouhZyK6Q6sJpIrK3yKaH4jA9lq
         S33jt6WSpcL+RG96RtBWh/Ct2/D2DCZBF3KmRGUA=
Date:   Tue, 29 Sep 2020 14:12:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/30] spi: dw: Initialize n_bytes before the memory
 barrier
Message-ID: <20200929131225.GE4799@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20200920112914.26501-4-Sergey.Semin@baikalelectronics.ru>
X-Cookie: I left my WALLET in the BATHROOM!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 20, 2020 at 02:28:47PM +0300, Serge Semin wrote:
> Since n_bytes field of the DW SPI private data is also utilized by the
> IRQ handler, we need to make sure it' initialization is done before the
> memory barrier.

This looks like a fix so should have been before any cosmetic cleanups.

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9zMrgACgkQJNaLcl1U
h9ADXwf/VfBVN64j5D1Qdpr1AuBo5GLZ7Lv8WZ+LOueVwNndpF1V1pUDAGi63hMm
jzQi8luVWfoqRPiMa450CPnivKoDkVSMUBS/9uWCub/4Vea+cEL6TTrkOl6lxCU9
ND/mQgD0hUb4/f3b7KoTXn9Qp1E/4eSvcb8N7IIqIxjzcOKCrbn/g3vUNgAleE1r
JnmEUpvkY1inP/yURskCB7xNTXdaJRzy2fMUn+6mbX1W5RMk6ocG8zkv3LJXrcoP
e73Mq+qWCorphO639qclMW+er+LNU8FkT4BAr/FYyDuAN90Dzx13/vGFjhhG9fEG
7mwERlJcDeRU2/i9LsDzuf7hvmtjpw==
=pdBD
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
