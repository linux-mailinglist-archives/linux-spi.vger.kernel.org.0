Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4F1AA10
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2019 05:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfELDMx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 11 May 2019 23:12:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35212 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfELDMw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 11 May 2019 23:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A9OY9hBfbTY7S2hso66X68O5pPXVzbcBRlTLnQO/ZWY=; b=ehzAh4hceMgRSle4c8PxPkagJ
        +xO4SKEW6EuiRTK8dYfmBml6bjfbe52xaQPMo1WFeDYL0KKG2Spco0Wt7Nrhq2TI5D1amXQiOKr7a
        bWtJwwzs9Ins7JSJLz3T6S1IxTV0B17AP55kftVnKVZZ9a+bqSyFXtEmpDrbBvsS8WPtI=;
Received: from [61.200.20.122] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPeus-0002IA-0s; Sun, 12 May 2019 03:12:46 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 1AD5844000C; Sun, 12 May 2019 04:12:42 +0100 (BST)
Date:   Sun, 12 May 2019 12:12:42 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Message-ID: <20190512031242.GB21483@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
 <20190419151823.GS2803@sirena.org.uk>
 <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190506044425.GN14916@sirena.org.uk>
 <BYAPR12MB3398D946FDD0E5406B23EB50C20C0@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398D946FDD0E5406B23EB50C20C0@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2019 at 06:53:25PM +0000, Sowjanya Komatineni wrote:
> > On Mon, Apr 29, 2019 at 10:02:46PM +0000, Sowjanya Komatineni wrote:

To reiterate:

> > Please fix your mail client to word wrap within paragraphs at
> > something substantially less than 80 columns.  Doing this makes your
> > messages much easier to read and reply to.

> Any concerns for using set_cs API from SPI core as it already does direct gpio based cs using
> Descriptors?

Yes, that is precisely what I'm telling you not to do.  That function
doesn't do enough to make it worth exporting and the code that uses it
assumes it's managing the chip select entirely, adding a single other
use will make things fragile as it will mean that there's a chance
someone will change what the core is doing without taking into account
the different things that the Tegra code is doing.  Either let the core
handle chip select entirely or open code it.

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzXjykACgkQJNaLcl1U
h9CdDwf/RMwk8JveODVogg3LW+9FdUslYiuSh/72+FYAjmKk28dm3H328PpA/y2c
ZytPr8GyaF0vI4dbOhl7xFeHSJvb3FSmZxYUrD0f5kWkPjMI/SB2Z2hCZFdnONMm
wssyJ+3Q7dS4fOCmSOg11yn8c02PAzP5R+G2Vqdt/tKH+hj2ItKxghQI10qGL78K
AtAYMCzLlUNJ1QgWeg3cAfNZZlGTQoOuRCx6hvklNTgwxk6ED2aKF2FV4Jw2AxI0
n89eG0UOGQeI0KmPSc8GOUduj/0vUITd0qSWVNOtvirNf1rV6gu6mMZIclPiLPjp
kPI1Fp72G4ZAFyfGuleOFW2K6uDZVA==
=qEfj
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
