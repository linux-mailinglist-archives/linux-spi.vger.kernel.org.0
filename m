Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7A1E423E
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 14:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgE0M1x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 08:27:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:31245 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0M1x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 May 2020 08:27:53 -0400
IronPort-SDR: e7S28aKYIqvFriwO3vy58aUU0rgzmzBOff2gLGRa/a6iqqAjl+tvRgjcjkTTyhcFYkJAxVSVEg
 F9A4sQDZb+Rg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 05:27:52 -0700
IronPort-SDR: r/0VV5Gn/ThQHLjfa1A9AuoFl78zCSZkHvQfgGhM5scEpvNWLa+MQIg7/c/vzmf4DFlSnIdylm
 XaRbLtXoqtiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="345516438"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2020 05:27:50 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdvA1-009DT9-EU; Wed, 27 May 2020 15:27:53 +0300
Date:   Wed, 27 May 2020 15:27:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
Message-ID: <20200527122753.GN1634618@smile.fi.intel.com>
References: <cover.1590408496.git.lukas@wunner.de>
 <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
 <20200525132143.GX1634618@smile.fi.intel.com>
 <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
 <20200526082204.GM1634618@smile.fi.intel.com>
 <45681e81-7efd-857f-eea1-fb4767e3d946@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45681e81-7efd-857f-eea1-fb4767e3d946@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 27, 2020 at 09:09:17PM +0900, Tsuchiya Yuto wrote:
> I tried a kernel built with the prerequisite patch to this series + all
> of patches in this series on top of v5.7-rc7 (with Arch Linux config
> + olddefconfig).
> 
> Current situations on 5.7-rc7 with Arch Linux config + olddefconfig
> (without applying this series):
> - I can reproduce the touch input crashing (surface3-spi) I mentioned
>   in bugzilla [1] only after s2idle.
> - all the other situations are the same as described in that bugzilla;
>   I see NULL pointer dereference [2] after touch input crashing then try
>   to unload only spi_pxa2xx_platform module.
> 
> So, the steps to test that I did with this series applied are:
> 1. go into s2idle then resume from s2idle
> 2. make a touch input then surface3-spi reports that "SPI transfer
>    timed out" repeatedly and no longer responds to any touch input
> 3. try to unload only spi_pxa2xx_platform module and see if the NULL
>    pointer dereference no longer occurs
> 
> and I can confirm that I no longer see the NULL pointer dereference.
> Thanks!

Thank you very much for testing!

> On 5/26/20 5:22 PM, Andy Shevchenko wrote:
> > On Tue, May 26, 2020 at 09:39:13AM +0200, Lukas Wunner wrote:
> >> On Mon, May 25, 2020 at 04:21:43PM +0300, Andy Shevchenko wrote:
> >>> Tsuchiya Yuto, I'm going to apply this series as preparatory to my
> >>> WIP patch in topic/spi/reload branch in my kernel tree on GitHub,
> >>> so, it would be possible to see if this + my patch fixes crashes
> >>> on removal. Though, please test this separately from my stuff to
> >>> clarify if it fixes or not issue you have seen.
> >> You also need to cherry-pick commit 84855678add8 ("spi: Fix controller
> >> unregister order") from spi/for-next onto your topic/spi/reload branch
> >> for reloading to work correctly.
> >>
> >> Alternatively, rebase your topic/spi/reload branch and redo the merge
> >> from spi/for-next.  (You've merged spi/for-next into your branch on
> >> May 14, but the commit was applied by Mark on May 20.)
> > Ah, right. Will do it soon.
> 
> I also built a kernel against your branch topic/spi/reload
> (permalink: https://github.com/andy-shev/linux/tree/55cb78d5a752). The
> result is the same as only applying this series; so, to fix the NULL pointer
> dereference that I mentioned in bugzilla [2], only this series is required.
> 
> Also, I want to make sure that what you tried in that branch is fixing
> the NULL pointer dereference on spi_pxa2xx_platform module removal when
> touch input crashed, not fixing the touch input crashing itself?

Yes, my aim was to fix the SPI module reload issue. While the applied patch
from Lukas does a huge improvement, there are still issues with ordering (you
probably will never see them, though it's still possible based on the code).

So, as far as I understood, the touch still able to come into position where
it's not anymore responsive. Is it correct?

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206403
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=206403#c1

-- 
With Best Regards,
Andy Shevchenko


