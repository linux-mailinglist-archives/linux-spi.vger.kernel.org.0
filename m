Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1753B1F047
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfEOLmk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 07:42:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38536 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbfEOLmk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 07:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MsMZWcEhieyD9y/MB1UTwo9lx4vEdenhn0ViWkYWga0=; b=YPUAoCHj9TAeCyAY9x620+maF
        MTsK55mHerI2S3KHuTJN/zQumYR2a2uJqdILUENk4iqLHEOmIwGJypY2hAbthxdHYkg6tsOcweSEq
        6VO7MTxNMmCVGpF3dp1/ga4D+WAiMxz2CW3RgmVnMnUyFz6XEZpRZbAjxyCKf618uMvL8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQsIv-0003eS-5H; Wed, 15 May 2019 11:42:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 319621126D6A; Wed, 15 May 2019 12:42:33 +0100 (BST)
Date:   Wed, 15 May 2019 12:42:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Message-ID: <20190515114233.GF5613@sirena.org.uk>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
 <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190515093522.GC5613@sirena.org.uk>
 <BYAPR12MB3398ED52051F5BFA08D7B3A6C2090@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190515112900.GE5613@sirena.org.uk>
 <BYAPR12MB3398528B86D3DE9CC3AA6D85C2090@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398528B86D3DE9CC3AA6D85C2090@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: You will lose an important tape file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 11:40:41AM +0000, Sowjanya Komatineni wrote:
> I tried few settings before sending V5 too but didn't made diff.
> Will try with different email client.
>=20
> What email client are you using?

I personally use mutt.  I know people also use things like Thunderbird
and Evolution successfully.  There should be other people at nVidia you
can ask about how they get things set up I guess?

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzb+ygACgkQJNaLcl1U
h9B1yQf/aoNSV/N3Iq8hWgg8l7YtShuKh8pJ5p5FRa8eM/RrsWiGS0Ih3uARw12Y
jwhP0HRwm1WMSphc4F/gwbRIS6KiCLmtK21uVfQ8ZhwePMzM7riNNCNInkHsEyq/
MWm7JRK3YEjPpbqRhzGjUylGbuMqeY2oifTnZPMhLpu98nqZBxdkLlbvVMvQ4Lzq
bs8R5PeuqWFOZgb2d89fb6jGVheVWKGjP4cxlreDlGd00IlBZDdKFMUlkxqWytj8
LRLPtjy6Ekaq5qQh7TDrxHkogptz9dQo5cB4gfDPj3AN+UVX7caCwUe2qc3x3e66
xjey0jls24Elt0FLSZAgUIPOremvZw==
=Fhe/
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
