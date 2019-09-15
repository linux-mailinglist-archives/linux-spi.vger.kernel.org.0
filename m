Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169C3B2FB6
	for <lists+linux-spi@lfdr.de>; Sun, 15 Sep 2019 13:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfIOLWr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Sep 2019 07:22:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52308 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfIOLWr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Sep 2019 07:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=56zqmhsjMtRUCKlYk+SxAg1yHp75qE9+3DpNLXrWEng=; b=GwwMVLsYAnn9ukgLmEPf4qaVg
        3Ef8kV/O+KpJO9xdKRnuJbcykqI0MrPfnu/xYpuOJHjqp6YkPLpOdOHonwxFfp5R62ePkGl/9bSop
        Ir365pCVsf7kel/p/RQG+fUBqRXijq5D58uu9CWUIzqnBHnt4GmxvZ82yIWL2r4u+Y1GI=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9Sc8-0007S4-1e; Sun, 15 Sep 2019 11:22:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 02C602740137; Sun, 15 Sep 2019 12:22:42 +0100 (BST)
Date:   Sun, 15 Sep 2019 12:22:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] spi: dw: Add compatible string for Renesas RZ/N1 SPI
 Controller
Message-ID: <20190915112242.GA43855@sirena.co.uk>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568376720-7402-4-git-send-email-gareth.williams.jx@renesas.com>
 <CAHp75VeJY44oqYPhb-E8U1Uz5tKEJ1wZfmsGYEDttLzypHEAHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <CAHp75VeJY44oqYPhb-E8U1Uz5tKEJ1wZfmsGYEDttLzypHEAHA@mail.gmail.com>
X-Cookie: Exercise caution in your daily affairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 15, 2019 at 02:00:33PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 13, 2019 at 3:14 PM Gareth Williams

> > The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
> > additional registers for software CS control and DMA. This patch does not
> > address the changes required for DMA support, it simply adds the compatible
> > string. The CS registers are not needed as Linux can use gpios for the CS
> > signals.

> > +       { .compatible = "renesas,rzn1-spi", },

> Can't you simple use in DT something like
>   compatible = "renesas,rzn1-spi", "snps,dw-apb-ssi"
> ?

Yes, you can and should do that but it's still nice to list the
compatibles explicitly in the driver in case someone leaves out the
fallback compatible for whatever reason - if both the driver and the DT
list things then there's a bit more robustness.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+HwIACgkQJNaLcl1U
h9AfuQf5AVfP2aLgb/wagBnPhqQNepUFArGUV9VrZqyKZbaEveqGp42TXTaWp4Z4
F5vjPMGkBHfhHJoKWyJZiFnNaimOHVvH2MxsVxdxckvF5MDWShZO7xtKHGAqkwmv
JGXJRWaSkVPW1WQ7rYXLLTqXYyhIYASbl1YNjymHxgw/aEr9Zn2XoxihmgeiLANg
K990BsukJHIcY7n15boVvb15IqTiB2W51exwDyTHw5SMQ4zEt8IXexDn8meqZKzs
x4qQeZKni+Y0Lykk9c6+Y7Sixf+P8XUjVaVW1jCjBWkmB9ebBnb6o4oSzhlHP4SC
F8eS11Hqa8IvR+5S+AZLRgDTXVBYCQ==
=BDOI
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
