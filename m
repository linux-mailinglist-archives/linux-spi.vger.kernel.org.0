Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9341D4DE5
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOMle (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgEOMle (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:41:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5242074D;
        Fri, 15 May 2020 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589546493;
        bh=hMPK6q3eUtJxBQ+2esxAxFRSSLe+V9kh3wpoNhsQ/5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x2Cd8itMuEBuL3bi5iQnvOyhHUd2e9Tk3dY/F4FbBEazLtSOrXMVP33Z2bDBQMU0z
         LeCYbmTumiKrCF3jLJSLZ0Np/GWA/lB83/wj15vIT8Zo47J6x7Fz5mNFxDxFZDQqBJ
         +qxdyLrnnv9JiMOGk/KYJca/1dyUD6TyrXCLp/e8=
Date:   Fri, 15 May 2020 13:41:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200515124131.GE5066@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-3-Sergey.Semin@baikalelectronics.ru>
 <20200515120111.GV185537@smile.fi.intel.com>
 <20200515121815.GB5066@sirena.org.uk>
 <20200515123702.GA185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <20200515123702.GA185537@smile.fi.intel.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 03:37:02PM +0300, Andy Shevchenko wrote:
> On Fri, May 15, 2020 at 01:18:15PM +0100, Mark Brown wrote:

> > Well, nobody wrote one.

> spi_delay_exec() seems quite good to be used here.
> Can we use it for delays?

I guess we could, though it's really there because for historical
reasons we've got a bunch of different ways of specifying delays from
client drivers rather than for the executing a delay where you've
already got a good idea of the length of the delay.

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+jfoACgkQJNaLcl1U
h9BKTAf/TvLyXpdq3y47lMcIJW0azlHSYYpsjhk7KL7FYaThbTENaUIDlLt6vuWn
Ey1uwQIbmiCXbW0QRmecmmGvMmi9Ws1GOgI0m+mHGP8R/1heZllkp2SV9SQ92LBP
+I/oHQFDs1ZgJEQT7Iwoi+ebHZo0znU6hlwqqinSGF24Js9RWwlgibv7ZAvXqRmz
/FkzjpS0NngqX4zK1zwKhATuAQ4mov+VyD5nTd+qh627S/ZzbvJ6Io71ysv+HvZv
4Ep3N6G0dKgnw2r0n78AAgmXd3GvhPjxA9an19Uq24tk8BqCRH4MJ47Y3XitbTlg
hTiDVd3ieHb+88LR17aMP0M0Oq82/A==
=Tx+Y
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
