Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C383375576
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhEFORh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 10:17:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:18867 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhEFORh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 May 2021 10:17:37 -0400
IronPort-SDR: tIHcckKhxi6xhy9SAJOFrYCDzq3gSQH0lZwMyq2m0VYI4z1DmFl8pVLxxuM+swc2DFvC8r9/ey
 GOqKQOdVEgOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="198536516"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="198536516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 07:16:38 -0700
IronPort-SDR: C08k1Vj8W6Wbrnez5hI9zY1XwHuNPXAyiYQN/YyvAha3A4DEInpjcmB7QJbyOHsK2ev02YCGZT
 WhprMdX40PUg==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="407025263"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 07:16:36 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1leeno-00A4IM-P7; Thu, 06 May 2021 17:16:32 +0300
Date:   Thu, 6 May 2021 17:16:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     bier@b-x3vxmd6m-2058.local, Mark Brown <broonie@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when
 use GPIO as CS
Message-ID: <YJP6QIl+jnjKPlRo@smile.fi.intel.com>
References: <424d37007b7e298cf9bca5ac38d45a723e0976ee.1620301297.git.xhao@linux.alibaba.com>
 <CACRpkdYyXO=47aTyhUfY6MLNUFiRUzORLGDMeV7E4JULbx3hbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYyXO=47aTyhUfY6MLNUFiRUzORLGDMeV7E4JULbx3hbQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 06, 2021 at 02:30:01PM +0200, Linus Walleij wrote:
> On Thu, May 6, 2021 at 1:45 PM Xin Hao <bier@b-x3vxmd6m-2058.local> wrote:
> > From: Xin Hao <xhao@linux.alibaba.com>
> >
> > When i was testing the TPM2 device, I found that the driver
> > always failed to register which used SPI bus and GPIO as CS
> > signal, i found that the reason for the error was that CS could
> > not be set correctly, so there fixed it.
> >
> > Fixes: 766c6b63aa044e ("spi: fix client driver breakages when using
> > GPIO descriptors")
> > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> 
> (...)
> >                                 /* polarity handled by gpiolib */
> >                                 gpiod_set_value_cansleep(spi->cs_gpiod,
> > -                                                        enable1);
> > +                                                        !enable);
> 
> We have been over this code a lot of times, can you
> help us to investigate the root cause here and check
> how the interrupts are provided on this platform.
> 
> TPM2 makes me think that this is an Intel platform
> and maybe ACPI of some kind so you need to run
> it by Andy, who is working on some related fixes.

The above is exactly what my quirk [1] for ACPI does in case the controller
gets GPIOs from the ACPI.

[1]: https://gitlab.com/andy-shev/next/-/commit/5ccbdbb4787d871722f361d77c5f3cb806811c48

-- 
With Best Regards,
Andy Shevchenko


