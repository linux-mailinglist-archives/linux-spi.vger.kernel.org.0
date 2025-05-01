Return-Path: <linux-spi+bounces-7815-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E433AA6059
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B31466B47
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E01A08B8;
	Thu,  1 May 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhQuQnuS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427E1FBC8C
	for <linux-spi@vger.kernel.org>; Thu,  1 May 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111732; cv=none; b=AXR18LhK+XGZM3+e/n0nR5FnigWjq7LTq9ME3PQ1ngP/ML9d26EJOFnLxnNd3GLAQvx93hf0DXvuQUylwhr4OUiz/USeBOO+lkoEu28FwEITTDaXq4zsl52G0iPfNcXjqOdVllHDqf4TcATlwLk63vn221H57nyT0fYQTh1J6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111732; c=relaxed/simple;
	bh=4rkQ3Dw/vam/Vj+imyvV8Y9YuqnRhg19j57rXz0G09I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ki0a+A9vYNTlv3yznofV7lh7Pt+gCTip7UMrI5TEIqvNhseYxnOrg/NTSEpPChl2UB7HaSw29ag/Uvb7oES0c9xJXtrejXTvXpf8erF3xbFUNz0ibSENgQvDBjp7Ljyh0TJ5oT267NT0cl7iYdo5Ygax8mJnOzpDriFO9Y3nCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bhQuQnuS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43e9ccaa1ebso1340515e9.1
        for <linux-spi@vger.kernel.org>; Thu, 01 May 2025 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746111729; x=1746716529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CQO3BwoDKAYLGKeUQMSLddVF7xiAI/qGk80JN0kw5s=;
        b=bhQuQnuSqYFE2XUWxRak+3tLVQ7hEzFTAMuDMVYSPSBszvJOexq/WKAjt6G7FLmIf6
         hEW4RT7fTobFodsH93x5uILIjraALQZnD4cdK9v6GVXBGZa3RmjnwJGHDDzc4sn5XKYA
         xFPPx3SWRRXoOUWlVdSwD2ZlhNTRuTpYDUHz3FyU1iJQG5u7u3C2DPTqf92an0u1L2Z9
         MSZ27hUosr3RdD7wYpJXJ5qmV7lq1Pqmcu52ZGleL0wU8Q4wLsQPx3Ihhtt5utf+yWLA
         JnX+4JCWMIoHy80S1X6z3MPMtK1i2v9dBS/bUD3edA7Vl8tqOCL1pjKHF4ppTyRZAfgh
         TNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746111729; x=1746716529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CQO3BwoDKAYLGKeUQMSLddVF7xiAI/qGk80JN0kw5s=;
        b=NAatsKS2nEYUaZVczkiwnylJQwbTkosWTU0zH6i4gK89ZyUBD1jeZ3lBqBKTVOOf1k
         QHmHjT5O2t0Idwe4kEvbpSlLl5o683Ws6TUZFTtxAQk2VZvqpndSJJDvHuMngaadrkxW
         4sHEUAyoCQFfNQiBN3rhGLJPmR5jgRxIboP+t2TpBxbbpYs10GT1VB1Ib91YNnydlGCd
         92xmOvS5JVMURQlX0NApjnY+MCKOVJLctErh1+vnkX0QnB8yBadPmWCBBQ4TU3VUCz2N
         GK7/RoZ92QVRl5HWJcxsWqDpSgnQiIjo0uPr2Y+VdpXfaiRnByo+eOIGWwhUScS5qF7s
         JqKA==
X-Gm-Message-State: AOJu0Yw4uJJVncfdi/Yj0vhc7+O/bODcRwUwioFqm2OizpoNxilg6VEs
	7uTuc+dzcTEW2aW7Dnp3LFxu8rpbzRYqW1d+KNf/5I2QrddO5DoG3SNyEHYhnPU=
X-Gm-Gg: ASbGncvBap7pBn1OnVpf9qUISi9Mc/tukXIpDHz31aIdNm7vQYzGiSWYj/8CxA+uCqo
	mUys9X+IACkB9YXcKoh+itWNFysB5PUtEwNDhWSakyD7rZm/k3Q9LVinmkUyDx7QlDcKxhJ8wH4
	35MqXtEwXsRfvMqTJaqW9uP6FrYdXspjfanMPlkqqUjUbg0BEAHuLIM0Pu8xk5t0wGmJnE5X2xA
	P75EIawjK0ZTO3Yli/YPfPeaT3owMxk/mvhx/j5kC5yJegC1YO6QoyFC4bnlPq3+zFVIxwpPke+
	IEuRiLGAuxvoGBsm+ZxX3wlkapVtc2Q1aYRbX8XPPjD4Aq+gQBjH4IjhJGA=
X-Google-Smtp-Source: AGHT+IE4vTsyhTKjuwrkxiEbVaqWLWprrAFI6LPkc5oJ6Tw5j0urpY7Zf4f4AAtn0dsslPS8UEL2JQ==
X-Received: by 2002:a5d:59af:0:b0:391:3110:dff5 with SMTP id ffacd0b85a97d-3a09404c7a7mr791880f8f.5.1746111729092;
        Thu, 01 May 2025 08:02:09 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a4702csm1033190f8f.40.2025.05.01.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 08:02:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 01 May 2025 17:01:59 +0200
Subject: [PATCH v2 1/3] spi: atmel-quadspi: Fix printed error code during
 DMA setup
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-n-smatch-fixes-v2-1-d2ad9c1f2e67@linaro.org>
References: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
In-Reply-To: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
To: Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4rkQ3Dw/vam/Vj+imyvV8Y9YuqnRhg19j57rXz0G09I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE4zpE4sh6HCX0YHtu8ifWSZYIijtzq3yBuTF0
 rzZi40A/NKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOM6QAKCRDBN2bmhouD
 17ByD/9kTC3n6CgO/RKnoXTfVLW/0Pek2pCNI0Uowbck7+kCs7+0VPQ42qPkHHI4T6iWorNe0Qu
 GhENCHnyqd3A2bm6kqChnDRxzS4e7Ahct2c31seIg2nLHs5HmusHPNwSC8HTnzrT/N3kFvotDsj
 V01lG8bCbJ8qh5PSHAqTJFHMUAVq5zdJ0mKvnMISjajAEMTVvNcNRcQAl0Q5wBllqaKNflYn47O
 h6f37rS32zOxHljsIuMOo99la3c72iTkFCLSOc6a1N6fRYxAPH2ze13O24+vDphIwPEndOLRFyT
 adnFoGHyzgqEFu8ULVxDCIPLR+ZHmPNZtvOaE0XsFluaUcGhTKqKtYhQcf586SsGBKqz5u2mRxg
 vO40HXN1p6lX+XZTB5bO43/DN9UcC0eXoz+bp1nlTiJIqN9vLh1fQ6zhPvZi9axRBc5Qma/RVeQ
 W5S0gjuVVVUiVB35Prck8VDSNAIn7RApJikZCESHlqVV2JIMgtrGPQLmq9MEcjdcOlOux3H5cQN
 Xr7swRKIyavFwNYjvAQtV+KfJwU38RDFDSPSa9XMSsYxRMd0CcJG6Ai+EL7oFi4PX5oT0yxnMM+
 Z3GldcMCrtpxCa9IsLBZfEjp1k/MXtXtVVIS5RaUZ5j6M/50awIM3PLEocmTM9lwoKQAuEy2RAR
 EWKOBKuTGJOR/FQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

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
index 244ac010686298c58427fadc0ebfff5e62d18880..fc36751763887cc14bc71e2f398a25e56e9c5e42 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1287,9 +1287,9 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
 
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
@@ -1310,8 +1310,9 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
 
 release_rx_chan:
 	dma_release_channel(aq->rx_chan);
-	aq->rx_chan = NULL;
 	aq->tx_chan = NULL;
+null_rx_chan:
+	aq->rx_chan = NULL;
 	return ret;
 }
 

-- 
2.45.2


