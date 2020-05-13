Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E26E1D0FA1
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbgEMKX1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 06:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbgEMKX1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 May 2020 06:23:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2ADE205ED;
        Wed, 13 May 2020 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589365406;
        bh=SgltVphT3mpSTEBHdav7w7v68p4IcFWaePiyBQPkO8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NrsN+a3kpBa7OFvfx9JXEBF+1YkN3RgZILtNd4fzcVkmVsRyKxSyx+gt6YXsmbXrz
         Hx1RfoOlKR1O+niAskCU80lQ2ZSQTI3Q6rmpzlyPMTGKgmrfJJinz9rZfb/cTjDtwl
         gI0HCGuNKK1ywI5CqXsbEbg51rVPBG0qLm+l4fIg=
Date:   Wed, 13 May 2020 11:23:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Message-ID: <20200513102324.GB4803@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508133336.GK4820@sirena.org.uk>
 <20200512200733.bdbbhkjkwjd5yzqq@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20200512200733.bdbbhkjkwjd5yzqq@mobilestation>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2020 at 11:07:33PM +0300, Serge Semin wrote:
> On Fri, May 08, 2020 at 02:33:36PM +0100, Mark Brown wrote:

> > Please don't make new feature development dependent on conversion to the
> > new schema format, there's quite a backlog of reviews of schema
> > conversions so it can slow things down.  It's good to do the conversions
> > but please do them after adding any new stuff to the binding rather than
> > before.

> So by saying this do you want me to revert an order of the first two patches
> in the series, right? So the series would first add the DMA properties support
> to the binding, then would convert the binding file to DT schema.

The conversion to YAML format should be the very last thing in the patch
series, and as Andy says there's another patch in flight also doing this
conversion which you should coordinate with.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl67ypsACgkQJNaLcl1U
h9AodAf/V7hLsdN16eZChRbVtE6dJ5AQUp2c5eX7YNYnMNJwp1c/rBpMUNUA8YL+
noBZvjVO2gt+2IwQWc1EZhxbHT1r+6tX8UCrddNFQ6yJi8xsTnUZk3GV+2nd0B6w
neS85VfshHlLkOZxoaBd7k48Z1aDmdYUkzgBZ432BHy5yzR4uE4zU8BZtcqkvBBT
qs/Cd9VftFV3zv1HUofjURdirNqylzsQoApRaGtJT79eqZyt/0cSi2bWipJAtHTz
lhVWfqby7g4FI+GGUYSvjY3eo4flsLhWk/hML+wQoZoSZiBvjoz0uoZnsM8FVQ3w
4X17XlyTkbM6XVYez5I8xYh3U6TyoQ==
=6nLk
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
