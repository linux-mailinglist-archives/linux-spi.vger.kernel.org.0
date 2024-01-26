Return-Path: <linux-spi+bounces-886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12383E46C
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 23:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498D6B21654
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38200250F4;
	Fri, 26 Jan 2024 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="snbozogO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467524B35
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306453; cv=none; b=QTbwgVSD41/TxzdYhxtL7UhG1cl8nFY8Y4/E20v7qInGkfCgCpfFa3Lk3KurCtK8X8kzZVz4VWabwJfUv4huaxvq6p+x6deAx4d2aWgIamUWx+QvhKRUlNX4b+rD6WArEJFcBBE1UFMgcVgrL/TiGfWJrdtgUJMQaoBjvoiNxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306453; c=relaxed/simple;
	bh=8iVWfiw5eGV7Bx9wkZhDmrGmQZhW2iSHwJ8sKYhM5rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufwiK+5awpZmEdcBls1idj4YNkOqUlUegb+ba1ffEEfRC+8cUZi3Wp0FTlcClTeUiP3Rgn5n5Intu2vuOXYGlGrMBkMCiiQJFkRkD04ridYPJpxIFedX/hLdHYOLVB/il5+nSosrXXDVdUklRWtrYTBHjmeYLNVMWC5FhZWS0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=snbozogO; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-20757468411so541448fac.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 14:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706306448; x=1706911248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6vULbTr1BYFyRU2Eitly8jsoFUEcFQOPUSNj1txhFw=;
        b=snbozogOjAdRWxy7wfrcjz+3EizXX9fVz8RMpFcZgydcSDjpL2+btBbGkJw3Grkt8h
         MxrrpkxECYS3Is5KT9mFxFVq/btpNk8apdXfFq8ILt0F1gQUpIDgogw8FQQzsV5uC0cW
         w1y2cy44DVGO2KAnK17tFT5tdNfDGhSpDmcyGf61WVQBMyq+kQzVXjqM3WnfY69aF2ac
         AZx7i1N+lwK9dhSmSrUDcZ5LkgX8c+NAbjFcVhNb8f6y8s4uWQaWwoxOnonOLGXs9Q3a
         Q6DSmzThw9GjcEJD/+UtoELsJ1kgTTTGZo1XOcojUsRELpcEG1BVPwoEIh/SgMmdPZKP
         e6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306448; x=1706911248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6vULbTr1BYFyRU2Eitly8jsoFUEcFQOPUSNj1txhFw=;
        b=MN2oO3++SsQt61AiNGDLwg2ik4xNarT0bkWV3Tas5ehxKknxk/SfwLHk0FHiJoZHtW
         nFEASJcK7jles5xXK8Op3Wli0vHa9KShYol3ZmMIWWeUkj40U7U0g+2a/8RvedVb674Z
         dd7jb9rHQqTiS14xeeWRKJF7RoAiWZFjY/zpwU8PfoncnVw6Ex2/Y6RyQxSsYXiXKMgF
         Ud+FuFWuLjfo/qyiXG5ljW7/7lOG0eEojt3BPHUCRBvqhs8fu+lYkhsVgvaX2QmremYV
         FFe7OcxD6iSLXq7Biy7yiNGz44WISS3Lejo+ri2y29ZKxB1l/Y67wES4AsGxFJOBGFvA
         8Asw==
X-Gm-Message-State: AOJu0YyskdzrpC/ZJ6OOtcbmnKUJNUfjcTNYtd7+ffxoiPlDPTwgLpVx
	0//kPt1wpGv+GKq/gt8N9CXDtack9akPzia9TVw8sa2dv/DA61oTmd0sQPQ69Us=
X-Google-Smtp-Source: AGHT+IGcq+1ADS2rAnXRcLEEACRnfZ/hVeWGGAnVVnNZFAY+ZYLNpH+TT4tDmT/PykMiZckVin9ZBg==
X-Received: by 2002:a05:6870:d152:b0:214:816f:8b5a with SMTP id f18-20020a056870d15200b00214816f8b5amr379651oac.12.1706306448699;
        Fri, 26 Jan 2024 14:00:48 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id p26-20020a9d695a000000b006dc87c016e4sm426399oto.60.2024.01.26.14.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:00:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-spi@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm2835: implement ctlr->max_transfer_size
Date: Fri, 26 Jan 2024 16:00:23 -0600
Message-ID: <20240126220024.3926403-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core SPI code will handle splitting transfers if needed as long
as ctlr->max_transfer_size is implemented. It does this in
__spi_pump_transfer_message() immediately before calling
ctlr->prepare_message. So effectively, this change does not
alter the behavior of the driver.

Also, several peripheral drivers make use of spi_max_transfer_size(),
so this should improve compatibility with those drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-bcm2835.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e709887eb2a9..e1b9b1235787 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1117,19 +1117,6 @@ static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 	struct spi_device *spi = msg->spi;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
-	int ret;
-
-	if (ctlr->can_dma) {
-		/*
-		 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by
-		 * the SPI HW due to DLEN. Split up transfers (32-bit FIFO
-		 * aligned) if the limit is exceeded.
-		 */
-		ret = spi_split_transfers_maxsize(ctlr, msg, 65532,
-						  GFP_KERNEL | GFP_DMA);
-		if (ret)
-			return ret;
-	}
 
 	/*
 	 * Set up clock polarity before spi_transfer_one_message() asserts
@@ -1219,6 +1206,19 @@ static int bcm2835_spi_setup_dma(struct spi_controller *ctlr,
 	return 0;
 }
 
+static size_t bcm2835_spi_max_transfer_size(struct spi_device *spi)
+{
+	/*
+	 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by
+	 * the SPI HW due to DLEN. Split up transfers (32-bit FIFO
+	 * aligned) if the limit is exceeded.
+	 */
+	if (spi->controller->can_dma)
+		return 65532;
+
+	return SIZE_MAX;
+}
+
 static int bcm2835_spi_setup(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
@@ -1348,6 +1348,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = BCM2835_SPI_MODE_BITS;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->num_chipselect = 3;
+	ctlr->max_transfer_size = bcm2835_spi_max_transfer_size;
 	ctlr->setup = bcm2835_spi_setup;
 	ctlr->cleanup = bcm2835_spi_cleanup;
 	ctlr->transfer_one = bcm2835_spi_transfer_one;
-- 
2.43.0


