Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046B6111AB
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfEBCla (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:41:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37966 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfEBCla (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5ObYVRU0Kf3pIITjmag/DPVZ4iVx1mDoeKshyHfJ4vg=; b=cUEDpZHpMZfUfljvsKyxjzbES
        jWRaGxO3R9a3EdC2DaCtHkS9Vhdxvktq3aB9nQfImncj6KC4FS8w8k+EY4u1TSJ+yKAxodqr/Wbav
        JahLkMP6xJ8NFsNMUrUarbZBLbsRy374CbDweYt3y7gyTLMbbOEa6m0S6GHXl5Ay87bak=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1el-00060N-6I; Thu, 02 May 2019 02:41:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0FB6D441D3C; Thu,  2 May 2019 03:41:04 +0100 (BST)
Date:   Thu, 2 May 2019 11:41:04 +0900
From:   Mark Brown <broonie@kernel.org>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmal.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, geert@linux-m68k.org, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marcel.ziswiler@toradex.com,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 3/4] spi: Patch Macronix SPI controller driver
 according to MX25F0A MFD driver
Message-ID: <20190502024103.GT14916@sirena.org.uk>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
 <1555320234-15802-4-git-send-email-masonccyang@mxic.com.tw>
 <20190419145151.GR2803@sirena.org.uk>
 <OF7742B4A9.445066F6-ON482583EC.0037E377-482583EC.0039125B@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U2mKMzaWgYxzMy3/"
Content-Disposition: inline
In-Reply-To: <OF7742B4A9.445066F6-ON482583EC.0037E377-482583EC.0039125B@mxic.com.tw>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--U2mKMzaWgYxzMy3/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 06:23:21PM +0800, masonccyang@mxic.com.tw wrote:

> > It'd be much better to describe what the above actually means - what
> > changes have been made in the introduction of the MFD driver?  It does
> > feel like there's not as much abstraction as I'd expect between the MFD
> > and the child, there's a lot of peering into the parent and enabling and
> > disabling individual clocks for example rather than either having this
> > hidden behind a function or just having the clocks owned by the child
> > driver.=20

> Do you mean I should remove ps_clk/send_clk/send_dly_clk resource from MF=
D=20

> and patch them to spi-mxic.c ?

> Or any other ?

I think you need to have a clear idea that you can explain as to what
the MFD is and how it's split up.  What's being abstracted, what's not
and why.  Without knowing anything about the device or what the series
is trying to accomplish it's hard to be sure exactly what the best thing
to do is.

> The driver also isn't using the MFD interfaces to pass through
> > the register subblocks for the IP - instead the child driver is peering
> > straight into the MFD structure and looking at a variable in there.

> Patch regmap for mfd, nand and spi ?
> or any other patches is needed ?

This is a memory mapped device so there should be no need to use regmap
unless you want to.  The MFD subsystem has facilities for passing
through memory regions to subdevices.

--U2mKMzaWgYxzMy3/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKWL8ACgkQJNaLcl1U
h9AjiQf/bW7XYR+RCtB5mk7NUhGOFWv7c4gcOImzc4a6QObhKLrSolCYsj2RWhcl
Gnq+EA50PHXQZqZMl6tLN7skgu1q8gHz79mwbns4pqSQtAC5Uw5PU2MWGMpBkBXl
lx4jDU7D7JmlCkkbWCOb9mi/Rhq4AAbn4yWSd4ZN+3FC2znx8HY9x/12257saaV8
ndBNuyLQdAWw8oz5cIpcLU7w+YaEYcT6qHbTbmfRBdCyIfKTxVOwq403UnLSjKW6
LU90b3lGa1zs5IP2m6rKwRCggfZnkgjvrRl9VQJXPxx3Ggyj7jG1OKBa7ia0Kf/a
QZsQU1oxCxD+GUVGvbJkybiuRYKmxw==
=TLm4
-----END PGP SIGNATURE-----

--U2mKMzaWgYxzMy3/--
