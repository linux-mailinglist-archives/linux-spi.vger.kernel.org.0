Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E8375319
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhEFLgG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 07:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234832AbhEFLgF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 May 2021 07:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1CC261157;
        Thu,  6 May 2021 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620300907;
        bh=DiqP12Vg8J2d6hM0eOvFLpV7oR3nT9I8QI77NtuOz9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzArdHvKrANtpFIwPYJDBmAFfGoRcp3HXsVYohZdJW1sYatBvZivS1N/6gjrIGxYy
         DNK+II3OnJnRM0NxGbPFAkXvmCPnjYZ/WSHaxXAS2ZsT/XyartQlTs793Sc0SyFTWC
         6HxipSahBNGnsq87JuX2Y8bZnCbMmX+f7aLjPKLLiS36+blklvW5yX5Cw4ZUuLFgtZ
         jJrU+fUrIO2oM6WAXa+1smjC/A1EIbynbpwOT57IGQthckZM8La+bdU9t+14DONP9h
         +FhKqcEj8cjEDOQVO4ZFK5lESvyplYorWyXBQX8Q6YUj7RgtpCOchx8ePYyXY7gegJ
         IKPQvlS3jO7EA==
Date:   Thu, 6 May 2021 12:34:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jay Fang <f.fangjian@huawei.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>,
        "tangzihao1@hisilicon.com" <tangzihao1@hisilicon.com>
Subject: Re: [PATCH 0/2] spi: Correct CS GPIOs polarity when using GPIO
 descriptors
Message-ID: <20210506113430.GB4642@sirena.org.uk>
References: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
 <CAHp75Vfr8t9UVqVn6hLSN6Mi3=iNAn612eE-qKq9HfrwNhpg3Q@mail.gmail.com>
 <CAHp75Vei0QGaKiq5Nai7Gsa=jcMSipaXV_6qZbBy=f0OrN=DHQ@mail.gmail.com>
 <e919da77-a664-d78b-2c47-cc9ba8745a72@huawei.com>
 <CAHp75VdPYGLmDkmKETBHWLOQVHwZAdbk4wBtzMjXcX223eH1-w@mail.gmail.com>
 <CACRpkdYR99SRgDJEK6e-eT86hBOxz-Ym5pf8Zn+0k4u+i=nfOA@mail.gmail.com>
 <CAHp75Veoqnd3Hgzq8DAz-_=QxMt-+r608dkzPp67YA5eitLJNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <CAHp75Veoqnd3Hgzq8DAz-_=QxMt-+r608dkzPp67YA5eitLJNw@mail.gmail.com>
X-Cookie: If it ain't baroque, don't phiques it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 06, 2021 at 02:24:17PM +0300, Andy Shevchenko wrote:
> On Thursday, May 6, 2021, Linus Walleij <linus.walleij@linaro.org> wrote:

> > Curious that ACPI has SPI CS as always active high,

> Here I didn=E2=80=99t get what exactly you are pointing out. GPIOs are ac=
tive high,
> due to historical reasons. Otherwise SPI CS depends on the actual hardware
> and may be (most of the cases?) active low.

SPI chip selects are almost always active low - the signal is often
written nCS or /CS for that reason.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCT1EYACgkQJNaLcl1U
h9BtRwf8CmSo0LBbA+fnpHRVtFy4gGNTPypwY9UMtIsBN1Egb/9HtWlfewD3TcDF
K/x3Qx6M1SdZHkCkpxN/QWVsuJxKxZm2YbGzCG4WidQ4js9aufOX+QrKEepcmPCP
hW+4H49yn6HRCU7MD0qOEI6/OwDhiYq7TDpFWnJSZ0+hDhp0SWkU8yjkOcwJvTfz
Rf0f0tFmv5i+C2H7x6+T/2DydlrUBE7CXreNgR6fY5wbBMftnTDN7C2znLusm6mN
t1Xzh7BIMkmVwtwZ8daUem6Pfy+3PhWd+4/pDpg9yR10m9CcjRBwfaSBh8iggVhx
DDDnRebtd3kg7nnBEl/9pCdwuro6Gw==
=Z+no
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
