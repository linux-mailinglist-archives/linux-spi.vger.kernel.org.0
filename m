Return-Path: <linux-spi+bounces-3005-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08AF8CC3E6
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 17:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DCE1F216C0
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E00286AD;
	Wed, 22 May 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yV0G5iCz"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616824B2A;
	Wed, 22 May 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390776; cv=none; b=fuZFcXRlxgKrciB1lBP1njJ1ocfgY53t1iECjKoHeVdYvi47NhCQHZ+3tuVFKRrjn+T4xeoV5EA+ADSd/qcAXtP2JE/ceQZO2+AxIwj0YqgEO8onuMhPYeudzSZhBo/ZKmiekNluayNaCJTHApkXi8MIXk1TAxjdwn1N6bWyl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390776; c=relaxed/simple;
	bh=ZNvZxr9T2o/TPzqHQ+f1eJEWgXXoZcn3D4DHe1nKn54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCXZEWLPHJhJDzIAKihr9Z82Bl0mRjiXH9DIVe66QQME2lW4oaff9uG4c1zxnCTVnBkw6fufLfF3qs14CSX8AKUlTJiFrL2w7g6Bt7DPNQPVx5pL990ZeSMU3t3d35utUuPNxwMhZORwB5ZvT2DsEHGynqIRHyTM4xrx1cNFhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yV0G5iCz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716390767;
	bh=ZNvZxr9T2o/TPzqHQ+f1eJEWgXXoZcn3D4DHe1nKn54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yV0G5iCzoEryREZwhe/qmp5Wx1eBANbeV0hsvUbEe2xLIIt5lIYNT3KZaFny4ej8g
	 9IGN4sD/k5/gwZe0edopM2GDyMerUw20rVfyPuY/G5wo6XWtYx2CHbUwcFqRWsGuGD
	 dkRY+OwuRe7QlwqJ8fnCGJiq0146Ap3Z4pm3d2skcJwQ4/RxN0xDCiribstRM0WJme
	 R0UIdYcGpNXG1NdZ3F/trQcdEs7QQDr0yt5GlXhTlCMKXDoGp0z6NZ5TK4t/G0H9bX
	 fFdLQomyJIZoR8zB6dzY6GaIDbUXWBVfPBt9C0PH2KvGlXpPhaqjuC50VNVWBeR0yL
	 Y6hDOGl+doEjg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E9EB93782175;
	Wed, 22 May 2024 15:12:45 +0000 (UTC)
Date: Wed, 22 May 2024 11:12:43 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <76763ae4-557a-401e-9497-9295e7da3fd7@notapiano>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org>
 <Zk3X7Dgst5kVzJxy@smile.fi.intel.com>
 <5c32d7fd-4a7f-4d9c-805c-87d4d14f741e@linaro.org>
 <71e7b6f8-67f2-4c03-b83a-71d7e747ad04@linaro.org>
 <Zk4AKOoymq5OvlkA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zk4AKOoymq5OvlkA@smile.fi.intel.com>

On Wed, May 22, 2024 at 05:24:40PM +0300, Andy Shevchenko wrote:
> On Wed, May 22, 2024 at 03:18:18PM +0200, Neil Armstrong wrote:
> > On 22/05/2024 13:53, Neil Armstrong wrote:
> > > On 22/05/2024 13:33, Andy Shevchenko wrote:
> > > > On Wed, May 22, 2024 at 12:03:33PM +0200, Neil Armstrong wrote:
> > > > > On 15/05/2024 23:09, Nícolas F. R. A. Prado wrote:
> > > > > > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > > > > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > > > > > have checks for orig_nents against 0. No need to duplicate this.
> > > > > > > All the same applies to other DMA mapping API calls.
> > > > > > > 
> > > > > > > Also note, there is no other user in the kernel that does this kind of
> > > > > > > checks.
> > > > > > > 
> > > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > this commit caused a regression which I reported here:
> > > > > > 
> > > > > > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > > > > > 
> > > > > > along with some thoughts on the cause and a possible solution, though I'm not
> > > > > > familiar with this code base at all and would really appreciate any feedback you
> > > > > > may have.
> > > > > 
> > > > > I also see the same regression on the SM8550 and SM8650 platforms,
> > > > > please CC linux-arm-msm@vger.kernel.org and me for a potential fix to test on those platforms.
> > > > 
> > > > There is still no answer from IOMMU patch author. Do you have the same trace
> > > > due to IOMMU calls? Anyway, I guess it would be nice to see it.
[..]
> > > > 
> > > > Meanwhile, I have three changes I posted in the replies to the initial report,
> > > > can you combine them all and test? This will be a plan B (? or A, depending on
> > > > the culprit).
> > > > 
> > > 
> > > I'll try to apply them and test.
> > 
> > I stacked the 3 changes, and it works:
> > Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> 
> Thank you!
> 
> I will try to develop and submit a fix against IOMMU which I believe is the
> correct place to address this. So, this one will be plan B in case the IOMMU
> folks will refuse the other one.

Hi,

that change did not work for me. Stack trace follows at the end.

But adding the following on top did fix it:

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0851c5e1fd1f..5d3972d9d1da 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1253,8 +1253,13 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
                /* The sync is done before each transfer. */
                unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;

-               if (!ctlr->can_dma(ctlr, msg->spi, xfer))
+               if (!ctlr->can_dma(ctlr, msg->spi, xfer)) {
+                       memset(&xfer->tx_sg, 0, sizeof(xfer->tx_sg));
+                       xfer->tx_sg.sgl = &dummy_sg;
+                       memset(&xfer->rx_sg, 0, sizeof(xfer->rx_sg));
+                       xfer->rx_sg.sgl = &dummy_sg;
                        continue;
+               }

                if (xfer->tx_buf != NULL) {
                        ret = spi_map_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,


The thing is that even with all the previous changes applied, if one of the
transfers inside the message doesn't support DMA, the null pointer would still
be passed to the DMA API.

Alternatively, I think a better way to achieve the same is (I have verified this
also works):

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0851c5e1fd1f..3f2ee70d080a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1322,7 +1322,7 @@ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	return 0;
 }

-static void spi_dma_sync_for_device(struct spi_controller *ctlr,
+static void spi_dma_sync_for_device(struct spi_controller *ctlr, struct spi_message *msg,
 				    struct spi_transfer *xfer)
 {
 	struct device *rx_dev = ctlr->cur_rx_dma_dev;
@@ -1331,11 +1331,14 @@ static void spi_dma_sync_for_device(struct spi_controller *ctlr,
 	if (!ctlr->cur_msg_mapped)
 		return;

+	if (!ctlr->can_dma(ctlr, msg->spi, xfer))
+		return;
+
 	dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
 	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 }

-static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
+static void spi_dma_sync_for_cpu(struct spi_controller *ctlr, struct spi_message *msg,
 				 struct spi_transfer *xfer)
 {
 	struct device *rx_dev = ctlr->cur_rx_dma_dev;
@@ -1344,6 +1347,9 @@ static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
 	if (!ctlr->cur_msg_mapped)
 		return;

+	if (!ctlr->can_dma(ctlr, msg->spi, xfer))
+		return;
+
 	dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 	dma_sync_sgtable_for_cpu(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
 }
@@ -1637,10 +1643,10 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 			reinit_completion(&ctlr->xfer_completion);

 fallback_pio:
-			spi_dma_sync_for_device(ctlr, xfer);
+			spi_dma_sync_for_device(ctlr, msg, xfer);
 			ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
 			if (ret < 0) {
-				spi_dma_sync_for_cpu(ctlr, xfer);
+				spi_dma_sync_for_cpu(ctlr, msg, xfer);

 				if (ctlr->cur_msg_mapped &&
 				   (xfer->error & SPI_TRANS_FAIL_NO_START)) {
@@ -1665,7 +1671,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 					msg->status = ret;
 			}

-			spi_dma_sync_for_cpu(ctlr, xfer);
+			spi_dma_sync_for_cpu(ctlr, msg, xfer);
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,


I'll let you decide what is the best fix for the issue (what has been posted so
far in this thread or another fix in IOMMU). If you go with this, feel free to
add my

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

Stack trace:

[    3.086173] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
[    3.103002] Mem abort info:
[    3.105885]   ESR = 0x0000000096000004
[    3.109738]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.115198]   SET = 0, FnV = 0
[    3.118342]   EA = 0, S1PTW = 0
[    3.121570]   FSC = 0x04: level 0 translation fault
[    3.126584] Data abort info:
[    3.129545]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    3.135188]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    3.140383]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    3.145837] [000000000000001c] user address but active_mm is swapper
[    3.152369] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    3.156423] input: cros_ec as /devices/platform/soc@0/ac0000.geniqup/a80000.spi/spi_master/spi6/spi6.0/a80000.spi:ec@0:keyboard-controller/input/input0
[    3.158806] Modules linked in:
[    3.158812] CPU: 6 PID: 68 Comm: kworker/u32:2 Not tainted 6.9.0-next-20240515-00005-gad5f430e51d2 #424
[    3.158820] Hardware name: Google Kingoftown (DT)
[    3.158823] Workqueue: events_unbound deferred_probe_work_func
[    3.175091] input: cros_ec_buttons as /devices/platform/soc@0/ac0000.geniqup/a80000.spi/spi_master/spi6/spi6.0/a80000.spi:ec@0:keyboard-controller/input/input1
[    3.175859]
[    3.175861] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.186858] cros-ec-spi spi6.0: Chrome EC device registered
[    3.190317] pc : iommu_dma_sync_sg_for_device+0x28/0x100
[    3.190327] lr : __dma_sync_sg_for_device+0x28/0x4c
[    3.211853] tpm_tis_spi spi0.0: Cr50 firmware version: B2-C:0 RO_A:0.0.11/bc74f7dc RW_A:0.6.70/cr50_v2.0.3361-b70f24b1b
[    3.212461] sp : ffff800080942dc0
[    3.212464] x29: ffff800080942dc0 x28: ffff7eb103be2000 x27: ffff7eb101012010
[    3.257562] x26: ffff800080943008 x25: ffff7eb103be2480 x24: ffffb819fada5180
[    3.264887] x23: ffff7eb101012010 x22: 0000000000000001 x21: 0000000000000000
[    3.272213] x20: ffffb819fb10c718 x19: 0000000000000000 x18: ffffb819fbde8988
[    3.279539] x17: 0000000000010108 x16: 0000000000000000 x15: 0000000000000002
[    3.286863] x14: 0000000000000001 x13: 000000000016356d x12: 0000000000000001
[    3.294188] x11: ffff800080942cd0 x10: ffff7eb103c74ff8 x9 : ffff7eb103be2469
[    3.301515] x8 : ffff7eb10101cf04 x7 : 00000000ffffffff x6 : 0000000000000001
[    3.308849] x5 : ffffb819fa51a780 x4 : ffffb819f9704acc x3 : 0000000000000001
[    3.316182] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff7eb101012010
[    3.323509] Call trace:
[    3.326023]  iommu_dma_sync_sg_for_device+0x28/0x100
[    3.331125]  __dma_sync_sg_for_device+0x28/0x4c
[    3.335790]  spi_transfer_one_message+0x378/0x6e4
[    3.340634]  __spi_pump_transfer_message+0x1e4/0x504
[    3.345737]  __spi_sync+0x2a0/0x3c4
[    3.349334]  spi_sync+0x30/0x54
[    3.352568]  spi_mem_exec_op+0x26c/0x41c
[    3.356610]  spi_nor_spimem_read_data+0x148/0x158
[    3.361454]  spi_nor_read_data+0x30/0x3c
[    3.365494]  spi_nor_read_sfdp+0x74/0xe4
[    3.369532]  spi_nor_parse_sfdp+0x120/0x11d0
[    3.373921]  spi_nor_sfdp_init_params_deprecated+0x3c/0x8c
[    3.379562]  spi_nor_scan+0x7ac/0xef8
[    3.383336]  spi_nor_probe+0x94/0x2ec
[    3.387109]  spi_mem_probe+0x6c/0xac
[    3.390796]  spi_probe+0x84/0xe4
[    3.394119]  really_probe+0xbc/0x2a0
[    3.397793]  __driver_probe_device+0x78/0x12c
[    3.402270]  driver_probe_device+0x40/0x160
[    3.406569]  __device_attach_driver+0xb8/0x134
[    3.411144]  bus_for_each_drv+0x84/0xe0
[    3.415091]  __device_attach+0xa8/0x1b0
[    3.419040]  device_initial_probe+0x14/0x20
[    3.423340]  bus_probe_device+0xa8/0xac
[    3.427288]  device_add+0x590/0x750
[    3.430872]  __spi_add_device+0x138/0x208
[    3.434999]  of_register_spi_device+0x394/0x57c
[    3.439656]  spi_register_controller+0x394/0x760
[    3.444399]  qcom_qspi_probe+0x328/0x390
[    3.448442]  platform_probe+0x68/0xd8
[    3.452216]  really_probe+0xbc/0x2a0
[    3.455898]  __driver_probe_device+0x78/0x12c
[    3.460382]  driver_probe_device+0x40/0x160
[    3.464682]  __device_attach_driver+0xb8/0x134
[    3.469246]  bus_for_each_drv+0x84/0xe0
[    3.473193]  __device_attach+0xa8/0x1b0
[    3.477137]  device_initial_probe+0x14/0x20
[    3.481435]  bus_probe_device+0xa8/0xac
[    3.485383]  deferred_probe_work_func+0x88/0xc0
[    3.490044]  process_one_work+0x154/0x298
[    3.494172]  worker_thread+0x304/0x408
[    3.498035]  kthread+0x118/0x11c
[    3.501358]  ret_from_fork+0x10/0x20
[    3.505046] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
[    3.511301] ---[ end trace 0000000000000000 ]---

