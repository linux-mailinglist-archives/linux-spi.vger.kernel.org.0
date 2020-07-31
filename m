Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694EC234235
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbgGaJQm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 05:16:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:22072 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731922AbgGaJQm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 31 Jul 2020 05:16:42 -0400
IronPort-SDR: nZgnEnM/qvPQelqk73o6skUOFleR3pAK7JAyXfrSJe70Knrkbown43ZQ4/Fr9xg5wppTdMP1+9
 9TGuqQ/t8sxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131821901"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="131821901"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 02:16:42 -0700
IronPort-SDR: gpvw0Abs5CnYEvazRB+XVI9NSw3UaufCehRGRBFs0HkLDPEVVi55K0P+N7J7l9+hQUP10EKCW3
 oU7RqZxUpVqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="491427729"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2020 02:16:39 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1k1R9a-005HJj-KS; Fri, 31 Jul 2020 12:16:38 +0300
Date:   Fri, 31 Jul 2020 12:16:38 +0300
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
Subject: Re: [PATCH 3/8] spi: dw-dma: Configure the DMA channels in dma_setup
Message-ID: <20200731091638.GJ3703480@smile.fi.intel.com>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
 <20200731075953.14416-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731075953.14416-4-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 31, 2020 at 10:59:48AM +0300, Serge Semin wrote:
> Mainly this is a preparation patch before adding one-by-one DMA SG entries
> transmission. But logically the Tx and Rx DMA channels setup should be
> performed in the dma_setup() callback anyway. So let's move the DMA slave
> channels src/dst burst lengths, address and address width configuration to
> the DMA setup stage. While at it make sure the return value of the
> dmaengine_slave_config() method is checked. It has been unnecessary in
> case if Dw DMAC is utilized as a DMA engine, since its device_config()
> callback always returns zero (though it might change in future). But since
> DW APB SSI driver now supports any DMA back-end we must make sure the
> DMA device configuration has been successful before proceeding with
> further setups.

...

> +	if (!xfer->rx_buf)
> +		return NULL;

...

> +	if (xfer->rx_buf) {

> +	}

This looks like a separate change to drop one of them and not hide in the next patch.

-- 
With Best Regards,
Andy Shevchenko


