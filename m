Return-Path: <linux-spi+bounces-1145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 777DA84CA2C
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 13:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C621284ADF
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F559B66;
	Wed,  7 Feb 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4ucYHDK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590085A0EA
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307482; cv=none; b=feXdMM+3+e+fyYZIy2rjpNBl/xRMoPkPWk13SRboM5dO5qqaOB52QhG3kA1fw1RqCVkyBwRfX/Gzj019bZJRN3U1Tg2tfkyorX0Vuub2pVypZHXqW1YkdqmA0iP5YlB+VFKEhDbd3VVDZd4DzW0QQb/FliS/9hf+j3V+CPCjC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307482; c=relaxed/simple;
	bh=cUYKFiaaaNIsippBKnm1eD5vm9eIcx8figxCCL6UVUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL3QuYDiauWCyIkCDxyDxrod4X+mxosLIEwrM2LB+4qhfcCajOiGySLY2G7xEmd70RBtFSMRTrYyibOXlqPMNDzfaPBoerZpRKSmlk6e9qzdmAMtN8pDjKjBuj5LFg925loI3iYW6J1W+QKtfP4GgeDE2Dho/2sTUw+hSdciHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4ucYHDK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4101565d20bso3181615e9.2
        for <linux-spi@vger.kernel.org>; Wed, 07 Feb 2024 04:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307477; x=1707912277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PkOeTiV9Vr1e3YEJjpMzE9wK8R9Udngne0PKYOLQyo=;
        b=Q4ucYHDKM0GYhygK9yMtYX5ZEeD89imUFy13GWshcCNqxeUdM44sUWSoP0b9CJcF7/
         FguGAoKGvNmM6RevtJD3AwK4sGc9zsscR8igWw7w+Ss4uCxfePbenHGKE0poStAkxdsy
         9f2V5EYdviaUwS9SHruvAyssdiwzmhKzJWNJDatbXvbNZvuLTDEcbwLiBJRrEwn88Ll9
         RvPxaQIXEll+ObGSdY8p0W+zBRZB3AHzob5GDb5oqnuBNhR80ZnzspWd7zlnpJjHt2l/
         EEL/B1yxCM8U726cG5ea14nc0feXr4R0ERGJvG8uw21jG4+awnCSFlqJlHhsxldBAH+e
         OWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307477; x=1707912277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PkOeTiV9Vr1e3YEJjpMzE9wK8R9Udngne0PKYOLQyo=;
        b=L3fjI4C9dWz7t1l0/w+ket9kU0Os2xvt6qeayLM873lJpTAUFb8auAnk8PorfIjjno
         XT6IRMqinyKm0wZyx/iMmF7ne2eKpMZ2Nh2KGeRm9OU8LHrn2ew7WQiQ8NQGaU96maZk
         6DnX4tRoX1aMCzKm+3JBbgvbx2ayiq1QtyC/p/W6NqLiMGWTYB8Iy0+DN99Zy8yLUMZh
         zARvrC74J+cpHt8r2kViWRuM+dbsV4Ja5WsPhUwDTENLO3cNqTjiI/SoAavn7XfaUTnZ
         tD5rc1MEy+RtAmc8xrMFJakAFgZHJjzsXaPLNhd+liNNIVYoTuptxOsWtWfeBzLcEpw8
         xe7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWezEbk1q9PMpO/U1jbx70p4aUBlCOkGveQ45CJuDgc9v8G3AT/Lqg+JGLmB2Wynq7R+DJ9rpXW+mmVHy5wMbzhxkzTwy81ZkTr
X-Gm-Message-State: AOJu0Yyzlv+zo27a+WpyE8RtIAzDFlqiM7Z2G3ONpSX3hrxI9HNUT2St
	g6/z5ILBBi/40xylU5PaZxDQG85ImK1ujww3E/3+jjgrlzbhfks4bcMffuadOgpqYCE3cdMZNjD
	FYtY=
X-Google-Smtp-Source: AGHT+IHizISQgkpwBJ/ZOu+j/DpNp3CwOOqT46l5+PQ6v2brq0tpCpNqXigNsovkUwiz2s1PwCsJrg==
X-Received: by 2002:a5d:5051:0:b0:33a:ef65:172f with SMTP id h17-20020a5d5051000000b0033aef65172fmr3038397wrt.65.1707307477460;
        Wed, 07 Feb 2024 04:04:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWB+BM8Mhb8VFL2sq2sCoTDS49kqgPhevZMeajZjUn2tespElYOon/prHpdepPcDpw+LIoKsrMsDFOFqDCHkVQTsTXhzEoiUyQ2WfxV2qfJ/JLuHHNcAHOq28Nek8tLRyO7m1wpXRmV5aT9pPlCTw5/ZukkMFFG4geVBDz9+6I3C7KmZ+IJLE5mGpGesi1z197Z28tgdtovCzDxggqgJADb6iAfU3/xSI3HmMOqX2Dy+rufzbfkr4nuwpghpo10xMsNYwgT+x4skWwyPHM+T7gaC7f1+F9LzYUBBTKwRGNpxcaj6cnnZdey7tgd9T5rsumdp7Rr68J75Uy0tA0xkrOISXohHWkJb9Ky0fAV+08ClLRZEA+ORzczJej53bA8bfLq5fYYXFzysdkpoEyaYrBFa4zJxVPLiW/lWZVSNp521pGoPFLzYRp6veWfbtzoWAfnUlfFHIY2I6fk6Ix6flRg2wYMuu0ivMPlAf/aJ5cDQY+VNjov/F7BBwTa6g==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:37 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 01/17] spi: s3c64xx: sort headers alphabetically
Date: Wed,  7 Feb 2024 12:04:15 +0000
Message-ID: <20240207120431.2766269-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorting headers alphabetically helps locating duplicates,
and makes it easier to figure out where to insert new headers.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7ab3f3c2e9aa..1455cbd2fa8d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,19 +3,18 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/spi-s3c64xx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-#include <linux/of.h>
-
-#include <linux/platform_data/spi-s3c64xx.h>
 
 #define MAX_SPI_PORTS		16
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-- 
2.43.0.687.g38aa6559b0-goog


