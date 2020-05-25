Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24A51E0F5D
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390674AbgEYNXa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 09:23:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:43498 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbgEYNX3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 09:23:29 -0400
IronPort-SDR: fSsqYVOSDpe3GEq07WThveHS5V6+K0M2Cw6smlyHdOcZqbRV8PVvSr9757ThF+EBD+yLjsW84B
 ubGYXIT9kw5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 06:23:29 -0700
IronPort-SDR: E4qERus38693IFp7jgHzLDA2T05pE1UTbJXjREL0QP7ykx4yOSIVTTD2wtTrZ3R+Ayf2q90uqP
 LNnk6zZdo9QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="413510522"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 25 May 2020 06:23:26 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdD4j-008nBa-7s; Mon, 25 May 2020 16:23:29 +0300
Date:   Mon, 25 May 2020 16:23:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 0/3] Intel SPI unbind fixes
Message-ID: <20200525132329.GY1634618@smile.fi.intel.com>
References: <cover.1590408496.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1590408496.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 02:25:00PM +0200, Lukas Wunner wrote:
> Fix unbind ordering issues in the Designware and PXA2xx SPI controllers
> built into Intel SoCs.
> 
> To test, you'll also need the following commit:
> https://git.kernel.org/broonie/spi/c/84855678add8
> 
> This is compile-tested only, so please review and test thoroughly.
> 
> Pay particular attention to the IRQ handlers dw_spi_irq() and ssp_int():
> Both drivers request the interrupt with IRQF_SHARED, so the IRQ handler
> may run even though the SPI controller itself hasn't signalled an
> interrupt.  The IRQ is requested before registering the controller and
> freed after unregistering the controller.  Thus, the IRQ handler should
> immediately bail out if the controller is not yet or no longer registered,
> e.g. by checking in the controller's registers whether an interrupt is
> actually pending.  The drivers may need to disable interrupts in the
> controllers' registers upon unbinding and they need to make sure that
> the registers are accessible until the IRQ is freed.
> 
> I don't have a datasheet for these SPI controllers but I hope someone
> who is more familiar with them will be able to check for correctness
> of the IRQ handling.

Thank you for this!
I reviewed all three, but I have no means to reliably test it. From the
description and logic point of view this sounds correct. So, let's wait for
Tsuchiya Yuto to test and confirm that it's right way to go.

> 
> Lukas Wunner (3):
>   spi: dw: Fix controller unregister order
>   spi: pxa2xx: Fix controller unregister order
>   spi: pxa2xx: Fix runtime PM ref imbalance on probe error
> 
>  drivers/spi/spi-dw.c     | 4 +++-
>  drivers/spi/spi-pxa2xx.c | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko


