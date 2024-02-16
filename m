Return-Path: <linux-spi+bounces-1393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4312985767E
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 08:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BE2284E89
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 07:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330371BDC9;
	Fri, 16 Feb 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY078VYN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8E1B80F
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067173; cv=none; b=P1vKWsvtt2sbqJt/DvdDT2nJAzb3MZ/I0Vqj1ycNKsDXfiuJBcA7aOrPOj4SYksEPzWib2KA+Tpcc7yhRl7JOwOpqnLHzPjtbZRoojPD+zl/8QQcBJom/GCSiBfqmlzVdBcIrwJJtqkeU7/6++yTw4AJNVUiS2DM28WwzqPyFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067173; c=relaxed/simple;
	bh=Q12iQnFdG2iZ85QopCuTAOBD4Ofa9upNXT0gtIFtD/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/C+wwErDCSJFoZbSmA0ok9kw3ocbGdGDazB5iVq2a83cm2hWKafNB0qTqDMtQjqFuMGR4ELa5o5src5r6s/avz6JIQjKal4fq9leQDU47cdyqV06Kmy0aonbzGk570asBp3gb/sSc6UKL/h3d2RDHw/l69v3LI5QKyCADafC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY078VYN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d18931a94so320912f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 23:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067168; x=1708671968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6DI6oxyBGAOnmgH57nVgi2YtxfkZy7vqtRyT86aOak=;
        b=RY078VYNjo9FRPbhZpQFDaXaDRBwAJFC2FjTsr51EbNVwFbYxstosOhzie+rHs5zMu
         jQnfg7eeINjlEZP3DCKiaHtuqy432YeESeXiQrwH68fqileR+OnYPwHiF4OQRrjbv4n/
         x7oNG6x+5cqTIZ+j3tlfJuNb8Aa77noPULgvJzHu1Mgs1UsJXTJ4492psh4WK/g3meD0
         bc8R7yfG60wmUd1GfZ3C6wvQsY7uT6FVDf4eF51dzZ9Xvinme/RC7+hPDOAQ4JEWsVEw
         2uKzWwonKbH3OHoBksufj7bM5oKYhaWJP42q4OpuXCk+f2Tl/lOfUa7eh6FXCjOLY9we
         zzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067168; x=1708671968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6DI6oxyBGAOnmgH57nVgi2YtxfkZy7vqtRyT86aOak=;
        b=RfUz8qu8Ml/Lo8kZno1NrSP/aps2X2c8UAYawC7nXjpkzCGiSgZHY0D8KTIxDHlZgo
         r7gcEls68iKSMbPSqelIA3z5BvC5bQCr2F3yDqr83pf49z8LQOg4A39dbjXFv5kozB4Q
         lKvKSc5Ggck5YOhu3Z6BVRyNZNk7watvp3SpZRPRFoOrASik/O9NL5aXKVIcprsiiVYh
         LyzGYqa22KKZzGfua2DtLVEtimp0vv7QLvWVmBKGMZ/emDTW1lUBxdWMuy9FSFraNwFM
         XO7SLsRTqbVA6CdS9lvDOViATh9gmXvF147j+w0ZWuapE3GDu4KXwi8laUQ8LL9ZoaGH
         ffUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmaG8jDIo4Np6//0Lu7zV9nyemOLLYbCRVwaIhZxqfoFKgEz196sPXnhdXaM7tbGE/pCogyLHz7Cl2UeZPmMJLmUyXF56nl3wL
X-Gm-Message-State: AOJu0YySXN4ntuC2WCU9yW6UAiqHcUEztBp58drd94qK/ZjVwikw0yyH
	Aa93LHsN1+IMKUy5lKFY5ya9Hw066pdD3KZbMI9gpYsetomenW1JI/xLsoZtse4=
X-Google-Smtp-Source: AGHT+IElxq2xk6aiqP+v7vVmB9Rn+o8tE/AamjN56/HIJFwjBwNBu23xznmMSINpOQWx94t5lmSSfA==
X-Received: by 2002:a5d:6190:0:b0:33c:f968:e243 with SMTP id j16-20020a5d6190000000b0033cf968e243mr2968421wru.43.1708067168666;
        Thu, 15 Feb 2024 23:06:08 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:06:07 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 08/12] spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
Date: Fri, 16 Feb 2024 07:05:51 +0000
Message-ID: <20240216070555.2483977-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare driver to get rid of the of alias ID dependency. Split the
port_id logic into a dedicated method.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ac47755beb02..40de325bd094 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1200,6 +1200,27 @@ static inline const struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 	return (const struct s3c64xx_spi_port_config *)platform_get_device_id(pdev)->driver_data;
 }
 
+static int s3c64xx_spi_set_port_id(struct platform_device *pdev,
+				   struct s3c64xx_spi_driver_data *sdd)
+{
+	int ret;
+
+	if (pdev->dev.of_node) {
+		ret = of_alias_get_id(pdev->dev.of_node, "spi");
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to get alias id\n");
+		sdd->port_id = ret;
+	} else {
+		if (pdev->id < 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Negative platform ID is not allowed\n");
+		sdd->port_id = pdev->id;
+	}
+
+	return 0;
+}
+
 static void s3c64xx_spi_set_fifomask(struct s3c64xx_spi_driver_data *sdd)
 {
 	const struct s3c64xx_spi_port_config *port_conf = sdd->port_conf;
@@ -1252,18 +1273,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->host = host;
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
-	if (pdev->dev.of_node) {
-		ret = of_alias_get_id(pdev->dev.of_node, "spi");
-		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-					     "Failed to get alias id\n");
-		sdd->port_id = ret;
-	} else {
-		if (pdev->id < 0)
-			return dev_err_probe(&pdev->dev, -EINVAL,
-					     "Negative platform ID is not allowed\n");
-		sdd->port_id = pdev->id;
-	}
+
+	ret = s3c64xx_spi_set_port_id(pdev, sdd);
+	if (ret)
+		return ret;
 
 	if (sdd->port_conf->fifo_depth)
 		sdd->fifo_depth = sdd->port_conf->fifo_depth;
-- 
2.44.0.rc0.258.g7320e95886-goog


