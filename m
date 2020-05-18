Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532091D7915
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 15:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgERNAn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 09:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERNAn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 09:00:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31E71207D3;
        Mon, 18 May 2020 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589806842;
        bh=ptRx364m99gLe8b4PaIDcBg1wnlIqZ8QZv5aW8MUiz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQzpbw6R9xMhb5YxMbk+I5cOwk4cKSqiUvPIAPk2g2tn7hxb6qM7jfsQuxZssQb1a
         hfZSCeSH6jLbjicpFxDTPaELYYSymjlg9sBJW17riIRjSiRtzxwlF/6Ft5xZ2+UF5A
         mM01N8gkmEJ73LftdVnTgDRKvrQao8c184wQabzQ=
Date:   Mon, 18 May 2020 14:00:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Joe Perches <joe@perches.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/19] spi: dw: Move Non-DMA code to the DW PCIe-SPI
 driver
Message-ID: <20200518130039.GG8699@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-14-Sergey.Semin@baikalelectronics.ru>
 <20200515145153.GJ1634618@smile.fi.intel.com>
 <20200516201724.7q5uhxmzpr6xjooj@mobilestation>
 <20200518125850.jnhaqlr2ticu3ivs@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Content-Disposition: inline
In-Reply-To: <20200518125850.jnhaqlr2ticu3ivs@mobilestation>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2020 at 03:58:50PM +0300, Serge Semin wrote:
> On Sat, May 16, 2020 at 11:17:25PM +0300, Serge Semin wrote:

> > Only if we rename the spi-dw.c to spi-dw-core.c. Such modification will break all
> > the pending patches merging. Mark, are you ok with this?

> Mark, could give me your comment regarding this renaming? Are you ok with this?

Either way is fine for me.

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ChvcACgkQJNaLcl1U
h9AEsAf+Mvi0DahdPQXvlc5p6J2WfVIC/Nfkr+2hZJdtns7zXQVZpaIxk+465AR5
6GHgGMkKnqIjRRx3MuoHR4CHa8+JX9F0yfxl53XICxtFoCbT7gjOmHEtwylQf7pY
hx3jpxE58Eeu8QhelS7udCNBSOq+wHu250YLde1MzGEoHUUdsYCIvmDCfsY3/2bU
REDvwVOdRHapxoBbg9TXAVww9Py7J++EBbYW9SLwqUGz1r8rZN4Hu9MasIDTzt4w
+aBUrl9JoIRjL/ll6uIgj87+vkl2qelmTQVKEl/dbkhMCfjCii60gucyjvMi0Dte
yrd7rPguLhaezc9A+kHaMjJua6jW0w==
=TYaY
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
