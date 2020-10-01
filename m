Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293152809AD
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 23:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbgJAVwI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 17:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgJAVwG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 17:52:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24532206C9;
        Thu,  1 Oct 2020 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601589125;
        bh=vsvc818owkKY7m+LLobuNLysXuCTizF+7zmEKBikfsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otf/xA3yihY8soX97e3Sm80bwRSVkiv/5HjdVnIryYRKrXWbUU+ecGCZeeqQDlQ4U
         IcAU+PKPRt2/zutafqmrFTD0Y6lv21Mjdeax6vfcRLbQ7rd+xYcsjaynR0+dOJYugO
         Mepmjz2M9ZBE3lWrwveoeBKqElL4JiKaKikrSPaI=
Date:   Thu, 1 Oct 2020 22:51:05 +0100
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
Subject: Re: [PATCH v2 02/21] spi: dw: Add DWC SSI capability
Message-ID: <20201001215105.GA6618@sirena.org.uk>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
 <20200930185545.29959-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20200930185545.29959-3-Sergey.Semin@baikalelectronics.ru>
X-Cookie: You were s'posed to laugh!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 09:55:26PM +0300, Serge Semin wrote:
> Currently DWC SSI core is supported by means of setting up the
> core-specific update_cr0() callback. It isn't suitable for multiple
> reasons. First of all having exported several methods doing the same thing
> but for different chips makes the code harder to maintain. Secondly the
> spi-dw-core driver exports the methods, then the spi-dw-mmio driver sets

This doesn't build with current code in an x86 defconfig, please check
and resend (looks like you forgot to update dw-pci):

mnt/kernel/drivers/spi/spi-dw-pci.c: In function 'spi_mid_init':
/mnt/kernel/drivers/spi/spi-dw-pci.c:52:5: error: 'struct dw_spi' has no member named 'update_cr0'
  dws->update_cr0 = dw_spi_update_cr0;
     ^~
/mnt/kernel/drivers/spi/spi-dw-pci.c:52:20: error: 'dw_spi_update_cr0' undeclared (first use in this function); did you mean 'dw_spi_set_cs'?
  dws->update_cr0 = dw_spi_update_cr0;
                    ^~~~~~~~~~~~~~~~~
                    dw_spi_set_cs
/mnt/kernel/drivers/spi/spi-dw-pci.c:52:20: note: each undeclared identifier is reported only once for each function it appears in
/mnt/kernel/drivers/spi/spi-dw-pci.c: In function 'spi_generic_init':
/mnt/kernel/drivers/spi/spi-dw-pci.c:62:5: error: 'struct dw_spi' has no member named 'update_cr0'
  dws->update_cr0 = dw_spi_update_cr0;
     ^~
/mnt/kernel/drivers/spi/spi-dw-pci.c:62:20: error: 'dw_spi_update_cr0' undeclared (first use in this function); did you mean 'dw_spi_set_cs'?
  dws->update_cr0 = dw_spi_update_cr0;
                    ^~~~~~~~~~~~~~~~~
                    dw_spi_set_cs
make[3]: *** [/mnt/kernel/scripts/Makefile.build:283: drivers/spi/spi-dw-pci.o] Error 1
make[2]: *** [/mnt/kernel/scripts/Makefile.build:500: drivers/spi] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/Makefile:1788: drivers] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:185: __sub-make] Error 2

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl92T0gACgkQJNaLcl1U
h9AbgQf/bLX8RD1tQDCh33nB1KcN6vn/sXlOf4oGW97OBz+PbG0cvrdEg5K/qywQ
83N9YV0m7p1ZUzw8FRHz5tl3paBb+rHRzljzz59EletxikeGcyKJeY8KzEQXeRoP
OOtSuz98J3TMx4bUB8/WgnLou1A4r+ecxDUZOTVHtf9UaePfhlxzr4VUobIZmFna
dg9GRjyhu5mfW1ao0i2crAXmhODpS7seYVhv9d9hJqJCVBEvi5QlYBBbpQjUSeHm
US2uNdvlhkM3xyrerabhe2KuZL2KvUTwHxDDy0hS56fQ/ZsvOX4lENyQO93GEVmk
JDm/dOVOXH35Au6pbOpLsClOu/5S9Q==
=Aqgk
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
