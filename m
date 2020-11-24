Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395882C2D28
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390483AbgKXQk6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 11:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390275AbgKXQk5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Nov 2020 11:40:57 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FEF2063A;
        Tue, 24 Nov 2020 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606236056;
        bh=8hRyrH+e9jPA9ADN2yrZ91TecMLNXEDDHVw9OxfQm68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4FI692RUTMP1nyquq8bac1/iKDFtWsdrvok+tObajfwGMp17f4VtJuHfydgybk/y
         nx2oyT1wrGjSCtOZo/ZzZcWXErq4WiPrrPXZeMd8UfUyJZyzHQZI40TkzTphxQ/1xH
         D9xzKwI39fiQx0ylW3+sQFv56hmnhsyXu4kWkQL8=
Date:   Tue, 24 Nov 2020 16:40:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Grant Likely <grant.likely@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO
 descriptors
Message-ID: <20201124164033.GH4933@sirena.org.uk>
References: <20201106150706.29089-1-TheSven73@gmail.com>
 <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
 <20201111123327.GB4847@sirena.org.uk>
 <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
 <20201116210632.GJ4739@sirena.org.uk>
 <CACRpkdayWzWKHv69cg_GL2O=NWozqi_ZLnH1WdMOHzEb1bU-xA@mail.gmail.com>
 <20201118114049.GA4827@sirena.org.uk>
 <CACRpkdbJsiW_U2hrsT+t5gsbj+ow2t_kEmTQyD2jZxs3LCRfLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k18oBAwMkTg3OUap"
Content-Disposition: inline
In-Reply-To: <CACRpkdbJsiW_U2hrsT+t5gsbj+ow2t_kEmTQyD2jZxs3LCRfLw@mail.gmail.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--k18oBAwMkTg3OUap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2020 at 04:21:48PM +0100, Linus Walleij wrote:

> > What people think they were sold was the idea that they shouldn't have
> > to write driver code or upstream things, something with more AML like
> > capabilities (not realising that AML works partly because ACPI hugely
> > constrains system design).

> This makes a lot of sense.

> I suppose what we need to think about is the bigger question of why
> people/companies/managers are so worried about working upstream
> that they will go to lengths to avoid it and jump at any chance of
> raising a wall of abstraction between their internal development and
> the in-kernel software development.

> I think of this as vendor/community couples therapy or something,
> there is some form of deep disconnect or mistrust going on at times
> and having worked on both ends myself I would think I could
> understand it but I can't.

In this case I think this is partly due to the way people were sold on
the DT conversion - part of the sales pitch was that you'd not need to
get board support upstream, which is a useful thing if you want to run
things like LTS or distro kernels on newer hardware.

--k18oBAwMkTg3OUap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+9N4AACgkQJNaLcl1U
h9AmLAf8DM61FfpzGM4oQNZas4+G08OBlwKsgGSIdCGWJmARtSNsr/v/gU8uxHl9
9xHTfsELOPN14KEMMJ/cjbvZYETVFaRY3Awt/hGFyFk8Ry+qIMa8McDuEFk4qOKR
2JEuuKKXsIC0LS+9CPvK1lDqsAEmPdFjvgv6aKEjMdI60FhZznjqWPTDfDu0vyX8
/TNgMGhOrcz58URC93saI6+rUKm6QCP/4oY4ptnwQEUxo8U7cG8siurSLIw9kVhq
jae23kx9bng89T86IXpu8bFnHxw76ke6/Xsb/kwRf0YmgXAOV9e4vdwVb93qBgYU
Wvpjcfcoe5T50D19Xjt9LuUufb7waw==
=VuZO
-----END PGP SIGNATURE-----

--k18oBAwMkTg3OUap--
