Return-Path: <linux-spi+bounces-8019-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845CAB119A
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FA9A0444A
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F186E290DAB;
	Fri,  9 May 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tADtBuj2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E6290BB6
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788827; cv=none; b=iCGVqyOiPoXS84vIbBm8iZOgSkqXtWDZuGV8zFT63cjwrTVhW9Ra4YB4+1ciP7lx8QwaHwGZqqOmCKCcW8tcvtnKvhGMl3arYsNilb0BqUJ3QwiTu7D/QpNfapIjduJsv53fcBiZ6CxriAw4ylK6L7s0luwJWpL57LYWteMidf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788827; c=relaxed/simple;
	bh=xranPDn1OkC/NMUiO3u7jz/wgKrHQyAzstGTneAYvJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxogeGdvobvpbQPf8eqTpYeEih0iBsI7y7UJt5OfE1IpsAlcvf1UgIFQJRVL2V2aFlQl1X5nSnqKYxBHLQokP9i0a2+e7Ev4X76llIZl2I6yX4iu+QhEW8CcAB8Ke0+jjtWP6qE7G+CgyyTiI3GEF2OUwr9aWPtIBDkU9cFlDNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tADtBuj2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0b9625735so910434f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788824; x=1747393624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/ugUs7fJj63IN/MNSKX5UMLi4/fRK7xsOMmgdlrCl8=;
        b=tADtBuj2ACcYtc6anYQGg1c1PTCpJPHv+zQuWM0YaC3aJDyaMSSbzAwz0MjpQDW4Lx
         CVIg79ZG72kmS+b0LmZhliIymGi9jhEHq0oPv0cI7omaxYTPGPkeXzxQKP/yPIPcsoZV
         RJ07pX4bYCtJX8Htkn2DVX74I7g8azDwY35sC0Ry5tAT/2NuihUa6GTeKyzdvX4eRGDW
         RogW5TR93r+QsAqDKO6YdO+xN6L/AoQNX5Rht8i2mrWzD1Rm7J3UKheazNQ0nyWZAZ8S
         gmXDKQs3sIeo3vr4/IkN07UgONRZuDMf4xyW2tlo5Hx2K/EQS7crC08TAQQxMI7gR/C5
         moQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788824; x=1747393624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/ugUs7fJj63IN/MNSKX5UMLi4/fRK7xsOMmgdlrCl8=;
        b=G3X2q/meusrD2XuyIHm2DwbppCaOtpUY5VN5aPWsillDB46aXKbwPEqvgABB7WLSpF
         SLjRtIicFtWGnWgiajJXJIcraPqMm3h4Jo38yi3lIMYURVK0tJaPT+hfDw9d0qQUQhsx
         8x7/JJaTleSfzpk+792XpxSvrm/t3E5UMAbFH422u3GOtT61/Q+nJGH3t+j7I2T/FQRR
         27vE66yWZKK5Qf+KOzpCo0tTNtDmPiJQPkhWFw/x32UdSffkPw58taPaaZteXMibEW2n
         HQKccq0mHFNFlrOxBn2GaoUHRBNqtGpTlsrRED30FtqEl/wDFdT2vdsfJUd3SOXv7hPm
         ZilQ==
X-Gm-Message-State: AOJu0Yw1GZ8H4nMF9kjYGfSxqT2m17XLGUDzbKqK88E8LoO/iAVYbLQp
	Lt7nOyYdKJ3dNZrFnKD3cWIwTwRDzcjJLBEtVG6OH0f9YBH0szOTpC/U6UZaBgU=
X-Gm-Gg: ASbGnct7BMLMleYEJCoP7u5nPKzL8n+42+25DvFJQEfu95BaXTV53/ptRp+fPtz5d5q
	m6dZe4X+TXwOFrjnDLsgWq1hrB74e1zeoucJBgNzpLKcU5TLCi9+HHAJ+ByD31RQQ3J/3Qezb4z
	Kv7107SfCBSDiZtFgGZbB3ljqVNEMA1oL0/kf4Exu3n4gJEFtA2JkJWuWWfFTPH+xCLmdlQq5O2
	WYy3CKY0K/sj4/sto8m141jzm1THnAH6dfbJK/trpZIwU6S7zX8otSnqsmi5/HJG4W0L7cNhtz+
	R1n6lT/6R6lwmDE077n9kItGLais9LMz8UiSCdp4M/3rtbs=
X-Google-Smtp-Source: AGHT+IGt4VaJbNHq9FNQxWvc/835NhTOA2iiwAH7rDv6mlJrY9Iqd6PFdsksfuN5qOW+kOzhHmEEPA==
X-Received: by 2002:a05:6000:2404:b0:39c:c64e:cf58 with SMTP id ffacd0b85a97d-3a1f64ab930mr2978779f8f.55.1746788824315;
        Fri, 09 May 2025 04:07:04 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:07:03 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:54 +0100
Subject: [PATCH 07/14] spi: spi-fsl-dspi: Reset SR flags before sending a
 new message
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-7-32bfcd2fea11@linaro.org>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
In-Reply-To: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org, 
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

If, in a previous transfer, the controller sends more data than expected
by the DSPI target, SR.RFDF (RX FIFO is not empty) will remain asserted.
When flushing the FIFOs at the beginning of a new transfer (writing 1
into MCR.CLR_TXF and MCR.CLR_RXF), SR.RFDF should also be cleared.
Otherwise, when running in target mode with DMA, if SR.RFDF remains
asserted, the DMA callback will be fired before the controller sends any
data.

Take this opportunity to reset all Status Register fields. This is
required for enabling target mode for S32G in a later commit.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 902bf23d276a..b7363cfc649d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1063,6 +1063,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
 
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+
 		spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 				       dspi->progress, !dspi->irq);
 

-- 
2.34.1


