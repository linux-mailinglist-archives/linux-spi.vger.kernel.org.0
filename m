Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94141E1D9B
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 10:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgEZIrB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 04:47:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:62008 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgEZIrB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 04:47:01 -0400
IronPort-SDR: Ht+mIOSVQDAG0ss6VX6CIbhrnewJbV2js3KImKZgqC9Pp/TyvVqaO1G6clyvnrn58+i/lRZg4b
 UQ5rdzryt1bQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 01:47:00 -0700
IronPort-SDR: UJXE4WUwd6YH+tmzJx8W7m0M/PGEGBU45tIqMKVL19/YqBVlE5LezTw+apmlV5IdjDDa466b0q
 +tIH1XOfznFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="291106555"
Received: from mylly.fi.intel.com (HELO [10.237.72.67]) ([10.237.72.67])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 01:46:58 -0700
Subject: Re: [PATCH 3/3] spi: pxa2xx: Fix runtime PM ref imbalance on probe
 error
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <cover.1590408496.git.lukas@wunner.de>
 <58b2ac6942ca1f91aaeeafe512144bc5343e1d84.1590408496.git.lukas@wunner.de>
 <20200525131244.GV1634618@smile.fi.intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <049b3538-bb0b-89a0-dae7-09b2e950db6c@linux.intel.com>
Date:   Tue, 26 May 2020 11:46:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200525131244.GV1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 5/25/20 4:12 PM, Andy Shevchenko wrote:
> On Mon, May 25, 2020 at 02:25:03PM +0200, Lukas Wunner wrote:
>> The PXA2xx SPI driver releases a runtime PM ref in the probe error path
>> even though it hasn't acquired a ref earlier.
>>
>> Apparently commit e2b714afee32 ("spi: pxa2xx: Disable runtime PM if
>> controller registration fails") sought to copy-paste the invocation of
>> pm_runtime_disable() from pxa2xx_spi_remove(), but erroneously copied
>> the call to pm_runtime_put_noidle() as well.  Drop it.
> 
> Looks like correct fix to me.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
Yes, I think it was blind copy-paste from pxa2xx_spi_remove() where 
pm_runtime_put_noidle() is needed due the pm_runtime_get_sync() call but 
not in pxa2xx_spi_probe().

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
