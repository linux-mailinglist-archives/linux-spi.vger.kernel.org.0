Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3628D8692F
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2019 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404164AbfHHSze (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 14:55:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35066 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404161AbfHHSzd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Aug 2019 14:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QjkoBON2R0G9dPWiD46toYdQm9FG0fge33xVSCag5ms=; b=vqt03qIKNSYXmWRwtn6SMC0vn
        2KxAD407l3Awcyh2IzdII6GyPqRZFsRiCPW6czfrc9RB9mRifazXgV+8/2TNZ76/UaOA0+A2UJDmJ
        IyNQtmNyWKwRuBMlsGkSPrg8Pj0jKAk8CeSe2LXRN+1EW53APKC59dZ9Blp6kqbrQuQNw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvnZL-0003lN-Gm; Thu, 08 Aug 2019 18:55:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5CB972742B42; Thu,  8 Aug 2019 19:55:22 +0100 (BST)
Date:   Thu, 8 Aug 2019 19:55:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, bbrezillon@kernel.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-spi@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] spi: npcm-fiu: add NPCM FIU controller driver
Message-ID: <20190808185522.GJ3795@sirena.co.uk>
References: <20190808131448.349161-1-tmaimon77@gmail.com>
 <20190808131448.349161-3-tmaimon77@gmail.com>
 <20190808132740.GG3795@sirena.co.uk>
 <CAP6Zq1j7jHejdx9h-nxCJcVjtGx_3rHmay7R8nn11DLaE8Q4gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Content-Disposition: inline
In-Reply-To: <CAP6Zq1j7jHejdx9h-nxCJcVjtGx_3rHmay7R8nn11DLaE8Q4gA@mail.gmail.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 06:37:06PM +0300, Tomer Maimon wrote:

> for example in our driver we modify the access type (singe, dual or quad)
> according the op->addr.buswidth
> for example in the npcm_fiu_set_drd function.

>         regmap_update_bits(fiu->regmap, NPCM_FIU_DRD_CFG,
>                            NPCM_FIU_DRD_CFG_ACCTYPE,
>                            ilog2(op->addr.buswidth) <<
>                            NPCM_FIU_DRD_ACCTYPE_SHIFT);

> we also modify it in the UMA R/W functions.

Ah, it's only for the flash functions - that's fine.

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1McBkACgkQJNaLcl1U
h9CSyQf9HMQyWI7F+/mz/TefzbACHnpE0c8lwToPC8gs3NlHo8g0orLblfG3DsLm
UEB893DEnNq2PyAZ3RalNBeet13paLEA0qBru8OSMUWpeNwDNxNPJnw0LKgWMfJd
hR7ajSCzI8nNleQRxNko7depUDzpemRXDWxmIyeoBPOYzHxX3AWFoyuaz9aUo2Rl
Unh0Hf1osxqIy1e/McvePEnPv0TT99Ymj8k6/8GnvioyP4EpahOXI8dSR2jI0EhD
E00zLhgmAoNpkwrV/jtjy/U4bWl2oEXrySbQ9Ljy8b0iFVArSIEFILHO06iXOkXP
gKzJeeqWsQ6fz//+fGxegx1F6fcTpg==
=AZer
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
