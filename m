Return-Path: <linux-spi+bounces-6609-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D652A25E52
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 16:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6844E1881BC6
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2120AF6B;
	Mon,  3 Feb 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ZkOGUhdE"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D820AF65;
	Mon,  3 Feb 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595601; cv=none; b=pz2okNsV+kP7MMlkL005qhmNSk+plBk6bpRTL768JW+fhkIpGjF050KPq6emRqAsHh0YAn9c00taKAIonU07cXXCYqTslH8UHRnLW+flJ44DVh5/jYjGP9iP1XzzkamwpcMb4wpZzMiMmbXfMR7MZ1HdMmFQolNoaVANJUHHdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595601; c=relaxed/simple;
	bh=S4iSdPY0u2qGzgIj6sz+1VT7L8s6eD4vS+xdZJk5T1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JPdQKUXGE+9mIR/PK27Jq/7EP4AoMUnEGMeHexBe32EcEmBbsFkaOKjynAoFlDTFWYHx/+0EV65a9KuosPNAKS6oEjR7ee4iJvKNQV2O3h0mt3HIM7YK3zlxTnUHDTT7wK07FoIT03eMHui1tLokBkd2DmVKtSeos2GdyjOvlKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ZkOGUhdE; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E560EA0E4F;
	Mon,  3 Feb 2025 16:13:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=KsW8X9WKTUVjkLOMVLun4STQMn5HssaiU+p3WX0jzQw=; b=
	ZkOGUhdEZdk7nZcdBpWIynCii/QLezGnYiubpZmIP1nbEsFPV/VrJIVF5IaJTpqo
	gEgut8MklY1FQc38+jyXZMvY8iSMwvUu8b3dmlTU2nwZm9MQZ9SawibxDHCgXCFu
	hz9epWJh5YtWkNHRY3uaUToFhOuyZ6dSRUWuBId4uqIfXqATAU3lxbV2xTEnzFk9
	Q/8T3i4DVAFSfUrNQkheHUOu0Sf2Y7jvh+IpzuQb74CCMYCjHemWFctTXarz+f75
	2t3Nmx1hAHSRNua1pk71sr7Fy7dM6YxjkgwbWGt7WSeBLo02Cjyzc8lqhhlGN9CD
	Y+c+qbXBEQCs5h71oaXWm0qk0jd4KZqRVX/zqm20d8fOhwi9y21mR4G86V9sifxH
	Yw/8tVr4gXcdrlXSn4KQN/Jd3s+P5BoAljXMkUuutV+Vdn5kGPk+cJPLvRwRrEAB
	GXZ0kTJqgCfbAbzF7/I2DZfpYuu6+cP4ZHXDQCDtqoYFref5apShFiMGy2XvPUyx
	bjWxjJ3r0FnMfzqHGTsdGvjK9Ql+e12nGZrBPNn3FjTKWzkzeSs6bLOKi44jwT7A
	244J1GsxeZ//J+g+WT4qgGfuokPC+/hyJ08GdthvOUzBe+lpP/cPbDJ5AJaTfA5Z
	3kqVPMLb0rYebPocaKcZaKetv4LYylaj2Q0PqdsThBE=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Mark Brown <broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: kernel test robot <lkp@intel.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH for-6.14] spi: atmel-quadspi: Fix warning in doc-comment
Date: Mon, 3 Feb 2025 16:12:49 +0100
Message-ID: <20250203151249.79876-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738595593;VERSION=7984;MC=1580607873;ID=182239;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667064

The doc-comment for `struct atmel_qspi_pcal` had a typo in one of the
struct members' name, causing a warning with the `W=1` option.

Fixes: 5af42209a4d2 ("spi: atmel-quadspi: Add support for sama7g5 QSPI")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501311707.Ltj0qXse-lkp@intel.com/
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index abdc49d9d940..d8c9be64d006 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -235,8 +235,8 @@
 /**
  * struct atmel_qspi_pcal - Pad Calibration Clock Division
  * @pclk_rate: peripheral clock rate.
- * @pclkdiv: calibration clock division. The clock applied to the calibration
- *           cell is divided by pclkdiv + 1.
+ * @pclk_div: calibration clock division. The clock applied to the calibration
+ *           cell is divided by pclk_div + 1.
  */
 struct atmel_qspi_pcal {
 	u32 pclk_rate;
-- 
2.48.1



