Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3817A6572A
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2019 14:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfGKMlU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jul 2019 08:41:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45820 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbfGKMlU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Jul 2019 08:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rr0MZjQ0enn7b2r5LEgcRCN3jvJJD/0EMA3V9vYZvWs=; b=UDLBt7E8UoJ7o2qIBgnTeal3C
        lLQeQRKz9lplnUqwPjw/OYRT4o5Fjj3bFYs1wMvfkD0YgHW+RQVYa/qYvTNp+4cunXUIN+jkSalXh
        BMnyulH5dC6wtvXAa+4UK0HoW2RGcAXq3JGLS0Iei7fY+RKVO/2YQyyo7vGWzvz1s8mHQ=;
Received: from [217.140.106.52] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlYNy-0002MO-3f; Thu, 11 Jul 2019 12:41:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 41E59D02DA8; Thu, 11 Jul 2019 13:41:17 +0100 (BST)
Date:   Thu, 11 Jul 2019 13:41:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Han Xu <han.xu@nxp.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB
 memory for FSPI
Message-ID: <20190711124117.GG14859@sirena.co.uk>
References: <20190710023128.13115-1-han.xu@nxp.com>
 <20190710023128.13115-2-han.xu@nxp.com>
 <20190710151628.GF14859@sirena.co.uk>
 <AM6PR04MB49672BE152440416ACCE275197F00@AM6PR04MB4967.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49672BE152440416ACCE275197F00@AM6PR04MB4967.eurprd04.prod.outlook.com>
X-Cookie: Visit beautiful Vergas, Minnesota.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2019 at 03:35:46PM +0000, Han Xu wrote:

> > > dynamically alloc AHB memory for FSPI controller

> > Why?  This is currently done at probe which is what you'd expect to happen
> > here, there's no explanation as to why this change is being made.

> Explained in cover letter, It failed to alloc the whole memory mapping area during
> probe on some platforms, since the AHB memory area could be pretty large. The
> error may look like:

> [    1.129404] fsl-quadspi 1550000.spi: ioremap failed for resource [mem 0x40000000-0x7fffffff]

The commit itself needs to have some explanation of what it's
doing so it's in the git log, particularly for something odd like
this.  More generally this just doesn't feel like it's solving
the problem - essentially we're just deferring the mapping and
then keep on failing operations until the allocation succeeds for
some reason.  That's going to be disruptive for users of the
device and it doesn't seem like it's going to be a robust
solution.  Why does the allocation not work initially and why is
it more likely to work later on?

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0nLmwACgkQJNaLcl1U
h9A+Bgf6AwDQOAxz8HNRuZUiqA0sCkEKXRDLd50GzqscTcokWsglR/zwhB8hT2o4
ui8ywL3XMsPaiJANgZ9jjXoCroNHhl52Xsjb/d3B8fcVGk/w7XRk4jmsgpcDkmCC
7KqbRkhIqOnqAbeEkgh2q3JXrJMrZr4f1dAcukG9t39z2I1gPu7okG8+Zqaso/py
7mpD7AMzeBKLuktxUGv866HhtZyrVS8s/QK3l6alqZmmSA5A9WQWIzNBmDTu8QCZ
FwG3G85vE+EOj2Z18nFN759QMzVyxLuYFjrRs7W4CP42oEJze7ixXOjHvqFw5hWn
IIc9v+dlFMmZ+/YZ10LuImjktd5eMg==
=rGo2
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
