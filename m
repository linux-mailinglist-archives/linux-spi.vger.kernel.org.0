Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C6E37A732
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhEKM4r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 08:56:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:5813 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhEKM4q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 08:56:46 -0400
IronPort-SDR: H4LLrThFVEcjymsKoy1QP6oz/ylLrrN7ai0y61DQG2MxY/FLqyXwPizbOUEHGVYGVmbvW+SMXY
 mG3DsvDxgHKg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186565628"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="186565628"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:55:39 -0700
IronPort-SDR: NQRM/ZbnuICiyMsTks3kjEe2l5Fnm5WqS9YJWO4D+Xze/wSq3NEQ62EAUfezPbfJDGiblVSGqm
 zCUDwWt2zsjA==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="471114843"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:55:07 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lgRuf-00BRpA-6g; Tue, 11 May 2021 15:55:01 +0300
Date:   Tue, 11 May 2021 15:55:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Xin Hao <xhao@linux.alibaba.com>
Subject: Re: [PATCH v1 1/1] spi: Assume GPIO CS active high in ACPI case
Message-ID: <YJp+pV1mmIxY3LLX@smile.fi.intel.com>
References: <20210510141022.56499-1-andriy.shevchenko@linux.intel.com>
 <20210511111330.GH4496@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511111330.GH4496@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 11, 2021 at 12:13:30PM +0100, Mark Brown wrote:
> On Mon, May 10, 2021 at 05:10:22PM +0300, Andy Shevchenko wrote:
> 
> > +			bool value = has_acpi_companion(&spi->dev) ? !enable : activate;
> 
> Please write normal conditional statements to improve legibility.

OK!

> >  			if (spi->cs_gpiod)
> > -				/* polarity handled by gpiolib */
> > -				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
> > +				/* Polarity handled by GPIO library */
> > +				gpiod_set_value_cansleep(spi->cs_gpiod, value);
> >  			else
> >  				/*
> > -				 * invert the enable line, as active low is
> > +				 * Invert the enable line, as active low is
> >  				 * default for SPI.
> 
> The change would be clearer with the documentation formatting changes
> split out from the rest of it.

Will remove these changes from a fix in v2.

P.S> something is odd about the series I have submitted, i.e. half of the
patches simply didn't make it. I would wait with any new submission until it
will be clarified, otherwise it's a chance to miss more patches without any
reason why.

-- 
With Best Regards,
Andy Shevchenko


