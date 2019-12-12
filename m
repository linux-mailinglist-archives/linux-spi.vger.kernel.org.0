Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2811D35E
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 18:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfLLRNK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 12:13:10 -0500
Received: from foss.arm.com ([217.140.110.172]:54016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbfLLRNK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 12:13:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CCF030E;
        Thu, 12 Dec 2019 09:13:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E10CB3F6CF;
        Thu, 12 Dec 2019 09:13:08 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:13:07 +0000
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
Message-ID: <20191212171307.GL4310@sirena.org.uk>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20191212152855.GD4310@sirena.org.uk>
 <TY1PR01MB15627D5522BE325B7BE74E328A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline
In-Reply-To: <TY1PR01MB15627D5522BE325B7BE74E328A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 04:53:26PM +0000, Chris Brandt wrote:

> There were some good suggestions from the V2 series that I think complete
> this driver. But I have not sent out a V3 until I can better understand
> this 'competing' solution.

Oh, this is a new driver for the same hardware as the RPC driver :(

I don't really know enough about the device and there was *huge* amounts
of discussion which I'd have to try to page in so it'd be really good if
there were some agreement among those of you working with this device as
to what the best way forwards is.  I'm not sure any of the issues were
at the framework level so that's probably more sensible anyway.

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ydSIACgkQJNaLcl1U
h9D+Sgf/ZdTezi2XkrSj7Vf2jqZscfXCtYud4GrauBqG0s9CiBYXKi0JQYDtufT1
7TLKdfKxilykONY5NYeEHQDFK4va79wMn1gjUOB+9O/DDGW0VeBs3Mi57ib28se8
3UVwm6T86Hrdh6r4yCMrS+T4be7blcu4piRDrYNc2AAg+HwugvEerMO+FlaaI6k8
CgqryzMLgRy6CUJwTk0QDQAr8jCyHM3M/M57QYFDBI7Udwa1lirpjxG4UjOtrkfC
QLPbH1psEHGhJXPOAgEbB1X9tXcyQ8W6DY+d980YUw7eRL0hSGSSLGoCpODk0tCP
5rwMLw6bF1ylqBSlgZO745nsTXDoVQ==
=576k
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--
