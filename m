Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F384241278C
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 22:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhITU4a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 16:56:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48600 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbhITUya (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 16:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ydCuwsv2pg7ealIoHUJECPrmEEmgCX1L67j51xBqnoA=; b=JollxnLLHFJ5lC8sEM5JtRNisE
        +W5dnkLNXhDHEkOsRldxF4S4eHmXE5YHBJ1wLCZiNDswP5K4J9J31D1uSCKBhSUFJ5qZ+lsYjWi0v
        En+Q9kkQhDcdV/k6NowI/tmcjWLnpEU0Q9+6nUFtbppbh8+vdkRgvpfBfufR2Wy3Zv0g=;
Received: from cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net ([92.233.91.117] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mSQHV-000eI1-RW; Mon, 20 Sep 2021 20:52:55 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 43751D0E9AC; Mon, 20 Sep 2021 21:52:54 +0100 (BST)
Date:   Mon, 20 Sep 2021 21:52:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andreas Schwab <schwab@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <YUj0pkhrR6kzPstv@sirena.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
 <871r5j6nlw.fsf@igel.home>
 <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Aplk1EN5iLWn29n7"
Content-Disposition: inline
In-Reply-To: <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
X-Cookie: lisp, v.:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Aplk1EN5iLWn29n7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 20, 2021 at 08:49:21PM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 20, 2021 at 09:41:47PM +0200, Andreas Schwab wrote:
> > On Sep 20 2021, Russell King (Oracle) wrote:

> > > Therefore, this change breaks module autoloading.

> > Reverting this change breaks module autoloading.

> No.

> Module autoloading worked before. Then someone probably noticed a
> problem, and thought they'd fix it by changing how the module alias
> strings SPI provides are produced. In fixing it, they broke existing
> setups that have worked for years.

To be clear Russell is absolutely right here.  These changes have
broken module autoloading for spi-nor on device tree based
systems which don't list the jedec,spi-nor fallback compatible,
and quite likely for some other drivers/systems that were also
relying on the fallback compatible mechanism in a similar way.
They will also have fixed systems where we weren't autoloading
based on DT compatibles but the broken systems are still broken
and regardless of the quality of the DTs that those systems have
DT is an ABI so they have to continue to work.

Ideally we'll be able to keep both sets of drivers working (and
I think we probably should just get all the compatibles listed in
the spi-nor driver for the sake of robustness if nothing else),
unfortunately this wasn't noticed until after v5.14 was released
so we might now have systems relying on the new behaviour too
which complicates things a bit.  Still, if we can't get it fixed
reasonably promptly (this week say, for the next -rc) I expect
I'll revert as Russell has suggested.

--Aplk1EN5iLWn29n7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFI9KMACgkQJNaLcl1U
h9DZgQf/dwpjkRgf7we00U7q36ZVZI+T0vTskjcTRsDJOPJLfOLVdXxRQopWnIwA
UmKfSthKAZyMmugabGwJ9ubh9WWQS+M21e4XAg3zyjrRFuodwrFjcj70d5O+gxQo
VaBcu/UP0okXFlcxMgUK1IhFMH6Ohe6BCtYqbrKgPRel7c3NnIxzT92bT0KejbHJ
dkXO/p4FOs/rdnDfjFLtLmfsjeYwXUmr3rkJqjjINwSD99Z35zWpaMlrA220aElu
lDr1jGT68ah00V+Kyds6hcl79/Kfc/h7vpY+WZkWnZ1HRTi2TAd+6KDvLMEYjc09
AmOyM7Zswz10vNZWNUyB1DUGYEQEuA==
=cpDL
-----END PGP SIGNATURE-----

--Aplk1EN5iLWn29n7--
