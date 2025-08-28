Return-Path: <linux-spi+bounces-9690-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90BB39954
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCBC1C21292
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3A30AD1D;
	Thu, 28 Aug 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B29OnnR/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049330ACEB
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376132; cv=none; b=qdmkEfFX6uzXenZn24Z9wN2mYboTKTM5I+QEuub/3CBxwLYlS7XSHvzd/MfZ7aZNpVmrD32NLfo9T0NTgETcQGgu8xB/k4zWfXin1/uFzchIUlNjDWzbG54ntXtK4AKKL/eYBz1ckWO7qQAB6a7NTMFWhLI7JJXUEbtJOK+0Qao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376132; c=relaxed/simple;
	bh=TykPo4FEzszkEjBWuJuKm7lmZkKFORU7dcqQiaiy+TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8ZQdJ2ZGNLeAp6Ur0ZccslEUBVSwv8xIjNDqMVwyqelD90voNpugiXeHY9cQcS01tjeh8+7j8DNIz6yi6Q1eG5wO/KBdFITMHgmPnEg39H8GAZBXmtTUpijVP3jYGuoEwF+HmFEzSco+5RsAeEDoF2tsRdxqxcyYb3gRAFcKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B29OnnR/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so6107245e9.3
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376129; x=1756980929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQ9pY7TQE3ufolQ9TVb2mjFq264G6eCq3tJESmx13zY=;
        b=B29OnnR/weDT1VEFXdSnkce5mWw0BN5KOeZbj47+KObZk9hhKfHJ4I86NNRJ0s9maT
         OhdH7hrDqBFl6gczMCKQHJm1GEIP/iHGEY3BjNR7IT9mQAXR9+bd2L6+pizgHhKFimkB
         T2RN3xrEIPcbI4twThfc26XyeUU3rvFvA+O55mKjNvimhR97GBmb//YR5L5PPHP/UBei
         uET2Lg7eq0f+HSlj78lNXxggi8ScKnboF1kwAbktwxjpXext9wzQ8Fp88kqUrmOxPla0
         SlkJocn2ShUcNQGzhhXF2BQvMcuoz7afyvfM7RK/jr5/uHkMwqQEsJZAo2ZY3/fh/woJ
         rAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376129; x=1756980929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ9pY7TQE3ufolQ9TVb2mjFq264G6eCq3tJESmx13zY=;
        b=TdJi0Q84cU9RuaQH/ka1gkHW6iRt2gqqIE6XVwNLTEPZCISgTRYyHYTA3mNKbWf1H9
         sJBpuqQZksA/jVsEW5bMg7OlkMq77p44UbGyScB2IlPRcE4A8s4Evq2kUaUsAfGe71WJ
         JMyfcr8G/WkrBFm05Ka/L5Hb08qaD+h95k0PWmPtOPO/hos/lF8l5CBY9grgPwZmS4Je
         7ougl12mrRk6FxirAJ6J0NRVpSl+JP0rcVKvg58b60S1Hrbbre8uNnSQPHYJxTBu33hn
         8AUwgcRevz/Yhdz91zCqA8McAtLZkRl6M9ruszhGIBjsII5fg8cVRmK+vJQvig6+NGVh
         XwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4sfxjdswM0Nxtv1wrla7cT3dmo4BVw9qaMIOcYL5H3CN9+OMfGblkguFLjkCC+j53X+3Azr6RV5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJDcEDmuZACEGJOXs/xj1OqUk6TlA6/hVqQaRcdJU0LLn+9K3
	NwqhfNqvHuW/18/W8NdgomLOfRK50Gjge/KJB40gNmPzGwB6GbMX2UtHNWfeaPmoB8Y=
X-Gm-Gg: ASbGncuMKpoeADSIdoeKoKNPoScnKBe6GCAMKTGLREHxnHrp7rFCi70VR2gk1pGqjS2
	q8M/9M5r1yg3k4SxVQGy5hhIjpXvyBc56eqYekkd+bncnFZx7O/FzwL/eZWdda0rh4U4UkkSXeh
	2UN/c2mg2X78CcAMFjtgJEWhWBn3zw1mwuEYqqOpVP2sj9LVG88K16AWvkXCtnaMBFO3QH9fZD5
	NQHeDgbo6orfvgBO5BANEZtisZ6TruPqhmGZxOgs5z7dLMoYKw6S2kuingmusszg/gG9ATPwg8l
	m05No8zXYOilNJ9svMRbaMOzE079wXqMUEu3J8QDtvb5f73ubNBTiLeTZ0G3b3lZzndRJacH2CS
	nkoNXqxZFZt5B2ryp5PeBGSIybbTkN7L30ze+OE9DfB2kOGOsJaFF
X-Google-Smtp-Source: AGHT+IEcoQuc6QzIvtKO6ABGbnE0SC0x96tO0hq5odZF7G8dxr0fq10f5k0rt03N5RbMj/NANFSoXg==
X-Received: by 2002:a05:600c:3b9e:b0:459:dc35:dc05 with SMTP id 5b1f17b1804b1-45b517a05e5mr203008615e9.9.1756376129159;
        Thu, 28 Aug 2025 03:15:29 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:42 +0100
Subject: [PATCH v2 3/9] spi: spi-fsl-lpspi: Reset FIFO and disable module
 on transfer abort
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-3-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

In DMA mode fsl_lpspi_reset() is always called at the end, even when the
transfer is aborted. In PIO mode aborts skip the reset leaving the FIFO
filled and the module enabled.

Fix it by always calling fsl_lpspi_reset().

Fixes: a15dc3d657fa ("spi: lpspi: Fix CLK pin becomes low before one transfer")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 5ea4a306ffa6..e50261e9a1fa 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -733,12 +733,10 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
 	ret = fsl_lpspi_wait_for_completion(controller);
-	if (ret)
-		return ret;
 
 	fsl_lpspi_reset(fsl_lpspi);
 
-	return 0;
+	return ret;
 }
 
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,

-- 
2.34.1


