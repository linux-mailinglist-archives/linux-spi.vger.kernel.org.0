Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF073708D6
	for <lists+linux-spi@lfdr.de>; Sat,  1 May 2021 21:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhEATxL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 1 May 2021 15:53:11 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:39245 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhEATxL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 1 May 2021 15:53:11 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9B61F2800B3D0;
        Sat,  1 May 2021 21:51:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8EE261BC5; Sat,  1 May 2021 21:51:35 +0200 (CEST)
Date:   Sat, 1 May 2021 21:51:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nsaenz@kernel.org, phil@raspberrypi.com
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
Message-ID: <20210501195135.GA18501@wunner.de>
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
 <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
 <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
 <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
 <20210423115724.GB5507@sirena.org.uk>
 <672e8d77-ee5c-f10f-0bd3-f8708dfc24c8@devtank.co.uk>
 <20210423162055.GE5507@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423162055.GE5507@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 23, 2021 at 05:20:55PM +0100, Mark Brown wrote:
> Part of the issue here is that there has been some variation in how
> num_chipselect is interpreted with regard to GPIO based chip selects
> over time.  It *should* be redundant, I'm not clear why it's in the
> generic bindings at all but that's lost to history AFAICT.

It seems num_chipselect is meant to be set to the maximum number of
*native* chipselects supported by the controller.  Which is overwritten
if GPIO chipselects are used.

I failed to appreciate that when I changed num_chipselects for
spi-bcm2835.c with commit 571e31fa60b3.  That single line change
in the commit ought to be reverted.

And the kernel-doc ought to be amended because the crucial detail
that num_chipselect needs to be set to the maximum *native* chipselects
isn't mentioned anywhere.


> The best thing would be to have it not have a single array of chip
> select specific data and instead store everything in the controller_data
> that's there per-device.

Unfortunately that's non-trivial.  The slave-specific data is DMA-mapped.
It could be DMA-mapped in ->setup but there's no ->unsetup to DMA-unmap
the memory once the slave is removed.  Note that the slave could be removed
dynamically with a DT overlay, not just when the controller is unbound.

So we'd need a new ->unsetup hook at the very least to make this work.

The Foundation's downstream kernel now contains a bandaid commit which
raises the limit to 24 and errors out of ->probe if the limit is exceeded.
I would have preferred if it errored out of ->setup.  That way only
the slaves exceeding the limit would fail to instantiate:

https://github.com/raspberrypi/linux/commit/05f8d5826e28

Thoughts?

Lukas
