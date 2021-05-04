Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829FB372B66
	for <lists+linux-spi@lfdr.de>; Tue,  4 May 2021 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhEDNyv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 May 2021 09:54:51 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:42073 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhEDNyu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 May 2021 09:54:50 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B0749300002D5;
        Tue,  4 May 2021 15:53:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A367F437A5; Tue,  4 May 2021 15:53:53 +0200 (CEST)
Date:   Tue, 4 May 2021 15:53:53 +0200
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
Message-ID: <20210504135353.GA12996@wunner.de>
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
 <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
 <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
 <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
 <20210423115724.GB5507@sirena.org.uk>
 <672e8d77-ee5c-f10f-0bd3-f8708dfc24c8@devtank.co.uk>
 <20210423162055.GE5507@sirena.org.uk>
 <20210501195135.GA18501@wunner.de>
 <20210504115130.GA7094@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504115130.GA7094@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 04, 2021 at 12:51:30PM +0100, Mark Brown wrote:
> On Sat, May 01, 2021 at 09:51:35PM +0200, Lukas Wunner wrote:
> > I failed to appreciate that when I changed num_chipselects for
> > spi-bcm2835.c with commit 571e31fa60b3.  That single line change
> > in the commit ought to be reverted.
> 
> > And the kernel-doc ought to be amended because the crucial detail
> > that num_chipselect needs to be set to the maximum *native* chipselects
> > isn't mentioned anywhere.
> 
> Can you send patches for these please?

Yup, I've cooked up two patches over the weekend, one bcm2835 short-term
fix for-5.13 and one long-term solution for-5.14, they're on this branch:

https://github.com/l1k/linux/commits/bcm2835_spi_limit

Just needs some more polishing and testing before submission (hopefully
in the second half of this week).


> > Unfortunately that's non-trivial.  The slave-specific data is DMA-mapped.
> > It could be DMA-mapped in ->setup but there's no ->unsetup to DMA-unmap
> > the memory once the slave is removed.  Note that the slave could be removed
> > dynamically with a DT overlay, not just when the controller is unbound.
> 
> > So we'd need a new ->unsetup hook at the very least to make this work.
> 
> There's the cleanup() callback which seems to fit?

Right, I initially missed that but found it and then prepared the patch
on the above-linked branch.

Thanks,

Lukas
