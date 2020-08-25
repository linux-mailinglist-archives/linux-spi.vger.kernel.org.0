Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036C32520E5
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHYTrE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 15:47:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:17265 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYTrE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Aug 2020 15:47:04 -0400
IronPort-SDR: 9+x1eazVhNHxNA7wDBRCNS4ja2Wjin3gPTjZ5Hh7ZKUK0UCfNTKZdYBvloV0+LcUoj0KEgogPu
 +6POBqZIpNWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="157230533"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="157230533"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 12:47:03 -0700
IronPort-SDR: kQnvf0WEnRUxScPJj+4S02cOhCeVJXddfs+MVMUN+EsRhGmGNN99eIbVhYhWvrO7rZ7dYB3ia6
 eVS3SgRv7b0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="328973234"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 12:47:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAelt-00BOSv-CY; Tue, 25 Aug 2020 22:38:17 +0300
Date:   Tue, 25 Aug 2020 22:38:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers
Message-ID: <20200825193817.GR1891694@smile.fi.intel.com>
References: <20200825171730.17638-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825171730.17638-1-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 25, 2020 at 07:17:30PM +0200, Cezary Rojewski wrote:
> Update list of SSP registers with SSC2 and SSPSP2. These registers are
> utilized by LPT/WPT AudioDSP architecture.
> 
> While SSC2 shares the same offset (0x40) as SSACDD, description of this
> register for SSP device present on mentioned AudioDSP is different so
> define separate constant to avoid any ambiguity.

In general it's okay, couple of nit-picks, though. After addressing,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  include/linux/pxa2xx_ssp.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
> index 6facf27865f9..935d7db5bc32 100644
> --- a/include/linux/pxa2xx_ssp.h
> +++ b/include/linux/pxa2xx_ssp.h
> @@ -41,6 +41,8 @@
>  #define SSTSS		(0x38)  /* SSP Timeslot Status */
>  #define SSACD		(0x3C)  /* SSP Audio Clock Divider */
>  #define SSACDD		(0x40)	/* SSP Audio Clock Dither Divider */
> +#define SSC2		(0x40)	/* SSP Command / Status 2 */

Is it the same as been called SSCR2 in Tangier?  (Also called SSP Command
Status register 2) I guess we may name it with R applied.

> +#define SSPSP2		(0x44)	/* SSP Programmable Serial Protocol 2 */

Also, please move them below with a comment like LPSS SSP block:
https://elixir.bootlin.com/linux/latest/source/include/linux/pxa2xx_ssp.h#L181

>  
>  /* Common PXA2xx bits first */
>  #define SSCR0_DSS	(0x0000000f)	/* Data Size Select (mask) */
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


