Return-Path: <linux-spi+bounces-4099-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B4941F35
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 20:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C8A284A47
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8846188003;
	Tue, 30 Jul 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zNcrStya"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB333999;
	Tue, 30 Jul 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362960; cv=none; b=cZvbssAy8mxfGlPtQPjGC/YRZRBeWvnX+pNAMYF1mmXegzY/xeem9Nst5lmQRDyWb+1F0KSNQN6uQ27p3DO9lOK8lTz8cOyQ7bsSFbN56cBha1D8zrihAdWeRbn/FnOK5/nkv0pQbApj5R1ydIpBYPDGG1SWU8UcxOA9+F7QtdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362960; c=relaxed/simple;
	bh=+PyuAXNvzsOMoJPhIzCcq2lv0hmRbpd+QT24orU3Xv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FixyT3zCqNfXG98qYaJDVVFkMhT/ULYPurIpXZOAun4HRfxb+KiSVioBNzHxunzXKeGwAawCMivIJOywS6bHC/OWp6fle1qfgU5S7XhhXzFNqSO6a5yQKRRYC1CBSLSZmJUelEHdtXaxxAv8E+EN9gRmpAq2TYuJuaqj1TtrWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zNcrStya; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722362956;
	bh=+PyuAXNvzsOMoJPhIzCcq2lv0hmRbpd+QT24orU3Xv4=;
	h=From:To:Cc:Subject:Date:From;
	b=zNcrStyaA7kWxJZ8JdBiC/hDWkyFGxUvL8eU4TFT3eFvd2hmjS2GATer2OlYphMQr
	 IfE63LfjgA7S82Ii/EfS5rzRvKprw859omA0OWvTKQ495TT9TBZgcpLbweX6+w3+aS
	 83sBf4J2nRoSmr8upyIzOukCO61f95LAhqzjgLqY6XWXLygZ494kkYnX2lpxVvtcxO
	 oHC46Mou8fIN2uENlgd/0EyxL3z6EIPCu6Mq/ur9NJlxeeE83TwpBQCohxyMn3YMxl
	 TtnpiCfhRoBDRGaHIm5snYddcHb4+fB+MuOT4NpkeD6+d85ovwbPxZdzPBOS6tiL7r
	 ztPIxBlMPKsUw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CDDD03781139;
	Tue, 30 Jul 2024 18:09:16 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 758D44800E4; Tue, 30 Jul 2024 20:09:16 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lee Jones <lee@kernel.org>
Cc: Dmitrii Osipenko <dmitry.osipenko@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Urja <urja@urja.dev>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
Date: Tue, 30 Jul 2024 20:05:05 +0200
Message-ID: <20240730180903.81688-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I converted rk808 to device managed resources I converted the rk808
specific pm_power_off handler to devm_register_sys_off_handler() using
SYS_OFF_MODE_POWER_OFF_PREPARE, which is allowed to sleep. I did this
because the driver's poweroff function makes use of regmap and the backend
of that might sleep.

But the PMIC poweroff function will kill off the board power and the
kernel does some extra steps after the prepare handler. Thus the prepare
handler should not be used for the PMIC's poweroff routine. Instead the
normal SYS_OFF_MODE_POWER_OFF phase should be used. The old pm_power_off
method is also being called from there, so this would have been a
cleaner conversion anyways.

But it still makes sense to investigate the sleep handling and check
if there are any issues. Apparently the Rockchip and Meson I2C drivers
(the only platforms using the PMICs handled by this driver) both have
support for atomic transfers and thus may be called from the proper
poweroff context.

Things are different on the SPI side. That is so far only used by rk806
and that one is only used by Rockchip RK3588. Unfortunately the Rockchip
SPI driver does not support atomic transfers. That means using the
normal POWER_OFF handler would introduce the following error splash
during shutdown on all RK3588 boards currently supported upstream:

[   13.761353] ------------[ cut here ]------------
[   13.761764] Voluntary context switch within RCU read-side critical section!
[   13.761776] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0x3ac/0x404
[   13.763219] Modules linked in:
[   13.763498] CPU: 0 UID: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.10.0-12284-g2818a9a19514 #1499
[   13.764297] Hardware name: Rockchip RK3588 EVB1 V10 Board (DT)
[   13.764812] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   13.765427] pc : rcu_note_context_switch+0x3ac/0x404
[   13.765871] lr : rcu_note_context_switch+0x3ac/0x404
[   13.766314] sp : ffff800084f4b5b0
[   13.766609] x29: ffff800084f4b5b0 x28: ffff00040139b800 x27: 00007dfb4439ae80
[   13.767245] x26: ffff00040139bc80 x25: 0000000000000000 x24: ffff800082118470
[   13.767880] x23: 0000000000000000 x22: ffff000400300000 x21: ffff000400300000
[   13.768515] x20: ffff800083a9d600 x19: ffff0004fee48600 x18: fffffffffffed448
[   13.769151] x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000048
[   13.769787] x14: fffffffffffed490 x13: ffff80008473b3c0 x12: 0000000000000900
[   13.770421] x11: 0000000000000300 x10: ffff800084797bc0 x9 : ffff80008473b3c0
[   13.771057] x8 : 00000000ffffefff x7 : ffff8000847933c0 x6 : 0000000000000300
[   13.771692] x5 : 0000000000000301 x4 : 40000000fffff300 x3 : 0000000000000000
[   13.772328] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000400300000
[   13.772964] Call trace:
[   13.773184]  rcu_note_context_switch+0x3ac/0x404
[   13.773598]  __schedule+0x94/0xb0c
[   13.773907]  schedule+0x34/0x104
[   13.774198]  schedule_timeout+0x84/0xfc
[   13.774544]  wait_for_completion_timeout+0x78/0x14c
[   13.774980]  spi_transfer_one_message+0x588/0x690
[   13.775403]  __spi_pump_transfer_message+0x19c/0x4ec
[   13.775846]  __spi_sync+0x2a8/0x3c4
[   13.776161]  spi_write_then_read+0x120/0x208
[   13.776543]  rk806_spi_bus_read+0x54/0x88
[   13.776905]  _regmap_raw_read+0xec/0x16c
[   13.777257]  _regmap_bus_read+0x44/0x7c
[   13.777601]  _regmap_read+0x60/0xd8
[   13.777915]  _regmap_update_bits+0xf4/0x13c
[   13.778289]  regmap_update_bits_base+0x64/0x98
[   13.778686]  rk808_power_off+0x70/0xfc
[   13.779024]  sys_off_notify+0x40/0x6c
[   13.779356]  atomic_notifier_call_chain+0x60/0x90
[   13.779776]  do_kernel_power_off+0x54/0x6c
[   13.780146]  machine_power_off+0x18/0x24
[   13.780499]  kernel_power_off+0x70/0x7c
[   13.780845]  __do_sys_reboot+0x210/0x270
[   13.781198]  __arm64_sys_reboot+0x24/0x30
[   13.781558]  invoke_syscall+0x48/0x10c
[   13.781897]  el0_svc_common+0x3c/0xe8
[   13.782228]  do_el0_svc+0x20/0x2c
[   13.782528]  el0_svc+0x34/0xd8
[   13.782806]  el0t_64_sync_handler+0x120/0x12c
[   13.783197]  el0t_64_sync+0x190/0x194
[   13.783527] ---[ end trace 0000000000000000 ]---

To avoid this we keep the SYS_OFF_MODE_POWER_OFF_PREPARE handler for the
SPI backend. This is not great, but at least avoids regressions and the
fix should be small enough to allow backporting.

As a side-effect this also works around a shutdown problem on the Asus
C201. For reasons unknown that skips calling the prepare handler and
directly calls the final shutdown handler.

Fixes: 4fec8a5a85c49 ("mfd: rk808: Convert to device managed resources")
Cc: stable@vger.kernel.org
Reported-by: Urja <urja@urja.dev>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/rk8xx-core.c  | 15 +++++++++++++--
 drivers/mfd/rk8xx-i2c.c   |  2 +-
 drivers/mfd/rk8xx-spi.c   |  2 +-
 include/linux/mfd/rk808.h |  2 +-
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 5eda3c0dbbdf..757ef8181328 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -692,10 +692,11 @@ void rk8xx_shutdown(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(rk8xx_shutdown);
 
-int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap)
+int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap, bool is_spi)
 {
 	struct rk808 *rk808;
 	const struct rk808_reg_data *pre_init_reg;
+	enum sys_off_mode pwr_off_mode = SYS_OFF_MODE_POWER_OFF;
 	const struct mfd_cell *cells;
 	int dual_support = 0;
 	int nr_pre_init_regs;
@@ -785,10 +786,20 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
 
+	/*
+	 * Currently the Rockchip SPI driver always sleeps when doing SPI
+	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
+	 * handler, so we are using the prepare handler as a workaround.
+	 * This should be removed once the Rockchip SPI driver has been
+	 * adapted.
+	 */
+	if (is_spi)
+		pwr_off_mode = SYS_OFF_MODE_POWER_OFF_PREPARE;
+
 	if (device_property_read_bool(dev, "rockchip,system-power-controller") ||
 	    device_property_read_bool(dev, "system-power-controller")) {
 		ret = devm_register_sys_off_handler(dev,
-				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
+				    pwr_off_mode, SYS_OFF_PRIO_HIGH,
 				    &rk808_power_off, rk808);
 		if (ret)
 			return dev_err_probe(dev, ret,
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 69a6b297d723..a2029decd654 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -189,7 +189,7 @@ static int rk8xx_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(regmap),
 				     "regmap initialization failed\n");
 
-	return rk8xx_probe(&client->dev, data->variant, client->irq, regmap);
+	return rk8xx_probe(&client->dev, data->variant, client->irq, regmap, false);
 }
 
 static void rk8xx_i2c_shutdown(struct i2c_client *client)
diff --git a/drivers/mfd/rk8xx-spi.c b/drivers/mfd/rk8xx-spi.c
index 3405fb82ff9f..20f9428f94bb 100644
--- a/drivers/mfd/rk8xx-spi.c
+++ b/drivers/mfd/rk8xx-spi.c
@@ -94,7 +94,7 @@ static int rk8xx_spi_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
 				     "Failed to init regmap\n");
 
-	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap);
+	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap, true);
 }
 
 static const struct of_device_id rk8xx_spi_of_match[] = {
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 69cbea78b430..be15b84cff9e 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -1349,7 +1349,7 @@ struct rk808 {
 };
 
 void rk8xx_shutdown(struct device *dev);
-int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap);
+int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap, bool is_spi);
 int rk8xx_suspend(struct device *dev);
 int rk8xx_resume(struct device *dev);
 
-- 
2.43.0


