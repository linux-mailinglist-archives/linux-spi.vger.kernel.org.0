Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9536C808
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhD0OyK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 10:54:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:65116 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236427AbhD0OyH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 10:54:07 -0400
IronPort-SDR: +nELwunGr/DRWrp/3csDTqOxpflkVR7gsJIhBrUQxkktx/9R4kQNBAOaJF5YaY1d7ixtkmrV16
 yDhIw/lG/imw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="281855663"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="281855663"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 07:53:19 -0700
IronPort-SDR: mDYm9swO0IuEFDarQ/vqe6eBdCFtg+yA2WeYwo8epkvNzMg6f5HVuDg4J34X3OQrNE0Uz52loI
 SzLtBCPIyjhA==
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="457673982"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 07:53:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lbP5O-007f4P-1b; Tue, 27 Apr 2021 17:53:14 +0300
Date:   Tue, 27 Apr 2021 17:53:14 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <YIglWpz8lSidXmDd@smile.fi.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
 <20210427143457.GI4605@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427143457.GI4605@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 27, 2021 at 03:34:57PM +0100, Mark Brown wrote:
> On Tue, Apr 27, 2021 at 02:46:02PM +0300, Andy Shevchenko wrote:
> 
> > Mark, are you accepting patches for v5.14 now, or should I resend
> > after v5.13-rc1 is out?
> 
> > (I have few more in my queue :-)
> 
> Send them now if you like.

Got it!

I think I prefer to produce a less noise in case this series for some reason
needs to be changed / amended. I'll wait till this series lands in your queue.

P.S. basically my question was about this series.


-- 
With Best Regards,
Andy Shevchenko


