Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0742342DD
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 11:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgGaJ0f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 05:26:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:45104 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732483AbgGaJ0Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 31 Jul 2020 05:26:16 -0400
IronPort-SDR: 9XHWa6z2a29eh0PHreyP7rparXJGKKFdxHjI3vYjdih9N4N38qmmZeUmDilr/aTYaKqkW4odoR
 zUurRCRsJeaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169864034"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="169864034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 02:26:15 -0700
IronPort-SDR: dMJKnG4gLf/ZvU6NfIhQQ3ls1mZ/QxQ4ba4hOlulrJ69hK9n591LKrQsaYtUiue30/TDck/16Y
 iIjLqG5nFPcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="331014832"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 31 Jul 2020 02:26:12 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1k1RIq-005HOZ-Di; Fri, 31 Jul 2020 12:26:12 +0300
Date:   Fri, 31 Jul 2020 12:26:12 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] spi: dw-dma: Add max SG entries burst capability
 support
Message-ID: <20200731092612.GK3703480@smile.fi.intel.com>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 31, 2020 at 10:59:45AM +0300, Serge Semin wrote:

...

> Note since the DMA-engine subsystem in kernel 5.8-rcX doesn't have the
> max_sg_burst capability supported, this series is intended to be applied
> only after the "next"-branch of the DMA-engine repository is merged into
> the mainline repo. Alternatively the series could be merged in through the
> DMA-engine repo.

This needs to be thought through...

I gave some simple comments (and on top just try not to modify the same lines
inside one series two or more times, e.g. ret = func() -> return func() -> ret
= func() in one case).

-- 
With Best Regards,
Andy Shevchenko


