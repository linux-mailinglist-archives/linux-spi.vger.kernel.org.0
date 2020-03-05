Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0756317A950
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 16:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCEPyB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 10:54:01 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2511 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgCEPyB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 10:54:01 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 81C7585F4FD0C4A75E66;
        Thu,  5 Mar 2020 15:53:58 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 5 Mar 2020 15:53:58 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 15:53:58 +0000
Subject: Re: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
To:     Joe Perches <joe@perches.com>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e265e7df-fd8c-691f-389a-c0e0e377ed9e@huawei.com>
Date:   Thu, 5 Mar 2020 15:53:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/03/2020 15:15, Joe Perches wrote:
> commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
> controller driver") likely inadvertently used a select statement
> with a CONFIG_ prefix, remove the prefix.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

It's a pity checkpatch can't pick this stuff up...

The select is just for enabling the driver of a slave driver, so should 
not cause any build issues when not enabled. thanks

FWIW,
Acked-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/spi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 82177d..2dc7bd 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -292,7 +292,7 @@ config SPI_HISI_SFC_V3XX
>   	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
>   	depends on (ARM64 && ACPI) || COMPILE_TEST
>   	depends on HAS_IOMEM
> -	select CONFIG_MTD_SPI_NOR
> +	select MTD_SPI_NOR
>   	help
>   	  This enables support for HiSilicon v3xx SPI-NOR flash controller
>   	  found in hi16xx chipsets.
> 
> 
> .
> 

