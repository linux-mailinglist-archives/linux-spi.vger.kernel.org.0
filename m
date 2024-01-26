Return-Path: <linux-spi+bounces-855-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4FE83DFB5
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7FF28625A
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA2121358;
	Fri, 26 Jan 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgaahFHg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE73210EF
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289361; cv=none; b=Mx3/0z6TXPWC1jwhLVynqT2yI4Z/hTKl9P1Nm1WqyyvfFWswjMoui4mteqeKB8YGhgdGyw02n0HFIoyaf1hBZwN8tZmZ39DOxwzjAL/gyH4eg5bQLnCDzlvRBwO3nvJRwQc+4hK32Wc4SlkhWaBx47MRRiDXswZ0vW025W793HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289361; c=relaxed/simple;
	bh=nQYzWdDeWV5+4bKiItDoglDKTO/Dzi/wJFH7VQFwoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDBJTP3lN9HW0qSjQehd9/d2P2uLnODLcZkiqzNMsNvfPjaBEaSZNd4FFGM/P2apG0HO7MOrBOGSevib1lBnLdttzrzDgLADm0keiQQcKIF7k8A4AB+8P7XYTVoa4xN4Yi8twPRVHR2u38AQ6RXiGnliLZPy/IX0kNLgZhU5Srs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DgaahFHg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so10064805e9.1
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289356; x=1706894156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byLqjPGX2U9floq2ktVuyo0IP+fRFNCCMq67reNTymU=;
        b=DgaahFHgRvra9fyLK0Ew2hU8rTEaMInlX+oVxhcRAEQycERtoRyv3iXJJGobSm8A9y
         z2bZt7OaQ8+8V8t7JU0KG9mDr6a7wvpvV2c88KNmiazwA2uyq759Kgf06/jS7dbQfyw+
         b4jltwH1W9vtxO0iBdwoSy6DTrrbiZcvMIRPiZJfS/apItBmrWpYlYcDywFrtRYnBt9s
         lPUCvxpvSVtCBldaWr29Dz//4asb9PDuHT63JJMmsyzGZFTp4YYYYCfwVxbVmRlVCWuG
         YUNntKWAaBd0yAkhbeMYnggebBgn0nux3iie1Be5QmkIZpeMRFX5xqeiEvwmXLrgMI3P
         mK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289356; x=1706894156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byLqjPGX2U9floq2ktVuyo0IP+fRFNCCMq67reNTymU=;
        b=cqy1cdwSkjgPSXX+xLwQGzI5o1qI+13uyRRmeLe7fdJ8vcF4TghAkOfy4UB+wUyeVd
         jFLEi+LF+is+G5pQL0WZKpxEDToqTR4Zfs0QijusX4Hi5aBcCwj+KboCW3YZ7zYwbrfc
         XimaqzSNJuotyWgP9KFZyzyRDJdQJ+f+Sxhm0r6WdHOS3onWrihG6/VU4UfeLU1iD007
         jckGfL1yAIJAgtGo2x90/Yp50gbFr6gPySGgBqUgBD3NLiGVaW0jNZOTUawLd8bPRYrQ
         kBxmbdD0NC6zW3+dzB/wekUR+horZLjBWyhRTdh4se71jSbVcLe/w+WeHh/OW5vrxsgu
         OCSw==
X-Gm-Message-State: AOJu0YykdTQ4kQRPilqYH0KGzdSPziUUvgL2gz6sC9AuSm8UFZihdnCx
	bd9yzqP0lAQEdR4zhSCacQyydWFEV+3JFezObXX7WXRijItYvHV1eLQPms3OCwQ=
X-Google-Smtp-Source: AGHT+IG83hVVkWCOFUgF0c27tv+I8VxsYGHb2dXyr0ioweVMaw0+DSQAY0Eif9VfosCOeNfsa8sQKQ==
X-Received: by 2002:a05:600c:4fc2:b0:40e:3edf:1053 with SMTP id o2-20020a05600c4fc200b0040e3edf1053mr94867wmq.17.1706289356632;
        Fri, 26 Jan 2024 09:15:56 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:55 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 07/17] spi: s3c64xx: remove else after return
Date: Fri, 26 Jan 2024 17:15:35 +0000
Message-ID: <20240126171546.1233172-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Else case is not needed after a return, remove it.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9bf54c1044b3..bd2ac875af59 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -407,12 +407,10 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
-	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
+	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
 		return xfer->len > FIFO_DEPTH(sdd);
-	} else {
-		return false;
-	}
 
+	return false;
 }
 
 static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-- 
2.43.0.429.g432eaa2c6b-goog


