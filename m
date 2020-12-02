Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6C2CBBC6
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 12:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgLBLnr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 06:43:47 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:58879 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLBLnr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Dec 2020 06:43:47 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id CBE752801373D;
        Wed,  2 Dec 2020 12:42:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 085AD1D8B55; Wed,  2 Dec 2020 12:43:04 +0100 (CET)
Date:   Wed, 2 Dec 2020 12:43:04 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH for-5.10] spi: rpc-if: Fix use-after-free on unbind
Message-ID: <20201202114304.GA25779@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <bf610a9fc88376e2cdf661c4ad0bb275ee5f4f20.1605512876.git.lukas@wunner.de>
 <9534f4fb-6f5e-b538-6903-e702a7301b1d@omprussia.ru>
 <20201129113548.GA2587@wunner.de>
 <31f68249-2499-7ca6-9804-aad39e94b3b6@omprussia.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31f68249-2499-7ca6-9804-aad39e94b3b6@omprussia.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 30, 2020 at 10:18:12PM +0300, Sergey Shtylyov wrote:
> On 11/29/20 2:35 PM, Lukas Wunner wrote:
> > > Not sure why spi_unregister_controller() drops the device reference
> > > while spi_register_controller() itself doesn't allocate the memory... 
> > 
> > Yes, that's exactly what I'm trying to move away from with
> > devm_spi_alloc_master() (introduced in v5.10-rc5 by 5e844cc37a5c).
> > The API as it has been so far has made it really easy to shoot oneself
> > in the foot.
> 
> Maybe it needs to be fixed, rather than using the managed device API?

devm_spi_alloc_master() *is* the fix, or at least a means to get there:

No longer dropping the reference in spi_unregister_controller() requires
that the drivers drop the reference.  So every single SPI driver needs to
be touched.  However, upon closer examination I've found tons of bugs in
the ->probe and ->remove hooks of SPI drivers, some of them related to
reference counting (leaks or use-after-free), others related to not
disabling clocks properly etc.  Ideally, the fixes for those bugs should
be backported to stable.

devm_spi_alloc_master() allows me to do that and at the same time it
allows stretching the migration across multiple releases.  That's because
spi_unregister_controller() auto-senses if devm_spi_alloc_master() was
used, and if so, it no longer drops a reference.

devm_spi_alloc_master() has the additional advantage of simplifying
probe error paths, as is apparent from the diffstat of the $subject patch:

 drivers/spi/spi-rpc-if.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

I think the vast majority of SPI drivers can be converted to
devm_spi_alloc_master() and the few that can't will be amended to
explicitly drop a reference.


> > > Perhaps the order of the calls in the remove() method could be reversed? 
> > 
> > I'm not familiar with power management on these Renesas controllers
> > but rpcif_disable_rpm() calls pm_runtime_put_sync(), which I assume
> > may put the controller to sleep.
> 
> Sigh, that's a stupid typo on my part, being fixed now to
> pm_runtim_disable()...

Okay in that case the order of the two calls in	rpcif_spi_remove()
won't matter, i.e. it would actually be possible to fix the UAF by
calling rpcif_disable_rpm() before spi_unregister_controller().

However, I still recommend fixing the UAF in the way proposed by
the $subject patch because of the simplified probe error path and
reduced LoC.


> > The only thing that looks confusing is that rpcif_enable_rpm() calls
> > pm_runtime_enable(), whereas rpcif_disable_rpm() calls
> > pm_runtime_put_sync().  That looks incongruent.
> 
> Do you need a link to the fix (it a whole patchset of minor fixes)?

I don't *need* it, but am happy to take a look.  Glad that I was able to
point out another bug. :)

Thanks,

Lukas
