Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79199F2C
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2019 20:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbfHVSth (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Aug 2019 14:49:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbfHVSth (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Aug 2019 14:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZFdAsAhKZXbTwipyAaLFn+KZWfn8XNc9r15goIeXnEQ=; b=U1CQNO/Rb0Iyz0z+3cgPPSD5t
        yhIw97sY5teyyLY4Jx428leYLZS5iPxcA7I/uM5iE/KFbA/y+8SCkf4tgj5SDwGOdvM7hYQPr665k
        SUqd0tZqSi/DTAM9lJGUC4zZAT3Npzos+gkkK8AdXmfY8lSugZ0ocCSCWvOr319DJmvdc=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0s9N-0007nF-HB; Thu, 22 Aug 2019 18:49:33 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 65A7ED02CB0; Thu, 22 Aug 2019 19:49:27 +0100 (BST)
Date:   Thu, 22 Aug 2019 19:49:27 +0100
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
Message-ID: <20190822184927.GH23391@sirena.co.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 06:39:18AM +0000, Ashish Kumar wrote:

> > > Please use subject lines matching the style for the subsystem.  This
> > > makes it easier for people to identify relevant patches.
> Hi Mark,

> After looking at some patch in Documentation/devicetree/bindings/spi/
> I think I should update subject line to
> dt-bindings: spi: Add ls2080-qspi compatible string for FSL QSPI driver
> or=20
> doc: qspi: Add ls2080-qspi compatible to DT bindings for FSL QSPI driver

Drop the dt-bindings:.

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1e47YACgkQJNaLcl1U
h9A7uQf/dNBtSbaZ/Q4CmLrmJW1+t4b2gh+ryETbQz8vNiKnPlKBeQLF7W8KiJ+h
DYG8qCiWwyHsIV4wo/hTUfViQJLPVnnabfoilcj46ZfB3SZrXk2i3h5dV1MZcHXx
6CpWEUv56ti/1XoKXIfzcXYF9jcBjtD7gI87Ee8alit5X9a5FCl1s0HLXaivtgOa
OqxL3SXPUt/KaKVY9/zGhN7bQ5pgH7xwWUQjJPKwY13/pbkBYyDzQAnxryap0KJ8
vrUol7hPBtAmn3YZuuSXj+fRaWZ0F9snmRz1dglCedX4YMcwWOHH/v+Kn4sUg0sW
k9a5KRX73AGlnwVjb9khqyuA163Byg==
=Lzgd
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
