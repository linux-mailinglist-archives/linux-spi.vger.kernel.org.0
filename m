Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047121E1D29
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgEZIWF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 04:22:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:11106 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEZIWF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 04:22:05 -0400
IronPort-SDR: ZX5uU99g/RLfDanouOfRCmew0yfyE4zNHpxfj/yph6pqvCkB4sTXJ/3B+xFvpYscs0Jz150Wj6
 p2DXsjgpQQlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 01:22:04 -0700
IronPort-SDR: ERWGElHgYUQBAPHZq0swOS/OGEsy62crV9xEEvNSSwPrSuMwHoAG0YkjBtTHHF9tPlWVelOYf+
 MmgkdH0Cd/WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="269993027"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 26 May 2020 01:22:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdUqb-008x1S-02; Tue, 26 May 2020 11:22:05 +0300
Date:   Tue, 26 May 2020 11:22:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
Message-ID: <20200526082204.GM1634618@smile.fi.intel.com>
References: <cover.1590408496.git.lukas@wunner.de>
 <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
 <20200525132143.GX1634618@smile.fi.intel.com>
 <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 26, 2020 at 09:39:13AM +0200, Lukas Wunner wrote:
> On Mon, May 25, 2020 at 04:21:43PM +0300, Andy Shevchenko wrote:
> > Tsuchiya Yuto, I'm going to apply this series as preparatory to my
> > WIP patch in topic/spi/reload branch in my kernel tree on GitHub,
> > so, it would be possible to see if this + my patch fixes crashes
> > on removal. Though, please test this separately from my stuff to
> > clarify if it fixes or not issue you have seen.
> 
> You also need to cherry-pick commit 84855678add8 ("spi: Fix controller
> unregister order") from spi/for-next onto your topic/spi/reload branch
> for reloading to work correctly.
> 
> Alternatively, rebase your topic/spi/reload branch and redo the merge
> from spi/for-next.  (You've merged spi/for-next into your branch on
> May 14, but the commit was applied by Mark on May 20.)

Ah, right. Will do it soon.

-- 
With Best Regards,
Andy Shevchenko


