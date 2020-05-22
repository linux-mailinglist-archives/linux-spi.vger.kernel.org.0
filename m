Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6D1DECC2
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgEVQEQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 12:04:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:8252 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbgEVQEP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 12:04:15 -0400
IronPort-SDR: fc6zomEbi80bNiDvdPAANqm3JE/7OyJtgRlFd+CvRE2OfgD6U6G/ou3A8oM2zFb5LaWdnNTP4G
 TmGn2qGhC94g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 09:04:15 -0700
IronPort-SDR: WNjSqc4cwIhTalZPets6YWXKP7QBzGlhsoHvnscSxJeJRjbvsW5sKTwHpADnF7dWsWrUg8FEZ7
 guAkje8YQ7QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="255627245"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2020 09:04:14 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jcA9h-008G8V-AT; Fri, 22 May 2020 19:04:17 +0300
Date:   Fri, 22 May 2020 19:04:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Make spi_delay_exec() warn if called from atomic
 context
Message-ID: <20200522160417.GI1634618@smile.fi.intel.com>
References: <20200522155005.46099-1-broonie@kernel.org>
 <20200522160233.GH1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522160233.GH1634618@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 07:02:33PM +0300, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 04:50:05PM +0100, Mark Brown wrote:
> > If the delay used is long enough the spi_delay_exec() will use a sleeping
> > function to implement it. Add a might_sleep() here to help avoid callers
> > using this from an atomic context and running into problems at runtime on
> > other systems.
> 
> Thanks!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

We may improve it later, though, to be smarter and spill a warning only when it
uses non-atomic delays. For now this is good enough.

-- 
With Best Regards,
Andy Shevchenko


