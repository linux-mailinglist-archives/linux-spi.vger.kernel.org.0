Return-Path: <linux-spi+bounces-7270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C8AA6BAEE
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 13:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B83189FA68
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8C22B590;
	Fri, 21 Mar 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2GoAwZz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C36227B94;
	Fri, 21 Mar 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560885; cv=none; b=LeymHQa4cvHl7DvtTidqep+tGziFKI0aG0Wl83vhkTsyHg2NywBXrG2urPcC2uF7FCz1i53Ihu2gfF/LElbNGDJxC+r8MqiVxM+bGjYadtjW7KEzHokZnrk0HY7y5cSk9xLSv1fqCaZgOoE+tAaIZkQFzgBmaxIBpi7T+rncXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560885; c=relaxed/simple;
	bh=BG95/kpH2T2XChYHmeVEkv+OFNTEZEMhajpahTEw5MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilupazpaQlJe/LOU3HJMP/Nbflk/clMs6aJhh0trX1FTcL7EhOxHeZOYGn35UNGhtyPaOLeZFrzBzBfin3d+duDqlfDXwRZBmV1GNh+rGbcszOQsBX3A4gBZd+Gn2NaZstxOitbtOLsGquJ5bTvssryYnstgvm31l3GTokoqUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2GoAwZz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so3624477a91.0;
        Fri, 21 Mar 2025 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560883; x=1743165683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wwN9Kvr/NKHQSZ1VFBzwzCVRSebNdFa88rDFhJwVuA=;
        b=L2GoAwZzI/6AlR2ZNatpoKwrfOfuGwmi+0vNWkZcqiI21aKhQlG8OSjv8wj6nIcdNa
         XyWbYJagu8uM3waSGgHTZLLIW9zGGWl1zuPpSnRAMw7xVphqBPkyJ083bzKF9pnfMYoM
         oAaNjzhWDxjp7CtygJii2UPMb7j0KzD4eR4fezVf8c2tlW6Z+/ap3X2y2ayL1cXJYFSY
         PpuBqfcZaeE1XNO3XOHYAHrL0/6+pdvJh3rLhDaq9BrqRanQE4OlBo5dLi6QUkjDZQE2
         FvjGWFYo36s2wbBhJXjmlnlR6UzWiosr5c29kmjEOPRO3fFr8TUC8zdoPGa6vuPMAbOe
         CO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560883; x=1743165683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wwN9Kvr/NKHQSZ1VFBzwzCVRSebNdFa88rDFhJwVuA=;
        b=JdvDdyQFU4tT78/4XpKM2pf3Iud2ETCQv/8HjT0F1iV6RaAEyzEbwoQW1ZqEBd1ThP
         ZFPR9eSdH6O9roK7+1K9F9y+0KEUGX0/he96pBerpN3HqrFRu+7m1sTIOKwdBokvWvyH
         j67pesKAhaPLNrl32ciiP3vSaS3KDjjv+hRk0mpDRLBoppEjLbrABuq/PPO6M8O5K6ZD
         PsrCHwmM9NonXuyD93PqR391OTRr5zlBt7du7ROA6Ka/jMhRaG2xOmEB+kKuz1nzHo4y
         69RKjxUBVKMe6AM8bU2wUFHFT7eQtCwNKLYOdBYbbfUrhKxqBk8Iwhoj5Qzml9sS9Djd
         Ia0A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ26eqjpfGReKqZkLM0utcEtAYnW2Duw/h5nWQpc9yukZ0rLzYTH4/wChWwL/d+JwLPUzudVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8aN0ieO9r6CA7GLptsurhVTGgwIs4pjxLKZ0AD+7iY9dLCxz
	XetTw5w6Mokl5pGaUkPop6SePehEnQvnoWsHHao8RiWQcGZ7fvP7Z1gCQyQ+
X-Gm-Gg: ASbGnctPl+BEB9iAvL9K9xRu6BfTxGLBuR6slvCpcWG147tKF8CcMWIOR3OGGeT8l/i
	Ac5DuHLiFQ94+StIupt2+g8qzsO7b3DTSqyyK2YE1C5tMqf5f00HmBj5nezUur2XkdJwphui0z+
	WXzl6+M/cPNfsc3VFldFGQL+sXKuNdcaipJp+CJ4shEDCy+4CynOsvKhtS7ZqK28z1KyhRZ5Vvk
	wDHts+kM7NYdnHceYvcp59kIej82ftjJ0NZrSBTlCdhU3E1xg7qMuYMgiZEUY2VzblR16o7D+SG
	nxPZaqaKhPzTEYr14iq1u+peh5ofdAR0oFrcEZFv4PBgRnLorWxlueIz
X-Google-Smtp-Source: AGHT+IHKoofb89gkg69CyAvY7SuA69KooT8+07mHaCKF1Sl6zFIL6xNY6g4HTxlAOxSKosmFiBX+8g==
X-Received: by 2002:a17:90b:280b:b0:2ee:d824:b559 with SMTP id 98e67ed59e1d1-3030fef09b9mr4797264a91.28.1742560883477;
        Fri, 21 Mar 2025 05:41:23 -0700 (PDT)
Received: from localhost.localdomain ([147.11.105.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf635929sm6424975a91.40.2025.03.21.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:41:22 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 21 Mar 2025 20:40:22 +0800
Subject: [PATCH 2/2] spi: fsl-qspi: Explicitly unregister SPI host in
 remove()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-spi-v1-2-b9939baa64b6@gmail.com>
References: <20250321-spi-v1-0-b9939baa64b6@gmail.com>
In-Reply-To: <20250321-spi-v1-0-b9939baa64b6@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Volker Haspel <volker.haspel@linutronix.de>, 
 John Ogness <john.ogness@linutronix.de>, imx@lists.linux.dev, 
 stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2

Currently, the SPI host is registered using a managed API, which
automatically unregisters it when the device is detached from its driver.
However, this unregistration occurs after the driver's remove() callback.

Since the host is already disabled inside the remove(), any pending IO
from child devices can easily corrupt the kernel.

For example, the following steps on an imx8mq-evk board can trigger a
kernel panic:
  while true; do cat /dev/mtd0 >/dev/null; done &
  echo 30bb0000.spi >/sys/bus/platform/drivers/fsl-quadspi/unbind

To fix this, explicitly call spi_unregister_controller() in the
remove() callback. This ensures that all child devices are properly
removed before the host is disabled.

Cc: stable@vger.kernel.org
Fixes: 8fcb830a00f0 ("spi: spi-fsl-qspi: use devm_spi_register_controller")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/spi/spi-fsl-qspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index efd87f44c63a5b12b76538aa459ca8eb203b9dcd..4767d2085510c2f231476ba75e46f83271c4c645 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -272,6 +272,7 @@ struct fsl_qspi {
 	struct device *dev;
 	int selected;
 	u32 memmap_phy;
+	struct spi_controller *host;
 };
 
 static inline int needs_swap_endian(struct fsl_qspi *q)
@@ -862,6 +863,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	q = spi_controller_get_devdata(ctlr);
 	q->dev = dev;
+	q->host = ctlr;
 	q->devtype_data = of_device_get_match_data(dev);
 	if (!q->devtype_data) {
 		ret = -ENODEV;
@@ -934,7 +936,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
@@ -957,6 +959,8 @@ static void fsl_qspi_remove(struct platform_device *pdev)
 {
 	struct fsl_qspi *q = platform_get_drvdata(pdev);
 
+	spi_unregister_controller(q->host);
+
 	/* disable the hardware */
 	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
 	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);

-- 
2.48.1


