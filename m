Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65B517763F
	for <lists+linux-spi@lfdr.de>; Tue,  3 Mar 2020 13:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgCCMnl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Mar 2020 07:43:41 -0500
Received: from foss.arm.com ([217.140.110.172]:46538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgCCMnl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Mar 2020 07:43:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C99FEC;
        Tue,  3 Mar 2020 04:43:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050CE3F534;
        Tue,  3 Mar 2020 04:43:39 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:43:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
Message-ID: <20200303124338.GD3866@sirena.org.uk>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA@mail.gmail.com>
 <f6f21e75-7cee-89da-bb87-95327a4ec2cc@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <f6f21e75-7cee-89da-bb87-95327a4ec2cc@huawei.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2020 at 09:42:45AM +0000, John Garry wrote:

> However, maybe another callback could be introduced, .early_setup().

One thing I like about the explicit core code is that it makes it much
easier to see which drivers are doing the worrying thing, with just
overwriting things in a callback everything is very freeform and you
have to audit things individually.

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eUPkACgkQJNaLcl1U
h9BYcAf4kl/gydZycwZtTddrolWZTe5aGp9hdBn91H5K4i0f3Sp/wzjZi9Z7NMLZ
hFT1kd7fwU9kHr5QBDt66s8mnC/A8WU/yLekP7hKQkumLFBXT+EzpW4ZsD0OFB8R
KvAr5BCFqvJMdRPYCqsqi1nvZwNA4jYhWXp5sGlT3T/4GH0ulhQDZghULkx+8e06
Kd23pOwyQmDQgwVTqQ/YuB36cPzriYsoxu3vijQZLIVGO4K/PPqiaoq5Af1EiGlr
mcwa0IaW3IMQbjLk5KPuITz8YUMrPryVc+unOuertCfFYoHcYmgIO/Aq6yOpnbRl
UajtjXoFfB5jRdSGvoDFHjZcfYfJ
=FOcd
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
