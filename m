Return-Path: <linux-spi+bounces-5161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B334995B71
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 01:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D61B225AB
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 23:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA921500E;
	Tue,  8 Oct 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAr3j8s5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57E33986;
	Tue,  8 Oct 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429396; cv=none; b=UTD6Yj1+f6hKQ9qimjGn4RQZTfmq0X4Zar3PLyfto2rTiKDE2EtoY2z8HT4eUO1q+pp3CCR0Bk3JO1wXaauMjLggsE/KOGj0+XQ/GlSyDm5anY9PvkekcsKZNEAUrqbim9gRvOZ+SPOhmwUwADntNW/txH2dKnncgRsDAnktWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429396; c=relaxed/simple;
	bh=sgRdB6GHGNFkcHdj8XNl55fFHOIehVfGXwJ3yVIuoHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEwngF7674lYsBr8maCrZDXIZWJBFdRr/BKKhrj1k2g5vBWaHYTVvaNehwWYaI7DEBfvdgvxw5fMQ8GO8FGIsNzLnUTnWFemJn/QGbFsGf2jUVSgVbwkSNrpEnzNqO4pKFp1R4Tf+6ltxfcuXa2G1f1TJPQQVRQvdPgY804zarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAr3j8s5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A457EC4CEC7;
	Tue,  8 Oct 2024 23:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429395;
	bh=sgRdB6GHGNFkcHdj8XNl55fFHOIehVfGXwJ3yVIuoHs=;
	h=From:To:Cc:Subject:Date:From;
	b=DAr3j8s5ni9LSRzFbT4nXGcCy6z4CXH2+SXbxT+4C2czApXDu6hAf8uKLK06sjlUT
	 T9CRF0/cPlftvxNjMd4VP/mDKCc6XaPYF+qwxhuAXWEhtC1VJrMcUK1Z51ZC/f2BKZ
	 VUdCCPip6ds+y72ZE9AF1aaCL3D8zB9nJWLoOBAh+/QbN29w2uzs3P2S2vaANko1Sw
	 cpPJEpPiAphyropwX+JLu9p/xlKBJaP+ARankm1sjNPSFp8WpJeBSSW4lB75q4riah
	 IH7Zc48yga+Mr4P9IV93GkakkBCf7649DnUTR3n1oTCsCF06x75kgdS5YyF0oovwAD
	 wxQiYFbsCnXOw==
From: djakov@kernel.org
To: broonie@kernel.org
Cc: ruanjinjie@huawei.com,
	dmitry.baryshkov@linaro.org,
	dan.carpenter@linaro.org,
	naresh.kamboju@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgi Djakov <djakov@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] spi: geni-qcom: Fix boot warning related to pm_runtime and devres
Date: Wed,  9 Oct 2024 02:16:15 +0300
Message-Id: <20241008231615.430073-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georgi Djakov <djakov@kernel.org>

During boot, users sometimes observe the following warning:

[7.841431] WARNING: CPU: 4 PID: 492 at
drivers/interconnect/core.c:685 __icc_enable
(drivers/interconnect/core.c:685 (discriminator 7))
[..]
[7.841494] CPU: 4 PID: 492 Comm: (udev-worker) Not tainted 6.1.111-rc1 #1
[7.841497] Hardware name: Thundercomm Dragonboard 845c (DT)
[7.841499] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[7.841502] pc : __icc_enable (drivers/interconnect/core.c:685
(discriminator 7))
[7.841505] lr : icc_disable (drivers/interconnect/core.c:708)
[..]
[7.841541] Call trace:
[7.841542] __icc_enable (drivers/interconnect/core.c:685 (discriminator 7))
[7.841545] icc_disable (drivers/interconnect/core.c:708)
[7.841547] geni_icc_disable (drivers/soc/qcom/qcom-geni-se.c:862)
[7.841553] spi_geni_runtime_suspend+0x3c/0x4c spi_geni_qcom
[7.841561] pm_generic_runtime_suspend (drivers/base/power/generic_ops.c:28)
[7.841565] __rpm_callback (drivers/base/power/runtime.c:395)
[7.841568] rpm_callback (drivers/base/power/runtime.c:532)
[7.841570] rpm_suspend (drivers/base/power/runtime.c:672)
[7.841572] rpm_idle (drivers/base/power/runtime.c:504 (discriminator 1))
[7.841574] update_autosuspend (drivers/base/power/runtime.c:1662)
[7.841576] pm_runtime_disable_action (include/linux/spinlock.h:401
drivers/base/power/runtime.c:1703 include/linux/pm_runtime.h:599
drivers/base/power/runtime.c:1517)
[7.841579] devm_action_release (drivers/base/devres.c:720)
[7.841581] release_nodes (drivers/base/devres.c:503)
[7.841583] devres_release_all (drivers/base/devres.c:532)
[7.841585] device_unbind_cleanup (drivers/base/dd.c:531)
[7.841589] really_probe (drivers/base/dd.c:710)
[7.841592] __driver_probe_device (drivers/base/dd.c:785)
[7.841594] driver_probe_device (drivers/base/dd.c:815)
[7.841596] __driver_attach (drivers/base/dd.c:1202)
[7.841598] bus_for_each_dev (drivers/base/bus.c:301)
[7.841600] driver_attach (drivers/base/dd.c:1219)
[7.841602] bus_add_driver (drivers/base/bus.c:618)
[7.841604] driver_register (drivers/base/driver.c:246)
[7.841607] __platform_driver_register (drivers/base/platform.c:868)
[7.841609] spi_geni_driver_init+0x28/0x1000 spi_geni_qcom
[7.841615] do_one_initcall (init/main.c:1298)
[7.841619] do_init_module (kernel/module/main.c:2469)
[7.841623] load_module (kernel/module/main.c:2878)
[..]

This occurs when the spi-geni driver receives an -EPROBE_DEFER error
from spi_geni_grab_gpi_chan(), causing devres to start releasing all
resources as shown below:

[7.138679] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_icc_release (8 bytes)
[7.138751] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_icc_release (8 bytes)
[7.138827] geni_spi 880000.spi: DEVRES REL ffff800081443800 pm_runtime_disable_action (16 bytes)
[7.139494] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_pm_opp_config_release (16 bytes)
[7.139512] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_spi_release_controller (8 bytes)
[7.139516] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_clk_release (16 bytes)
[7.139519] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_ioremap_release (8 bytes)
[7.139524] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_region_release (24 bytes)
[7.139527] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_kzalloc_release (22 bytes)
[7.139530] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_pinctrl_release (8 bytes)
[7.139539] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_kzalloc_release (40 bytes)

The issue here is that pm_runtime_disable_action() results in a call to
spi_geni_runtime_suspend(), which attempts to suspend the device and
disable an interconnect path that devm_icc_release() has just released.

Resolve this by calling geni_icc_get() before enabling runtime PM. This
approach ensures that when devres releases resources in reverse order,
it will start with pm_runtime_disable_action(), suspending the device,
and then proceed to free the remaining resources.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/r/CA+G9fYtsjFtddG8i+k-SpV8U6okL0p4zpsTiwGfNH5GUA8dWAA@mail.gmail.com
Fixes: 89e362c883c6 ("spi: geni-qcom: Undo runtime PM changes at driver exit time")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f6e40f90418f..768d7482102a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1116,6 +1116,11 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->tx_reset_done);
 	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
+
+	ret = geni_icc_get(&mas->se, NULL);
+	if (ret)
+		return ret;
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
 	ret = devm_pm_runtime_enable(dev);
@@ -1125,9 +1130,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (device_property_read_bool(&pdev->dev, "spi-slave"))
 		spi->target = true;
 
-	ret = geni_icc_get(&mas->se, NULL);
-	if (ret)
-		return ret;
 	/* Set the bus quota to a reasonable value for register access */
 	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
 	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;

