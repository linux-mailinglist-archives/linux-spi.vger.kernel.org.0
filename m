Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3569F37A8B0
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhEKOOi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:14:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:39313 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhEKOOh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:14:37 -0400
IronPort-SDR: Ox2ATWqhoTEbygqkU67iwcz+HZiJLwcXd6qgdK8CbAM3I/j3c8Mhd7KDZRV/QasEMZ/4EruHdv
 a/Pbs4PyzBwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179044594"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179044594"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:13:30 -0700
IronPort-SDR: XWeliyNGUr1fBJgpmzQTk+wnAEIVoQ1NpxHUGgP7CmAWCiSgGYYn/E7tC/qPno4JAxIXTlmLzj
 GElIT6wMfHhw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="541660559"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:13:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lgT8W-00BSqe-Oy; Tue, 11 May 2021 17:13:24 +0300
Date:   Tue, 11 May 2021 17:13:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <YJqRBIdTlvnsCYsn@smile.fi.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
 <20210511134706.GI4496@sirena.org.uk>
 <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
 <CAHp75Vca2KT4kd9zw3ECqym1rRDSg2NNbwRRVVA1L7vyD3VCJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vca2KT4kd9zw3ECqym1rRDSg2NNbwRRVVA1L7vyD3VCJQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 11, 2021 at 04:56:05PM +0300, Andy Shevchenko wrote:
> On Tue, May 11, 2021 at 4:52 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, May 11, 2021 at 4:47 PM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > On Tue, May 11, 2021 at 03:28:18PM +0300, Andy Shevchenko wrote:
> > > > On Tue, May 11, 2021 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > > > On Fri, 23 Apr 2021 21:24:27 +0300, Andy Shevchenko wrote:
> > > > > > Set of cleanups here and there related to the SPI PXA2xx driver.
> > > > > > On top of them, adding the special type for Intel Merrifield.
> > >
> > > > > [07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
> > > > >         (no commit info)
> > >
> > > > The above patches are effectively missed.
> > > > Anything to fix in your scripts / my patches?
> > >
> > > Like I said, patch 7 didn't apply so you should check and resend.
> >
> > I didn't get it. I have effectively rebased the entire series and resend as v2.
> 
> v2 --> v3
> 
> v3
> https://lore.kernel.org/linux-spi/20210510124134.24638-1-andriy.shevchenko@linux.intel.com/T/#t
> 
> 
> > I can speculate that your scripts have a bug since they might try v1
> 
> v1 --> v1 and / or v2
> 
> > as well (as far as I can see they usually send a confirmation of
> > application for all versions of the series in question).
> >
> > Sorry, but I do not see an issue.

Just in case I'll send a v4 with only patches that missed.
Otherwise it will be the same as in v3 (see above).

-- 
With Best Regards,
Andy Shevchenko


