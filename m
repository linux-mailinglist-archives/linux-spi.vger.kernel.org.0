Return-Path: <linux-spi+bounces-6218-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C35A016D9
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 21:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAA03A3F6A
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9FB1D61A7;
	Sat,  4 Jan 2025 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpKWDkAi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B81D5CE3
	for <linux-spi@vger.kernel.org>; Sat,  4 Jan 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736024087; cv=none; b=G7uQx4Y0VqmsTw9FHzBz9i98YDevriDsAGWN1lX0L139PID+8n5pS4Ipeqv5f4rRy9aGUPpD9UNQcRFFRYNF40gM61orrlSDfesRZG3v2VUdQLoR6A4GtwA/3Nhm0h17+fTashRpIEhkjRQkP203oq2LZxZrxGt6+iAw3qvueDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736024087; c=relaxed/simple;
	bh=0pluUhxj+qHekDTaDHHUWfvMX4R8WWXSMErhdppVD4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4zZsCkpilS16rVb3jko4gEiyTcu6zFBIWjcSgzOkR3WFTy2BeyA4lsftkfXBLLrjv4VFxPUxysTEyQ9KJ9waPqdDcRrIbXte1QtS5vQg/GQh+xOoGSEVPj0l1gpbp43fkbujrjGSSZUHQGPH8c7p+NPIU87GKqZt+lB47bJ7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IpKWDkAi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa680fafb3eso164448266b.3
        for <linux-spi@vger.kernel.org>; Sat, 04 Jan 2025 12:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736024084; x=1736628884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLKX/DDFIRPvx5t6DaUjc92tk+3Aa7daTr762N5Ifkc=;
        b=IpKWDkAiY/Ttys+LjWLoxLoHZDs+pi3cu980+RD7Xi7kdylySfQRse2ik28rGbBCut
         wcIgmbbWU4pPHlHpYtGwTOBfgpgUo927OxMNebTOEJJYm0/JCBICliRZiRylZawj4c+k
         TYQ9Z8pTgn23p/mhZAip2AyGuPOSO5n6qWiD05YVgCyuX9/Cnu7JBxy31Gc9GoLSO7ez
         QyfLeJKYv2h3GnrWFHmav/NWnl8SP3zCipd5KTPwLU7NaX9vQeYRWcyoJ4HrL4GeuyUJ
         bMDbRyjnFzVNEqL16q1Dn1Bh4z98C/9mHvrFhwgcgZTIan+r9j0jq7pXsVrnkhVSpyiT
         fUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736024084; x=1736628884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLKX/DDFIRPvx5t6DaUjc92tk+3Aa7daTr762N5Ifkc=;
        b=WBo42p4tDv+kz3qRTAzQeEHPr1/FDUr4ZiOaKieCh5eNZlDy6AtzkAT/L5UvnuHBbr
         ibGLTulyTMUw4PZSR9i02MzFHVNVHSbW3kvpBA/N150bIqfMV0K3c/r1eXsFYHjOpFSd
         a4S9desT1o/qEF5UtmBMJnkFLEs1WRgPpZONOT7e3gk5D+rJsv/C1eLRccDiURXFIo9r
         oP5e5J/dZoePcojzXYtD5EvcQFiAO8X7bemOlewmipplBhxbUt0eFGH+jeqfvwCUCb7G
         RFyuiGS+JfN+KUGFnoFfo4bdkCu8GbbeOg3XsGFknDLBHPHITUwUPzBQa3ivYvjb6UnQ
         5/+g==
X-Forwarded-Encrypted: i=1; AJvYcCWISB+sJ4qX2ND8md9SdsZ6uOuY7QpX/ckEB/NjUSBjzKbkiEKTt4aPzwK9O3bcsRzKRlVo5R7wpPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPCEDD1HahTKiT700yz6vGrDa2vj2SQ19qwK1qKpNmszVRXZ0
	zrW8hhUKUmhKASKjM8oFQLBZbYyoLLfiT5Z+sfFgSWN0LCwWO1DXeu1DSkbRzPE=
X-Gm-Gg: ASbGncsRmKfLoaPCsAHTRGMe805Mtf1vwL2fmMdb4ybvCr5UJFLRTYrYCeO218fT6y8
	yRJ/Fxa7oLILAVZm+tK+JdwYD+G8CUaZkiMesOAf/f7+XkfW9V+1X7fJ1ll1zTOBAih+sIhxEuJ
	d7RdoG6o2Q5IJbDWsXPoXT6CHf0px/pA+S7huBhLsPXrPtuO1Z9RBBZfxjkD3p7ctrJbOZX8rmE
	sS3nIhDCCwexJnGGPdpiO8zWNEFf4dK7WE17RTiAvkpNLJKrmZDaBYpmzk5j/sGhrXSwec=
X-Google-Smtp-Source: AGHT+IFmkhn29wqYEMmrNGScq5CXWT6m6SapSyW0XiDfeMVUzsZXK4EWiuoixIVsOEwexnWV5pkkww==
X-Received: by 2002:a17:907:6d1f:b0:aa5:a60:ad6a with SMTP id a640c23a62f3a-aac2d4472c8mr1834711266b.8.1736024083242;
        Sat, 04 Jan 2025 12:54:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaf4a841749sm839666666b.137.2025.01.04.12.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 12:54:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] spi: atmel-quadspi: Fix printed error code during DMA setup
Date: Sat,  4 Jan 2025 21:54:35 +0100
Message-ID: <20250104205437.184782-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
References: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On dma_request_chan() failure driver NULL-ifies the 'rx_chan' and
immediately uses it as PTR_ERR() so dev_err_probe() prints incorrect
error code.  Rework the code so proper error code will be printed and
NULL-ifying of 'rx_chan' will happen in common error handling block
(failure of DMA setup is not fatal for the driver and further code
depends on 'rx_chan' being non-NULL for DMA operations).

Reported by Smatch:
  drivers/spi/atmel-quadspi.c:1287 atmel_qspi_dma_init() warn: passing zero to 'PTR_ERR'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/atmel-quadspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d135cca4e454..057bc20a74ce 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1283,9 +1283,9 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
 
 	aq->rx_chan = dma_request_chan(&aq->pdev->dev, "rx");
 	if (IS_ERR(aq->rx_chan)) {
-		aq->rx_chan = NULL;
-		return dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->rx_chan),
-				     "RX DMA channel is not available\n");
+		ret = dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->rx_chan),
+				    "RX DMA channel is not available\n");
+		goto null_rx_chan;
 	}
 
 	aq->tx_chan = dma_request_chan(&aq->pdev->dev, "tx");
@@ -1306,8 +1306,9 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
 
 release_rx_chan:
 	dma_release_channel(aq->rx_chan);
-	aq->rx_chan = NULL;
 	aq->tx_chan = NULL;
+null_rx_chan:
+	aq->rx_chan = NULL;
 	return ret;
 }
 
-- 
2.43.0


