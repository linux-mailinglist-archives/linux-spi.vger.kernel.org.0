Return-Path: <linux-spi+bounces-617-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F0F8387DB
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 08:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1D01C22E8C
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7E2CA2;
	Tue, 23 Jan 2024 07:16:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D8524DB
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705994169; cv=none; b=dwnVk0AUjfCtBVEMYJbzzbMMF3m2p8y7J15N9Q6sp5HRo5P/sUuBdy3Gi/uzAQw1B7FRFpgjfXAGUAEiqft1koJMYZajb5ymEi2Qw8N/Bq6RJQ7paA7+ycX1w15Ah4J3PiV0dQ0pjxlKCaN6L024WGq4CoIV5x4AEkeAxezVsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705994169; c=relaxed/simple;
	bh=TfSM0er0NbPBNRYl/O2DgCH4jAfoPS2pgcz7YzdX6dc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MXVmPCPyODweJe1fKiuzz+rjeQ5BQeT2W+uq4WWInjFKmWR4Uuyjo5lhpJql6NCY/nCmdeKHi3vEmCuXT/2He/ftZwFudTROk3xJFqXDemcZa1xNI+N6VYEevDjgr945wQ4gYpcpOWEYJVYfQ3McC9N2kfaViwqjOMbMmNnnCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TJyy46zgxz1gxsC;
	Tue, 23 Jan 2024 15:14:20 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 13B211A0176;
	Tue, 23 Jan 2024 15:15:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 15:15:48 +0800
From: Devyn Liu <liudingyuan@huawei.com>
To: <broonie@kernel.org>
CC: <f.fangjian@huawei.com>, <jonathan.cameron@huawei.com>,
	<linux-spi@vger.kernel.org>, <liudingyuan@huawei.com>
Subject: [PATCH] spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
Date: Tue, 23 Jan 2024 15:11:49 +0800
Message-ID: <20240123071149.917678-1-liudingyuan@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600002.china.huawei.com (7.193.23.29)

Return IRQ_NONE from the interrupt handler when no interrupt was
detected. Because an empty interrupt will cause a null pointer error:

    Unable to handle kernel NULL pointer dereference at virtual
  address 0000000000000008
    Call trace:
        complete+0x54/0x100
        hisi_sfc_v3xx_isr+0x2c/0x40 [spi_hisi_sfc_v3xx]
        __handle_irq_event_percpu+0x64/0x1e0
        handle_irq_event+0x7c/0x1cc

Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 9d22018f7985..1301d14483d4 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -377,6 +377,11 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 static irqreturn_t hisi_sfc_v3xx_isr(int irq, void *data)
 {
 	struct hisi_sfc_v3xx_host *host = data;
+	u32 reg;
+
+	reg = readl(host->regbase + HISI_SFC_V3XX_INT_STAT);
+	if (!reg)
+		return IRQ_NONE;
 
 	hisi_sfc_v3xx_disable_int(host);
 
-- 
2.30.0


