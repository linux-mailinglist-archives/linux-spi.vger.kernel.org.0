Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27372B7E16
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2019 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391210AbfISPXj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Sep 2019 11:23:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54608 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389443AbfISPXi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Sep 2019 11:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SVYXT/EUvY8dsNgMnbFhrjkCQ4V6Kbd9kNWc6esVgRU=; b=P/SxVrHRBzkUF7IyXXh+4tRhz
        Df5UYyJaVhO1+/XcArPgAVWIzBOG/mnMqSoB2D+KXbEmVbgyFmbGXSauFKhSVWB4d+rQLu9fQhURD
        Cud4yOT6xQvt6pRsAACKAR4yiZjYxyNkjTCb2d6KPJOWX5qFvsK0Qm3ip0bWs2VvPaC4s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAyHO-0004Fg-Bt; Thu, 19 Sep 2019 15:23:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 729AB2742939; Thu, 19 Sep 2019 16:23:33 +0100 (BST)
Date:   Thu, 19 Sep 2019 16:23:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] spi: dw: Add basic runtime PM support
Message-ID: <20190919152326.GP3642@sirena.co.uk>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <20190919133113.GK3642@sirena.co.uk>
 <TYAPR01MB292515FE4C74044CA53321C5DF890@TYAPR01MB2925.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline
In-Reply-To: <TYAPR01MB292515FE4C74044CA53321C5DF890@TYAPR01MB2925.jpnprd01.prod.outlook.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 03:14:54PM +0000, Gareth Williams wrote:
> On Wed, Sep 19, 2019 at 14:31:32AM +0100, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.  This makes it
> > easier for people to identify relevant patches.  This isn't even consistent
> > within the series :(

> Sorry about that, I will correct the subject lines for V3.

Don't worry about it unless you need to send a v3 for some other reason.

> Is there a set convention for the subsystem I should follow in future?
> Or should I follow the style of the individual files I work on?

Following the style for the file/directory is generally a good guide,
for SPI I tend to prefer spi: but I just moan about it rather than block
anything for it (unless I do end up missing the patch in my inbox).

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DnW0ACgkQJNaLcl1U
h9CozAf+KonuKSEWtCRvLPNHth5I6Dmv/rgmgnQLAcqXOvyYP4XKeVynEQWjP1VT
fRBeU1NL7gDivqKMWGOTDW7t+h8jULzY2zdyLJcARZ/dTByWuGk7u31qcYPUpVlW
wSiWGaAJm8d9vDeoj5dWwz9Ijg0VP7EmwQStss7hUjOTzFSOXV52mZuxOI2TQfXQ
6fm1dqVJ0f85TWNHTBBeV70W445kutx7yrF/Ed614cuCff5+SoKevGlC88PdTPV2
we5TlLr1J2/i4gISCWpWpbf6ddcjZrOaQZhoHQQfF4/3KvcWqmrgrr+wa+cTZWyI
YeEM6rjUhOpH1U3ABtzoZv8mBEQ5Gg==
=xyoB
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
