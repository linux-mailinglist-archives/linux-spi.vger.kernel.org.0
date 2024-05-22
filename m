Return-Path: <linux-spi+bounces-3012-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97968CC67D
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 20:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA461F22535
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2F145FF0;
	Wed, 22 May 2024 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qh434zbl"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7F210EC;
	Wed, 22 May 2024 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403315; cv=none; b=l1E40oCfSm43aSCRESdXf8NHnerqKrZGDHPcASURcvwsjlmebMGA9XTU/RzWdQWeWsQYOJGa3LwVwOBgTlXg/0gXTyxpuk0dLpYMkAggErS4eyhcnpRy/S8rp4fkIkiaAseiKiJo4G7YLgcjVKDQn1WdQEnfPR+exuUG4rWvSHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403315; c=relaxed/simple;
	bh=DBvi8kX86oi1qwiAojr/8EG3Zv/s7A8Unjv9EhW68EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSTZFwI+QCEWHm2/wMG0zfmjSmc0q2jDQarI9Z723Gbxjej8uG3I8jjePlTRzDz1wkVOZdMjVKgrF6SG7vYlQmjRhowodmX2PZanC0mj9v+DSKvIxnB0yooSn9gKZP33lJChedTbKWjruY/VqZBfMqdxV3rr0k9wzhQoB5dfZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qh434zbl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716403311;
	bh=DBvi8kX86oi1qwiAojr/8EG3Zv/s7A8Unjv9EhW68EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qh434zblkXDyaWJWhDuzbbzmj4QPCZRQ3PJWU8thw7m0Jn5oNrTrhdJDLvXTpvlMx
	 TCWfROwHjrRVaSfGKiO75TgK8xRZpFyjZDPsL4kg8+Mp0P1doxQ5hUBk2rIfisAKmu
	 M3N30USEvpl/yUCpepC+94WRMkFHLbMj+TkdRMybXTnkGjuFIa4Ann9vynvbxtQMZw
	 Y1gctuGzvIGujs7AIYjMIvyL2xIQqSj89D/ZoHWfkNCuVc1AThBpYdCp3o5LKFG/w+
	 MfhtS0/GhcEJUEei/MtAQ60I7lU8/hEeeKr0/f9WFmNhwDfT81C/QxiOCIutQIRx5H
	 dcsUgAGdURXkQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B93CE3782150;
	Wed, 22 May 2024 18:41:50 +0000 (UTC)
Date: Wed, 22 May 2024 14:41:48 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/2] spi: Check if transfer is mapped before calling
 DMA sync APIs
Message-ID: <4748499f-789c-45a8-b50a-2dd09f4bac8c@notapiano>
References: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
 <20240522171018.3362521-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522171018.3362521-3-andriy.shevchenko@linux.intel.com>

On Wed, May 22, 2024 at 08:09:50PM +0300, Andy Shevchenko wrote:
> The resent update to remove the orig_nents checks revealed
> that not all DMA sync backends can cope with the unallocated
> SG list, while supplying orig_nents == 0 (the commit 861370f49ce4
> ("iommu/dma: force bouncing if the size is not cacheline-aligned"),
> for example, makes that happen for the IOMMU case). It means
> we have to check if the buffers are DMA mapped before trying
> to sync them. Re-introduce that check in a form of calling
> ->can_dma() in the same way as it's done in the DMA mapping loop
> for the SPI transfers.
> 
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Closes: https://lore.kernel.org/r/8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org
> Closes: https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> Fixes: 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
> Suggested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

sorry I keep bothering you.

I tested this series and I still get the oops (attached at the end for
reference). When I tried this change originally, I added it on top of the
patches you had supplied. And as it turns out one of them was necessary.
Specifically, if I add 

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f94420858c22..9bc9fd10d538 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1220,6 +1220,11 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
        spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
 }

+/* Dummy SG for unidirect transfers */
+static struct scatterlist dummy_sg = {
+       .page_link = SG_END,
+};
+
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
        struct device *tx_dev, *rx_dev;
@@ -1258,6 +1263,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
                                                attrs);
                        if (ret != 0)
                                return ret;
+               } else {
+                       xfer->tx_sg.sgl = &dummy_sg;
                }

                if (xfer->rx_buf != NULL) {
@@ -1271,6 +1278,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)

                                return ret;
                        }
+               } else {
+                       xfer->rx_sg.sgl = &dummy_sg;
                }
        }
        /* No transfer has been mapped, bail out with success */

on top of this series, then I don't get any oops. (The memset doesn't seem to be
required, or at least in my test it didn't trigger any issue).

I guess this is needed because the can_dma "flag" is shared between rx and tx,
but either one of them might not have a buffer assigned (for unidirectional
transfers).

Sorry about the confusion.

Thanks,
Nícolas

Oops:

[    3.085228] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
[    3.096144] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
[    3.101468] Mem abort info:
[    3.110363] Mem abort info:
[    3.113239]   ESR = 0x0000000096000004
[    3.116114]   ESR = 0x0000000096000004
[    3.119969]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.123827]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.129284]   SET = 0, FnV = 0
[    3.134744]   SET = 0, FnV = 0
[    3.137881]   EA = 0, S1PTW = 0
[    3.141022]   EA = 0, S1PTW = 0
[    3.144247]   FSC = 0x04: level 0 translation fault
[    3.147475]   FSC = 0x04: level 0 translation fault
[    3.152491] Data abort info:
[    3.157505] Data abort info:
[    3.160468]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    3.163434]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    3.169065]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    3.169069]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    3.169073] [000000000000001c] user address but active_mm is swapper
[    3.169078] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    3.174711]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    3.179896] Modules linked in:
[    3.179903] CPU: 6 PID: 68 Comm: kworker/u32:2 Not tainted 6.9.0-next-20240515-00006-g6c6aba391be0 #427
[    3.185352]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    3.191869] Hardware name: Google Kingoftown (DT)
[    3.191872] Workqueue: events_unbound deferred_probe_work_func
[    3.198309] [000000000000001c] user address but active_mm is swapper
[    3.203495]
[    3.203497] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.247739] pc : iommu_dma_sync_sg_for_device+0x28/0x100
[    3.253204] lr : __dma_sync_sg_for_device+0x28/0x4c
[    3.258220] sp : ffff800080942dd0
[    3.261624] x29: ffff800080942dd0 x28: ffff1a58c1012010 x27: ffff1a58c1012010
[    3.268953] x26: ffff1a58c31a0800 x25: ffff1a58c31a0c80 x24: 00000000000186a0
[    3.276285] x23: ffff1a58c1012010 x22: 0000000000000001 x21: 0000000000000000
[    3.283615] x20: ffffc3561c10c718 x19: 0000000000000000 x18: ffffc3561cde8948
[    3.290943] x17: 0000000000010108 x16: 0000000000000000 x15: 0000000000000002
[    3.298274] x14: ffff1a58c09156c0 x13: 0000000000000001 x12: 0000000000000000
[    3.305602] x11: 071c71c71c71c71c x10: 0000000000000aa0 x9 : ffff800080942c90
[    3.312932] x8 : ffff1a5a36da4800 x7 : 4000000000000000 x6 : ffff1a5a36da4828
[    3.320265] x5 : ffffc3561b51a780 x4 : ffffc3561a704acc x3 : 0000000000000001
[    3.327596] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1a58c1012010
[    3.334927] Call trace:
[    3.337442]  iommu_dma_sync_sg_for_device+0x28/0x100
[    3.342540]  __dma_sync_sg_for_device+0x28/0x4c
[    3.347203]  spi_transfer_one_message+0x3a8/0x700
[    3.352042]  __spi_pump_transfer_message+0x198/0x4dc
[    3.357143]  __spi_sync+0x2a0/0x3c4
[    3.360738]  spi_sync+0x30/0x54
[    3.363971]  spi_mem_exec_op+0x26c/0x41c
[    3.368008]  spi_nor_spimem_read_data+0x148/0x158
[    3.372848]  spi_nor_read_data+0x30/0x3c
[    3.376881]  spi_nor_read_sfdp+0x74/0xe4
[    3.380916]  spi_nor_parse_sfdp+0x120/0x11d0
[    3.385314]  spi_nor_sfdp_init_params_deprecated+0x3c/0x8c
[    3.390951]  spi_nor_scan+0x7ac/0xef8
[    3.394721]  spi_nor_probe+0x94/0x2ec
[    3.398490]  spi_mem_probe+0x6c/0xac
[    3.402171]  spi_probe+0x84/0xe4
[    3.405491]  really_probe+0xbc/0x2a0
[    3.409173]  __driver_probe_device+0x78/0x12c
[    3.413654]  driver_probe_device+0x40/0x160
[    3.417961]  __device_attach_driver+0xb8/0x134
[    3.422533]  bus_for_each_drv+0x84/0xe0
[    3.426478]  __device_attach+0xa8/0x1b0
[    3.430423]  device_initial_probe+0x14/0x20
[    3.434720]  bus_probe_device+0xa8/0xac
[    3.438664]  device_add+0x590/0x750
[    3.442257]  __spi_add_device+0x138/0x208
[    3.446378]  of_register_spi_device+0x394/0x57c
[    3.451037]  spi_register_controller+0x394/0x760
[    3.455787]  qcom_qspi_probe+0x328/0x390
[    3.459826]  platform_probe+0x68/0xd8
[    3.463595]  really_probe+0xbc/0x2a0
[    3.467277]  __driver_probe_device+0x78/0x12c
[    3.471760]  driver_probe_device+0x40/0x160
[    3.476068]  __device_attach_driver+0xb8/0x134
[    3.480641]  bus_for_each_drv+0x84/0xe0
[    3.484585]  __device_attach+0xa8/0x1b0
[    3.488530]  device_initial_probe+0x14/0x20
[    3.492838]  bus_probe_device+0xa8/0xac
[    3.496784]  deferred_probe_work_func+0x88/0xc0
[    3.501442]  process_one_work+0x154/0x298
[    3.505568]  worker_thread+0x304/0x408
[    3.509425]  kthread+0x118/0x11c
[    3.512745]  ret_from_fork+0x10/0x20
[    3.516431] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
[    3.522686] ---[ end trace 0000000000000000 ]---

[    3.527428] Internal error: Oops: 0000000096000004 [#2] PREEMPT SMP
[    3.533868] Modules linked in:
[    3.537013] CPU: 2 PID: 102 Comm: cros_ec_spi_hig Tainted: G      D            6.9.0-next-20240515-00006-g6c6aba391be0 #427
[    3.548431] Hardware name: Google Kingoftown (DT)
[    3.553267] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.560412] pc : iommu_dma_sync_sg_for_device+0x28/0x100
[    3.565877] lr : __dma_sync_sg_for_device+0x28/0x4c
[    3.570899] sp : ffff8000809fb990
[    3.574312] x29: ffff8000809fb990 x28: ffff1a58c0ff8010 x27: ffff1a58c0ff8010
[    3.581644] x26: ffff1a58c4d39800 x25: ffff1a58c4d39c80 x24: 00000000000186a0
[    3.588976] x23: ffff1a58c0ff8010 x22: 0000000000000001 x21: 0000000000000000
[    3.596307] x20: ffffc3561c10c3d8 x19: 0000000000000000 x18: 0000000000000000
[    3.603639] x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000002
[    3.610972] x14: 0000000000000001 x13: 0000000000162b7a x12: 0000000000000001
[    3.618304] x11: ffff8000809fb8a0 x10: ffff1a58c1f93ff8 x9 : ffff1a58c4d39c69
[    3.625630] x8 : ffff1a58c102db04 x7 : 0000000000000000 x6 : 0000000000000001
[    3.632962] x5 : ffffc3561b51a780 x4 : ffffc3561a704acc x3 : 0000000000000001
[    3.640291] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1a58c0ff8010
[    3.647623] Call trace:
[    3.650148]  iommu_dma_sync_sg_for_device+0x28/0x100
[    3.655249]  __dma_sync_sg_for_device+0x28/0x4c
[    3.659903]  spi_transfer_one_message+0x3a8/0x700
[    3.664746]  __spi_pump_transfer_message+0x198/0x4dc
[    3.669853]  __spi_sync+0x2a0/0x3c4
[    3.673441]  spi_sync_locked+0x10/0x1c
[    3.677299]  receive_n_bytes+0xc0/0x118
[    3.681248]  do_cros_ec_pkt_xfer_spi+0x3c0/0x530
[    3.685997]  cros_ec_xfer_high_pri_work+0x20/0x34
[    3.690835]  kthread_worker_fn+0xcc/0x184
[    3.694960]  kthread+0x118/0x11c
[    3.698282]  ret_from_fork+0x10/0x20
[    3.701964] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
[    3.708221] ---[ end trace 0000000000000000 ]---

