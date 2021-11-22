Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54F4593B5
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 18:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbhKVRND (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 12:13:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:26328 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238230AbhKVRNC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:13:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321057776"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="321057776"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:09:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="606489759"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:09:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpCpC-009WtB-Km;
        Mon, 22 Nov 2021 19:09:50 +0200
Date:   Mon, 22 Nov 2021 19:09:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: Fix multi-line comment style
Message-ID: <YZvO3gxIQ61qNbWJ@smile.fi.intel.com>
References: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
 <20211119173718.52938-2-andriy.shevchenko@linux.intel.com>
 <YZu7qWKYbWnmy20q@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZu7qWKYbWnmy20q@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 22, 2021 at 03:47:53PM +0000, Mark Brown wrote:
> On Fri, Nov 19, 2021 at 07:37:18PM +0200, Andy Shevchenko wrote:
> >   /*
> >    * Fix multi-line comment style as in this short example. Pay attention
> >    * to the capitalization, period and starting line of the text.
> >    */
> > 
> > While at it, split the (supposedly short) description of couple of functions
> > to summary (short description) and (long) description.
> 
> This doesn't apply against current code, please check and resend.

I have merged your for-next branch (is it correct approach) on top of v5.16-rc2
and patches are applied cleanly. Is it something addition I should care about?

-- 
With Best Regards,
Andy Shevchenko


