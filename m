Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967CC1208ED
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfLPOw1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 09:52:27 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728008AbfLPOw0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 09:52:26 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3B58AEB36E6F617BABE2;
        Mon, 16 Dec 2019 14:52:25 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Dec 2019 14:52:24 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 14:52:24 +0000
Subject: Re: [PATCH v2 0/3] HiSilicon v3xx SFC driver
To:     <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <tudor.ambarus@microchip.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <65a6d94b-95b7-b11b-2234-c091ba3f671e@huawei.com>
Date:   Mon, 16 Dec 2019 14:52:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 09/12/2019 14:08, John Garry wrote:
> This patchset introduces support for the HiSilicon SFC V3XX driver.
> 

Hi guys,

Just a friendly reminder on this series.

Thanks,
John

> Whilst the kernel tree already includes support for a "HiSilicon SFC
> driver", that is for different HW. Indeed, as mentioned in patch #1, the
> naming for that driver could be better, as it should support more memory
> technologies than SPI NOR (as I have been told), and it is actually known
> internally as FMC. As such, maybe "hisi-fmc" would have been better, but
> we can't change that now.
> 
> I used V3XX in this driver name, as that is the unique versioning for
> this HW.
> 
> As for the driver itself, it is quite simple. Only ACPI firmware is
> supported, and we assume m25p80 compatible SPI NOR part will be used.
> 
> DMA is not supported, and we just use polling mode for operation
> completion notification. The driver uses the SPI MEM OPs.
> 
> Changes from v1:
> - Add ACPI kconfig dependency
> - Fix up header comment style
> - Change macros naming style
> - Try to enforce aligned accesses in hisi_sfc_v3xx_adjust_op_size()
> 
> John Garry (3):
>    mtd: spi-nor: hisi-sfc: Try to provide some clarity on which SFC we
>      are
>    spi: Add HiSilicon v3xx SPI NOR flash controller driver
>    MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC driver
> 
>   MAINTAINERS                     |   6 +
>   drivers/mtd/spi-nor/Kconfig     |   4 +-
>   drivers/mtd/spi-nor/hisi-sfc.c  |   2 +-
>   drivers/spi/Kconfig             |   9 +
>   drivers/spi/Makefile            |   1 +
>   drivers/spi/spi-hisi-sfc-v3xx.c | 284 ++++++++++++++++++++++++++++++++
>   6 files changed, 303 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/spi/spi-hisi-sfc-v3xx.c
> 

