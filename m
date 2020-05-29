Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DCE1E84E4
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgE2Rdb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgE2Rd3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:33:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3930D2072D;
        Fri, 29 May 2020 17:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590773609;
        bh=R3UlKfJDQ0YkZrgOUGl3rs/KIBJQkF8/RkXJ5GgzrwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8N3Gh2TBNix1CgIW235bblS8scifPnuXdlBEdd8SNvVohftIT9ziPO3JgPmafaTc
         rV1/4pQOA7kgqqoUM+/V3QdmCOhJPsf/TS56qT1kQooDPv7wqdlG4ZIBHwxdJEzggs
         wUKFu6qm8jD5nyWpWDdmPatB5a6jufbgEjad4Q4I=
Date:   Fri, 29 May 2020 18:33:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-mips@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Subject: Re: [PATCH v6 00/16] spi: dw: Add generic DW DMA controller support
Message-ID: <20200529173325.GR4610@sirena.org.uk>
References: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
 <159077271266.17043.13820488074564153429.b4-ty@kernel.org>
 <20200529172642.hcnvyzv2ocizsvpy@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YttKMwf6abDJOSyE"
Content-Disposition: inline
In-Reply-To: <20200529172642.hcnvyzv2ocizsvpy@mobilestation>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YttKMwf6abDJOSyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 08:26:42PM +0300, Serge Semin wrote:

> You must have missed the patch 16:
> 0e8332aaf059 dt-bindings: spi: Convert DW SPI binding to DT schema
> As you can see it has been acked by Rob. So you can also merge it into your
> repo. Though It has to be rebased first due to the Dinh Nguyen patches
> recently merged in. Do you want me to do the rebasing?

Please rebase.  TBH I'd not noticed Rob's review so I just left it
waiting for that, there's such a huge backlog there it didn't occur to
me that it might've been reviewed.

--YttKMwf6abDJOSyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RR2QACgkQJNaLcl1U
h9CsXQf/aA2456F8P1TeBjPSZTkkGMIoE4VH1b4PA9LR5SIljZUnVP61Ep3P51xI
zMvytLCsWgdSrTUkDRmsLN3YgF//wMfSgwbt+D4H/clzEsAPPo/WIUtAna8Qc1Kp
9WJPLwNCSmaZXdHPdVBTI1MDncTo4Su9Zd4H9LO/9boN1gi0oABIA0ggIaJKFYJl
wwX1VfvLyal/DlE6FkBe66D70A6rka20MxZtGRJdWQUXbm/rx/ptoROy83fdyrVm
A0sokgTBQYz2aMaLS0LN5frYdWzfNStlRMuDCO2Spf0OlELFVdcovfSDglTIOvUs
XZrETjZtic6tL+Ux2NH2/mXODvcc9w==
=z4mF
-----END PGP SIGNATURE-----

--YttKMwf6abDJOSyE--
