Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF02255C2F
	for <lists+linux-spi@lfdr.de>; Fri, 28 Aug 2020 16:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgH1OUV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Aug 2020 10:20:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:8249 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgH1OUV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Aug 2020 10:20:21 -0400
IronPort-SDR: 8OAF3IXEtXhz/tvqFrAejTFA3wXPIXefelyVtihvRoMX+5utni/hWTRxsIwhkPjY2qT8JEBXGl
 TuJMouIB9q5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136731406"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="136731406"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 07:20:20 -0700
IronPort-SDR: cI5kvVDM2ObruMkjqRxb50Hf+W7Ux8AsH0eMnY4Wpb6xH6Q/BGBQt2Yam548oWMOaWUTYdlGoo
 nGYV02fJ05sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="329964462"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2020 07:20:18 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kBfEm-00C8TY-7r; Fri, 28 Aug 2020 17:20:16 +0300
Date:   Fri, 28 Aug 2020 17:20:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v1] spi: dw: Replace dma_request_slave_channel() with
 dma_request_chan()
Message-ID: <20200828142016.GS1891694@smile.fi.intel.com>
References: <20200828135818.2492-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828135818.2492-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 28, 2020 at 04:58:18PM +0300, Andy Shevchenko wrote:
> Drivers should use dma_request_chan() instead of dma_request_slave_channel().
> 
> dma_request_slave_channel() is a simple wrapper for dma_request_chan() eating
> up the error code for channel request failure and makes deferred probing
> impossible.

It's not fully correct change.

-- 
With Best Regards,
Andy Shevchenko


