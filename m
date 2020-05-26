Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2526B1E2552
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgEZPVa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 11:21:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:12304 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgEZPV3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 11:21:29 -0400
IronPort-SDR: ERqthTgHLwyVCvrIwc+eo/coykNYXMaoyQOy07pVzQ7762SPQV+YS8lXz+mFfA6dxsAgrfEe/D
 LioudAX1kZnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 08:21:28 -0700
IronPort-SDR: AdWpaJ+ilaPii6iZgsCop3Hb0oTELos+7aj9aW1C+KRJUVsgY9M4ICyOGY2I1pPgVFN4tfA33z
 +VWa6GQuWwUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="266486528"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2020 08:21:26 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdbOT-0091Ce-BG; Tue, 26 May 2020 18:21:29 +0300
Date:   Tue, 26 May 2020 18:21:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        Sergey.Semin@baikalelectronics.ru, fancer.lancer@gmail.com,
        lars.povlsen@microchip.com, Liang Jin J <liang.j.jin@ericsson.com>
Subject: Re: [PATCHv2 1/2] spi: dw: add reset control
Message-ID: <20200526152129.GS1634618@smile.fi.intel.com>
References: <20200526151218.6186-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526151218.6186-1-dinguyen@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 26, 2020 at 10:12:17AM -0500, Dinh Nguyen wrote:
> Add mechanism to get the reset control and deassert it in order to bring
> the IP out of reset.

...

>  	struct clk     *clk;
>  	struct clk     *pclk;
>  	void           *priv;
> +	struct reset_control	*rstc;

I think either you make it one space or you align all the rest members
accordingly. I would rather go with former.

...

> +	/* find an optional reset controller */
> +	dwsmmio->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
> +	if (IS_ERR(dwsmmio->rstc)) {

> +		if (PTR_ERR(dwsmmio->rstc) == -EPROBE_DEFER)
> +			return PTR_ERR(dwsmmio->rstc);

If it's other type of errors when reset control, we ignore them...

Why?!

> +	}

-- 
With Best Regards,
Andy Shevchenko


