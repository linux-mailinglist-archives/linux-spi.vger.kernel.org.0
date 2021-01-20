Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854A22FCCE4
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbhATIk2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 03:40:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:35476 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbhATIkW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Jan 2021 03:40:22 -0500
IronPort-SDR: 6OLk+sVH+rA0jyw7UqTlWCYr32G+dmpo0fDXuzxKxUDMkgZwE5eMdXljuYEoljyh9xn/WAfAJx
 wiizrzYsXs1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="179217788"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="179217788"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 00:39:29 -0800
IronPort-SDR: mZqUniam7VcFuXD5LerhCNav9/39cJyr5DIghBgYfJqvLTX4cFYsqoM2xmK0sIEiEKIgiK59v1
 fXAN1acu4PsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="426822497"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 20 Jan 2021 00:39:27 -0800
Date:   Wed, 20 Jan 2021 16:35:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: altera: Fix memory leak on error path
Message-ID: <20210120083502.GA15003@yilunxu-OptiPlex-7050>
References: <20210120082635.49304-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120082635.49304-1-bianpan2016@163.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 20, 2021 at 12:26:35AM -0800, Pan Bian wrote:
> Release master that have been previously allocated if the number of
> chipselect is invalid.
> 
> Fixes: 8e04187c1bc7 ("spi: altera: add SPI core parameters support via platform data.")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/spi/spi-altera.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
> index cbc4c28c1541..62ea0c9e321b 100644
> --- a/drivers/spi/spi-altera.c
> +++ b/drivers/spi/spi-altera.c
> @@ -254,7 +254,8 @@ static int altera_spi_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev,
>  				"Invalid number of chipselect: %hu\n",
>  				pdata->num_chipselect);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto exit;

Thanks for the fix. Looks good to me.

Yilun
