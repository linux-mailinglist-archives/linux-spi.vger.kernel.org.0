Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF351DE693
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 14:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgEVMSY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 08:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgEVMSX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 08:18:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D30E20756;
        Fri, 22 May 2020 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590149902;
        bh=39Z2YC/hT0DLTH/QrHnGkxDnIs+bUNDKpwlJ2UMsj60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+Ft0HnjgAU98axSOB3qR/6xwnjzxBk9o9hYIlkj4SxFevAgTjyTLw4u6ckl1uXGB
         21ZP/qJQZNoRyC9/9+CrklTJUFWQ7ec5qhc0FpBM0QwQcTZtAZtJsdYb/vMgdVWfgR
         5JsYBJz38tYaVElZskAnfIKOkrIMKz3l+CoLbzK4=
Date:   Fri, 22 May 2020 13:18:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Alan Cox <alan@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200522121820.GG5801@sirena.org.uk>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
 <20200522000806.7381-2-Sergey.Semin@baikalelectronics.ru>
 <20200522111340.GX1634618@smile.fi.intel.com>
 <20200522115235.rt3ay7lveimrgooa@mobilestation>
 <20200522121221.GA1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20200522121221.GA1634618@smile.fi.intel.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 03:12:21PM +0300, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 02:52:35PM +0300, Serge Semin wrote:

> > Please, see it's implementation. It does atomic delay when the delay value
> > is less than 10us. But selectively gets to the usleep_range() if value is
> > greater than that.

> Oh, than it means we may do a very long busy loop here which is not good at
> all. If we have 10Hz clock, it might take seconds of doing nothing!

Realistically it seems unlikely that the clock will be even as slow as
double digit kHz though, and if we do I'd not be surprised to see other
problems kicking in.  It's definitely good to handle such things if we
can but so long as everything is OK for realistic use cases I'm not sure
it should be a blocker.

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7HwwsACgkQJNaLcl1U
h9DGbQf/aA5931PtrryL4ZW3uh64EHvrtq6HdmmV34g803DbZetKXoSdCysw7oSi
MdgShpfA9AR9+XVi5XuNVRh9REKm7VB54za86BUEm25d/W1x4G9rQiN5IxBLgwjZ
HUCMBgd+VG+ql4pm3PmtanE4K33rwAiMJf77Bdw+oKdqvQIdiXUzBkdsOCQ+pluZ
fOCeS+8ZfmX4nrg8f1Y8d7t633H4eHNbGe+H08iAsfBIGRfb7nmkdopxm6UviMbt
zOixF+I4sCyeiZAXY/5GeFc27QZyKc6qjd4LAPZIc3/kjIRg8d3CkjFYDDyw6Mgq
arVmdO3FsjblhLk4QYlHmt/Lc1alSg==
=H1CF
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
