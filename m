Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA05CFEC
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 15:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfGBNAP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 09:00:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGBNAP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 09:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jl7HQgZuMrwCLzhSVjxSh+yXNbxN3U9qGfVYC0VE3eY=; b=SV/WMONwZDgPwDEJrcwq8ZpS7
        q1qD2qsIar9NyLgjDey+HkhIYoZZvtTk9JzMQN8C7UckDpEuyKtSNcohDhWr3OUt9vqBm6EYw+rAJ
        5akzWbSMsVXs4JK4ZP4qwXBU01GES9TqEsrdfeMSq3CFSdLnTJOJOydR/v0g+D/VeYcvw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiIOH-0002N0-CX; Tue, 02 Jul 2019 13:00:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 99917440046; Tue,  2 Jul 2019 14:00:08 +0100 (BST)
Date:   Tue, 2 Jul 2019 14:00:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Mauderer <oss@c-mauderer.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: spi-gpio too fast for some devices
Message-ID: <20190702130008.GM2793@sirena.org.uk>
References: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
 <a06e9923-735a-da2c-9946-4740842d5ca5@c-mauderer.de>
 <20190624132352.GL5316@sirena.org.uk>
 <7e9d963c-9402-979c-1dbd-51e548a15652@c-mauderer.de>
 <a1cb37c8-dc05-3827-0646-3bf58937a19b@c-mauderer.de>
 <CAMuHMdX7g0QePv4KustSExjyQOxHyATpShWEVBVyNXLvqon0Dw@mail.gmail.com>
 <20190701165930.GE2793@sirena.org.uk>
 <88b52423-7489-8958-ad87-5139a6213e4e@c-mauderer.de>
 <20190701172635.GF2793@sirena.org.uk>
 <46a067d5-5c87-545b-d034-1cfbc7c674dd@c-mauderer.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gw4vLALk08fVJy3V"
Content-Disposition: inline
In-Reply-To: <46a067d5-5c87-545b-d034-1cfbc7c674dd@c-mauderer.de>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gw4vLALk08fVJy3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2019 at 08:33:27PM +0200, Christian Mauderer wrote:
> On 01/07/2019 19:26, Mark Brown wrote:

> > I was actually thinking of a DT property but yes that too, probably
> > would be useful for people trying to figure out the right number.

> My experience with the device tree from last time (a LED driver) was
> that implementation specific properties are not that popular. A property

No, they're absolutely fine when they have a use case.

> that tells one special driver from which speed on it should just ignore
> the speed and try it's best to do max speed seems quite implementation
> specific. Maybe except if I try to introduce a max-speed property to the
> SPI slaves that can be used instead of the speed.

You can already set the maximum speed - this is about tuning a
very system specific point to switch implementations.

--gw4vLALk08fVJy3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bVVcACgkQJNaLcl1U
h9Dtawf/Vi1sBAbAWA9P0zeZj6e9n091Cntxv3BawnAJEBLW1Tw6DuOGJGBZu7mm
xmDVkWLV7uStFSCM735BoR2sAvzhFN9+Dk7vLhkECta08JU7WMzVFRYCPVCA6KBL
2Pn6hgdmIzm0CB4I9u8NArY1m0TCoKrCPH9hcM1wjb/fkPOmeblvXWDWijM8LAjE
ZQcVgf8BbkfS1eAPT9JxhERmTAMQbE449hskbyEQgCiQ1/YdEQZRr8mVXu4Pg0IJ
rGksQzZ0daIgfT+wHgmsdxQC70e13O4unDAWiiY60O3x4YtPWWPXrLc1bfUQL6yG
i+oLII0yPZumvsaKI+cmqV2Q7F63PA==
=fVyQ
-----END PGP SIGNATURE-----

--gw4vLALk08fVJy3V--
