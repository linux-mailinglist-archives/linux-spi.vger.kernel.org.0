Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78B9F398
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2019 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfH0T4M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Aug 2019 15:56:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44474 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfH0T4M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Aug 2019 15:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/SvwAeVLFzkeHMJUWjHlGUw6u6XSl9ETzXitKNoc/KI=; b=aubTN7sVyrFsylxFt/p++jFvz
        IUpDtM7H3+oQMGOc08rN9Mts1dnJQoYWhOEwtloAPx03pQn3vPwiembAtDwXyNPk785i+h5IXyZPv
        uTBrlA4psbYwK7SjQwyRlTyeTavoc7maGZjkCv/r1atgsxlBKteO/WFZQCbnO7K5Q8KSQ=;
Received: from 188.28.18.107.threembb.co.uk ([188.28.18.107] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2hZX-0001B6-Sn; Tue, 27 Aug 2019 19:56:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3C3E1D02CE6; Tue, 27 Aug 2019 20:56:06 +0100 (BST)
Date:   Tue, 27 Aug 2019 20:56:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Message-ID: <20190827195606.GA28879@sirena.org.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822184927.GH23391@sirena.co.uk>
 <20190827155005.GA18581@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20190827155005.GA18581@bogus>
X-Cookie: We are not a clone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 10:50:05AM -0500, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 07:49:27PM +0100, Mark Brown wrote:

> > Drop the dt-bindings:.

> If you do 'git log --oneline Documentation/devicetree/bindings/' you'll=
=20
> notice that SPI and ASoC are the oddballs now. I don't really care
> except it does add to tribal knowledge needed regarding maintainers'=20
> requirements.

Well, you have been pushing people to change over to using
dt-bindings: so I guess you do care :(  It really does cause me
to miss stuff, especially where people don't even include the
subsystem name in the header.  I get quite a lot of CCs for
things where I once reviewed a patch for a subsystem that made
use of some subsystem I do maintain or where one patch in a
series (perhaps even an already applied one) was relevant at some
point so I'm doing quite a bit of triage that's purely based on
the subject lines.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1litUACgkQJNaLcl1U
h9CT3Qf/blNHGchHmk2gQ8FvcJr6UsKNmtbrNv1Zov3/pMDT0H/NiFlJzdL4A6lh
F/4aSXaqEoR8Ns/IBrQ+geoVVr8dzb0P44QVSOPBlP2PlnMH1lKtLjtGoVYMwd9s
WtByb4e5KTeuOGUWdVC7+//RwjZyx5dMiV5qTv7f6yEZb+bq208Lrm30mluybDiF
8xj3c1HFSN4S+U0qvDcgsTjPOP0sOSP/DxXQUpKBPjf04446WOB7D8f7z8E+avI3
y22TeatnvVC9KDuGM136rHNNpWnO7X7wB2HQKs12JwOjQJCcNNx8/WbGaQFgZ1Zp
fdK3xIKw8dtN4DMr9QAh2R8lLLOunw==
=8aqH
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
