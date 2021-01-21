Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCF2FF2E0
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jan 2021 19:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbhAUSHn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jan 2021 13:07:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:42490 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389446AbhAUSHj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 Jan 2021 13:07:39 -0500
IronPort-SDR: R3uaTUyQQeHh91xQnzgeUAvjNjZI50UtqFf4qp7r7ydRGBeNZmauttN2ssX4peSN0HNqsv+QBL
 /vCknqU7YMPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="159094055"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="159094055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 10:05:53 -0800
IronPort-SDR: 9cu1I8h5Lp1klRFw0EE+R04Z18BzUkbxAHRM6F44I1AsFlQgnBeg+gbC8OAc8JtEzkHyUyPAHG
 8GSy722I2XFg==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="385400859"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 10:05:53 -0800
Date:   Thu, 21 Jan 2021 10:07:11 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Pan Bian <bianpan2016@163.com>
cc:     Mark Brown <broonie@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: altera: Fix memory leak on error path
In-Reply-To: <20210120082635.49304-1-bianpan2016@163.com>
Message-ID: <alpine.DEB.2.22.394.2101211006500.482327@rhweight-WRK1>
References: <20210120082635.49304-1-bianpan2016@163.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On Wed, 20 Jan 2021, Pan Bian wrote:

> Release master that have been previously allocated if the number of
> chipselect is invalid.
>
> Fixes: 8e04187c1bc7 ("spi: altera: add SPI core parameters support via platform data.")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
Acked-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> drivers/spi/spi-altera.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
> index cbc4c28c1541..62ea0c9e321b 100644
> --- a/drivers/spi/spi-altera.c
> +++ b/drivers/spi/spi-altera.c
> @@ -254,7 +254,8 @@ static int altera_spi_probe(struct platform_device *pdev)
> 			dev_err(&pdev->dev,
> 				"Invalid number of chipselect: %hu\n",
> 				pdata->num_chipselect);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto exit;
> 		}
>
> 		master->num_chipselect = pdata->num_chipselect;
> -- 
> 2.17.1
>
>
