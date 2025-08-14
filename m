Return-Path: <linux-spi+bounces-9418-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F69B26C0C
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26E5A019A0
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C38253F15;
	Thu, 14 Aug 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UC6ZixgO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5024BBEE
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187626; cv=none; b=Wg4I50vyPpS97e/i8JscrbjnkLipbbscG4LlsG1RzSreApYd2jcIyhMgvpxn0wwIsAtxVIbo364BqPmEdfzu1hz8yvz0qep407yOH1c6YPd1dorkN+lI6CEuTMOcGmX4mPEQke76d4l863Kt6aP3Rxr5+UsScC1FJjWbXYVoUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187626; c=relaxed/simple;
	bh=LIQFUNWTOqtolcuHkK+5pFdAZIsgYQVKYSFmavPARR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAss/qHui9Gm04fAWW53MrJ8ld8TKyQRvWAybqnqYEyOp/QtdYhxc4CQ3caNZvLnBy+GjE659ZjQ0hyTYOEle9DhTQXEco1huQ5y2QrN2CS7TiwWj8WhCPkE0SS/gXnumpjZ/VLGD+t40rgH76s1KW1NRTn4As4og+eCizVcxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UC6ZixgO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9e415a68eso610608f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187622; x=1755792422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Uvtvrck5DhEfDGyTURDlx1K5TeMVtpeGZ6H7CuQmSw=;
        b=UC6ZixgOqGpndMbxWTWe6b6053rtwQSP6FVAtHMfZXA4J+8O4tAytCkXBAKJyeB0nA
         P+H7HQ2kNCC0ZktDELHXWmb231LzqTL5DJIY7OMviT/mR60khjNdlJEK4fXcL0Dfn3+A
         Dj3yfIp+v9/kV68xFFr1wuqAu1Le3CN5hvjJZLQ4U7SKZlm6g/sl69ExuwpQMa0eXONS
         HnKz+PikUFAsjMONjp0orJzTjrTGx4Mm9wTH6Ljpi8hFApOB/fTh5RfkV18FinZU+nML
         0yHeNDtv5F0u1uj35VcFMPmm+nTIVRO21h1klh/DLUsepif2KQIx5IxpOPlJ4B0jSq9C
         y4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187622; x=1755792422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Uvtvrck5DhEfDGyTURDlx1K5TeMVtpeGZ6H7CuQmSw=;
        b=WdbazV2J0fdQ/2FC9JDtxJUm8ix5+E3ZM6ZuwjjgP2li02wn7DDSZQsQPYAC2bV/8q
         BUBah7jZ+mn/0lDpOPZcG4vtOBen7Nmqw87t3Q9NOlt5YKzC+sdBIjfgMVXaK9YS6J9+
         McNY4+3Dty7Tv9fm9ae0hJNfChDVr/6A4maVd0DNUmkqcPBGWZIjMgyGjtXY10RWFbtB
         7Cf8qC9k6jr1xrYBXWmacqV+sqEGhtloz+oyn9205trbGIs3jx0+66viJkP10j8Nai3f
         FVdnzlco1Cfn/M8sCvnwb0pxK8DXASKOigvbekcz0dZQtsIOizXSB8QOZ9EaQXV6DxTD
         zavg==
X-Forwarded-Encrypted: i=1; AJvYcCUIoC1hwy1jmFs4odHycemlVc6Hx6NitX91k2rnCmwd6sSOgAP1997M79Qlsi0QPbEcAqf+LGHaDL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0vA2H80BpWNFjW7XrFCCt1Huty1tODMMwWGNUj5xlQHTjwnW
	znjqUib9X+0Gt01kEtYRFGTwcIHz4e6xIKGepSDFBFqB5tSihLiujz6kNQoDy6Yat34=
X-Gm-Gg: ASbGncuQHvOvgvjF0Juap1AXIkJAgi5ON7RUiFqQt3ZEHATpT0uTRZqQRZzZEucIZOU
	dgNN1sweZcosYjg0km7xpBxKhG6Hicmil2i+Tljy8KTZ9LA4olkT7J2cQ4p2m4mYDiMlwNmwP/U
	GBA0jPiiv7j4PzJomtmI9V02iIbhbTJ+hsSANZf8b8A3K6IdzTuJXXWGamR5FLRg7Ch20t5c89y
	b99KqxlDzr3k98+Bd1NSGXihfgKO9bWDyS5u8O52suZANr0cpJr//4WNBgpN2fw2tmMe0cmsdxx
	fMJqi/egpIY/fH5qYIAtke/iaRuuRjIG2yJljd5Y1cLxnp/oA8rND0c5/lFoxwOj3vFIYfJ3uqG
	dxBH/SzRIXGb1EOibv1aZ4zrNpiP+qLTjuDezuh/g9g==
X-Google-Smtp-Source: AGHT+IGGBjbFKFRqiepm/LRwXnuwS+AKKH1MPA2LgWH+5Eq1mmSqrnU9CryUHU5mJcv16mc4hIWejw==
X-Received: by 2002:a05:6000:2893:b0:3b9:1d32:cf34 with SMTP id ffacd0b85a97d-3b9e415856amr2916372f8f.12.1755187622548;
        Thu, 14 Aug 2025 09:07:02 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:02 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:41 +0100
Subject: [PATCH 01/13] spi: spi-fsl-lpspi: Fix transmissions when using
 CONT
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-1-9586d7815d14@linaro.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

Commit 6a130448498c ("spi: lpspi: Fix wrong transmission when don't use
CONT") breaks transmissions when CONT is used. The TDIE interrupt should
not be disabled in all cases. If CONT is used and the TX transfer is not
yet completed yet, but the interrupt handler is called because there are
characters to be received, TDIE is replaced with FCIE. When the transfer
is finally completed, SR_TDF is set but the interrupt handler isn't
called again.

Fixes: 6a130448498c ("spi: lpspi: Fix wrong transmission when don't use CONT")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 67d4000c3cef..d44a23f7d6c1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,7 +3,7 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
-// Copyright 2018 NXP Semiconductors
+// Copyright 2018, 2023, 2025 NXP
 
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -787,7 +787,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	if (temp_SR & SR_MBF ||
 	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE | (temp_IER & IER_TDIE));
 		return IRQ_HANDLED;
 	}
 

-- 
2.34.1


