Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8212D1ED7
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 01:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgLHAPC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 19:15:02 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12012 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgLHAPC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 19:15:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcec55e0000>; Mon, 07 Dec 2020 16:14:22 -0800
Received: from [10.2.90.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Dec
 2020 00:14:21 +0000
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
To:     Lukas Wunner <lukas@wunner.de>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201206181612.GA26286@wunner.de>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <8ce3fa3a-88d7-e981-731a-9bce85047892@nvidia.com>
Date:   Mon, 7 Dec 2020 16:14:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201206181612.GA26286@wunner.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607386462; bh=xZahUYllljXiYxe4ydcG6ftS2v4ZpfHRVkgWv217yho=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=n61ZnjtsimFPYzBZV6lW3PUKROTJd25X7QXBQmBs0UHJ3I5/tmhrBQGpCNAqGaCAT
         PZcXiPNvYYIwZmC3235tEi1lhw7ZcaVHAJH2M5c/Sj9ssuJavwK7JgDCUjcyU1o7G+
         ZEVFgq4Lha2pQ74qVChIafYkfflCz+WPxYLp4G/+5EVAXJdsrrWtT8t2xs4YjeNM01
         OfNVbjuDsbJDSPj0OvoYCaMNc3MA/jEHZl3vvXdYEK0iu8mTKc4unfjXkYKpuZPo/l
         4/X/ZIfYzUgkCvJs5Y9YNsLQIHV2K316YkYOxj5IjuptmMRTnIwjqfUVS+rnVrHBVy
         f7ZZ1wp2DowCg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/6/20 10:16 AM, Lukas Wunner wrote:
> On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
>> +	ret = devm_spi_register_master(&pdev->dev, master);
> [...]
>> +static int tegra_qspi_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_master *master = platform_get_drvdata(pdev);
>> +	struct tegra_qspi_data	*tqspi = spi_master_get_devdata(master);
>> +
>> +	free_irq(tqspi->irq, tqspi);
>> +
>> +	tegra_qspi_deinit_dma_param(tqspi, false);
>> +	tegra_qspi_deinit_dma_param(tqspi, true);
>> +
>> +	pm_runtime_disable(&pdev->dev);
>> +	if (!pm_runtime_status_suspended(&pdev->dev))
>> +		tegra_qspi_runtime_suspend(&pdev->dev);
>> +
>> +	return 0;
>> +}
> With devm_spi_register_master(), the SPI controller is unregistered
> *after* tegra_qspi_remove().  SPI transactions may still be ongoing
> until the SPI controller is unregistered, yet you perform teardown
> steps (such as freeing the IRQ) while it is still registered.
>
> Bottom line is, you can't use devm_spi_register_master() in this case.
> You need to use spi_register_master() and explicitly call
> spi_unregister_master() in tegra_qspi_remove() *before* performing
> teardown steps.
>
> However, be sure to use the devm variant to *allocate* the SPI controller,
> i.e. use devm_spi_alloc_master() instead of spi_alloc_master().
>
> Thanks,
>
> Lukas

Thanks Lukas. I see devm_spi_alloc_master() in 5.4 but not from 5.5

Thanks

Sowjanya

