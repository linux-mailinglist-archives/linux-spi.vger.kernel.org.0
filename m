Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201004593CC
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 18:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhKVRS0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 12:18:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:58264 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhKVRSZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:18:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="232316971"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="232316971"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:15:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="456355284"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:15:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpCuN-009Wzm-CL;
        Mon, 22 Nov 2021 19:15:11 +0200
Date:   Mon, 22 Nov 2021 19:15:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: Fix multi-line comment style
Message-ID: <YZvQH3llm6GtihPi@smile.fi.intel.com>
References: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
 <20211119173718.52938-2-andriy.shevchenko@linux.intel.com>
 <YZu7qWKYbWnmy20q@sirena.org.uk>
 <YZvO3gxIQ61qNbWJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZvO3gxIQ61qNbWJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 22, 2021 at 07:09:50PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 22, 2021 at 03:47:53PM +0000, Mark Brown wrote:
> > On Fri, Nov 19, 2021 at 07:37:18PM +0200, Andy Shevchenko wrote:
> > >   /*
> > >    * Fix multi-line comment style as in this short example. Pay attention
> > >    * to the capitalization, period and starting line of the text.
> > >    */
> > > 
> > > While at it, split the (supposedly short) description of couple of functions
> > > to summary (short description) and (long) description.
> > 
> > This doesn't apply against current code, please check and resend.
> 
> I have merged your for-next branch (is it correct approach) on top of v5.16-rc2
> and patches are applied cleanly. Is it something addition I should care about?

cherry-pick also works, however this series doesn't applied cleanly (I used
`b4`). It means that I sent version before the final one.  Sorry for that,
I will resend soon.

-- 
With Best Regards,
Andy Shevchenko


