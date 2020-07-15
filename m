Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F47220BF8
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgGOLgU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 07:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgGOLgU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 07:36:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDD6206E9;
        Wed, 15 Jul 2020 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594812979;
        bh=Xh8/JBgH7wyEwqIpFjmyPj/0SkJTwu7TpyHRES0GSNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWh9fdXswjUMMJiZeb3FqvqyCsw77pDePQcttewiRlCv6W1+bmP+5pxznafCelqxv
         4ocXUjxeDGJUuFvIKyB6r+3kwO2j5+CwjFxD+zqIYGuMU1e5Szsd94ezsSwmwwSxVh
         JQHwjm6Cy48dDzKVKK9DbGos0MXTVJn01SZ7pdJs=
Date:   Wed, 15 Jul 2020 12:36:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
Message-ID: <20200715113609.GD5431@sirena.org.uk>
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
 <20200713151108.GB4420@sirena.org.uk>
 <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
 <20200714192907.GJ4900@sirena.org.uk>
 <16825a78-8eb0-90f2-433a-d1ae6eed6ba8@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <16825a78-8eb0-90f2-433a-d1ae6eed6ba8@kontron.de>
X-Cookie: 40 isn't old.  If you're a tree.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 09:26:29AM +0200, Frieder Schrempf wrote:
> On 14.07.20 21:29, Mark Brown wrote:
> > On Tue, Jul 14, 2020 at 10:54:15AM +0200, Frieder Schrempf wrote:

> > > patch in our own tree, or if a node with a custom compatible string like for
> > > example "kontron,user-spi" would be accepted upstream, without a matching
> > > driver?

> > I'm having a hard time getting enthusiastic about it TBH - can you not
> > just use spidev and live with the warning?

> Ok, I can do that, but when I resend my patches and add "compatible =
> 'spidev'" to my DT I expect someone to complain again as my DT does not
> describe the hardware.

That's the issue with kontron,user-spi too though :/

> But for obvious reasons this can't be considered a good solution and it
> seems somewhat disturbing that the maintainer needs to propose it because of
> lack of proper solutions ;)

Hey, I proposed other solutions you didn't want to implement!

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8O6ikACgkQJNaLcl1U
h9Ahqwf+Iu9cDSXmEFlO9SyIzVOl/fi+MMZVdyFlaZY9LJVs3q1FMn8K0FRwOnwh
8iqEHnjOSp6PlupJJmbXPTNw666Qv+d4Ct9WyCo3fq98npEi6P8aW37zmfbCLGSv
aBrxA3A5/bBoOV3NSXcmVOOGHjV0zqP+h1NVQ4gGTG27rSN3BXCE8BYifdvN5bP6
u67RLmi1feDqkQXt2beZ1nXv0N6xbVCyWcGG8g/Y2bt3e7/FO3zACmAQQc5CZ0WW
+sucY7Sa2zNMMXVkBgoaHvuvmjtIxsBKkRnwq/jcoOct3KITx7gz/1EsaVbPWnsL
lv4IT5tp7hkw4JezgeJRwJf60L84BA==
=YQrr
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
