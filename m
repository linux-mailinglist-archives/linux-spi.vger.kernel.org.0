Return-Path: <linux-spi+bounces-12174-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C845CEB175
	for <lists+linux-spi@lfdr.de>; Wed, 31 Dec 2025 03:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27ECE3009F02
	for <lists+linux-spi@lfdr.de>; Wed, 31 Dec 2025 02:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268EEEA8;
	Wed, 31 Dec 2025 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="L1zeWqyg"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676094A07;
	Wed, 31 Dec 2025 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767148494; cv=none; b=RykLpvaCfrQ73TrKmq2ME87CS4IxNgGu9xsDXaKOBggG97xJo7IYQYhwQi5lRoo9f9hpqJWhXv0qNDAMMyKKS5PHGaafxawMQgh+rthPbE67N3lEmYGV7ARQ5oC06nWIGpHnRKWDOndZq2gRAlLvXJ+6tdCeqyDTogPlEXGhioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767148494; c=relaxed/simple;
	bh=M7qsvCYGelc0Rou43P1LQ0jUpto9chj8Lx2VtCUCvYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3PwHF7qLTSaEP8FuwKuzpyUKhy6bZmbM508pF/wraaTl04Z0RYLQLCyeYly++tJ8fhsdLbKEkzltv8usBwg2Ikvc741Vq6kiYufgnWfU9PUnqqPaTLGIdgZddytzPd22WCK+c9XqOQjAGyB01/FTHFruXUJhGeSCB2LQY1dJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=L1zeWqyg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV2Yg0tA263938, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767148482; bh=5ozsshDM7B18aOKkp9lYV89Q21ZPn1UFh2WJqy9/GBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=L1zeWqygKNJ/lK2vCgn0WSMuSh6EL8yZPrzOoZEBLpF3MFcgSMhXI+o0sqAGQwQUV
	 dN4i33oAVU6J6z9d3KBWrV8elTabhhNR0YzA15LrMzzcQ1REOs1KXtGl2FvJYyT475
	 OyexV2mvBM1JhZ2TdyxwEyxlHUUT+rhEuTh8sQTUNdkEqf5qHRaQUuwtGb8BeT+2N4
	 kaXxWQ43RROGXMXnx/PmF7LfcMF4pgXpojrWzlN+xDzBAo8MKoz/pfEVi7jMAaA7P0
	 dQOxd9JGjaCaJPMvLiHwIG1kr766mJGkf9luN0nKK2TeqRhVQAGVXuwvilk0DgVfK8
	 YrF1LWWOCDJPA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV2Yg0tA263938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 10:34:42 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 10:34:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 10:34:41 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 31 Dec 2025 10:34:41 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <flove@realtek.com>, <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v11 1/4] spi: export of_find_spi_controller_by_node()
Date: Wed, 31 Dec 2025 10:35:44 +0800
Message-ID: <0e572a00aa305e588357162d400ba9472ce56dd3.1767148150.git.oder_chiou@realtek.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767148150.git.oder_chiou@realtek.com>
References: <cover.1767148150.git.oder_chiou@realtek.com>
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


