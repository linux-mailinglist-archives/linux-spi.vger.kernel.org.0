Return-Path: <linux-spi+bounces-12139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 847CDCDE7D4
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 09:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6895D30080D5
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 08:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5C314B88;
	Fri, 26 Dec 2025 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="m7aPFFhM"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBE7081F;
	Fri, 26 Dec 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766737830; cv=none; b=uZ04gcrZUkkmwYNM+J2O8J/IjUnYcQxZz/w5nqaGscMdw6CRqW5QekRoZWJZlgSedJumatga57jYGJUctLrqc6iTsvrUKeQ6FgxFqIM0mPJiGhFUZJIQmmlifarVdKagUEedFzjlHJRLKQaw0hUdlGM7bcUbi3MvsHokLQqT0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766737830; c=relaxed/simple;
	bh=5mk1AqDXqYxiWM7jWOHmEJdxyWWdlPMbxkXnY5N9BDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NWP37Q58PsLHYuKcGpZPupzlxb5hx/R54EoQnBuH8eMw7yGZ7M+DkbrWbJJXcLUxviYgAnwPj2Q8+L1p/JZlkIyveo9B/+V2vrXJr8hb5hFzxq5zRgjEPnhkraoDKr65wGEBQ/1scNWMJwNU1p673M4txOEeo3usmpz3hss+828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=m7aPFFhM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ8UHdpC3288780, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766737817; bh=ng2H3zL6NRfFerI1NxFjntwBYw3MU10vHUxtEwMlvWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=m7aPFFhM4ux9XvDNxK/QHGPPQ2S0HtxkSdZ84RG8XtNRacOaH6LpzlzirDET3CiIg
	 ZvtyxoxDxAc3HghDawmhKuGHHUoV6OnIQ/3FiBM/hGEWPMlApTZ/EoMW7XIzWM2MuA
	 rBO3DMiMQ1WsgT+Ubk4v2lFhcHBc9LxsZy879jWcLrS2slDrF+q/5d4lmVMW5sXZwQ
	 +u4iT9rQYJEO42CNquQS2L0zrwdh4QocAwzHCn7oa0Ungm4l6HgQV9FEL7Ep3PZ5e5
	 TlrBlj/yWB2YFRf2WM8ZjuytQL1WoyVtus2Khzla6guL6H7XnWMjY0TRSd7Ljo1cmO
	 fbnhcFVyiiP5Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ8UHdpC3288780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 16:30:17 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:30:17 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:30:17 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Dec 2025 16:30:17 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <flove@realtek.com>, <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/4] spi: change of_find_spi_controller_by_node() gating to CONFIG_OF
Date: Fri, 26 Dec 2025 16:31:19 +0800
Message-ID: <20251226083119.1052199-1-oder_chiou@realtek.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, the helper of_find_spi_controller_by_node() is gated under
CONFIG_OF_DYNAMIC. This prevents drivers from using it in all CONFIG_OF
configurations.

This patch moves the gating to CONFIG_OF, keeping the inline fallback
returning NULL when Device Tree support is disabled.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 drivers/spi/spi.c       | 20 +++++++++++---------
 include/linux/spi/spi.h |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ecb5281b04a2..2badacc7a91c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4761,15 +4761,7 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 
 /*-------------------------------------------------------------------------*/
 
-#if IS_ENABLED(CONFIG_OF_DYNAMIC)
-/* Must call put_device() when done with returned spi_device device */
-static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
-{
-	struct device *dev = bus_find_device_by_of_node(&spi_bus_type, node);
-
-	return dev ? to_spi_device(dev) : NULL;
-}
-
+#if IS_ENABLED(CONFIG_OF)
 /* The spi controllers are not using spi_bus, so we find it with another way */
 struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
@@ -4785,6 +4777,16 @@ struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 	return container_of(dev, struct spi_controller, dev);
 }
 EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
+#endif
+
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+/* Must call put_device() when done with returned spi_device device */
+static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
+{
+	struct device *dev = bus_find_device_by_of_node(&spi_bus_type, node);
+
+	return dev ? to_spi_device(dev) : NULL;
+}
 
 static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 			 void *arg)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e6fdaf02386c..8bc616b00343 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -882,7 +882,7 @@ extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
-#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+#if IS_ENABLED(CONFIG_OF)
 extern struct spi_controller *of_find_spi_controller_by_node(struct device_node *node);
 #else
 static inline struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
-- 
2.52.0


