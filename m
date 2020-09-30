Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5527EB36
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgI3Oos (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 10:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgI3Ooo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Sep 2020 10:44:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C3C206FC;
        Wed, 30 Sep 2020 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601477083;
        bh=qt7pfXhhMPetwSOE19ksOBdlPYEQgZvgP2oT8Ll9FWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wDnGt683QhtK7gZSqDOgZ5zdJ+MlWU+hNiGXg0fuHDa/C/Te5hWFf5b9kXC1qbay3
         HzVcB6rR3eUFAW2m9hG8O//OxXOtVP2B7k3E90Tq6w7J/WeCepjlsttp/f8yosuPjS
         BPbO0/i4rJo/GNqZ/w+aQ6ZHNLUlgrShAlWJzwdk=
Date:   Wed, 30 Sep 2020 15:43:44 +0100
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
Subject: Re: [PATCH 00/30] spi: dw: Add full Baikal-T1 SPI Controllers support
Message-ID: <20200930144344.GJ4974@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200929144351.GH4799@sirena.org.uk>
 <20200929224303.65awobe5dzwc2p4f@mobilestation>
 <20200930110403.GD4974@sirena.org.uk>
 <20200930131115.2lizge2ff64jbgpn@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zOcTNEe3AzgCmdo9"
Content-Disposition: inline
In-Reply-To: <20200930131115.2lizge2ff64jbgpn@mobilestation>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 04:11:15PM +0300, Serge Semin wrote:
> On Wed, Sep 30, 2020 at 12:04:04PM +0100, Mark Brown wrote:

> > Not all of the first 9, IIRC I skipped one I had comments on.

> Yes, you skipped one and I've already given you my response on your comment
> about it: [PATCH 02/30] spi: dw: Use ternary op to init set_cs callback
> So have I responded to your comment on another patch:
> [PATCH 11/30] spi: dw: Add DWC SSI capability .

> I will need a response from you about them to go further with this patchset.

I'm not sure I saw any concrete questions with those?

--zOcTNEe3AzgCmdo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90maAACgkQJNaLcl1U
h9BkJQf/YxSDENRYeU12odA8T9vIC5Bx+tNv9uayK8uZGOrRDPNOsnb+w0gvuCP4
s+zg6vQ5GVqZ5er1c4w7fUT7OGvj0EV+ofIEcpc3bBcWMFxxvCb0nXr2269jWYxU
1ACB6DM/GRz7JUXxTIiIvfWa0JPJSY3ynnhf5Ke2mpDeGZmx3gXTqu8tyKJUy1sC
H7VpYtc8ZpiQZJ9U0XvtTfj9P/VqQTuzV+7Ha//yf0nGpWcMRWjTsCvxNoXbD4GR
ecDq7NDfZY2q+iW5ao9YrCAeyGiDStUpBS/a375LeHY796IpiIn1tsi9jvvtfIIa
U9JXWH2OujGDhptZwqh4uN7nFV/BEw==
=FgSu
-----END PGP SIGNATURE-----

--zOcTNEe3AzgCmdo9--
