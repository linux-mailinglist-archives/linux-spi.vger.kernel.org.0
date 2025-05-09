Return-Path: <linux-spi+bounces-8017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B41AB118F
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3101BC17CA
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D7290BA3;
	Fri,  9 May 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxb8GYnN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7428FFE9
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788825; cv=none; b=PWcGY9ZFRiz7uXuKLwOATvtQzpbyPtzKr8qfnz4/enPG1QR9se7koGLqdKj9mjpewXvdjKvf8eTW+IhgrEFP2AIPvntIMsZBeOYVkPk0EPESvNH7A/WAJhbm1/xkm+71TDdWn1i86eWxS6G5t/e3gFf1eBdoUcCWnM6UGmpBeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788825; c=relaxed/simple;
	bh=D+fL2YJhn78smRy/FVA67pJck8oxKruZt+xjNMzmkhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSXC8WpDWzhuf5z77HNpxiznk8r57IBu5eV9XWwLr6mAFjVn4abkxgxfCH5QSIwnehlSRHIHVL/d8/vrQfZ4dNaIuBURpl9xnYY8WR+Skrt2VlJvslOSutOABXIgucREpPZJueofnck2qnNeyPkcUDXZC1LIMjbYS6nN3m3Utfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fxb8GYnN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0b6aa08e5so1820268f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788822; x=1747393622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82buFIB+rtX6lyncKzfqQ1BjFEonYyuZcyA3lmRU5C8=;
        b=fxb8GYnNTMWzz5tpQjCQazmvmL4bSAXCmqLp/LYx5fWyrhMypnXwmW3g+M2FgYPrxR
         n/+y9eIXforL3nEgC5M+2Vjqt7JjK2GJRnmtTeboeGo2zljzBA8YW53Pq6ayfDnkzM9G
         9zEK+1UHQvSnbl24TQQpLt6TASMDE7d1wZNy36GDHePERSzRr8956LP0QgtAo2V6zyim
         uT3K79UxF6TKBpKhwj+Q7Ino4iGzM/+rE9VA2a93w/Af9+aYtjHqnewoShUugshK3Zmu
         ea8gRjZFWFLKNkMF1N5pyYO8SVLx9uqlclFEpyey4nktbazPsuN3TO4Nc5olPWWM0Zjk
         oLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788822; x=1747393622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82buFIB+rtX6lyncKzfqQ1BjFEonYyuZcyA3lmRU5C8=;
        b=gNivcD7MkzojGTuINkE9ewSSLxJezdRODWQ+drEl+VJ1pBfBa6+wZdq+L0eVfyomkQ
         MVXnhnaCLJ7kYo6a8cspluwnYjGxSTzpfck/OXGTFEj4dvUSTZ/1RIbcdZucw+t4Et11
         xkrDjSJ0wcULDI+8kcEkXeX2E2Ry5zdbM1N4aWo872wIXRYIqOgxL5Zii/0FceXS2/f4
         zjczEECLaES6wik5kK3R6qoMe4EMNv3YGraEj+arHPfT/UVMr331KszyR2xVqDhwV7Kz
         I03VHXdEuI7IY1WjpJfMY9U3oHr2vKiucUcUh2bFcI8moYwQjDab6OuzT+LSN9Qw1p0C
         oDjg==
X-Gm-Message-State: AOJu0YzpAtRv2ivSu+gliadgVJVkNFAeiYjPlIDDj7RSYxwVrOTd8hb+
	IulcGb9l8oQ1OUlyTlCRUw7Dz95jMO8w2Pe+BGB6vGiBx0TasxrqFz43FYb+FR8=
X-Gm-Gg: ASbGnctoW0/g41rQ/wOwAHYD11pJp+PLAauCyaA+czjV/i+IaBU9Jwm83afH+GaVk1s
	aXvn6lVW46vlfUshRlbKLY3ZJ1NMc0OmVBDulm35XyaSURiXFzIIUjmxaoGIEzawfwhF2DjMIVY
	e+hTReZlbEXsEKdQwg2jowXILnKdejvw5K3MwKgX0zEZNMqmqDISPFWf8OI6QgxDwtV1H2qwp61
	8tFiLFgJWPGJUQYcPZVpusOqRH88xXGyPr1eXBXxcYgt3qwXkvj9Y3k1Q7nIuX0boFvsefxFZ2H
	FfHduWrWXf7E1oZznaGYBxaqut4qyervVKwnY51MxNDD14o=
X-Google-Smtp-Source: AGHT+IEE94+EF9/8yZCVzM9YnUpAQNsIoaIC6oYQfj4cjZjT31gCTBuncCPpzbHVyG2nFW+mquupKA==
X-Received: by 2002:a05:6000:220c:b0:3a1:f5d7:b041 with SMTP id ffacd0b85a97d-3a1f5d7b0d7mr3035935f8f.25.1746788821614;
        Fri, 09 May 2025 04:07:01 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:07:01 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:52 +0100
Subject: [PATCH 05/14] spi: spi-fsl-dspi: Use spi_alloc_target for target
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-5-32bfcd2fea11@linaro.org>
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
 linux-arm-kernel@lists.infradead.org, Marius Trifu <marius.trifu@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Marius Trifu <marius.trifu@nxp.com>

spi_alloc_target should be used for target devices. This also sets
ctlr->target automatically so delete that line.

Signed-off-by: Marius Trifu <marius.trifu@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index df6f85122bfe..f7f9425a19e1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1340,7 +1340,10 @@ static int dspi_probe(struct platform_device *pdev)
 	if (!dspi)
 		return -ENOMEM;
 
-	ctlr = spi_alloc_host(&pdev->dev, 0);
+	if (of_property_read_bool(np, "spi-slave"))
+		ctlr = spi_alloc_target(&pdev->dev, 0);
+	else
+		ctlr = spi_alloc_host(&pdev->dev, 0);
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1379,9 +1382,6 @@ static int dspi_probe(struct platform_device *pdev)
 		of_property_read_u32(np, "bus-num", &bus_num);
 		ctlr->bus_num = bus_num;
 
-		if (of_property_read_bool(np, "spi-slave"))
-			ctlr->target = true;
-
 		dspi->devtype_data = of_device_get_match_data(&pdev->dev);
 		if (!dspi->devtype_data) {
 			dev_err(&pdev->dev, "can't get devtype_data\n");

-- 
2.34.1


