Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2C27EBB7
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgI3PCT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 11:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730774AbgI3PCS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Sep 2020 11:02:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD8B2076B;
        Wed, 30 Sep 2020 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601478138;
        bh=wgtBREp7GX7jbTg82MpTBnYDUzeeak3Og8bQ30VgTOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Smk8kFJMwkYcCnbVbtfFFoTNbayV3wRb26dNEP8swsoz8DiuQYekD50RLqfuTno3G
         82Z/0H6CU5WFRTM3FHCxYjJaedyNojyqkU4xV73tmkekTG6l1l67tsDldfTpLc0IVN
         1IYQd0/oSlcy7XbPHi+ljZh5kXnsmRazfaegMRJo=
Date:   Wed, 30 Sep 2020 16:01:17 +0100
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
Subject: Re: [PATCH 02/30] spi: dw: Use ternary op to init set_cs callback
Message-ID: <20200930150117.GK4974@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-3-Sergey.Semin@baikalelectronics.ru>
 <20200929131153.GD4799@sirena.org.uk>
 <20200929215553.xgst2v5ssweymlpw@mobilestation>
 <20200930145759.7djm5xijhg6mjtg3@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jITzwD3HDGXid3BE"
Content-Disposition: inline
In-Reply-To: <20200930145759.7djm5xijhg6mjtg3@mobilestation>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jITzwD3HDGXid3BE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 05:57:59PM +0300, Serge Semin wrote:
> On Wed, Sep 30, 2020 at 12:55:55AM +0300, Serge Semin wrote:

> > +	if (dws->set_cs)
> > +		master->set_cs = dws->set_cs;
> > +	else
> > +		master->set_cs = dw_spi_set_cs;

> Judging by having your comment on this patch you obviously didn't like the
> ternary operator used to assign a default value to the set_cs callback. So I
> suggested a solution, which may suit you. What do you think about it? Agree,
> disagree, insist on leaving this part of the code along, etc.

That looks fine.

--jITzwD3HDGXid3BE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90nbwACgkQJNaLcl1U
h9ASfgf/QMr+QBDA7a6p663htW8/oE/VfyDebGfO+9YvBL8at6ceQjbrmSFPIY+Y
p6UxWjJYM8gqayOZmJDOLwHHqs+EF56WKVfLJk2qM9vKqsDBPS99Z+Nt1G7Ufzay
nqYReurEdo4zXbdbq+0yLcI6P6pBwUJOVzOcqwwxW+7gCQzWOvG+YJUawvkLscT6
cizglDz2zEc3CJCltivU6jWUcLKWSukbPQFLrxt8aYQtMZs4zu350iL/4d0aFIa1
/McGgJYh7XCVgQFioPn7IFocfrlCJETL1vz5Jdnkdr3EooihGbo+nuSDHlqk5TPW
inCxg0N+muJngYfr4HY3g4VU4qzO0Q==
=Pczo
-----END PGP SIGNATURE-----

--jITzwD3HDGXid3BE--
