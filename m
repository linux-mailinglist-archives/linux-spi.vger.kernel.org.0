Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE43120985
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfLPPVi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 10:21:38 -0500
Received: from foss.arm.com ([217.140.110.172]:58714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbfLPPVi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 10:21:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CBCF1FB;
        Mon, 16 Dec 2019 07:21:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F08EE3F718;
        Mon, 16 Dec 2019 07:21:36 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:21:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Brandt <Chris.Brandt@renesas.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Message-ID: <20191216152135.GG4161@sirena.org.uk>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20191212152855.GD4310@sirena.org.uk>
 <TY1PR01MB15627D5522BE325B7BE74E328A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20191212171307.GL4310@sirena.org.uk>
 <TY1PR01MB156256ED8A09D4CD02AC26AC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <TY1PR01MB156256ED8A09D4CD02AC26AC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
X-Cookie: Backed up the system lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 05:25:43PM +0000, Chris Brandt wrote:
> On Thu, Dec 12, 2019, Mark Brown wrote:

> > I don't really know enough about the device and there was *huge* amounts
> > of discussion which I'd have to try to page in so it'd be really good if
> > there were some agreement among those of you working with this device as
> > to what the best way forwards is.  I'm not sure any of the issues were
> > at the framework level so that's probably more sensible anyway.

> I'm trying to figure out if the differences are 'technical' or
> 'ideological' (ie, R-Car use cases vs RZ use cases).
> Of course we can do anything we want in our vendor BSPs, but I'd like
> to see a common upstream path.

That'd certainly be good to achieve.  Hopefully we can get some
agreement between everyone on what the best way forwards is.  I don't
recall any substantial framework concerns with either driver so I think
it's more a renesas question.

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33oP4ACgkQJNaLcl1U
h9AaYgf9FWzuFWeQnyYn63oY+9wqMpwmFKKYapmBdLEDpM4FvBClhmmHDFp7/Z3M
Gu5PZc0KJUDCrmBr2oulXL7cVjG1WlON/AkYHhU/OHElt1VJstBbUxGc1umu3Xap
+m2wEFfP63AvTL+d2fhkGhCOcQ5qsYRf1oYfUWTw550yMdR5CNnaPe0a81GJKd9W
RapZHUrSdZDd46Ab6e2y/wCb+JyA0thWLr3ctUN5zmGTYQSeXEMJcxTEHaRxjJSw
M3K/Ta9DbWE4IoaH/9avPv8TClP9KieW1ts4flJRc2E7bJ/Xp6bV1aZTU63iKvwJ
2XyTtPY0KF/rO+dilSJ9gwcLHaRksw==
=YGOH
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
