Return-Path: <linux-spi+bounces-11938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C145DCC1445
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 08:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F73C3011A97
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B308F33FE11;
	Tue, 16 Dec 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="g2jkpNeN"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18BA33DEE5;
	Tue, 16 Dec 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869476; cv=none; b=oPGQ6usOQ7Wo8zSUX1mfNahAyomNnbUFL13xntY/H2lMJ4it5r3DJrY1rueHHPAeESQqkC3Em0upnNcuLmoH2NOWCfbFEc9iDDy+Wn+nf4LFgWtHgwHeNxBlVrtBBzONG+iGRE2aCXfviWacC/MlEA3FJw1Gq+/MzuL3F74gsm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869476; c=relaxed/simple;
	bh=+nOCJtKm6LqEC57WeGgYv6jRNGhDOLF+UTQE1MdkbQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+mst/epxFwqO1oAF2aHNjCmzWtlzRHKiPB6Q8wmkb0DHZxlNyraFiQTBV11BXCfsHjUgB+ISYN0I73dJF4l9NntM1Tcbz1pulFRaR2qPNIDKz9SVn0ZHS1pUfIZLwEIEbbMCszKJWcbGwnputztfijSZ3M2L7smBQ0HQhAFRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=g2jkpNeN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BG7HLn243480195, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765869441; bh=fjuHIIyTDdtwtVvJNBPuw1E2RWlC5vK7HA/qU8tD4S4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=g2jkpNeNJ5Wy8hiEPkavsJ8YzxPONb7aXNOpVRWdgGaPaWoIhnTvd+G1qdcCYFGc8
	 dyPGpt5fSy+tgwjdXBV/M7WvqUD586W1N36ImpHiF7vSOVP3/ykg5xcdhRCLY/Rv3f
	 77aoNm9bkdUfwJGNXQ7Ep1xlckG2LtIvIMJR3ua+MPOJQAhPzNFf2E5qwgewBW2EId
	 gU1LAcpDROBr+cIMC5yIdmrddYrLifEs1wtkuuTE+IwgcI56P4Kwqa4J86qd/S/bvY
	 KyZvFbIG0d7g+co1bR9uCRlFWfpGlEm1l/PpcZw9bPR8zJXfYXJUtYuQaBJR7zlnti
	 ew/l0JHWK1V5g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BG7HLn243480195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 15:17:21 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 16 Dec 2025 15:17:22 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 16 Dec 2025 15:17:21 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 16 Dec 2025 15:17:21 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <perex@perex.cz>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <flove@realtek.com>,
        <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou
	<oder_chiou@realtek.com>
Subject: [PATCH v10 1/3] spi: export of_find_spi_controller_by_node()
Date: Tue, 16 Dec 2025 15:18:51 +0800
Message-ID: <20251216071853.3929135-2-oder_chiou@realtek.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216071853.3929135-1-oder_chiou@realtek.com>
References: <20251216071853.3929135-1-oder_chiou@realtek.com>
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
---
 drivers/spi/spi.c       |  3 ++-
 include/linux/spi/spi.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index cb2c2df31089..1eb04a96cc1c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -882,6 +882,17 @@ extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+extern struct spi_controller *of_find_spi_controller_by_node(
+	struct device_node *node);
+#else
+static inline struct spi_controller *of_find_spi_controller_by_node(
+	struct device_node *node)
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


