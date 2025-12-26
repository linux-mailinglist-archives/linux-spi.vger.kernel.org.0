Return-Path: <linux-spi+bounces-12141-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4A8CDE819
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 09:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EDAA3007684
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C008C314D02;
	Fri, 26 Dec 2025 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ngacBzbR"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09929314B82;
	Fri, 26 Dec 2025 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766738276; cv=none; b=RFWnR1Q6m2Av7zVKw6caRJtqheyX10vghAlbWjvinpb5Gh2vnVY3iFTlk8wZje6VOLnzqHhmNiyvakRCunjZ1TMYLha02yRxz2UyTCKbF2LaTTgBZnTFCASTYRkeOpL/EYPNLjXguU6/sTAwrfDFxP/6D9FDpkoJwxOyFGImkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766738276; c=relaxed/simple;
	bh=5mk1AqDXqYxiWM7jWOHmEJdxyWWdlPMbxkXnY5N9BDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LMekkpXGnXUnTzk3YLkF1m4z8D9Q9LzxYVFfGL35cfo/0Y3PdrhXhNfKjpj8Fs5ZboFy5/4xbnmiG4DAqJb2BIuugywxkqKcM9LWSfkGGbPrD8XDs587OHH8Qtp9hx5Cuafc97iUYL6rVAE9VYeQAImmvwLfqijfp/KPVre31Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ngacBzbR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ8bkDeB3311939, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766738266; bh=ng2H3zL6NRfFerI1NxFjntwBYw3MU10vHUxtEwMlvWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ngacBzbR2uvG1QG4XYPJ0d55Tg5tI8HsCSozOkgyDUSLZMu56oxiHsh5wlyDQxZvE
	 g5uYjrTdUqKUuHf7L4kEyy5TanNiDiI23SW9bJjcSIvd45hiC3OUkx70GuyBdkZLae
	 1MuwABIXk3jT06tgaN0cl6PKc3teYd26z02dPcAMuLxh3nYcO1Dbv0RMDVrpfEpaDd
	 q4rPntHdvfSIh7DoJlwZaGKjNwXI+fVU+vWbtoU43Uu0Q7U+W6T1NAAjxdMTqz4bW0
	 Oz0KbK1Yazts5RehYqat3T39qyue6pMEZ4ZBx+YBzXj4SwSGvU4I6W/jY3NICo4hd5
	 tRU2Ihd2s/+7A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ8bkDeB3311939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 16:37:46 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:37:44 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Dec 2025 16:37:44 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <flove@realtek.com>, <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v11 2/4] spi: change of_find_spi_controller_by_node() gating to CONFIG_OF
Date: Fri, 26 Dec 2025 16:39:09 +0800
Message-ID: <20251226083909.1052641-1-oder_chiou@realtek.com>
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


