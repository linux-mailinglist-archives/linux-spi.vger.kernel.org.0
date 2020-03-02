Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BCD175FC0
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 17:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCBQdU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 11:33:20 -0500
Received: from foss.arm.com ([217.140.110.172]:35120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgCBQdT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Mar 2020 11:33:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 798BFFEC;
        Mon,  2 Mar 2020 08:33:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F22793F534;
        Mon,  2 Mar 2020 08:33:18 -0800 (PST)
Date:   Mon, 2 Mar 2020 16:33:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Garry <john.garry@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
Message-ID: <20200302163317.GH4166@sirena.org.uk>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <CAMuHMdV9v-7eRqi3JjcNaOBpRrC2-gLDCizYOJwhQCjZiLr5dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV9v-7eRqi3JjcNaOBpRrC2-gLDCizYOJwhQCjZiLr5dA@mail.gmail.com>
X-Cookie: Whistler's mother is off her rocker.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2020 at 05:12:05PM +0100, Geert Uytterhoeven wrote:
> On Fri, Feb 28, 2020 at 4:23 PM John Garry <john.garry@huawei.com> wrote:

> > A host controller driver might know this info from DMI tables, for example.

> Can't acpi_register_spi_device() obtain that info from DMI tables,
> to avoid contaminating the generic code?

The DMI tables are going to boil down to per board quirks which we
*could* put in the core but you end up with a lot of them and chances
are that at some point we'll end up with device specific quirks which
don't fit so well in the core.  Handling stuff in the drivers is fairly
idiomatic.

Much ACPI, so standards :/

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5dNUwACgkQJNaLcl1U
h9AexAf/aeE9iGeVv7pH09/MjY36txVc4+qNNLl4dd0LN6yt222WVl1jNMjvWnTl
LrJ94pJcXCAPNZMpzkOMFJHdSK2n9PCuoA9KprkrZ2UUUpQe96q+Ll2qGnO3R7Wo
qcL0FtJEGfuo9znEMdKSAxp2Buc6RW3AgPYp/9N7s+JT17mm9dL50BrujpvgaE6C
LTSQ7KZ+rJFDBejSFD8T81zT80tVWXqyzWH9xdDFc9RkvBlX2iFqkUHXDP73Z1ik
v/6mYFfXLjz0ekOn4/YKkTip2/EQ/EA4SrPYF80UOIzFFGYECBSdGXU3ZEHvkQBV
jodU2vNG5FKyZOVlc4YxD5faKm8peA==
=zK3/
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
