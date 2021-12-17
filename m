Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23C047896C
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 12:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhLQLFd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 06:05:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:16181 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234890AbhLQLFc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Dec 2021 06:05:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="237272476"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="237272476"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:05:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="612088757"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:05:27 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 17 Dec 2021 13:05:25 +0200
Date:   Fri, 17 Dec 2021 13:05:25 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <Ybxu9eNCBy3OgWLN@lahna>
References: <20211118130543.11179-1-mika.westerberg@linux.intel.com>
 <20211118130543.11179-3-mika.westerberg@linux.intel.com>
 <20211216115100.448351e4@collabora.com>
 <Ybtn1VTsspxdIeT8@lahna>
 <20211216174347.69cf611c@collabora.com>
 <Ybxotgb927kpCizL@lahna>
 <20211217115206.33da307c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217115206.33da307c@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 17, 2021 at 11:52:06AM +0100, Boris Brezillon wrote:
> On Fri, 17 Dec 2021 12:38:46 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Hi,
> > 
> > On Thu, Dec 16, 2021 at 05:43:47PM +0100, Boris Brezillon wrote:
> > > Why no just
> > > 
> > > 	if (iop->mem_op.addr.nbytes != op->addr.nbytes ||
> > > 	    iop->mem_op.addr.dtr != op->addr.dtr)
> > > 		return false;
> > > 
> > > then?  
> > 
> > That would be too simple ;-)
> > 
> > I'll do this change in v5.
> 
> I didn't review the driver thoroughly, but it looks clean an tidy. Feel
> free to add
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Thanks!

> One more thing. I think it'd be good to implement the dirmap hooks (in
> a follow-up series, not here), so you don't have to iterate over the ops
> table every time a read/write request is issued. Should be as simple as
> storing the exec_op() pointer in the driver-private dirmap pointer, and
> calling this function when ->dirmap_{read,write}() is called.

Okay.
