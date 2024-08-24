Return-Path: <linux-spi+bounces-4296-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C5095DBEE
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 07:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919A31F2394B
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 05:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C114A4C9;
	Sat, 24 Aug 2024 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KFdvO7Js"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m1013.netease.com (mail-m1013.netease.com [154.81.10.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA7DF71;
	Sat, 24 Aug 2024 05:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724477016; cv=none; b=Dic0Yq77ngSFy3eMYt8GZl1108iQAeCdfISKdm9/ijM991abcV/Aq9SA1dNDlV4taA248TATVxEUSyIgRVcoZL/0t4Jt3RkSSe7SrY1bzZ/taKJmuK6QK5BwIa421Jxr4oV+GbqGTjd2hDwg/wlLEs8IEjr48ywIA/M7sFyHua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724477016; c=relaxed/simple;
	bh=5WsuRaYhcJxW661ZUm1cuAs4/wNqZ7oeWqcZoBhK6LY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClB17glQkkevSGMN6LhsYRoYoVLZbEA+VJi8voMZ5pXIBMZAgFmRh1TXkvm/d4OVdxffD9W3HweYH3sCE1Prm+e5j8ofltY7wKKize7x2pWD7C8zfPcw/kDqBBktjHSYCQVKUNlFo98DfCHT0Jc+4hFNKDs+pn2GNCTcUETAjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KFdvO7Js; arc=none smtp.client-ip=154.81.10.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=KFdvO7JscHuM/NTAAGVKObPjlLINFAnduAYtJLeB9c6tYIjoNrnFYJFXjLSxBCG400goR1rVJuD32o8LedATmKds7ONUrzKlcK/2qVNQZ4zc65cO4Basm004NSOKJpi2kbvBNGW0L5zwT04GW8a4YpwX4DVE32J9M9B6w8pWsZQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=nd5VIf5W6pvlmFIxeaG4uBeEYTx1cRTIUzJ8Ujk2LXs=;
	h=date:mime-version:subject:message-id:from;
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id DA5DD6E085D;
	Sat, 24 Aug 2024 13:14:54 +0800 (CST)
From: Jon Lin <jon.lin@rock-chips.com>
To: briannorris@chromium.org,
	broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: rockchip: Avoid redundant clock disable in pm operation
Date: Sat, 24 Aug 2024 13:14:52 +0800
Message-Id: <20240824051452.3954878-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlOGlZIS0lPGE9LSUsaSElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9182cf15d509d5kunmda5dd6e085d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTo6Hjo4OTIrKBoVOQoBVh4O
	NzIaCkpVSlVKTElPT0xNT0JOTE9PVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFPTElDNwY+

Fix WARN_ON:
[   22.869352][ T1885] clk_spi0 already unprepared
[   22.869379][ T1885] WARNING: CPU: 3 PID: 1885 at drivers/clk/clk.c:813 clk_core_unprepare+0xbc4
[   22.869380][ T1885] Modules linked in: bcmdhd dhd_static_buf
[   22.869391][ T1885] CPU: 3 PID: 1885 Comm: Binder:355_2 Tainted: G        W         5.10.66 #59
[   22.869393][ T1885] Hardware name: Rockchip RK3588 EVB1 LP4 V10 Board (DT)
[   22.869397][ T1885] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[   22.869401][ T1885] pc : clk_core_unprepare+0xbc/0x214
[   22.869404][ T1885] lr : clk_core_unprepare+0xbc/0x214

Fixes:  ("spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops")
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 57 +++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index e1ecd96c7858..043a7739c330 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -940,33 +940,24 @@ static void rockchip_spi_remove(struct platform_device *pdev)
 	spi_controller_put(ctlr);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int rockchip_spi_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int rockchip_spi_runtime_suspend(struct device *dev)
 {
-	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
-	ret = spi_controller_suspend(ctlr);
-	if (ret < 0)
-		return ret;
-
 	clk_disable_unprepare(rs->spiclk);
 	clk_disable_unprepare(rs->apb_pclk);
 
-	pinctrl_pm_select_sleep_state(dev);
-
 	return 0;
 }
 
-static int rockchip_spi_resume(struct device *dev)
+static int rockchip_spi_runtime_resume(struct device *dev)
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
-	pinctrl_pm_select_default_state(dev);
-
 	ret = clk_prepare_enable(rs->apb_pclk);
 	if (ret < 0)
 		return ret;
@@ -975,41 +966,45 @@ static int rockchip_spi_resume(struct device *dev)
 	if (ret < 0)
 		clk_disable_unprepare(rs->apb_pclk);
 
-	ret = spi_controller_resume(ctlr);
-	if (ret < 0) {
-		clk_disable_unprepare(rs->spiclk);
-		clk_disable_unprepare(rs->apb_pclk);
-	}
-
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
+#endif /* CONFIG_PM */
 
-#ifdef CONFIG_PM
-static int rockchip_spi_runtime_suspend(struct device *dev)
+#ifdef CONFIG_PM_SLEEP
+static int rockchip_spi_suspend(struct device *dev)
 {
+	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
-	clk_disable_unprepare(rs->spiclk);
-	clk_disable_unprepare(rs->apb_pclk);
+	ret = spi_controller_suspend(ctlr);
+	if (ret < 0)
+		return ret;
+
+	/* Avoid redundant clock disable */
+	if (!pm_runtime_status_suspended(dev))
+		rockchip_spi_runtime_suspend(dev);
+
+	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
 }
 
-static int rockchip_spi_runtime_resume(struct device *dev)
+static int rockchip_spi_resume(struct device *dev)
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
-	ret = clk_prepare_enable(rs->apb_pclk);
-	if (ret < 0)
-		return ret;
+	pinctrl_pm_select_default_state(dev);
 
-	ret = clk_prepare_enable(rs->spiclk);
+	if (!pm_runtime_status_suspended(dev)) {
+		ret = rockchip_spi_runtime_resume(dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = spi_controller_resume(ctlr);
 	if (ret < 0)
-		clk_disable_unprepare(rs->apb_pclk);
+		rockchip_spi_runtime_suspend(dev);
 
 	return 0;
 }
-- 
2.34.1


