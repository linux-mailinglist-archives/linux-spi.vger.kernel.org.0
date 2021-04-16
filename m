Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B753623F3
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbhDPPat (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 11:30:49 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:32817 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343674AbhDPPar (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Apr 2021 11:30:47 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B9775300002A5;
        Fri, 16 Apr 2021 17:30:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A048816E8B; Fri, 16 Apr 2021 17:30:19 +0200 (CEST)
Date:   Fri, 16 Apr 2021 17:30:19 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: Multi driver SPI chip select count unenforced.
Message-ID: <20210416153019.GA26144@wunner.de>
References: <6a6c9d49-9064-4bbe-0330-87f92623d669@devtank.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6c9d49-9064-4bbe-0330-87f92623d669@devtank.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 16, 2021 at 11:55:45AM +0100, Joe Burmeister wrote:
> However, after I found the same broken pattern in a few places.
> You can find suspects by grep'ing in the SPI folder for "->chip_select]".

You need to cc the maintainers of the affected drivers.
You can retrieve them with "scripts/get_maintainer.pl drivers/spi/spi-...".

Please don't attach patches but rather submit each one separately.
Pass a commit range (abcdefg..0123456) to "git format-patch" to
get numbered patches, then submit them with msmtp or "git send-email".


> Subject: [PATCH] Handle SPI device setup callback failure.

Prepend the subsystem to the subject and drop the period, e.g.:

spi: Handle SPI device setup callback failure

Patch otherwise LGTM.


> Subject: [PATCH] Remove BCM2835 SPI chipselect limit.

Prepend "spi: bcm2835: " in this case and drop the period.
Use "git log --oneline <filename>" to see what the prefix should look
like for a particular file.


> The limit of 4 chipselects for the BCM2835 was not required and also was
> not inforced. Without inforcement it was possible to make a device tree
> over this limit which would trample memory.
> 
> The chipselect count is now obtained from the device tree and expanded
> if more devices are added.

I'd prefer it if you could just raise BCM2835_SPI_NUM_CS to 6
(or 8 or whatever you need).  Use commit 603e92ff10a8 as a template.

Then submit a separate patch to error out of bcm2835_spi_setup()
if bcm2835_spi_setup >= BCM2835_SPI_NUM_CS.

Honestly I think the additional code complexity isn't worth it to allow
for dynamic resizing.  Raising BCM2835_SPI_NUM_CS results in just a
few additional bytes, that's probably smaller than the increase of the
text segment due to the additional resizing code.

Nit: I think the correct spelling is "enforce".  (Not an English native
speaker but my dictionary says so.)

Thanks!

Lukas
