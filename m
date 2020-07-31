Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24E234228
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbgGaJPe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 05:15:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:47187 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731966AbgGaJPc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 31 Jul 2020 05:15:32 -0400
IronPort-SDR: QbmkD4IX30F0DbLt+uYeSwDnEt4yABnz5QPpAuh7TgmaLOw7g3SSEs/OVioTqHAY19KJ+vJ0FB
 dH0Z/EaT1RwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="236615597"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="236615597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 02:15:32 -0700
IronPort-SDR: 3c3WT31CGkqIElhKI2BX/M1C8ksT9DIAJGWX7oMiUiGsrdX+vAesJzGR34NPpFINTKXO5qwZKj
 t9TPAXgdWmsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="323179389"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2020 02:15:29 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1k1R8S-005HIf-Sb; Fri, 31 Jul 2020 12:15:28 +0300
Date:   Fri, 31 Jul 2020 12:15:28 +0300
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
Subject: Re: [PATCH 4/8] spi: dw-dma: Move DMA transfers submission to the
 channels prep methods
Message-ID: <20200731091528.GI3703480@smile.fi.intel.com>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
 <20200731075953.14416-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731075953.14416-5-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 31, 2020 at 10:59:49AM +0300, Serge Semin wrote:
> Indeed we can freely move the dmaengine_submit() method invocation and the
> Tx and Rx busy flag setting into the DMA Tx/Rx prepare methods. By doing
> so first we implement another preparation before adding the one-by-one DMA
> SG entries transmission, second we now have the dma_async_tx_descriptor
> descriptor used locally only in the new DMA transfers submitition methods,
> which makes the code less complex with no passing around the DMA Tx
> descriptors, third we make the generic transfer method more readable, where
> now the functionality of submission, execution and wait procedures is
> transparently split up instead of having a preparation, intermixed
> submission/execution and wait procedures. While at it we also add the
> dmaengine_submit() return value test. It has been unnecessary for
> DW DMAC, but should be done to support the generic DMA interface.
> 
> Note since the DMA channels preparation methods are now responsible for
> the DMA transactions submission, we also rename them to
> dw_spi_dma_submit_{tx,rx}().

...

> +	cookie = dmaengine_submit(txdesc);
> +	ret = dma_submit_error(cookie);
> +	if (!ret)

Use traditional pattern
	if (ret)
		return ret;

Same for below.

> +		set_bit(TX_BUSY, &dws->dma_chan_busy);
> +
> +	return ret;

...

> -	if (!xfer->rx_buf)
> -		return NULL;

This seems not related.

-- 
With Best Regards,
Andy Shevchenko


