Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D8027CF21
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgI2N3L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 09:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgI2N3L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 09:29:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8DB0208FE;
        Tue, 29 Sep 2020 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601386150;
        bh=cFnWipWsvzKq0QWJiU/ZjmzGD2hQyr2IG3LD/6DIPNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twh62VJHIJHrbjpauzhuMluy8KBotG8kEzuwCsBMwVuJUb9S0PqiLWFqHXjY9Mw9c
         Um7Q+fE0TLWvcAX/9ZHwmC8Iu6KnmHI/S9ux31ZOAQo8OEO5EQhO4Ypvg14cPLLaiS
         Wx0zCHEjczonFOCggJY7WanqVaci7XCan39om1cs=
Date:   Tue, 29 Sep 2020 14:28:11 +0100
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
Subject: Re: [PATCH 04/30] Revert: spi: spi-dw: Add lock protect dw_spi rx/tx
 to prevent concurrent calls
Message-ID: <20200929132811.GF4799@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline
In-Reply-To: <20200920112914.26501-5-Sergey.Semin@baikalelectronics.ru>
X-Cookie: I left my WALLET in the BATHROOM!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 20, 2020 at 02:28:48PM +0300, Serge Semin wrote:
> There is no point in having the commit 19b61392c5a8 ("spi: spi-dw: Add
> lock protect dw_spi rx/tx to prevent concurrent calls") applied. The
> commit author made an assumption that the problem with the rx data

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9zNmoACgkQJNaLcl1U
h9BBvQf/QU0hc1jrkeVXFBPWkdr9yvmXWX8FQWaMUkx3ukXHKkNYv9cLZFj8Xidx
DRJAaNwueEpbihutbrA67Q5Nos6OzJPE6YKMvKIVNfYAAedPzoEX7qPM6grfT5ro
ElFdLB7goGfTB+44utjSAg7LY7oLU6aemiz+6WHwa5wECOkEam3aLikY/9hi3Hvn
+u+3BSza0zzsori3UFXlQ6ueJ70hkPSZIuw1hCLv6NESLe0+NF5bUU5TOt+GzyxQ
QNX/+m3OvhvugoOXj1pHN+oGT6Co7HCq9kU9o+OB32Vj67jj7oyMET66UmdvoA8z
ASXi4cslqY7yqjhjYN+MvtjSfrLNng==
=UrRA
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--
