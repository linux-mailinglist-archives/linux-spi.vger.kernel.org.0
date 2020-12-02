Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C012CC097
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgLBPS4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 10:18:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgLBPSz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 10:18:55 -0500
Date:   Wed, 2 Dec 2020 15:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606922295;
        bh=+nK4IZmCJ6wufHa7H+opzW8X/iz35XK211vgEzoJO3I=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKd5YaULTDiU/fL6zmaG5oulb1W8dBiM0kzpxtAJoeZJHgm4+SW4Teu67J7D7ceGJ
         O4FKsVtQ5QA3z4+Ldc3TMQ5uHriUpiqaBfkO6yk+8G+xbVJN/7zYUwN83AoaNLtjcy
         bIRB79LTLJaaIy2/MYRgHrpnjHWkT1znY0iZQqSw=
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH for-5.10] spi: npcm-fiu: Don't leak SPI master in probe
 error path
Message-ID: <20201202151745.GF5560@sirena.org.uk>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
 <160683107676.35139.5898255579541696458.b4-ty@kernel.org>
 <20201201143027.GA23044@wunner.de>
 <20201201171726.GN5239@sirena.org.uk>
 <20201201174908.GA5827@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
In-Reply-To: <20201201174908.GA5827@wunner.de>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 06:49:08PM +0100, Lukas Wunner wrote:

> I think I'll base the resent patches on for-5.11, Linus would probably
> not be happy to receive such a large quantity of commits this late in the
> cycle.  (Shout if you disagree.)

That's probably sensible yes.

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/HsBgACgkQJNaLcl1U
h9BqEQf+OawiKfZUmKYZq9rTw02Eqk9wvB1zTuLV/a5kkvObTVoS3dyshUhC0Vz1
sVBwgA8h8eGPd+tALAh7s0Aqo5PPepQ6BtASPP3gHuFKr3nZ6X/blKEOssxMeTAR
AWLrKvaoi70qZNXpVbioJXYju6OKNnzjBW5UTVziA3QyAcph1f6suYbZqyAV6oOj
qKVOITyc3yxuy/aZXUKNMCiNSbOztaWkowrRsWCzqQgCcZlJmcqJ3HFG519t8OSL
rvfbgkhkxX/JxJ/Db/YuyWyWizhWEZtj88OyZW8SQBDQHVfyN1SNCxrvk1Gc9izc
H+QgpSWkg+ipxjmFCZzQOGyoguI44A==
=wYb3
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--
