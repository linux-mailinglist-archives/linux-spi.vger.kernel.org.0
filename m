Return-Path: <linux-spi+bounces-1222-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD084E9A6
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 21:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA86CB2F505
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 20:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36263C099;
	Thu,  8 Feb 2024 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePtWzHD8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50E383BA
	for <linux-spi@vger.kernel.org>; Thu,  8 Feb 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423723; cv=none; b=Py8XF0krth2IUqR/GBDDPoLFwz88cccysmNUAnnyvaaD9+yLqEtb2G7H2LAMNTPOh0pIFgfzTn/RmVRtzokrBjiJ4MyKsysD9d56fYe1QOX2LMt3Ev2UozZGUMwOdD/3jOMf4BM7Jn3/WwpDkDlcmJ8fs5eRtGqHhnkjpfHHDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423723; c=relaxed/simple;
	bh=ckCRYnNvMIn289Uaeitkz9MPGu6deST5KDhd+ydIsBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPI4f0bRzQm64G+Cycco1AqQbRPvn/IM4RsS+qYHFVwcHMmwYG//dY5OoSq7f+tKHPa7ObnEH1u0k8HdEDNo5u59+bL1DOzrgLm3KNuIdUEcBEIJ4g5UpNhnsa5JqIsuXnr5Jn5HAMQvzTxJZn4gepx/cT28ZaIeJQPLipW/Ug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePtWzHD8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5114c05806eso283039e87.1
        for <linux-spi@vger.kernel.org>; Thu, 08 Feb 2024 12:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707423720; x=1708028520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrqUcGgHJSe93EQJvf4/pcFq39Owmftzt0EiiVtqek8=;
        b=ePtWzHD88q6d0I8+FuI2v8Mbx669LldV8uHpWWyzxezcBTA3V1/5sxFhxnci96fNAn
         9gqAb6tx9YmeLq4g2q+KHviE4BHBp9ne/1SPK1D+eNrrEcvmTikc1rnLHFHPclbnb+ts
         81AeP0Nf5jttCR6NSLnCQh5OPDbxWs8j2whqmDU6zwza3FT0szMg6IcVdDoNWWVVj+Oo
         YGmT7YwUszeZst80Y3aJjCMM3BIUtxHIVogEcKIMlR2BUkxXfRTzi+CDvASCUEieomZu
         SMC12pCfWxhGeIoFlvw5ukiSXNlNyD8pp1wxZ+DQUP973j9rJGPURrrp3I70gDPFIPZv
         IgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707423720; x=1708028520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrqUcGgHJSe93EQJvf4/pcFq39Owmftzt0EiiVtqek8=;
        b=NmR/isHVXluGhQE1yy+oxH85yoHzTbc1RgTTIXn+1NGfunXgC0dcgySh6moBMpVBbQ
         8BIzFBFN97PpYxN7EkZvB0xy/GqtqM0/OpV2WNc8ye3+GWVKZPCsvaWhHvHPr2CiqF1r
         yKfd2eWnt8SepsGKExTz/FWVGzhSZ5DUFwyxI13hfibXIOunrKRmYp0oXsh16TLIIXV5
         Cqfsx5q3uwankUrB1gdmzWnzXPtRQoffKGaIhC8DhjNSybMHdUj7gRp7w4ybr6ha8Bww
         sUrHexDNtymND+/Yx8lU1VyV+TUuXMZQZamzKUzvnmfkW6xyfA7Q9nFidIGhKM3Idkgh
         16eA==
X-Gm-Message-State: AOJu0YySaRH2kAOh5HtSL1S8qW3/uBK9sGsbnm4H9cfcEZWpfDwao+oc
	ZtQwWXNMkf8kc861mAgpoXsO0kJLeZ4G/HJdWtpzSGe7q7T+3sUlC1kYF/3nOAM=
X-Google-Smtp-Source: AGHT+IEvCz6u9bCOJFi0/kNc2Z2lsFQ6dktXoQwmQa4/urrhseDbei7D1UHqz/z7bxlVs2jpnOOnpg==
X-Received: by 2002:ac2:42d4:0:b0:511:47e1:aa58 with SMTP id n20-20020ac242d4000000b0051147e1aa58mr234021lfl.28.1707423719947;
        Thu, 08 Feb 2024 12:21:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOc6ARr5frpGIr3+feVvJ0AbglTxE+IZna5ZIFZhPd1EMs7AXBkGVa476dqS1WJ7AAZFJnFcWlK15kyxO2F/FrX2PUk1ugaf6G9P3f3Yrp+9DIpLwjxuWb8PZWn5+CxUCwxuS5xdJo
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b0040fdd7cbc8dsm361481wms.47.2024.02.08.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:21:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] spi: pl022: Add missing dma_filter field kerneldoc
Date: Thu,  8 Feb 2024 21:21:53 +0100
Message-Id: <20240208202154.630336-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208202154.630336-1-krzysztof.kozlowski@linaro.org>
References: <20240208202154.630336-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kerneldoc for dma_filter field in struct pl022_ssp_controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/linux/amba/pl022.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index e08488df6d28..d7b07d0311e1 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -225,6 +225,7 @@ struct dma_chan;
  * struct pl022_ssp_master - device.platform_data for SPI controller devices.
  * @bus_id: identifier for this bus
  * @enable_dma: if true enables DMA driven transfers.
+ * @dma_filter: callback filter for dma_request_channel.
  * @dma_rx_param: parameter to locate an RX DMA channel.
  * @dma_tx_param: parameter to locate a TX DMA channel.
  * @autosuspend_delay: delay in ms following transfer completion before the
-- 
2.34.1


