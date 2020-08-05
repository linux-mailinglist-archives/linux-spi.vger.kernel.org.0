Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3502523D22F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 22:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgHEUJk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 16:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgHEQcO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:14 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FCF22D04;
        Wed,  5 Aug 2020 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596627111;
        bh=XtraZqjy+w6iRy+RCIQ5ANLerN6dU4WAvBFMK4YcMJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvHo7vZvjQy/hrYGM6L8kySbV9RisC2jj1fDI1wf8EJA48tCUGtjzqBRJMvnmruZX
         I3tsM+lfGVQbNDkpwU03zw4psFLQUFOHXBqau7x+/UDo5EjkP/+7zG9vMcHQP0rBUP
         22wdYY0ZsaOjw5Hm3qb9qilXljQPpBQdnMG3ZH3U=
Date:   Wed, 5 Aug 2020 17:01:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Feng Tang <feng.tang@intel.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] spi: dw-dma: Add max SG entries burst capability
 support
Message-ID: <20200805113146.GW12965@vkoul-mobl>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
 <20200731092612.GK3703480@smile.fi.intel.com>
 <20200731125954.jeeqmccnknqllwxh@mobilestation>
 <20200804211443.GE5249@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804211443.GE5249@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04-08-20, 22:14, Mark Brown wrote:
> On Fri, Jul 31, 2020 at 03:59:54PM +0300, Serge Semin wrote:
> > On Fri, Jul 31, 2020 at 12:26:12PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jul 31, 2020 at 10:59:45AM +0300, Serge Semin wrote:
> 
> > > > Note since the DMA-engine subsystem in kernel 5.8-rcX doesn't have the
> > > > max_sg_burst capability supported, this series is intended to be applied
> > > > only after the "next"-branch of the DMA-engine repository is merged into
> > > > the mainline repo. Alternatively the series could be merged in through the
> > > > DMA-engine repo.
> 
> > > This needs to be thought through...
> 
> > There is nothing to think about: either Mark completes review/accepts the series
> > and Vinod agrees to merge it in through the DMA-engine repo, or we'll have to
> > wait until the next merge window is closed and then merge the series in
> > traditionally through the SPI repo.
> 
> Well, the merge window is open now so this won't get applied till -rc1
> anyway.

Yes and the max_sg_burst capability is in my next and should be in PR to
Linus this week, so rc1 should have this.

-- 
~Vinod
