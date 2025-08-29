Return-Path: <linux-spi+bounces-9771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA72B3BA2A
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073C67C3FF4
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBBF314B65;
	Fri, 29 Aug 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGZtQzCu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF89314A78
	for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468052; cv=none; b=XKBeZ9GCQXxeJtInPW2NkJFkfrkHctjKkYhgTT76+Qubq1un1fQR8w7XnzINc9A0/zIzaY0PCcOSLkCpwodMGLea1uNslF90GpxuqSziqHvmRsZeyZ9F5lfjCPawqhT84OayY2cdLqe9R3uAKfgZvWeQlhwTXJodEmLi0AB3vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468052; c=relaxed/simple;
	bh=ntK5L5T/QM76W3rTDaszRT95k+dCoyl1H2FWmC7FW6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJFn3eHVV/Zdj8lDWvBLrMm8FMxdY2v/sLBh3wV90nBm8WPVaWbYmKeF7ghkVYF7F4XRWhblmAdX45j7UtxYd4RD95mdBUC76X5/GzvhOzAMT85kJs3zLNCAe3ckoLTXDu43cYyclaykkmqE7EKswXEP70pF4moBLNvwjbQtVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGZtQzCu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c98b309804so1217845f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756468047; x=1757072847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKPM1NaI+rLr+WfS0ckt9fLMpS/+n3/5mziB0NSyT44=;
        b=rGZtQzCuNgt1J9rNRUNom0KzBMSiDWRMSlhOfJGprrDykRxqMyuEXRd7DaAgLgRF3g
         EPvutMa/W1ByNKRPT19+8hZoB977AZKV2pi+efmc2G0MZ0WSckUwYdh9wsAvXuIO9+iO
         RKjA0wCeyqa1eAYQ6wdYoGGdGGIOL2kk0sJUwi/qDsfGQXRJD7oG2kL7jq/3imyNDF3H
         vP9kVBBaUDiJZn5EfzL31kpcmVXCdf4oacpAWh8dyrHLsQ0LlQXT3CjcBsXqGE41ZhgU
         NkoEgtqpT7vvpaXRoMWwmVzHkrP0Vq7+mK9kdCAhKCHy/tIsbDZ4IpuEd4ENq6MpM2bQ
         iGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468047; x=1757072847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKPM1NaI+rLr+WfS0ckt9fLMpS/+n3/5mziB0NSyT44=;
        b=VCm4LU89mPkuBQnX7ep7uodWtRZvbkWbAu5Cza4pDM8PhTMBmPGc6daEl8I6VtFBKk
         fVYZcp9NbKVjt2ZF64fZwNnRZg6qHoSqsFbh25HcfqM755J9jJkboj+6zspviCme6CaK
         DYOFgxgHt3hdy3WEGeICDuv5slgkUij40wg5NopyRetO/gbEiNoTmfiJrsl5asePr9L7
         KvFqu7RwKu+hP0/bUmSWdC+/aCAfMABKcEjv1G2IlJQ+lj61ywlTCQ27kk9X8Y371hsQ
         OX/qv/lwRXBxJeGXijhRTxuC/E7ZU+U1OMOjFjY7TgcrMxZLP7cQQ6xIQjOF4U02eXz2
         QY+g==
X-Gm-Message-State: AOJu0Ywxcs79rKtJeTzco1nWDEC2ZS4rhMxCMsYjZC2OiFJFpgZktq/t
	2eV1uk6/nF8nUJqRyYGDQwUMZBNogP48p+Ll87Wu0p5Q+L5sgog9/RFfCPd8WhVl+o4=
X-Gm-Gg: ASbGncsbM9kSMcSP0l/9LEgqbghkprDqF0NuwnOHu1WEeyIOz/isHU34IcSe4d6aqjO
	gW7kk3MvmBuBrSbjHiE8fiz4Nkpm8qiXDhuyIESH8BmjtFyAWzdK1vyMdTeh37s3G7LMg3i23VN
	LcElfUfQHbZZK4x06hxUtLZ4CwkMY2FHG2XRU9PDh4Ftsp74XBKSs0OGeZ5+63svJS0VlDFLyLx
	wBrBJ/LPAElxAHU0J7opvzEtvdshev16z7N/pcJ69GBnd77gnxzHfe6pReU1hehz18260QUL2qA
	jyxNpeGlLJLKKYTfg/MSgieuzd0fH1m5c40Yp5v99ZfVnNZC6USU0K36AnPGf62TlNl2yTQ1EA/
	+VLA1XQ6VuBHUTles535N8SvrrkElUA1ltkFoj2Y6XQ==
X-Google-Smtp-Source: AGHT+IHv+Gaestx0qRxtBdc4nmSi3ic1F/o/Ny/4cEGuBY1B1TJaPYSMMe0sdfWbsW9bjcLeH/F+Ow==
X-Received: by 2002:a05:6000:290f:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-3d0b3ccc6bdmr1514886f8f.39.1756468047268;
        Fri, 29 Aug 2025 04:47:27 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm29873255e9.9.2025.08.29.04.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:47:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 29 Aug 2025 12:46:45 +0100
Subject: [PATCH v5 3/7] spi: spi-fsl-dspi: Stub out DMA functions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-james-nxp-spi-dma-v5-3-3246957a6ea9@linaro.org>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
In-Reply-To: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This will allow the build to succeed with !CONFIG_DMA_ENGINE, either due
to a randconfig build test or when the target only uses one of the
non-DMA transfer modes which this driver supports.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 48054932d517..0baf7e0608f2 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -373,6 +373,8 @@ struct fsl_dspi {
 	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
 };
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static bool is_s32g_dspi(struct fsl_dspi *data)
 {
 	return data->devtype_data == &devtype_data[S32G] ||
@@ -468,6 +470,16 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 	return txdata;
 }
 
+/* Push one word to the RX buffer from the POPR register (RX FIFO) */
+static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
+{
+	if (!dspi->rx)
+		return;
+	dspi->dev_to_host(dspi, rxdata);
+}
+
+#if IS_ENABLED(CONFIG_DMA_ENGINE)
+
 /* Prepare one TX FIFO entry (txdata plus cmd) */
 static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
@@ -481,14 +493,6 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
-/* Push one word to the RX buffer from the POPR register (RX FIFO) */
-static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
-{
-	if (!dspi->rx)
-		return;
-	dspi->dev_to_host(dspi, rxdata);
-}
-
 static void dspi_tx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
@@ -589,8 +593,6 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	return 0;
 }
 
-static void dspi_setup_accel(struct fsl_dspi *dspi);
-
 static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
@@ -722,6 +724,18 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 		dma_release_channel(dma->chan_rx);
 	}
 }
+#else
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
+{
+	dspi->cur_msg->status = -EINVAL;
+}
+static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
+{
+	dev_err(&dspi->pdev->dev, "DMA support not enabled in kernel\n");
+	return -EINVAL;
+}
+static void dspi_release_dma(struct fsl_dspi *dspi) {}
+#endif
 
 static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 			   unsigned long clkrate, bool mtf_enabled)

-- 
2.34.1


