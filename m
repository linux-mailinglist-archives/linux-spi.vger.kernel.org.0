Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCDF478911
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 11:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhLQKiz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 05:38:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:33881 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233421AbhLQKiz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Dec 2021 05:38:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="227015666"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="227015666"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 02:38:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="483184755"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 02:38:49 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 17 Dec 2021 12:38:46 +0200
Date:   Fri, 17 Dec 2021 12:38:46 +0200
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
Message-ID: <Ybxotgb927kpCizL@lahna>
References: <20211118130543.11179-1-mika.westerberg@linux.intel.com>
 <20211118130543.11179-3-mika.westerberg@linux.intel.com>
 <20211216115100.448351e4@collabora.com>
 <Ybtn1VTsspxdIeT8@lahna>
 <20211216174347.69cf611c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216174347.69cf611c@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Dec 16, 2021 at 05:43:47PM +0100, Boris Brezillon wrote:
> Why no just
> 
> 	if (iop->mem_op.addr.nbytes != op->addr.nbytes ||
> 	    iop->mem_op.addr.dtr != op->addr.dtr)
> 		return false;
> 
> then?

That would be too simple ;-)

I'll do this change in v5.
