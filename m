Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D831B696
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 10:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhBOJnk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 04:43:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:32705 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhBOJnk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 04:43:40 -0500
IronPort-SDR: MMWHYJNJAjJgjzvEDIy0srb8pPLvkmKgYxjH0vOhJc3K4mZN2NjP4dNte1L1lzUX5ee1AxeUHP
 QCSdHK23gwXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="179143295"
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="179143295"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 01:41:54 -0800
IronPort-SDR: Dk/069UiJ4MpefNYiPyQnQG7aruGvEhg7HrUNxureNlfXmPZ1icBfJEHPQx3m7nt/yT7ENMdYa
 coAEQtYVnQdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="398994579"
Received: from mylly.fi.intel.com (HELO [10.237.72.57]) ([10.237.72.57])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2021 01:41:51 -0800
Subject: Re: [PATCH] spi: pca2xx-pci: Fix an issue about missing call to
 'pci_free_irq_vectors()'
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Dejin Zheng <zhengdejin5@gmail.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210214145746.602770-1-zhengdejin5@gmail.com>
 <d113b6f5-d234-452e-3e82-90c5237eff0e@siemens.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <88dff093-b18f-e23c-9cec-b8623da5857b@linux.intel.com>
Date:   Mon, 15 Feb 2021 11:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d113b6f5-d234-452e-3e82-90c5237eff0e@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2/15/21 11:23 AM, Jan Kiszka wrote:
> On 14.02.21 15:57, Dejin Zheng wrote:
>> Call to 'pci_free_irq_vectors()' are missing both in the error handling
>> path of the probe function, and in the remove function. So add them.
>>
>> Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
>> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
>> ---
>>   drivers/spi/spi-pxa2xx-pci.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
>> index 14fc41ed2361..1ec840e78ff4 100644
>> --- a/drivers/spi/spi-pxa2xx-pci.c
>> +++ b/drivers/spi/spi-pxa2xx-pci.c
>> @@ -254,8 +254,10 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
>>   	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
>>   	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
>>   					   c->max_clk_rate);
>> -	 if (IS_ERR(ssp->clk))
>> -		return PTR_ERR(ssp->clk);
>> +	if (IS_ERR(ssp->clk)) {
>> +		ret = PTR_ERR(ssp->clk);
>> +		goto err_irq;
>> +	}
>>   
>>   	memset(&pi, 0, sizeof(pi));
>>   	pi.fwnode = dev->dev.fwnode;
>> @@ -268,12 +270,16 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
>>   	pdev = platform_device_register_full(&pi);
>>   	if (IS_ERR(pdev)) {
>>   		clk_unregister(ssp->clk);
>> -		return PTR_ERR(pdev);
>> +		ret = PTR_ERR(pdev);
>> +		goto err_irq;
>>   	}
>>   
>>   	pci_set_drvdata(dev, pdev);
>>   
>>   	return 0;
>> +err_irq:
>> +	pci_free_irq_vectors(dev);
>> +	return ret;
>>   }
>>   
>>   static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
>> @@ -283,6 +289,7 @@ static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
>>   
>>   	spi_pdata = dev_get_platdata(&pdev->dev);
>>   
>> +	pci_free_irq_vectors(dev);
>>   	platform_device_unregister(pdev);
>>   	clk_unregister(spi_pdata->ssp.clk);
>>   }
>>
> 
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
Please fix pca2xx-pci -> pxa2xx-pci in the subject line. With that 
change you may add:

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
