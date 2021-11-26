Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2A45EE89
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKZNIo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 08:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232653AbhKZNGo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Nov 2021 08:06:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED3506112D;
        Fri, 26 Nov 2021 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637931811;
        bh=QAD0fqmVf1jw+Lf34IzKs9qrKK0uHS/qI3FqYFyGPUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKANirDWpF/myNR5ipSftGhbDebfwA7La+sx0YQlzbe2cPhCC19xPhAgrwGFO8kvR
         wQbuX/mhjxpj39j9KBsZeY+OzDWuuqpxsIFRVJKoUUMbi2RFWEdtnlNAyfRn3gUQZS
         DouWfymP4T1+Vk65IW29q02hXY3jDiRor0ts5Qlkxcd4gIp8/XbCjNZfVUNUIV9PjU
         g+vmI08PxT3ABDVegyJGE1DgEPQQw0OG/KGM9jdbYtRcrjW1GMVQXb2J7oG7f7GZDv
         rvmKa7IngxRhbwZeVxprBzfH8TIHtZjbn6C1cv6imSClWISvOrV7oXMjLlxYjkxGJV
         XF3zO5TdMkJRg==
Date:   Fri, 26 Nov 2021 13:03:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lh Kuo =?utf-8?B?6YOt5Yqb6LGq?= <lh.Kuo@sunplus.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "LH.Kuo" <lhjeff911@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v3 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YaDbHe+COa3pke+s@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com>
 <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
 <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com>
 <YZz0n6Mpjl3tKmMe@sirena.org.uk>
 <CAHp75Vf6+monqu4Hq-yoFSohD9tNFqZTuKjqDDKAJE3Om2BUYQ@mail.gmail.com>
 <6eb68a8153ba46c48862d00f7aa6e0fe@sphcmbx02.sunplus.com.tw>
 <CAHp75VftSORts5cbDxvfyHgqhxmb7K74BfPd=mST+75C+Ch9dQ@mail.gmail.com>
 <33d50e94059b4734939db60b5c531bc9@sphcmbx02.sunplus.com.tw>
 <63a467164c985cadce0e28e50508363a8d2f6622.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ljQ879YUAyNrToFD"
Content-Disposition: inline
In-Reply-To: <63a467164c985cadce0e28e50508363a8d2f6622.camel@pengutronix.de>
X-Cookie: You fill a much-needed gap.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ljQ879YUAyNrToFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 26, 2021 at 11:36:29AM +0100, Philipp Zabel wrote:

> > 	pm_runtime_disable(&pdev->dev);

> I'm not sure if the SPI framework requires the spi_controller to be
> unregistered before hardware is powered off, maybe it is enough to call
> spi_controller_suspend() in the right place?

It would *probably* do the right thing but the expectation really is
that you'll unregister before making the controller stop working, that
should be much more robust..

--ljQ879YUAyNrToFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGg2x0ACgkQJNaLcl1U
h9Cxlwf/XZs/9xTqiksXDYhiMOpt6+eD4gpanC5q5BSuqZkuUFHjGzpqL/v/s/+V
edvkwQJDwb82Y2oKRhw/hZc4xA395j9lKmeJSWLyzCklvYlSIOAt4CPZx9w91Qsz
NNONWU+zLwo/tt1ZM09eIclf6fQ0ef04cmjNxgpv0cq/VhmlrbjsjKGj3ViRU0p5
Bz+ODOy0weYPH0VS9NDJlq2yzy7/M6dDN1vae/vApUDGUcSgiYr3+tZ/9LOugTTv
D+SUjWC/L8Wv0/TAbwBVpRwj0hyaWCkaPAkzT5nZxIvk7TKFprjOWvl3JHYqXBkB
/dyYP4Y8jc47Ya55wbhIZ+rpOExJ4g==
=ZANf
-----END PGP SIGNATURE-----

--ljQ879YUAyNrToFD--
