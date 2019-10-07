Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73188CEA09
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2019 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfJGRC6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Oct 2019 13:02:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56826 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGRC6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Oct 2019 13:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZOY/izmiavLTIQj54n6IQkVCG9+85gWQy14tT3EDmV0=; b=lf4bkH0BprDzs3rAmSZ1xRNM0
        QovVJMVonDYUSzpYubXfiAmSoYm+U+RQWN53l9/0xyVdlGtODEi7uLdOZUebcDAAcxZsgPQgpxvKW
        kgi3YNwrj85wJO1ybM9japYeUzuDF7ZJb1AMApcVPbswj6cK+aZmQq/LqnRAY7XzmCfLo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHWPO-00044c-W2; Mon, 07 Oct 2019 17:02:55 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 08620274162F; Mon,  7 Oct 2019 18:02:53 +0100 (BST)
Date:   Mon, 7 Oct 2019 18:02:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Message-ID: <20191007170253.GA5614@sirena.co.uk>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa>
 <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
 <20190926144342.327a3c66@jawa>
 <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
 <20190926160645.0a2623fa@jawa>
 <20190926151752.GU2036@sirena.org.uk>
 <20190927003849.0c9e4335@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20190927003849.0c9e4335@jawa>
X-Cookie: Death to all fanatics!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 12:38:49AM +0200, Lukasz Majewski wrote:

> Maybe, it would be sufficient for now to move the spi_slave_abort() in
> spi_release() before we decrease (spidev->users--) the use count?

I think that should be OK, or possibly safer to do it at the start of
the if (!spidev->users) section to avoid problems with fork()/exec()
combinations.  It'll need an if (spidev->spi) check as well, if we
manage to hit that we've pretty much lost anyway though and I'm not sure
I see a route to sensible error handling.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2bb70ACgkQJNaLcl1U
h9DHBgf/W/m+2jSATkcpdM7/FcRS/sMhWH6GHQp/pY+NkbGheVslqR70gaBKZl00
uVGBSaHg4XeQBndvtXyeqxAOOAqD9EvLXbRmAxDXcaezzr2K0UrysXvnAWJl80R6
UdzKeYw2gGchXz00zbWxnfcxcgQIvS4kRHfqoqb2LleeuL7g8S5rSdERpfoAGZG6
hVdax2Rpeskq0nGOzibmvi7N0+zQLn/379s0kXtavs+IfxT47eSPkkAv7V7ZOEPU
3BT0hYwJVBRC2Wb5m8Ddz0Cnt/mm0gTzURVxF+fTDj9uCXXxDEebrMpRLv1tcCfn
4+AI295/ZNCOaYqQzhx8/WYenQnqMg==
=Yu7g
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
