Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837FB28133A
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBM4u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBM4t (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Oct 2020 08:56:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5DF7206DC;
        Fri,  2 Oct 2020 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601643409;
        bh=0ZXo3fdb400Wi7zTirNJi+vIRV9asZikW2THLjL9Fq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBGuG5VQsj2N3F4O70bdAHANb0swRshE3sqyFD2xCSnGYwS07cIR6uMQUMKAR4/W+
         0CnYf6aVIGZiEZ5CRcmpBqjWrBsaMDrsYxiY2WCQttd/tmjPfQGa0tdmbRaC4WKtM3
         BAtLQ4L7guLXI4BI13Uwp26e3/s29XEb5CZorAvE=
Date:   Fri, 2 Oct 2020 13:55:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] spi: dw: Add full Baikal-T1 SPI Controllers
 support
Message-ID: <20201002125549.GB5527@sirena.org.uk>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201002102444.GY3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20201002102444.GY3956970@smile.fi.intel.com>
X-Cookie: Words must be weighed, not counted.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2020 at 01:24:44PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2020 at 01:28:08AM +0300, Serge Semin wrote:

> > the subject. Though some of them are mere cleanups or weakly related with
> > the subject fixes, but we just couldn't leave the code as is at some
> > places since we were working with the DW APB SSI driver anyway. Here is
> > what we did to fix the original DW APB SSI driver, to make it less messy.

> Maybe it's time to put your name into MAINTAINERS for this driver?

Seems sensible to me - Andy, it probably makes sense to add you as well?
Does one of you want to send a patch for this?

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl93I1QACgkQJNaLcl1U
h9Doiwf/TdOWB+DygK44AJ9c0G4abf7KIjbpqcyPh6MBmaEV7dDvZv90r43zabkJ
HP5jwcdiGjtBKhGRSIMjrs7REmqNA2HBn8lH4VIoKbWVL9znfRRDwPeT7YY7W7k8
pU+lA6KUrHomWjg38I+ln5Ff2DmracaIEH8fxQkP7VBTwpIRjf4QiuaRXmhZdCgG
gYNzhmu5rezd9rjezUdcFHM9mmJ+UKCZcszmM+vYoWmwgGp778g8ka7bR3SPRB/x
Z2q0E9gbjQU0XOE1R1xpPjlh9pINELSnIReEANoNeeo0CycXEDeHG3MXS3xgQu3S
BIDecFRQU4r1T2o7hX/Y0oKo2RRK6g==
=lR8c
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
