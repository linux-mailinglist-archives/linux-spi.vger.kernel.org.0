Return-Path: <linux-spi+bounces-9862-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF43DB4011F
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A06D1B27701
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1232DCC05;
	Tue,  2 Sep 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJc6m8TQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164302D543D
	for <linux-spi@vger.kernel.org>; Tue,  2 Sep 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817178; cv=none; b=u8/JOfBTVc0Cb+04iZAWKA5O5PD2zuhmkjY/6cFaMoMcmN3aPGffyo7LLI0qCRsQwpcIY1FGqEqHgooWPCdcFpO6CF/2ZCdXgdcxqFtB/Fg80y9/wGtBZxumP18CDj55UHJEe+wV++hMU5KRX+w+OIaAFq1vdp+ZK5dihYx//ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817178; c=relaxed/simple;
	bh=xSF+c1quUfEBbfl25vLH7FmwBetOvWPbpnPjJk15kZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RoGdR/jbOgkOsJgw6b9lXbf0s20GviFxX4yV9qTTA7rZB/olTbBgHS7jvNsuNye9wdsvgFxR3r6jKoZ8UgSKu4U75g5ymnkPbor9rJDZAOKtC7CAmGNt0Z6MCEGPqXDD5q2clUAqXJ7hQ9MhaJ4Frlw0z0jbo5mHv1OknOBimaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJc6m8TQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1799417f8f.0
        for <linux-spi@vger.kernel.org>; Tue, 02 Sep 2025 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817172; x=1757421972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMvtg5Mq6C/ZSIJ0uJaRfjqxGAaFFsi0SLuwvNPDC3w=;
        b=zJc6m8TQ05bQPU2RlNZ8v+6oQyr3Fbe+cf4F4//H1hlMJ35KyqYVR+cXj5HkTq2fHN
         aFogATpc33m0oVEc2lOC7rvHx/2GBwP2QURgMGIDnwd0iU7h4HuuTU6BORPpKLa1VG6z
         LL0g90qAoGibeENia0UQQXVGyxaCTtjBOpzkk273srnbIq1nVCnuTl/Fbe9FCQ5tsVkf
         sNHq/NfuWbb3sv5TzUPOy6VfzkjDbWqNcHpmN1Z5mm9WD1PYM5kDOsPVOeDpAMtpVEQS
         kJ0Ucp074yAi6FgjxNH+1EZEKxMRnzlE5rrDXsYH/h0Cn9GJoPDNYCEpHsDeZuF2FmAv
         d5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817172; x=1757421972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMvtg5Mq6C/ZSIJ0uJaRfjqxGAaFFsi0SLuwvNPDC3w=;
        b=lwL8/h1QvN0ytKN+vNe7ME2OnqNfoiS0YKIpRsaXCrxvH9AvW6xpmSGv/czw7rIfDj
         UENPU8Onxeme/i0yYVWtEgAI86sDNXlOSF9Se7kyY6oKwF8dR1mQ3VNaqE2+8DNOWV4H
         TsWyrT8bj11ameSx12UtjLrd1eVFSN4BcckELLHYIUDXZsYV11W4Rilsp7HpFgXBGrWZ
         K21aXgsTNU/A9AScD5P7oGwmmUdQlHSoVgwi+a9b/qTtxU+KFv5AcSJSY6AkG1gMBHQJ
         wVEEjKCutJhRoDXVbGFAWq8B0IM6yiWk8+T+cvdywNQQJ95nCDQ3ECK5oxnjtp1Frs+u
         RH9A==
X-Gm-Message-State: AOJu0YyYva9WufHZFioT+Hj/MAtoRH1T4Tlg3438W2p5VxU7ltyHg7jN
	4kOtOXUYBWus0fTxtdtVExSx1/QjTd8BNnnHVdwIKUcKKvfWIS/jvad0rBPQue9eQXM=
X-Gm-Gg: ASbGnctrJ6Pmw0XJqw5Z7njpP5kAsAPGd9NxF59eZh47BNYrKFLu23TlB6CmCawgSsM
	G8pN4f5/KtgcSR+TIfreh9hLSZ3oJKEZ4ZJwolAl18ZDzHDE1ODLzheAZYzNNMa58+Xw/0k5C7U
	P44ft9sLbY49kV96/R5O5fztJM9tDDWmiNwXw55LCnZHHsqB2/r3WnSyqd4dKuSq0S15ya93q/W
	r3YoXlc0CdEDjNV0l099o6w6yQ0kLDlsF77zAudLHset8f3hvoCc+JOTlYpmyLhuOgCQgO7mOU1
	Xk5sZWHmHnuhFgnmWu741RoXdbI2JwqAhAi670G6Z4OfFNCpevbcdgfXnfEqrrzCKTQEartjV5G
	1ticDHF8xSwO8Y7LqEnUPGXXuCMeiNuw=
X-Google-Smtp-Source: AGHT+IHHnLIfKXefUkGxa5EfKnESKjlVPeyNiNsifBpBQEufQVD811lASeZ0fiPvah3xuHy5ugya8g==
X-Received: by 2002:a05:6000:3110:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-3d1de4bc2e1mr9092247f8f.39.1756817172368;
        Tue, 02 Sep 2025 05:46:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:58 +0100
Subject: [PATCH v6 6/7] spi: spi-fsl-dspi: Increase target mode DMA buffer
 size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-6-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

When the device is configured as a target, the host won't stop sending
data while we're draining the buffer which leads to FIFO underflows
and corruption.

Increase the DMA buffer size to the maximum words that edma can
transfer once to reduce the chance of this happening.

In host mode, the driver is able to split up a transfer into smaller
chunks so we don't need to increase the size. While in target mode, the
length of the transfer is determined by the remote host and can be
larger than whatever default buffer size we pick. Keeping the buffer
small in host mode avoids wasting memory, but allocating the largest
possible in target mode gives the lowest possible chance of dropping any
data from the host.

While we could allocate per-transfer using the exact size of the
transfer, 128K is quite a large allocation and there is a chance it
could fail due to memory fragmentation unless it's allocated once at
init time.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6bf87ef01c13..3d29285c772c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -675,7 +675,18 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->bufsize = PAGE_SIZE;
+	if (spi_controller_is_target(dspi->ctlr)) {
+		/*
+		 * In target mode we have to be ready to receive the maximum
+		 * that can possibly be transferred at once by EDMA without any
+		 * FIFO underflows.
+		 */
+		dma->bufsize = min(dma_get_max_seg_size(dma->chan_rx->device->dev),
+				   dma_get_max_seg_size(dma->chan_tx->device->dev)) *
+			       DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else {
+		dma->bufsize = PAGE_SIZE;
+	}
 
 	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
 						dma->bufsize, &dma->tx_dma_phys,

-- 
2.34.1


