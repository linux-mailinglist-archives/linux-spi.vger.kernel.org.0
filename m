Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3989F204
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2019 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfH0SD0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Aug 2019 14:03:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52640 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0SDZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Aug 2019 14:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KbdXuUIb1PofA8gj3PpnmyfX3/C/zewyEqvqL3YUumE=; b=hzIztPaz4hj+uqKUNVeEA2H4S
        LkVkxGz8+v+KyMZ8HRUurKWnprzMY74/tjUb0ckNVXo3z1yrfZ0YNLGCKedxNsAnyyB1alfNotzcU
        HTZJz1n3eHvZVn0vV+GpFWj9N3a+3yCFFqIKeg2MC4+nOUPNYvcEk+Uf9EBgjLhFgl17A=;
Received: from 92.41.142.151.threembb.co.uk ([92.41.142.151] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2foP-0000rz-Ee; Tue, 27 Aug 2019 18:03:21 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 1FBBBD02CE6; Tue, 27 Aug 2019 19:03:20 +0100 (BST)
Date:   Tue, 27 Aug 2019 19:03:20 +0100
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
Message-ID: <20190827180320.GE23391@sirena.co.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822190507.GI23391@sirena.co.uk>
 <DB7PR04MB4011C9785D8D9CDFE9BC62DD95A10@DB7PR04MB4011.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KC8n6y+EC4k2kdZR"
Content-Disposition: inline
In-Reply-To: <DB7PR04MB4011C9785D8D9CDFE9BC62DD95A10@DB7PR04MB4011.eurprd04.prod.outlook.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KC8n6y+EC4k2kdZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2019 at 06:19:53AM +0000, Ashish Kumar wrote:

> For Patch-2, I intended to use this in arm64/boot/dts/freescale/fsl-ls1088a.dtsi (please see below), since both ls1088 and ls2080 has same QSPI controller.
> So I had introduced new compatible
> +                "fsl,ls1012a-qspi" followed by "fsl,ls1021a-qspi"
> +                "fsl,ls1088a-qspi" followed by "fsl,ls2080a-qspi"

Even if the compatible is supposed to be used in conjunction with
other fallbacks it should still explicitly be there in case
someone forgets or decides not to do that for some reason.

--KC8n6y+EC4k2kdZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lcGUACgkQJNaLcl1U
h9AO3wf+JCKT+OSIxSc0gdf/Uy1kGqqqZk0sJcNYIa8GbyIxvlUIyXI7fn0HYhs7
HeUX5hJxYc8xodd8CTzWXCdXFeXpV6weWYidbcvBDYLAQGEhnCQY7LoKFQdWBBse
GNwuCT4SMuAUXHutf6GZaTPv8SIXGrNaZqawtlrOg4TFzUmL74MjlCQvpMn5j15g
v9rmk4kF310PIxuIPFKHgU0gyJdJ7gcr7uYCfUJA1/EtEWHfVoOnyZ+IG0Di9rPC
sPa6VYx6Wv376zRTNMPBJEt0Sn87KEPnz7A0afRbmNhs5OxuK1kXXIhib5u6MvGj
neVEamNf4Dxb+u9KverWRMgfQFCSSw==
=mBNE
-----END PGP SIGNATURE-----

--KC8n6y+EC4k2kdZR--
