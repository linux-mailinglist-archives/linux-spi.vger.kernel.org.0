Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C692134C59
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfFDPfs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 11:35:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53802 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfFDPfs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jun 2019 11:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=joRyfXpNBkFZTEPOmX+UMFBZ/oEWaZuXdim83D22+5o=; b=S/Xm2ADq+50WBKiNcoyJt87JG
        kFVYkCczOyNB95Ww9rk2OLTIPRce+dVxk7WuG65hUbyTIwkrDSMapJ9Ml6vuDpIyVI6upI3CvFrTm
        NWrV8VZXnccHKenGRicqe39twDJdRRAwiWLtHTEdN/3NnhO9BF5eSUC6wVCTPr4zmr/W4=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYBTV-0006K3-Vj; Tue, 04 Jun 2019 15:35:46 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 72244440046; Tue,  4 Jun 2019 16:35:45 +0100 (BST)
Date:   Tue, 4 Jun 2019 16:35:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spidev: Use dev_dbg() instead of pr_debug()
Message-ID: <20190604153545.GH2456@sirena.org.uk>
References: <20190604025129.20387-1-festevam@gmail.com>
 <CAMuHMdV8hdVQAxw6ookb695K3TZuqy4VEv78=3gUBE17J=4aYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6nK9RR+X1IX2pXa"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV8hdVQAxw6ookb695K3TZuqy4VEv78=3gUBE17J=4aYg@mail.gmail.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--f6nK9RR+X1IX2pXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2019 at 09:22:30AM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 4, 2019 at 4:53 AM Fabio Estevam <festevam@gmail.com> wrote:

> >         if (status) {
> > -               pr_debug("spidev: nothing for minor %d\n", iminor(inode));
> > +               dev_dbg(&spidev->spi->dev, "spidev: nothing for minor %d\n",
> > +                       iminor(inode));

> This doesn't look correct to me, as a non-zero status indicates that the
> corresponding spidev was not found, and thus spidev is not a valid
> object pointer to dereference.

Right, the issue is that we don't have the device.

--f6nK9RR+X1IX2pXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz2j9AACgkQJNaLcl1U
h9Ariwf/cI8cVIu1TqijZwdqp0ZI1jpo+OJmZCTjytE6YIpqQN17RtEO9HpJd/JF
Tq/XvgcsxgVTaw86JC6a0/26c5NuD1/UvvXMd2JTm4uHG0sSE1HEmp7ll7+HUXOd
wBPBRM3GoEERslwDO4cPWUv+N/UGAr7/dQUpNeCeU6mctzqCjYEz8i2vPcgo/Flp
WAjrB2NmVyzE1qbaiO/RmFgqAm/m800d0YnH0h3F6ocKWvymXI03wP1pFjqcZpHz
bWEylG4xIbQoXTJdhOyTUu/lmjw0RKah1VT9D96mf2wMOYq1SaSbw5ZnD8tpgHM9
5ZB6jQGunH0erCilXb9GZm91ToXjEw==
=UajN
-----END PGP SIGNATURE-----

--f6nK9RR+X1IX2pXa--
