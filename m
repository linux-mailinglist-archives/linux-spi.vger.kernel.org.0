Return-Path: <linux-spi+bounces-9199-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415EAB13ADF
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 14:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28F43B2A49
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711725CC70;
	Mon, 28 Jul 2025 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkHaMedu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5E2222A3;
	Mon, 28 Jul 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707559; cv=none; b=tBCrfusLITg/CQcL+vARE5+gq/sIWh90Llaia2tJZEi/zftKs6MQkOXLPb2/w/ysISRfElzRCcgFdU6CsbuuFvwYhgM+SsWdDk/rw6fVTw1UFGGD0J4d5HvK8bvfExmya/c/VU0ru4GhEMENjGa8XQTRYWs3ARIOfe7ZAXxa4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707559; c=relaxed/simple;
	bh=IhmHfcSsqvi4XakQ4sYwxkmbwY7HX0R7FkhypdAtOrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzZwaPPq79uT13obV8PwJ/ue8SJKnaOmt7k0Sz3dbl8OzIEphS/UScnT8reWsiUVm6xXTZ47YaTUoHvKq5HS4JxpKUG457wgkak7enfM3eJX4L6qEgbh6BiRZvlWlYXeBv/6tQkeu/XP/d/QWqZpiMWO1ulUCbuYJzqgiea20l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkHaMedu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748d982e97cso3947629b3a.1;
        Mon, 28 Jul 2025 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753707556; x=1754312356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhAzjK5FT+CciFxLwNthNR1VR+Fzupqi6PO9KjFf0r0=;
        b=BkHaMedu9PWg/72u2ouC51DUv03UQqki8V6/omOur7ehmVug2Csx+EBEEuQr4zYlNU
         0johkAOXNG86mBN0Q0Xb2mB8rVItx1Fr/J0iHlUarfdhxP6+sZu7uvI74V8pmyuk1U2W
         QCig81FvCz7IQDLhB05/69+PREG9Z061aodzS0bLw535cVtgixsphHi3CFkJFfEa0IBt
         Njw3EGfBuaON8PpPZi37CKoPs5/Xnr2ynXseOnsfkCGRO5gQOHfToPFDOpa5I4N+wXMV
         PHSNaA/2LvqHRGIuQmYjrZGDYSq2lNS/AyLEzSBhwDleVEXtoaVEUkYHMDusAF0sssWq
         0Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753707556; x=1754312356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhAzjK5FT+CciFxLwNthNR1VR+Fzupqi6PO9KjFf0r0=;
        b=o1Xgv7ihsitOaK7RW04bPGMzKskXSQofWTZArJs4FihtXMyWoKwPewjX9NASDnqAlb
         omu26HK4yJUjsJKN3k4xhomPMfiKIlBItB6TE30GFP9HPeFA2714aom3BWxAEUW0dGSk
         lf0UIkUooY6NMrjBLsc0BxVbctm9rDhGX+X7D56VsnQCi1tmZ23ZoLAJ0OVJ3ThBPwDp
         +fIu56SVJc576mNZZWY5OJFLiUPoSv5bZvEe0Qzw1tT9lsz5SBbnsiIcLIALY36gCnwg
         1arV1RTJRkpV+azvE9uutzVPGdpSk2L4YadUt2lTH78Z+WOTYNYaQIvGMXvX/pUxQJiT
         eLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Rj+wrbKmD8Va3gfihMXaSuyvQ+MdBZSjoptst0gCZZsMQsTW8KRVuS22sfDV8oFc/1W94WawsoRr@vger.kernel.org, AJvYcCUS6nnvzPNyHvH809gvZ0hxFFGf+Uf57UxV74YX1dt7GbQJS48lmmNi4mQDFQNSbFruQkfLTV6HL7P+qaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfiiUxNDoBAQT2xAGiTc0hmMUmLJ3hpX4UgcYzBIyAloCnJMJ
	JHdv6BYu8rt5zmd5F1tHEI5BViPpnMPkKA0D+HNV3CU9xaXainhRLagc
X-Gm-Gg: ASbGncv/ojZLNA0TuAP7CjD9SksSt/Y8hZHSSMiT9CxDStADGltd0hnj1HOTX2LHHo3
	R/PWKmTfEphHzllu11UJ2wjjhJ/FNnXKx2eJLuAd8GG18K/jplpwj+/QdS3JT7yQ88XZPBS8uwS
	a3kcf0BpqE1dsFaMh2X/3NGRPULZ7LCYXf/PCh/EF4NTxQvT8dNVcfUN1FupJ6ErVWnT9XF06xA
	a66DcyLtHEIbk0uGluFvv5T+tL73ZR60uhAwRAGs36W2MmNG6jYD94E3L0ZiS5q+YPcVitYZztm
	/YcxP0NSeBEAlTg4bB9b+hsKFAg5lx7hElp6PecowQQLGvE1x9ZItxxfZsSycxf0m5jNPeHt07s
	jygFifLZcMV3oEEFB3a9RVf70PIKTuIi9B/hexTtBwNu22P2msfk3QdpRzTRRKsvaZgo8v+EU2U
	HoicYfwNPR175HdqBg
X-Google-Smtp-Source: AGHT+IGENH4RfeEDFn/IoEogrzWjFEeRAzJl6HlR7BypR5NTpHuCAK3gs/JhKuMwkxq3MC0ECTtFDQ==
X-Received: by 2002:a05:6a20:a126:b0:232:fcfc:7209 with SMTP id adf61e73a8af0-23d701a89d9mr19624271637.35.1753707556461;
        Mon, 28 Jul 2025 05:59:16 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([122.162.223.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640863513bsm5589392b3a.8.2025.07.28.05.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:59:15 -0700 (PDT)
From: "Darshan R." <rathod.darshan.0896@gmail.com>
To: lhjeff911@gmail.com
Cc: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Darshan R." <rathod.darshan.0896@gmail.com>
Subject: [PATCH] spi: sunplus: sp7021: Clean up coding style
Date: Mon, 28 Jul 2025 12:41:04 +0000
Message-ID: <20250728124104.6370-1-rathod.darshan.0896@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tidies up minor coding style deviations within the Sunplus SP7021 SPI driver, ensuring closer adherence to established kernel coding guidelines.

Specifically, it addresses:
- Correction of a whitespace inconsistency before a comma in `writel()` calls.
- Alignment of function parameter indentation for `struct spi_transfer *xfer` in `sp7021_spi_host_transfer_one()` and `sp7021_spi_target_transfer_one()`.

While purely cosmetic, these adjustments contribute to improved code readability and maintainability, making future development and review easier.

Signed-off-by: Darshan R. <rathod.darshan.0896@gmail.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index 7fd4cc6f74c2..256ae07db6be 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -103,7 +103,7 @@ static irqreturn_t sp7021_spi_target_irq(int irq, void *dev)
 
 	data_status = readl(pspim->s_base + SP7021_DATA_RDY_REG);
 	data_status |= SP7021_SLAVE_CLR_INT;
-	writel(data_status , pspim->s_base + SP7021_DATA_RDY_REG);
+	writel(data_status, pspim->s_base + SP7021_DATA_RDY_REG);
 	complete(&pspim->target_isr);
 	return IRQ_HANDLED;
 }
@@ -296,7 +296,7 @@ static void sp7021_spi_setup_clk(struct spi_controller *ctlr, struct spi_transfe
 }
 
 static int sp7021_spi_host_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
-				       struct spi_transfer *xfer)
+					struct spi_transfer *xfer)
 {
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 	unsigned long timeout = msecs_to_jiffies(1000);
@@ -360,7 +360,7 @@ static int sp7021_spi_host_transfer_one(struct spi_controller *ctlr, struct spi_
 }
 
 static int sp7021_spi_target_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
-				       struct spi_transfer *xfer)
+					  struct spi_transfer *xfer)
 {
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
 	struct device *dev = pspim->dev;
-- 
2.43.0


