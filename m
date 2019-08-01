Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A197DB98
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfHAMfK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 08:35:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51136 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfHAMfJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 08:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jn+TAs+wP2cc9h9jrK3a2n7Js2n4wFFbww5v7SUsvYc=; b=K7gXYWuRuzu1ZyYPKhgOzFdru
        SOUloJZGMoeo0cQCok3RcyjmDDBPVw4OZm/PQZM9vdRbAt8fu0Ozl7/rtJaTQHguXd+lDUWVot4Ii
        bx/2KN50JjOk3NcOwbelhXY6O6AWGbEOvFVFIOX418QS0JVDiN+2gG+r/2J2hv/jBytaA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htAIS-0004dZ-Af; Thu, 01 Aug 2019 12:35:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 570B02742C48; Thu,  1 Aug 2019 13:35:03 +0100 (BST)
Date:   Thu, 1 Aug 2019 13:35:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-spi@vger.kernel.org,
        Doug Anderson <dianders@google.com>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Message-ID: <20190801123503.GC5488@sirena.org.uk>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
 <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com>
 <20190801121718.GE31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20190801121718.GE31381@hirez.programming.kicks-ass.net>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2019 at 02:17:18PM +0200, Peter Zijlstra wrote:

> I'm thinking that isn't true 99% of the time, except of course when that
> bandsaw emergency break is attached through SPI, but in that case the
> admin can very well chrt the prio of this thread.

The SPI thread isn't usually RT, it's only made RT if something in the
system asks for it - the reason the ChromeOS people got CCed in is that
some of their embedded controllers are very fragile and need super tight
timing on some of the interactions over their control interface so
they're one of the users here.  Of course everyone is then going to
claim that their usage is the most critical usage in the system, and
they may well even be right, but I do tend to agree that just any old RT
priority is probably a sensible default since for most cases there will
be few if any other RT tasks anyway.

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1C3HYACgkQJNaLcl1U
h9Alfwf6AugMBoXb++tNEYu9FBXmJsqiEoyD4n90hKDCTMRgF8sokxYAvUGTJzQQ
iE0h+bYBl8vU2eJG4nCGRQZRRFmACX/amPXBY82xVOcBooUZ74g+igbRW35/nSuR
vtE8DGr2jugTuTznssPMVCKYSYcvxvV3PRzdvx30phQCUtqtBlpEFWVHH0FtacEM
UQPH01JiVA7QcE/ZqYXAR7Jsgfm7kNEMTAgaxvGUhYVVnHmWwZnioK8Ke/cE75SL
Uwa38z692JzCAL0c5qepeOF2aXLAjt+F1IPFWGrAjgmjRjqjS4ZzZWTGAWMMPscP
2Y/hPW2i7J6cvNkLxXborjsKCte3iw==
=t0Pu
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
