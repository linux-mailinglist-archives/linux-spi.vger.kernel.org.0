Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468771D9462
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgESKcv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 06:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgESKcu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 May 2020 06:32:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D6E206BE;
        Tue, 19 May 2020 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589884369;
        bh=APWdI/sKggcPUHM2EoqZ+F9oniCqmilI7u/Eu8rmUKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bb28hbkXTcnwyAr3AkQbQd7zAtdLWJXiwF/dtuByEyX/N6X+HswiTH+JVTDGBxke9
         PRaBWt7ep0OcLP0hk1XvvEZBbrGuzZtn0CFZ5SqDVCMU8CkMuKgVJvzlMPWmK1ng2s
         mB1xyHCzSfVJvy6NpiLF0vKH/DThsK16CNtbWd+U=
Date:   Tue, 19 May 2020 11:32:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Message-ID: <20200519103247.GA4611@sirena.org.uk>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <20200508113751.GD4820@sirena.org.uk>
 <20200510002039.hwahqasnnceowskz@mobilestation>
 <20200511212506.GA23852@sirena.org.uk>
 <20200518000542.ohtpem3lo2pbixbu@mobilestation>
 <20200518151946.GH8699@sirena.org.uk>
 <20200518211727.jrzo6tn7slqzxoyl@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20200518211727.jrzo6tn7slqzxoyl@mobilestation>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2020 at 12:17:27AM +0300, Serge Semin wrote:

> Here is what we need to do to perform the EEPROM-read operation:
> 1) Enable EEPROM-read mode.
> 2) Initialize a corresponding registers with a number of SPI transfer words
>    (with bits-per-word taken into account) to read.
> 3) Push opcode + address + dummy bytes into the Tx FIFO. When it's done and
>    the Tx FIFO is empty, the controller will proceed with read operations by
>    pushing zeros (or ones, don't remember what level it's by default) to MOSI
>    and pulling data from MISO into the RX FIFO.
> 4) Keep up with getting data from the Rx FIFO so one wouldn't get overflown.

> Regarding programming write each time. Well, it's up to the driver implementation.
> If opcode, address, dummy bytes and number of words to read are the same as before,
> then re-programming isn't required.

Ah, nice.  This should be useful for far more than just flash - most
register reads will also be able to take advantage of this, they follow
a similar write then read pattern.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7DtcwACgkQJNaLcl1U
h9BprQf/X3CrvqOEDZw4gFuSifMWeN7xtcsAEMLPFliUUq9vUY170vk9WBvEWXcU
8+KvebwsMCXWGekf3ySdQN5xQlLrIZ86/mMpntqTMg2Gsvxm7TsoCyW+K0JO/6Ef
2I+nIT+t92zUZhPbyzk7kmeKmC/Jsgg9zwHQpyN0+XjQlCUy0lCYhdR/P1y/5qsV
By+n3t6C5Vi6Dnz2wrYL+gqoH6quWA/wGQe3o0xtFyZuQIVgKogTOrgFOFW8fSBK
NUFEEZjIMctowJ27+FDhh5NXoJXqDUUkbzKOYGEf2Nja+Kk47clbgF/tDwfMlX/3
2duleovaghp6/F5OsQSe05zjfEutIg==
=0tWj
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
