Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9DA111B7
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfEBCpq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:45:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBCpq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aNhvX/Q8oZJ4/XJ3D47vwJgCQyOxntjtayZOPxGIk4I=; b=lQ/mfkYWf/Cm15lXSr9bc3bPC
        vU/4/jANVvYHM4KagxLuaxHAzzPT7nMSz5M/BTVrj+HsCYOy9Qhf36RH4s3Y22trd8zw9WFfoJ41M
        bssOL7yIQj7Fe7gVIkaBxsLnJup4fbjDUfb6N82h0PudXI/82l0VGzXDqzYrD2l1VB02E=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1j2-000611-OW; Thu, 02 May 2019 02:45:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C099A441D3C; Thu,  2 May 2019 03:45:24 +0100 (BST)
Date:   Thu, 2 May 2019 11:45:24 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tthayer@opensource.altera.com" <tthayer@opensource.altera.com>
Subject: Re: [PATCH 0/3] spi: SPI bus multiplexer
Message-ID: <20190502024524.GV14916@sirena.org.uk>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
 <20190412082913.GA6909@sirena.org.uk>
 <d91ab2261a1f4069bc48e090bd4ec702@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="worL9B4ITIAQZ1FS"
Content-Disposition: inline
In-Reply-To: <d91ab2261a1f4069bc48e090bd4ec702@svr-chch-ex1.atlnz.lc>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--worL9B4ITIAQZ1FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2019 at 10:28:16PM +0000, Chris Packham wrote:

> One other problem that I encounter is the interaction between cs-gpio=20
> and SPI_MASTER_GPIO_SS. Having cs-gpio automatically sets SPI_CS_HIGH=20
> which has the undesired side-effect that now my real chip select is=20
> inverted. I actually wonder if this change breaks commit 8eee6b9dd30d=20
> ("spi: Add Flag to Enable Slave Select with GPIO Chip Select.") since=20
> now there is an extra inversion on the CS enable.

That sounds like a framework bug which should just be fixed - we
shouldn't be disrupting users of real chip selects when using a GPIO
chip select.  Depending on the hardware we might need a chip select
assigned that isn't connected to anything for use while the GPIOs are
doing the real work but otherwise we shouldn't be breaking things.

--worL9B4ITIAQZ1FS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKWcQACgkQJNaLcl1U
h9A8mgf+NUGeTId/vCKU5fgsyKAKgLFNNREzR640DJheAW8jSR+tFvdWIcS+Xzui
wHoMW2SYbEQ9jOoDzhPQKNU9PM4q03Pz3NlbFRkHub9Mz76XQgLzV89K/FvBfOkf
xhh7repFxc81GLG9gTot2SHBOrsHIPz5LkpXK7FgRQJFiemZEdrDpDn6hmZuiK+v
kcU4mVpd7rza0fXLRoOcTCSnwjUU7+leF6zx4VsEqSWZ5Sl8oUy2LlvRqfziRKSg
uvCeyZAn7dYif/78KcjBs5fex/Eb3ac49T85SFAo1GhHPuyQtYJfe2ZxEtz4qrVB
czstXt8yaIV2diO5m+pXnum3mzstaQ==
=ou6s
-----END PGP SIGNATURE-----

--worL9B4ITIAQZ1FS--
