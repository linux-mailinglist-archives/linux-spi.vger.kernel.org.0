Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5131A2C2537
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbgKXMDh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 07:03:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42065 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732814AbgKXMDg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 07:03:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201124120325euoutp01518eef4558a60ece2ecc32b91a1b2590~KcAn3G3FC2795927959euoutp01C
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2020 12:03:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201124120325euoutp01518eef4558a60ece2ecc32b91a1b2590~KcAn3G3FC2795927959euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606219405;
        bh=ohbV081x2d+qe+8QgkAe1mObHIdNUXUCiiRzPduyJsk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CMq5M3VEJuHczRUNLLDpAVvZApcZJJjoWvFPd+WtEmNTMw74XIyYnltNxpNzeO4qX
         +RyOwlrt52R8p3uoixOU5DShGMWTlAIFoxy9Aa1cQIjarPAsrXxSsmn5f2tjy82MmA
         Q25o9eQW10Xz+5wyDerJPibifRPPf42g2ge9oQ3Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201124120324eucas1p27d3c1c8185b9bb27dbf9af46534d0a8d~KcAnQiFx82507925079eucas1p2k;
        Tue, 24 Nov 2020 12:03:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3E.53.27958.C86FCBF5; Tue, 24
        Nov 2020 12:03:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201124120324eucas1p189ec6eed6d6477e27a194f9d75d7b43a~KcAm1aTeU3037230372eucas1p1t;
        Tue, 24 Nov 2020 12:03:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201124120324eusmtrp23192203b4bc9a8bc1a520ec483a94450~KcAm0wZlY3019630196eusmtrp2y;
        Tue, 24 Nov 2020 12:03:24 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-23-5fbcf68c4be3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.1C.16282.C86FCBF5; Tue, 24
        Nov 2020 12:03:24 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201124120323eusmtip2a06e1517b7f60f41fa2500bcaf9917b6~KcAmbOSpu2324723247eusmtip2N;
        Tue, 24 Nov 2020 12:03:23 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] spi: Use bus_type functions for probe, remove
 and shutdown
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9b86504f-c5f4-4c85-9bef-3d1ee4cbaf9c@samsung.com>
Date:   Tue, 24 Nov 2020 13:03:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119161604.2633521-2-u.kleine-koenig@pengutronix.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87o93/bEG6zbJ22xccZ6VoupD5+w
        WTQvXs9msWrqThaLy7vmsFk0frzJbnF74mRGB3aPTas62Tz2z13D7tH/18Cjb8sqRo/Pm+QC
        WKO4bFJSczLLUov07RK4Mg78+c5UsFmt4svTNSwNjPPluxg5OSQETCQuLW5g62Lk4hASWMEo
        cerPASjnC6PExyvvmSGcz4wSpxecZINp+XbgHjtEYjmjxMSnrSwgCSGB94wSHUucQGxhgQiJ
        vsPvWUFsEYFMiQmX3zGCNDAL7GWUODv7DjNIgk3AUKLrbRfYVF4BO4nLbZ/ZQWwWAVWJfd+W
        gdmiAkkSBz8+gKoRlDg58wnYMk4BN4mHGzoYQWxmAXmJ5q2zmSFscYlbT+YzgSyTELjBIbF4
        7QKos10kdr3YxQRhC0u8Or6FHcKWkfi/E6ahmVHi4bm17BBOD6PE5aYZjBBV1hJ3zv0CmsQB
        tEJTYv0ufYiwo8Tk89NZQMISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5
        AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYBI6/e/4
        px2Mc1991DvEyMTBeIhRgoNZSYS3VW5nvBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeVbPXxAsJ
        pCeWpGanphakFsFkmTg4pRqYSnlSur4277qR+H+etS2PtH/Ptvaja6+XX5bM4GmdsfZg9xKu
        xXf/OPo+N8yYK6sVlKpo551ZWpdweebS/E/cLPcsquMzGh6++zhPVf/Ut5UuEoGcXzMfc9ZP
        fhcouLUlW3bVNqXT+Ws33JB6eFwyYUPTf+3VBvprdnGZHtIU7p23c/+2N2X1q0wU9fdGSp1p
        sNb/8UWua821Y01/z5qcu2x6/ZNAiayt+64sRpkFFm+WVD/bmatndMfIPM9UQGWS9d0DrXeu
        iv1I/q0XqDSrbrZi8fpI6fjbNr094tpHu2+fVPxpWPHHJ7OHQ91bqdo/rSWm4Pu22TN2n5wp
        mHd82a1/c/mkvjSKHVgU5P1MiaU4I9FQi7moOBEA33YE4LEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7o93/bEG3RMZLHYOGM9q8XUh0/Y
        LJoXr2ezWDV1J4vF5V1z2CwaP95kt7g9cTKjA7vHplWdbB77565h9+j/a+DRt2UVo8fnTXIB
        rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GQf+
        fGcq2KxW8eXpGpYGxvnyXYycHBICJhLfDtxj72Lk4hASWMooserBGVaIhIzEyWkNULawxJ9r
        XWwQRW8ZJX6c3sgIkhAWiJA4vH4lG4gtIpApceP9WiaQImaBvYwSR14tYIboaGSU+LVhLlgH
        m4ChRNfbLrAOXgE7icttn9lBbBYBVYl935aB2aICSRK/l66FqhGUODnzCQuIzSngJvFwQwfY
        HGYBM4l5mx8yQ9jyEs1bZ0PZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6x
        kV5xYm5xaV66XnJ+7iZGYNxtO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMLbKrczXog3JbGyKrUo
        P76oNCe1+BCjKdA/E5mlRJPzgZGfVxJvaGZgamhiZmlgamlmrCTOa3JkTbyQQHpiSWp2ampB
        ahFMHxMHp1QDE9f9Rw92qTk2x7kYqNzTCd2wcOdj1gcO3N9W5ywQT1J1vn9aeZ8I9yS7qyVT
        Fq5PvGb1KleQ89qyOJdMnsOtYXOqy+66eb3Z/0mJJ0l/W/DXaPdw9W0vIlcnHLvZldfUeSLg
        2avU+4fmbPbNbEv4rr3si+NUrfDlCyw/MOeI7zu9/fP7/B380lvna71xuajlO/XQBds7QgIN
        hSufKR7aX7VCYinLuYiFFa4TV69/oMDxIsDaOTWotD/6bpR2rbpKq+dCvz3aOS8+bthlxvNU
        fmmgbkqwZCGXi+tuzzW+/Yfd3RIbH6yrUbzs8Sfz0b0AlxXy7d9e/56S9mRzzOJpFrXTgj5P
        mLiB85GvReipJCWW4oxEQy3mouJEALC+sahEAwAA
X-CMS-MailID: 20201124120324eucas1p189ec6eed6d6477e27a194f9d75d7b43a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201124120324eucas1p189ec6eed6d6477e27a194f9d75d7b43a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201124120324eucas1p189ec6eed6d6477e27a194f9d75d7b43a
References: <20201119161604.2633521-1-u.kleine-koenig@pengutronix.de>
        <20201119161604.2633521-2-u.kleine-koenig@pengutronix.de>
        <CGME20201124120324eucas1p189ec6eed6d6477e27a194f9d75d7b43a@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Uwe,

On 19.11.2020 17:16, Uwe Kleine-König wrote:
> The eventual goal is to get rid of the callbacks in struct
> device_driver. Other than not using driver callbacks there should be no
> side effect of this patch.
>
> Signed-off-by: Uwe Kleine-KÃ¶nig <u.kleine-koenig@pengutronix.de>

This patch landed recently in linux-next as commit 9db34ee64ce4 ("spi: 
Use bus_type functions for probe, remove and shutdown").

It causes a regression on some of my test boards:

Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000018
Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000000318ed000
[0000000000000018] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in: cpufreq_powersave cpufreq_conservative brcmfmac 
brcmutil cfg80211 crct10dif_ce s3fwrn5_i2c s3fwrn5 nci nfc s5p_mfc 
s5p_jpeg hci_uart btqca btbc
buf2_dma_contig videobuf2_memops videobuf2_v4l2 bluetooth 
videobuf2_common videodev panfrost gpu_sched ecdh_generic mc ecc rfkill 
ip_tables x_tables ipv6
CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 
5.10.0-rc5-next-20201124+ #9771
Hardware name: Samsung TM2E board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
pc : spi_shutdown+0x10/0x38
lr : device_shutdown+0x10c/0x350
sp : ffff80001311bc70
...
Call trace:
  spi_shutdown+0x10/0x38
  kernel_restart_prepare+0x34/0x40
  kernel_restart+0x14/0x88
  __do_sys_reboot+0x148/0x248
  __arm64_sys_reboot+0x1c/0x28
  el0_svc_common.constprop.3+0x74/0x198
  do_el0_svc+0x20/0x98
  el0_sync_handler+0x140/0x1a8
  el0_sync+0x140/0x180
Code: f9403402 d1008041 f100005f 9a9f1021 (f9400c21)
---[ end trace 266c07205a2d632e ]---
Kernel panic - not syncing: Oops: Fatal exception
Kernel Offset: disabled
CPU features: 0x0240022,65006087
Memory Limit: none
---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

> ---
>   drivers/spi/spi.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 5becf6c2c409..e8c0a000ee19 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -374,16 +374,7 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
>   	return add_uevent_var(env, "MODALIAS=%s%s", SPI_MODULE_PREFIX, spi->modalias);
>   }
>   
> -struct bus_type spi_bus_type = {
> -	.name		= "spi",
> -	.dev_groups	= spi_dev_groups,
> -	.match		= spi_match_device,
> -	.uevent		= spi_uevent,
> -};
> -EXPORT_SYMBOL_GPL(spi_bus_type);
> -
> -
> -static int spi_drv_probe(struct device *dev)
> +static int spi_probe(struct device *dev)
>   {
>   	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
>   	struct spi_device		*spi = to_spi_device(dev);
> @@ -414,7 +405,7 @@ static int spi_drv_probe(struct device *dev)
>   	return ret;
>   }
>   
> -static int spi_drv_remove(struct device *dev)
> +static int spi_remove(struct device *dev)
>   {
>   	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
>   	int ret = 0;
> @@ -426,13 +417,25 @@ static int spi_drv_remove(struct device *dev)
>   	return ret;
>   }
>   
> -static void spi_drv_shutdown(struct device *dev)
> +static void spi_shutdown(struct device *dev)
>   {
>   	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
>   
> -	sdrv->shutdown(to_spi_device(dev));
> +	if (sdrv->shutdown)
> +		sdrv->shutdown(to_spi_device(dev));
>   }

In the above function dev->driver might be NULL, so its use in 
to_spi_driver() and sdrv->shutdown leads to NULL pointer dereference. I 
didn't check the details, but a simple check for NULL dev->driver and 
return is enough to fix this issue. I can send such fix if you want.

> +struct bus_type spi_bus_type = {
> +	.name		= "spi",
> +	.dev_groups	= spi_dev_groups,
> +	.match		= spi_match_device,
> +	.uevent		= spi_uevent,
> +	.probe		= spi_probe,
> +	.remove		= spi_remove,
> +	.shutdown	= spi_shutdown,
> +};
> +EXPORT_SYMBOL_GPL(spi_bus_type);
> +
>   /**
>    * __spi_register_driver - register a SPI driver
>    * @owner: owner module of the driver to register
> @@ -445,10 +448,6 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
>   {
>   	sdrv->driver.owner = owner;
>   	sdrv->driver.bus = &spi_bus_type;
> -	sdrv->driver.probe = spi_drv_probe;
> -	sdrv->driver.remove = spi_drv_remove;
> -	if (sdrv->shutdown)
> -		sdrv->driver.shutdown = spi_drv_shutdown;
>   	return driver_register(&sdrv->driver);
>   }
>   EXPORT_SYMBOL_GPL(__spi_register_driver);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

