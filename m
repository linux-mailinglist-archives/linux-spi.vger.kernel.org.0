Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D491099F90
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2019 21:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403907AbfHVTMU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Aug 2019 15:12:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40518 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfHVTMU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Aug 2019 15:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NZCJZbx63toKQeKOUzkuciD01o1c7jKzoOhoeTrTjFk=; b=q+csDCqmfhxxH7GM7HWjgxuWY
        5gXEE5q4zf7t5ijiChoL4bNdFk0bTc1imKVmCGY8ONcTyS92ZuvVbca9Q2smEf3TukbfnWNnmg/a4
        zOltZeEZyhoIq5xb5QEKQJ3v3RmrCxwApOxbhtgwmWx/NeDL7Wfr2RrhCgpeYJZ5T9Aqc=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0sVK-0007xk-KH; Thu, 22 Aug 2019 19:12:15 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5ACD7D02CB0; Thu, 22 Aug 2019 20:05:07 +0100 (BST)
Date:   Thu, 22 Aug 2019 20:05:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ashish Kumar <ashish.kumar@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Message-ID: <20190822190507.GI23391@sirena.co.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 02:18:43PM +0000, Ashish Kumar wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Snippet from driver spi-fsl-qspi.c
> static const struct of_device_id fsl_qspi_dt_ids[] = {
>         { .compatible = "fsl,vf610-qspi", .data = &vybrid_data, },
>         { .compatible = "fsl,imx6sx-qspi", .data = &imx6sx_data, },
>         { .compatible = "fsl,imx7d-qspi", .data = &imx7d_data, },
>         { .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>         { .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>         { .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
>         { /* sentinel */ }
> };

> I had previously sent dts patch based out of Shawn's tree with
> dependency on these dt binding patch. To which Shawn had
> replied to get dependency patch accepted first before sending
> this dts change.

Right, there appears to be an entry for patch 1 which was added
without the binding doc being updated - patch 2 looks to not have
the compatibles in the driver though?

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1e52IACgkQJNaLcl1U
h9CabAf/YnrmOa6aer/v5GZLa3V7LnDmLiT3+f/Pw1XPzt4G1mUV+xM1rjIPcPBy
i2g6mH4lVLJYx/ERwlDb6jW+2GH+uG08pU8ekqm1lQqOhqGaWJGY+Q4zXRGNoWRd
OlCbXUx/ZLWJ0RjrHkoSO43s5mOXkX1rtef65k/b6tAgW1PIM4GEzrRNnSwFXQ+R
zxOhxAAesVweBvASCRd5tOll8I+9KFX9pHbByUwCxHbb1OqJHg5/sT1TCtCRr0fR
K+7/bB4MjfjCF14StKLKszFUWhRNnyT73S13gX8NlPQPSRAUtOOyvuNPX/UtkNJj
trVFOiTCRf5s01u6GQl2n+a1gOa/Ew==
=Scpe
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
