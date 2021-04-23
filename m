Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19E36985E
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhDWRay (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 13:30:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:28650 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWRay (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 13:30:54 -0400
IronPort-SDR: HH7J0U3oyCG414KCwiaIxEOQyMXv+p9cFG6DYK4E5+h2aU8d1QQruvQA6r6eBU7Soh+EylEHoJ
 6Z2IKDtw2CbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="257411468"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="257411468"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 10:30:16 -0700
IronPort-SDR: H9+pJ0RnWOxq95zAbxojlapA9H16lEreXz5ioaDa6GiMX0Jc7ksJcaW+a51sLjX3NXrGLdTt9x
 Yd6R36OQH8PA==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="386443849"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 10:30:11 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lZzd2-006cKS-BS; Fri, 23 Apr 2021 20:30:08 +0300
Date:   Fri, 23 Apr 2021 20:30:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 05/14] spi: pxa2xx: Consolidate related headers under
 include/linux/spi
Message-ID: <YIMEIEnt4meMP6Hx@smile.fi.intel.com>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
 <20210423163437.89306-5-andriy.shevchenko@linux.intel.com>
 <20210423165630.GH5507@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423165630.GH5507@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 23, 2021 at 05:56:30PM +0100, Mark Brown wrote:
> On Fri, Apr 23, 2021 at 07:34:28PM +0300, Andy Shevchenko wrote:
> 
> > We have two headers split between include/linux and include/linux/spi.
> > Consolidated them under SPI realm, i.e. in the latter folder.
> 
> Why?  Isn't the point to maintain an abstraction between the general
> purpose use of the SSP IP and its application as a SPI controller?

Aren't the General Purpose of the SSP IP is an SPI controller either way?
What you are talking about is probably GP SPI vs. private (dedicated) SPI.

But okay, I got the idea, I can drop this patch.

> I'd
> check the cover letter for the series but there doesn't seem to be one.

Set of cleanups here and there related to the SPI PXA2xx driver.
It's hard to add something else here.

-- 
With Best Regards,
Andy Shevchenko


