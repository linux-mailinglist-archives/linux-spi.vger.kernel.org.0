Return-Path: <linux-spi+bounces-12137-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE38CDE7D1
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 09:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64BE30081B6
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41794314B8E;
	Fri, 26 Dec 2025 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Aks4p2pD"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8A199237;
	Fri, 26 Dec 2025 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766737800; cv=none; b=qTZuJWr1t9MDIcF/mp+hS/yd1NT6cVHg021WJ1No4B7VkcMCAESYVxrNpbVY5aiU7WErbHhpfgN6XtpLywGVh1FPRoHk+/tTLuD2gfNxbCKZh+uDLvjKAA0gnSDn4CFoLKNqFGCxh9+vstwR1VbFdiv6mFXvvyYQ1MhgXbyoRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766737800; c=relaxed/simple;
	bh=M7qsvCYGelc0Rou43P1LQ0jUpto9chj8Lx2VtCUCvYw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+636rpGJd+LF5CqF6yHsKHg37IPtiP+UhhEVD+zl9d3mfrka8miujxN8/9Aymv+qjT/o3YmcJfYyuI5+5utr65LDuBNajxk8wuD8TY2TrPjGc8Rd0ne7H9J9KSqi7kVY9AUoiHAXOj22EMN036mMaLktGz1iQjolFAZPGonh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Aks4p2pD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ8TmWzA3288560, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766737788; bh=5ozsshDM7B18aOKkp9lYV89Q21ZPn1UFh2WJqy9/GBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Aks4p2pDKCZ8QMABRkIEJKjARILo6AT5pmnNu10/wLXiFyxioVgcH6PUltChOp9mN
	 /uLFR/aWV9hvRpJx81niN7E5a1+xyqmQ3Jrpq4AAv6EVSomlMT9TyVBzdiN0MUhSuf
	 /nf2BbBrj/8iya/QU0dXjHoFCrVQ0/IwLkyJaoNcBmhzWlkQ1TJQG3cAASTvGGbIk1
	 qmAAdgvqbkXtocSW8Wwht70IsmEy6lF3jX7ZS6VUvOas7RscWpKhPxUEI+J24xx6uN
	 SkP54LnREBNdiUC7NocAeAZXN9k9YZ5JkqczaaYVrjRge0CeUqT0dhqg5xETMMnW0S
	 3MMvaeta36xGA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ8TmWzA3288560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 16:29:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:29:48 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:29:47 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Dec 2025 16:29:47 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <flove@realtek.com>, <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/4] spi: export of_find_spi_controller_by_node()
Date: Fri, 26 Dec 2025 16:31:01 +0800
Message-ID: <20251226083101.1052156-1-oder_chiou@realtek.com>
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


