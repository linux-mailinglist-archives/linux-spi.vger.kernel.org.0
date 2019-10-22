Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38390E02D0
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 13:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbfJVL0D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 07:26:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44732 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfJVL0D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 07:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ueem69yO8cHYmSkVl6qpWVmfOoanomVT/nQBv4iBmP0=; b=fXxIAamG7yi5MXYKP7fSwudt2
        WPNvnUSW5smo5IXX27OZMqwm/Ys/KDvQtgcfjFZrdjA4NCjzkGGJtff7oVHi163VtbL+Nc+1hW2dz
        ikjqgHwQjUFaQ3ob7s/pa01cIXvqle30ENLMJ/G+lPwx4QQUwv8SsTCGu8IWPR3mvaiGE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMsIb-0006Sr-8W; Tue, 22 Oct 2019 11:26:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 732D22743259; Tue, 22 Oct 2019 12:26:00 +0100 (BST)
Date:   Tue, 22 Oct 2019 12:26:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: xilinx: Add DT support for selecting transfer word
 width
Message-ID: <20191022112600.GD5554@sirena.co.uk>
References: <20191022090007.15147-1-alvaro.gamez@hazent.com>
 <20191022102007.GA5554@sirena.co.uk>
 <20191022102859.GA1928@salem.gmr.ssr.upm.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <20191022102859.GA1928@salem.gmr.ssr.upm.es>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 12:29:01PM +0200, Alvaro Gamez Machado wrote:
> On Tue, Oct 22, 2019 at 11:20:07AM +0100, Mark Brown wrote:

> > Any new DT property needs documentation adding but in any case this

> Oh, ok. If this patch is of any interest, then I should provide changes to
> the appropriate file under Documentation/, is that right?

Yes.

> I was preparing and testing a second patch to add "spi-bits-per-word"
> property to children of the SPI driver, similar to the spi-max-frequency
> property and others alike, to fully support AXI Quad SPI core with different
> word widths. This also modifies the DT, so I guess it'd be better to send a
> single patch that comprises all these changes alongside the DT
> documentation. Would that be correct procedure?

Usually the DT changes should be a separate patch to the code changes.

> > shouldn't be set in DT, it should be set by the client driver - it's
> > going to be a fixed property of the device, not something that varies
> > per system.

> But this is in fact something that changes per system. When instantiating an
> AXI Quad SPI core in a HDL design that's exactly one of the options you can
> provide. In fact, in the board I'm working with right now, I'm instantiating
> two SPI cores, one of them with 8 bits per word but the other one requires
> 32 bits per word, as the devices it's going to talk to have this
> requirement.

This is still something that should be configured by the client driver,
if you send data with a different word size to that the client intends
it'll just get corrupted.

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2u50cACgkQJNaLcl1U
h9A6DQf/cSHvzaFieEVGRJX9YSYm9dhufdTHiuo+7+t3qmUNKnwZsU43oW8q+zKp
0ONnEQFkKv5g2UojZ2IxItaqCnizxwyosQlHwCOEgdISZKZeEbrv+YBrBYhWofYo
NGqrYi6tA9SvojnZPtbwK8Udl4/dT36UyOpRa7IhwgfME8lacgKUcC3z8Xmb3CZE
IDIZk+ZQdgytHGiqheZJ/TGjJacsXWd+sxTpiOuF0goExuRbW6z0C1zEKxOcMXd6
mCfOjgt58EarQ0y+C0XFFZocs88rjPonp54Kv4ES1OfBwSC3t3jwlVNMkAIJ5GMD
thpFAUAv0eW420JuiO0YppElG4tbJg==
=IIdP
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
