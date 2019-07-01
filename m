Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8055C1F3
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2019 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfGAR0j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jul 2019 13:26:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37702 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfGAR0j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jul 2019 13:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g6LZ8Tx0pTrZ4NhPPifewe6o21F/XP97laDppwAIzSg=; b=G4T19QZeoIcfv/vrd6cIAD3jN
        ygYi5dkdH4108VDtjvwg0Wptb621uTVeHLJ0v0BoAeo8kUoiLQSwv1egM2J8HfX0cW3HZ2m0CZB1q
        quUN8jrL8kqfGZ/eY/4y3OxtWmOSnYVy30I/r2qO+dawe1uevG6GQ8fb9S6Ct3EqiST5g=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hi04a-0001lx-HC; Mon, 01 Jul 2019 17:26:36 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 53A53440046; Mon,  1 Jul 2019 18:26:35 +0100 (BST)
Date:   Mon, 1 Jul 2019 18:26:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Mauderer <oss@c-mauderer.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: spi-gpio too fast for some devices
Message-ID: <20190701172635.GF2793@sirena.org.uk>
References: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
 <a06e9923-735a-da2c-9946-4740842d5ca5@c-mauderer.de>
 <20190624132352.GL5316@sirena.org.uk>
 <7e9d963c-9402-979c-1dbd-51e548a15652@c-mauderer.de>
 <a1cb37c8-dc05-3827-0646-3bf58937a19b@c-mauderer.de>
 <CAMuHMdX7g0QePv4KustSExjyQOxHyATpShWEVBVyNXLvqon0Dw@mail.gmail.com>
 <20190701165930.GE2793@sirena.org.uk>
 <88b52423-7489-8958-ad87-5139a6213e4e@c-mauderer.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline
In-Reply-To: <88b52423-7489-8958-ad87-5139a6213e4e@c-mauderer.de>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2019 at 07:22:06PM +0200, Christian Mauderer wrote:

> Sorry that I'm not that common with the terms: With property you most
> likely mean one changeable at run time via the /sys filesystem right?

I was actually thinking of a DT property but yes that too, probably
would be useful for people trying to figure out the right number.

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0aQkoACgkQJNaLcl1U
h9DmFgf5AaFUIjILIobl8ffyZ+VS+CxSGI9HRjl2E3bU14+Bruw6Xaeb7GFXCGrZ
BkXgTFFxQ6pO2iZX+YWOlslOmv4jZQqH2DLkMOGz0whjEDNQIqcIFXpWIY9ow7WN
cCufMUR6oxvZbYZcdlyJCo/mrI1Hnp60tOwk8Wqu5FlS1HorkRI2SLOwE+66v7Sr
1PGDms28Tn/F3LVB5mByOJRtTCxbiyNbQmFNe247Q9IxG0kp4AA8Bi4AchuHlADC
vTHEwqT/tuTvYNyyzfXOVYGM5PW8HHRtRbBOLn2aglNCcDmlnBqxsrEg1KLl/Sxj
+Aaj6XdOkIEfFi0m8YxcU7oEJiU8aA==
=0OgW
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
