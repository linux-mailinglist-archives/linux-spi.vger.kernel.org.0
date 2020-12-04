Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003C62CEDEF
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 13:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgLDMSQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 07:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgLDMSQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 07:18:16 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E50C0613D1;
        Fri,  4 Dec 2020 04:17:35 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id m19so8335469ejj.11;
        Fri, 04 Dec 2020 04:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e7HzYQO3YzaI0Xq45plj0++Cajn7NB8YJZgNffWWxA4=;
        b=KBlaqyjMl7riblXcTBbWspPKj0sJsIQ2ErZOIBCKOjVwdQDLZ7fung3hIMdbklUoKP
         HBnwGKAxewZ7Z96Tay+7x/WfALEJ9cQQGBDxaY4YNuph94maXWBq0jAhxTWkWJF7TQkU
         +nyxRYmjs74gg4RQnqPkKp6cHXfWdhegzigJmUtQdLZfR0KFATUdQRIOFB1dzg/Y44Zc
         VPrQ1e5HYRsrC9cFN8vMG/HTZXgc/wkum1WGmV0ssRJils+lX+mtiNY/X2BsHv/j3ZXv
         yHh0gN4h6oSz26nk+p6EsTMX06byZdF2WQXoiT8x3yozkcEz9YOr35TtZXBQehy7qao+
         d9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e7HzYQO3YzaI0Xq45plj0++Cajn7NB8YJZgNffWWxA4=;
        b=MNj6SLeMLErxKFwPTg74LiTW85W6cFbroJmsJmkpr2k6UW6a1qRGAEciad3JIhdo9R
         SSgAkCyoxZd+d0T2EaeOY1NvwIQDw6lt/6LzFmHVRWXigQwcFCJHe8HgwRRgY+gCepZR
         XsaIxqFFzmtKPIRnffbX8ZUTEVwn4ireqgEDGmVSieE0d1O7rDMKzDtoxSQ1qxtlyLuZ
         dJsJ8PWJRchPIb0UBKCqvW9KaZzGhD173jyxYPvosASwdf2Tyd0qxrqoHUDHwsiNjs8P
         uef5LwQlc74g+RYS0PbmMj0qQWf/L3Dr2MLnX7MhapI3lY31vX/XgHRZ2rS3FZwdT5/r
         e3/g==
X-Gm-Message-State: AOAM533l4D988fYWC5yqF1DDpwl0aI6qOHM3whdoPeKixSQltju3VGHq
        Qo5nrwcietlD4CzIODcCM5SQhsBBiaE=
X-Google-Smtp-Source: ABdhPJx5lKqbhIGDNLL8xRRS9zB7p9lJruZqfGfomwNiWlIPl4HKe+VDZEFNgMb9YpgkvA/GKxp1Eg==
X-Received: by 2002:a17:906:5912:: with SMTP id h18mr6698916ejq.261.1607084254307;
        Fri, 04 Dec 2020 04:17:34 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id y17sm1111628edu.44.2020.12.04.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:17:32 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:17:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <X8oo23vly1SYKjbI@ulmo>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201202172721.GL5560@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i8Lsqvp6HbXRxqD7"
Content-Disposition: inline
In-Reply-To: <20201202172721.GL5560@sirena.org.uk>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--i8Lsqvp6HbXRxqD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 05:27:21PM +0000, Mark Brown wrote:
> On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
> > Tegra SoC has a Quad SPI controller starting from Tegra210.
> >=20
> > This patch adds support for Tegra210 QSPI controller.
>=20
> This looks pretty clean but I've got a few questions below about how
> this integrates with the frameworks as well as some more minor issues.
>=20
> > +config QSPI_TEGRA
> > +	tristate "Nvidia Tegra QSPI Controller"
>=20
> Everything else in this file is SPI_, even the qspi controllers.
>=20
> > +++ b/drivers/spi/qspi-tegra.c
> > @@ -0,0 +1,1418 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 NVIDIA CORPORATION.  All rights reserved.
> > + */
>=20
> Please make the entire comment a C++ one.  It also appears that the "All
> rights reserved" here conflicts with the GPL-2.0-only SPDX statement...

My understanding is that this phrase is pretty much irrelevant these
days. Furthermore, I don't think this is to be interpreted as a claim to
any rights other than the copyright, so it's mostly equivalent to the
"Copyright (C)" on that same line. Any license terms associated with the
file do still apply regardless.

That said, I'm not a lawyer, so don't take this as legal advice. FWIW,
there's something on the order of 8000 occurrences of that phrase in the
Linux kernel sources, so I think with or without the phrase we should be
okay.

Thierry

--i8Lsqvp6HbXRxqD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KKNsACgkQ3SOs138+
s6H62Q/9Fwa6i9csrNhhvi0flxowro5rRfpFy86gUQp2HX2f6ZiJ3zsN33Q9RF1+
mH/dMXdPoLvIx9eBnr8YshoU37O03H8WyoA3rD0DWmZa6nEc9lLdS/00gF+5frWx
W0s8TkcE1fsK/83GceEPmiWWJ8+geOqzdpaEQEoIkxuu4IXhq5ba13HVpWf4Zsbd
uPAuZVwbeO5ZVn2cKqEIkMvNCeZmx0zlgvIY0huoIYyjqbRXfChz27jnayWxqzF8
ljszXMEEasNGY91u7KcxphYtlJohE05Gk/fs5GKVIytkQ2+GeiRkAuHNPIIWHX6R
FB2h7DlV/8/oMmPjjGtiSvoEk4qT/reSDLU5DBMIcMUr8AxHqVWkk++r8gNBh2SV
U3KsvJ8MnwZeHn6you+e9b5kKVYVXbZyMclbCWWIWx3aJtASuppLQU0KvI414akB
5OopHQbOruFf2+ubusKLz7ICD/ynQ+JixMkSCZ3eb6yXmctnb2KgfPccjYcsBUrS
fs3oGKJYC6O8/aD/Z/rUrgeTutxQsPL1l0J4hxsIOpTcHlXI6AoOfVeaalO2PCnp
AC3O5abTmGVfkOtV9quC5/0WW1lAiYE7vOfiCNiJc2fVtZ5ST/DvtQGt+7isLfcy
zxnRghHODNCk+eMPZpVsUIjanoU4z1fnly8tBK75TmahjtRHYdo=
=5NKQ
-----END PGP SIGNATURE-----

--i8Lsqvp6HbXRxqD7--
