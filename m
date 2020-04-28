Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4481BB626
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD1GDF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 02:03:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:22916 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgD1GDF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 02:03:05 -0400
IronPort-SDR: Wggo6RUXqFgr70xtfXqtBrrLJXq+++Yp8ZM/Ai2Yl6qSTya6VDj/huJoHdvrGb3QzYYKQSPHhH
 LDoaZVD/ZHhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 23:03:04 -0700
IronPort-SDR: +pp6cGsVEXqpd9ZqUu2n1YXyEU8algll4co6CQBi2HZI9B3qgTIh1Nwn7LkLSYWzkQcSnyD/OI
 htXcp8Sx7XgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,327,1583222400"; 
   d="scan'208";a="246403763"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 27 Apr 2020 23:03:04 -0700
Received: from [10.215.240.200] (ekotax-mobl.gar.corp.intel.com [10.215.240.200])
        by linux.intel.com (Postfix) with ESMTP id 40AA4580B9A;
        Mon, 27 Apr 2020 23:03:01 -0700 (PDT)
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
To:     Hauke Mehrtens <hauke@hauke-m.de>, broonie@kernel.org,
        robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <1536b752-13d1-128b-1393-80cf175df5e2@hauke-m.de>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <4ba16d3e-0441-b3a7-11d3-7da40d630914@linux.intel.com>
Date:   Tue, 28 Apr 2020 14:03:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1536b752-13d1-128b-1393-80cf175df5e2@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/28/2020 5:52 AM, Hauke Mehrtens wrote:
> On 4/24/20 12:42 PM, Dilip Kota wrote:
>> Synchronize tx, rx and error interrupts by registering to the
>> same interrupt handler. Interrupt handler will recognize and process
>> the appropriate interrupt on the basis of interrupt status register.
>> Also, establish synchronization between the interrupt handler and
>> transfer operation by taking the locks and registering the interrupt
>> handler as thread IRQ which avoids the bottom half.
>> Fixes the wrongly populated interrupt register offsets too.
>>
>> Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
>> Fixes: ad2fca0721d1 ("spi: lantiq-ssc: add LTQ_ prefix to defines")
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>>   drivers/spi/spi-lantiq-ssc.c | 89 ++++++++++++++++++++++----------------------
>>   1 file changed, 45 insertions(+), 44 deletions(-)
>>
> Hi,
>
> I tried this patch series on a TP-LINK TD-W8970 (VRX200 with SPI flash)
> and the SPI controller is failing like this:
> -----
> [    6.947194] printk: bootconsole [early0] disabled
> [    6.964210] spi-lantiq-ssc 1e100800.spi: Lantiq SSC SPI controller
> (Rev 8, TXFS 8, RXFS 8, DMA 1)
> [    7.175188] spi-nor spi0.4: SPI transfer timed out
> [    7.178558] spi_master spi0: failed to transfer one message from queue
> [    7.185120] spi-nor spi0.4: error -145 reading JEDEC ID
> [    7.190378] spi-nor: probe of spi0.4 failed with error -2
> [    7.199729] libphy: Fixed MDIO Bus: probed
> ------
> It already fails when applying this first patch only.
This change is working successfully on Lightning Mountain SoC.(along 
with other changes in the patch series, as this alone doesnt configure 
SPI controller on LGM).

The major changes this patch does is: Finding out the appropriate 
interrupt by reading the LTQ_SPI_IRNCR register. So i think, this 
failure could be at interrupt handling. And offsets of LTQ_SPI_IRNICR 
and LTQ_SPI_IRNCR  registers also corrected.
When i added you in the internal review of this patch, i remember you 
are saying Interrupt controller on VR9/xrx200 is different and 
acknowledges the interrupts inside the IP  automatically. Does this 
leads to clearing the interrupt registers LTQ_SPI_IRNCR and 
LTQ_SPI_IRNICR? If it is the case, the SPI driver cannot figure out the 
cause of the interrupt and result in timeout.

Could you please print the LTQ_SPI_IRNCR and LTQ_SPI_IRNICR register 
values in the ISR and share the logs.

Regards,
Dilip

>
>
> Without this patch is works like this:
> -----
> [    6.939498] printk: bootconsole [early0] disabled
> [    6.954016] spi-lantiq-ssc 1e100800.spi: Lantiq SSC SPI controller
> (Rev 8, TXFS 8, RXFS 8, DMA 1)
> [    6.975465] spi-nor spi0.4: s25fl064k (8192 Kbytes)
> [    6.979066] 4 fixed-partitions partitions found on MTD device spi0.4
> [    6.985338] Creating 4 MTD partitions on "spi0.4":
> [    6.990127] 0x000000000000-0x000000020000 : "u-boot"
> [    6.997422] 0x000000020000-0x0000007c0000 : "firmware"
> [    7.212304] random: crng init done
> [    8.796128] 2 tplink-fw partitions found on MTD device firmware
> [    8.800674] 0x000000020000-0x00000027878f : "kernel"
> [    8.807776] 0x000000278790-0x0000007c0000 : "rootfs"
> [    8.813611] mtd: device 3 (rootfs) set to be root filesystem
> [    8.818268] 1 squashfs-split partitions found on MTD device rootfs
> [    8.824123] 0x000000590000-0x0000007c0000 : "rootfs_data"
> [    8.831772] 0x0000007c0000-0x0000007d0000 : "config"
> [    8.837785] 0x0000007d0000-0x000000800000 : "boardconfig"
> [    8.848193] libphy: Fixed MDIO Bus: probed
> ------
>
> This was done by applying your patches on top of kernel 5.4.35 and
> adding this: "spi: lantiq-ssc: Use devm_platform_ioremap_resource() in
> lantiq_ssc_probe()" in OpenWrt master.
>
> Hauke
