Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCBA11D103
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfLLP3A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 10:29:00 -0500
Received: from foss.arm.com ([217.140.110.172]:50756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfLLP3A (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 10:29:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB6A30E;
        Thu, 12 Dec 2019 07:28:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FE313F6CF;
        Thu, 12 Dec 2019 07:28:58 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:28:55 +0000
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
Message-ID: <20191212152855.GD4310@sirena.org.uk>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 02:29:07PM +0000, Chris Brandt wrote:
> On Wed, Dec 11, 2019, Sergei Shtylyov wrote:

> >    The last word from our BSP people was that JFFS2 doesn't work with the
> > HyperFLash dedicated BSP driver... :-/

> Is that why this "RPC" patch series is taking so long?
> It's a fairly simple piece of hardware.

The submitter appeared to be having difficulty with feedback from the
reviewers with knowledge of the hardware, then it looks like the last
version of the patch set didn't get any comments from any of those
reviewers.

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3yXLYACgkQJNaLcl1U
h9CWRAf/d0MNGnB7aK0YH7cmyHB95BuE2Ljgqzl+79JflqVMfGbDEZLG4CqVSalS
A7r5jUX6nfU3oI5DMuycdYsT6DnEcSeMXikHBTtb3qSt2Why1C7moQ+7yql8l3cN
icVqnMMLqMLcbEOjsMfZ4Kb3QwlgKbnZjXbpJtTlELz/i2Re3KPhCC2UX3laoYKI
KGtscAJnfFsf1G6bj3AtVQJk1o7daNFUAE2GTKAGRVKHjMQZW3WbatGNEPdQA6n2
GoIDVNFOFavSQ174YjzMpQ/5c1Am8h5yTioFtSAQyOcWHFbk8DbX0Pra9xsaD8pc
rfX4J9WWH3E5nLIRy9z1JZabk85x4w==
=D3b3
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
