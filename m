Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3308E12B00C
	for <lists+linux-spi@lfdr.de>; Fri, 27 Dec 2019 01:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfL0A7J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Dec 2019 19:59:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43302 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfL0A7J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Dec 2019 19:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b2rtFlDWT9u7yqTvQM+L2HoYozAhuvbhOAHBbpkqe5o=; b=rJE9LqGxvBqnQ69avZ18Yrp9H
        Wbg67tXSt2jFUMHx2UKQw5x82OAOcvfSyTNeQaRAzgOWpLMpNwk8i2M1+SBp7ckOqJ2qjeQS9ecFr
        ZpHY7u5nCsAWlwSiAkubqm7F6n6/WGrayjvT1KpeCEa9UB01CggOupVUMh368oE5RNfAo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikdxz-00048c-Ip; Fri, 27 Dec 2019 00:58:59 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 98563D01896; Fri, 27 Dec 2019 00:58:58 +0000 (GMT)
Date:   Fri, 27 Dec 2019 00:58:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     masonccyang@mxic.com.tw, Chris Brandt <Chris.Brandt@renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Message-ID: <20191227005858.GJ27497@sirena.org.uk>
References: <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
 <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
 <TY1PR01MB1562E196AB1C582F186CC74B8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <6f4c5d92-3ca4-2d1d-47c4-cbd52ad428b0@cogentembedded.com>
 <OF3F92D76C.33FFFBFC-ON482584D6.00093DAC-482584D6.0009A51D@mxic.com.tw>
 <bac1f4db-302d-0dd7-3b66-341a74f67a6b@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline
In-Reply-To: <bac1f4db-302d-0dd7-3b66-341a74f67a6b@cogentembedded.com>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 24, 2019 at 07:58:21PM +0300, Sergei Shtylyov wrote:

>    It doesn't matter much what's in the renesas-soc patchwork, the patch would
> be merged thru the linux-spi repo, and in their patchwork the status of your v17
> patches is "New, archived"...

To be fair patchwork isn't exactly used in the review process for
SPI like it is with some other subsystems so other than automated
updates when things get applied or superceeded the states don't
mean a huge amount.  Like I said elsewhere in the thread I'd been
expecting some review from other people working with this
hardware since up until that point it had been pretty active.

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4FV1EACgkQJNaLcl1U
h9Dw/Qf9H6McVLuJOf7UR+8tvE28HHYofwkbY9W0uLfOPBnIsIVtKzOG2cAfPJay
kXZ0Up1m1wHAMLGSw9Cb0NO8sweKh9ke+7V8lP9uXajisXtUbUVar3kgita+zRtB
Qsv/8L4zPyskxKL97XySBb+28UPEcmm2evLJf+LUiL6msYQ2S9960UKZ8JYj90g3
GDCZgbuZjGNpzy/fmQib5mG9JbpXHAzy0QSrT5X7h+hIepp/zDI+C1r+wyOzM7YE
pNtZ9ndxtEaKGqkmW+slAJn3peHxOqvS6S1BTGANnCPfsruGKOb/XL4ItNcOpLzp
7jHMO77S8ZX5o+nu46YjuqwYv+ziCA==
=L9BN
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--
