Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0CD9DB2
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2019 23:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394764AbfJPVtd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Oct 2019 17:49:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39620 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394721AbfJPVtc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Oct 2019 17:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZufvcA61v5agVfmRZclKpGS8RTRtaYHF1QkCoX0ETPs=; b=l51SxgSoH+eyfT2mm1rmGeBDT
        yhHObXSSp07I53kvAtlsoaAsFbOHIxbXQ+5WvPbqdFhqeM5Btng1ceKWOY/GqEEy2ZUfVTEoxRXTa
        1c+E9q1JTFuFWhzN0HvBdTIi9uijXihuIrT+FpqUqznByX6wziQTTDR7YCaC4sXshvUbk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKrAV-0006KC-UE; Wed, 16 Oct 2019 21:49:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EB915274325C; Wed, 16 Oct 2019 22:49:18 +0100 (BST)
Date:   Wed, 16 Oct 2019 22:49:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: pxa2xx: Set controller->max_transfer_size in dma
 mode
Message-ID: <20191016214918.GA11473@sirena.co.uk>
References: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
 <36610873-fa30-a286-d05c-5eceb3cbcb57@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <36610873-fa30-a286-d05c-5eceb3cbcb57@tronnes.org>
X-Cookie: Auction:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 11:30:51PM +0200, Noralf Tr=F8nnes wrote:

> As Andy mentioned, ->max_transfer_size is a callback:

> struct spi_controller {
> 	/*
> 	 * on some hardware transfer / message size may be constrained
> 	 * the limit may depend on device transfer settings
> 	 */
> 	size_t (*max_transfer_size)(struct spi_device *spi);

> (I looked at its users and they all return a static or probe time value
> so not sure why it's a callback.)

Huh, I wonder why we did that...  I can't find any clear record, and
like you say nothing is using it so we should probably fix it - however
that's best done separately to this :/  Sorry for the confusion, I
didn't register what Andy was saying as being pointing out the current
state of the code.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2nkF4ACgkQJNaLcl1U
h9A+Pwf/W+TqlKqBacstyeP18KY0oRQ7ySrj544UYjH8VdN93ZMgWCSCZ5FgL9tv
APkLEB1mXcpDeqLbLHKrNBS+8yMpCzqOVIYjmA1COIRm627P28BGBF1IKaFaPg2N
fjG5vu2nWcgpCjPneFPOdCP0RLEiRd0qWLCbPv4VpKJpYHK4U44/m7bN8iuM9cHB
Chd4H3kndisVKQXkwsAT6emauaPLaf17Hbhovoar5TlHECfIwOYKanPDPIYqgol6
uOFs93BJbfky2Wj5rbCNh1F6T2zKpG8ctOvrPrDVvNcVF2vv0+EIlESSGM+aON42
h/DQKS+S9hNCPnEKRtbjv++nzuZbow==
=+n2p
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
