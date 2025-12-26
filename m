Return-Path: <linux-spi+bounces-12140-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF5ACDE810
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 09:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5373300443C
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E9D314B88;
	Fri, 26 Dec 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TNezi2g/"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D52F314B83;
	Fri, 26 Dec 2025 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766738272; cv=none; b=UTA9gTyftxA7I32RrjOhZwtdhQvOyk5O8bfzpKIKvGh2Qr3AEd34oj2xkbojOEBDCVfPkhJ/cZN5XbWFL6G6xX3QjZMkYl2W8g9Sb1uNeMhfbBrzhyTox/Sl0ECt2RU2IXTvJj5P2xa4qgQo2S24ar4oexZ1+9OtTFSG/LoOUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766738272; c=relaxed/simple;
	bh=M7qsvCYGelc0Rou43P1LQ0jUpto9chj8Lx2VtCUCvYw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B8IPRh2SuT0Aa7l0/zpek0BuyiaMPpMvZlaTNg6c3njd+Xg7liyUn+AmemchO07eXWfMjktpHq3E5umIwdux1TzyT9qfjthn7kTLSMav6RNlljcKO/87UG9eL2d0a+WHl2ObpyJnhoAIehtEBeNLqHev8PlakToQ2zpj1lJKi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TNezi2g/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ8bd0233311936, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766738259; bh=5ozsshDM7B18aOKkp9lYV89Q21ZPn1UFh2WJqy9/GBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=TNezi2g/fMMjagW9Gqxx+go6KGHB0Tu6EGfOOw3HSqE+oOIMXVvsLXdjOIqkfK11p
	 CZmHFSXRby6PnenqB3/sClqJxBeMx8NCd5dUzxlyWst+ZHg/hpB7KfMxl3ybtD+BSO
	 kqOn7YdJ2NWKGX2jSsSdWrv+WzHWaZF1YOwT5eD6OIjfTQE7KwE4S7XEUompWB/4h1
	 DUTo4w36+iQfM+DpDCUsD2TwBCL7c9EKpIfYhiJirjdPgCmVgv+1gSJCSTH0E6fQ7x
	 KW8sqTzm8ZIaCuBRPMeM38Ca5X7UQxlOvWbQXO9PxOB/g+Kj34qFLRl32E/BBNvpwT
	 DSbIT9KnTETkA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ8bd0233311936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 16:37:39 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:37:39 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Dec 2025 16:37:39 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <flove@realtek.com>, <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v11 1/4] spi: export of_find_spi_controller_by_node()
Date: Fri, 26 Dec 2025 16:39:04 +0800
Message-ID: <20251226083904.1052630-1-oder_chiou@realtek.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Some devices are primarily described on another bus (e.g. I2C) but also
have an additional SPI connection that serves as a transport for
firmware loading. Export of_find_spi_controller_by_node() so drivers can
obtain the SPI controller referenced by a DT phandle.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e25df9990f82..ecb5281b04a2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4771,7 +4771,7 @@ static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 }
 
 /* The spi controllers are not using spi_bus, so we find it with another way */
-static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
+struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
 	struct device *dev;
 
@@ -4784,6 +4784,7 @@ static struct spi_controller *of_find_spi_controller_by_node(struct device_node
 	/* Reference got in class_find_device */
 	return container_of(dev, struct spi_controller, dev);
 }
+EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
 
 static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 			 void *arg)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cb2c2df31089..e6fdaf02386c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -882,6 +882,15 @@ extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+extern struct spi_controller *of_find_spi_controller_by_node(struct device_node *node);
+#else
+static inline struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
+{
+	return NULL;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SPI_MASTER)
 extern struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev);
 extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
-- 
2.52.0


