Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF18D1DECE2
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgEVQKE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 12:10:04 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45682 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbgEVQKE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 12:10:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4294A8030790;
        Fri, 22 May 2020 16:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DKBl80vdXtWy; Fri, 22 May 2020 19:10:01 +0300 (MSK)
Date:   Fri, 22 May 2020 19:10:01 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: Make spi_delay_exec() warn if called from atomic
 context
Message-ID: <20200522161001.s4pzjvzq6vwdivo3@mobilestation>
References: <20200522155005.46099-1-broonie@kernel.org>
 <20200522160233.GH1634618@smile.fi.intel.com>
 <20200522160417.GI1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200522160417.GI1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 07:04:17PM +0300, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 07:02:33PM +0300, Andy Shevchenko wrote:
> > On Fri, May 22, 2020 at 04:50:05PM +0100, Mark Brown wrote:
> > > If the delay used is long enough the spi_delay_exec() will use a sleeping
> > > function to implement it. Add a might_sleep() here to help avoid callers
> > > using this from an atomic context and running into problems at runtime on
> > > other systems.
> > 
> > Thanks!
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> We may improve it later, though, to be smarter and spill a warning only when it
> uses non-atomic delays. For now this is good enough.

IMO this wouldn't be better than the current solution. might_sleep() is called
"might" to warn that the called method may get to sleep, not shall, not will. As
I see it it's better to warn about the consequences straight away, but not at the
point when the sleeping method is actually called in the atomic context.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
