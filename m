Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC41E50BE3
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2019 15:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfFXNX6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jun 2019 09:23:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfFXNX5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jun 2019 09:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+UrtYLXzSnIgM6VP/LvN4aeGEXDC7vRlevOeGO44jQ4=; b=xKH5P5x5td39K7stmKi14D5rg
        ct6jsj/lxoC1KKU1kZacn8g9d6CCLTXNRlWTDXvoHyDlYtLOHPQ/vuzKmakL9gPuIxsjY56CHnLTQ
        0+ONqmRo17Lu0QZI6tNmKdSCPOnXJyl6UFu5mA8N6Xo0ib79U3ctfGKtaXRFg83/tQh9s=;
Received: from 188.29.164.245.threembb.co.uk ([188.29.164.245] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hfOwt-0001U6-Uf; Mon, 24 Jun 2019 13:23:56 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7F446440046; Mon, 24 Jun 2019 14:23:52 +0100 (BST)
Date:   Mon, 24 Jun 2019 14:23:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Mauderer <oss@c-mauderer.de>
Cc:     linux-spi@vger.kernel.org
Subject: Re: spi-gpio too fast for some devices
Message-ID: <20190624132352.GL5316@sirena.org.uk>
References: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
 <a06e9923-735a-da2c-9946-4740842d5ca5@c-mauderer.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KKvDzCUevEmRe2yO"
Content-Disposition: inline
In-Reply-To: <a06e9923-735a-da2c-9946-4740842d5ca5@c-mauderer.de>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KKvDzCUevEmRe2yO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 22, 2019 at 07:45:50AM +0200, Christian Mauderer wrote:
> On 10/06/2019 18:56, Christian Mauderer wrote:

> > I have a problem with the spi-gpio driver: It's too fast for one of my
> > devices. Now I'm searching for a good solution that could be
> > acceptable as a patch for the Linux kernel.

> > Currently there is the following comment and implementation for the
> > spidelay(...) function in spi-gpio.c:

> >> /*
> >>  * NOTE:  this clocks "as fast as we can".  It "should" be a function of the
> >>  * requested device clock.  Software overhead means we usually have trouble
> >>  * reaching even one Mbit/sec (except when we can inline bitops), so for now
> >>  * we'll just assume we never need additional per-bit slowdowns.
> >>  */
> >> #define spidelay(nsecs)	do {} while (0)

> >> #define spidelay(nsecs)	ndelay(nsecs)

> > which basically works. But with that the maximum rate drops to 1.6MHz.
> > I assume that such a drastic performance decrease isn't acceptable for
> > the kernel?

Yes, I can't imagine that other users are going to be happy with a
performance reduction like that.

> > Any directions for how an acceptable implementation could look like?

Off the top of my head you probably need to build a second copy of the
code with the delays included and then select that copy depending on the
speed that's been requested for the device and the speed of the system
somehow.  The actual bitbanging is in a header so that makes it a bit
easier to build two copies than it might otherwise be.

--KKvDzCUevEmRe2yO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0QzucACgkQJNaLcl1U
h9BG2Af+ILDi1nSe+5/828rNKaYgLC/odMc+lsAPgrJliTlgQeDo6CStklqipF+N
EK5KLJStaHsg6jHXEuDmNuDHdBp0Z9llgqWcgjgE+uOYiSX0GhhKXKlN00Gx0+Ef
cvBzgaACdkjHUH/+o82T1K8FqPaXCxyv4FB0rMkT8ooskYoOMnMMmyI5FnTKgaQE
MMNqS48MvLVQqhzAsUEAmbzZ28hirXV2IG1VPpPioEynZqKIzQzVjLeY2VEO72CW
VvL2TLioh5hBKOt8TZVvJXNWrp3ErI6idFUZfD4rM2aEXdmKZY0O3eWNXLUQERMj
ZN/+eVV8Vobn4n9eDMDazb28fwbE4A==
=Fabk
-----END PGP SIGNATURE-----

--KKvDzCUevEmRe2yO--
