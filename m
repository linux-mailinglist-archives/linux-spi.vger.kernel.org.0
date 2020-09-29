Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5535F27CEB0
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 15:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI2NMy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 09:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgI2NMx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 09:12:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB85208FE;
        Tue, 29 Sep 2020 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601385172;
        bh=2rl44aidI3q+YJ67zNfJz2z3LJuhtx2vNYInVu39t9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxOf2Jt/xCnYJi6WX3kh0Yk4uHi44l0tqvXJqn+0wELxV2JcMAB4ecyfSDL+ZrG1i
         nj5zBUWZofzBntN0foiDSAK9XvGMnF3EquTu+mtVQPyqTWtvNFE5NYShcqNIMZnXIk
         ZowA64huVCkLUGkJx0D06y4l07GXH7AFJUmVGODI=
Date:   Tue, 29 Sep 2020 14:11:53 +0100
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
Subject: Re: [PATCH 02/30] spi: dw: Use ternary op to init set_cs callback
Message-ID: <20200929131153.GD4799@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <20200920112914.26501-3-Sergey.Semin@baikalelectronics.ru>
X-Cookie: I left my WALLET in the BATHROOM!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 20, 2020 at 02:28:46PM +0300, Serge Semin wrote:
> Simplify the dw_spi_add_host() method a bit by replacing the set_cs
> callback overwrite procedure with direct setting the callback if a custom
> version of one is specified.

> -	master->set_cs = dw_spi_set_cs;
> +	master->set_cs = dws->set_cs ?: dw_spi_set_cs;

> -	if (dws->set_cs)
> -		master->set_cs = dws->set_cs;

This doesn't look like a win for legibility or comprehensibility.

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9zMpgACgkQJNaLcl1U
h9BCEAf+LUL3IhFgY8tpN/cxDegxeKq+2luBPnBzkz4mnoVIAU2IRLjszEkA1AhE
0+Ggq8GQjaAllOEKlP+yALng0JAQgCX+Skvlxy7O00I4nWdwVFf92r8KSh/0TUTW
FFplexpsYJlLNN7XosVsuKKc2pzYXmp7FhBAklu0VBHUi/T/cc76veo5sTIZuaUM
eVq4MYe7cbczRQ53QvqG5CJmy4QS3h7KkyIcuSkEouR/FNKMHBLliK5E2ybbO5k/
nfNnvkbKWQpnDj58C7/Gx3+X6419zptudbKW2OCmYqJv2QaHSgc1SqDhFHRX5Ue8
IHcUc0pLkvjrl2hTn5TEtwhQhOMBkQ==
=eJqS
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
