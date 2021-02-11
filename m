Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8F318B14
	for <lists+linux-spi@lfdr.de>; Thu, 11 Feb 2021 13:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBKMnx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Feb 2021 07:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhBKMkm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Feb 2021 07:40:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BD9764E05;
        Thu, 11 Feb 2021 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613047201;
        bh=qjJTw4Ge1nQUpb57midRU3heEpiHLCmlvVagsllttyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ns25xXL/is+KBrwNhowdssL582b2VsAwnEkeo3Ncm7EqMeoNCDBaQjI8YckevQOyG
         0n0oAK7Fbv0YX4loOBVaJibp/potEpIua90/0eb1iIot+Q/AClwhZPkyF6rsI792Zm
         lTluSe/rv3v3uC2+ZprlUCdGoNCnkXVmbqbA30L/gZuxM9XEXHQyVEPgeXdi3i+mRI
         4uy6OSBkYXQqL4eSkB/Iu1PBNQDqd0UQyT7ZUNfqnbFlz5P6XD6QH3PfrrMNfDhqKW
         g0Wo9oZ9LpgO0YCiTs4RL3hlxp4KLhf+ZK2MECfLPj99dxyrgfavBugGr3M1q6DVrr
         n6Aa0MBk7X1Xw==
Date:   Thu, 11 Feb 2021 12:39:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     LKML <linux-kernel@vger.kernel.org>, git <git@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: zynq: Convert Zynq QSPI binding to
 yaml
Message-ID: <20210211123907.GA5217@sirena.org.uk>
References: <4ece21a7e9691ed1e775fd6b0b4046b1562e44bd.1612951821.git.michal.simek@xilinx.com>
 <CAHTX3dKPTC1+awBADMCcgX+=PXsHPw2Bz3Po5=CocdKzVy3bRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <CAHTX3dKPTC1+awBADMCcgX+=PXsHPw2Bz3Po5=CocdKzVy3bRg@mail.gmail.com>
X-Cookie: Do not pick the flowers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 11, 2021 at 10:37:30AM +0100, Michal Simek wrote:
> st 10. 2. 2021 v 11:10 odes=EDlatel Michal Simek <michal.simek@xilinx.com=
> napsal:

> > +description:
> > +  The Xilinx Zynq QSPI controller is used to access multi-bit serial f=
lash
> > +  memory devices.

> Applied.

Doesn't really matter here but I would really expect subsystem binding
documents to go through the subsystem tree.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAlJWoACgkQJNaLcl1U
h9CROwf8CWGGnX7EkL4HWz4W+Ff9XeN7IdRAlRnqbuFXz/M4PGZOHhj121uHX/Rg
d7nl2ndT3S2KinCRf3wh9H8KerCX9JMRob/ZGOqetZlJJqcUDN2WvVQuwMW2u+Ud
116Fg0gfhNzoswprSSIB6qimJLE8xbLwcd1mbhuyCj/DgCtnz9qjl7XB9Pw+zwap
cKCFBkcMrhl+uQ5dY8Skm7B/1YYfYBTeyawPXFykNdooolzgt8/kcD5ZarGJw2/w
CZ8FIL+l1CCggNaV3eocXyR3gD15Cr3TLvqocuY/D5oVx8nrSEeZUizE66g/j9Uo
ZNiYk0v5FuMJOeh1gAO9FlXvoL6LtA==
=MCLa
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
