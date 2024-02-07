Return-Path: <linux-spi+bounces-1156-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E884CA4D
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 13:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4041C21E37
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE565A10E;
	Wed,  7 Feb 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHA7CYIG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487E5B21C
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307496; cv=none; b=Kv2M2znSHcHEVEb0clBm8Lw4ppi9VNtvD9MTi/ARnOHHYToWNp5Xemtf3m4eUtXvaPnZxAWZ0yuRjsF9RmGyfLJOI8cDJ0uxdppkhJssXyhxk5LJ/o1LB7i8hl3ShKZoNeDXh5o6PfwuVBwhHTpGUkBpdykVp2z6chWAemblAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307496; c=relaxed/simple;
	bh=m1U2ibNS2o4vQmNNZdCySzHxJgiI2IGiRefG6tMF48Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i62mm6omW+8Mqef0HJWJ78nlSODJQPiLefcE1FDHv0pNlOfKSS0oLR9rDcqoKNTHRyf/RkqStpWiFtcb4pETMIRhGuqDr77RkbTcMREWe8faiNKcIKmMiij3RPXUJrSTxsWNZSuH0G/rULG6NvEaTqiOWnYwQzKWTuS9E5rItWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHA7CYIG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b401fd72bso472116f8f.3
        for <linux-spi@vger.kernel.org>; Wed, 07 Feb 2024 04:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307491; x=1707912291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw2MVCnXePoaGoFwhILfXnUXamqqjuyMAhC06ZDA+Mc=;
        b=CHA7CYIGDFaxAthUuyoMT4LtUHxzxqyWQAXJT2cRYhunpf3xXRsmTby+HcFl6n25yV
         HSdwbUlesUq2QerWOEntSP2s+BCvbEYlFYJgqyQWw/FjvuU5FFj8qelh1gp/m8SerICC
         okKnR77bONbx7QOrMEv1NSFYrtmfDfxX87l/yu1Zqv57YnKYhiyXfQkw2MEv3oPSJ0d7
         yIr8+sOnKKPmptxXL5RxHE7xIbuBK5I051Z1sGnR2IidQgW4YTdn9oYhK7iRuJlO2sF0
         Khs4omdTNWL5qiyT9Aa9VZdTRiIb2Pqd9q3LmWbayekDJ83xOAKffIZzMG+u1J6Te7YG
         AAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307491; x=1707912291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw2MVCnXePoaGoFwhILfXnUXamqqjuyMAhC06ZDA+Mc=;
        b=ZBscM7wBAFxrOSPOR3uRFjUs96xmy67Pabzcr/UBhvKOWdZFNFsLeUblerl/b2Hv7y
         FVH3lybMGDC0DMRFfgwv8Q1P0g5zaBrPO6pPR0kZdXWKtebwE8LzlmRd2pGcrr8VOynY
         IL0mZ/pTHAUfkRENG3N3yC41+P4VZXrAHuhkx2hDyeu4gxkSzKVMQ7iTHq0b7NND9LGW
         ysLbBeUeJ/Nylgq8+G3UleF+Hezx9riw0M1814rEj5dJrzj1KqpjLG2dWXkPiAXSW7ZB
         JwoYxT/wl/YuQb0rc1gIjkhAjS8+fD7h5jsNJsIgvwF76Ns+Eo6kkoVifL3kaRQyWrCD
         Z2Jg==
X-Gm-Message-State: AOJu0YyaGxcAlVFK09K77Yzd9z6AsgzeWL7RQC6jv/Tfp6axjGXGUkEr
	GT2sV3Pn4yIhw8EKAB/BfuN9BMx7Z/UPflHf/lTvetM/K98NcEBm2DSdiFELnkU=
X-Google-Smtp-Source: AGHT+IHAYlMgGVbJm1ulTdNKa/+d0RgWGvnEGEpkGS2NLVlo4ZSIijWb3cfglDfGFwxik/TiWE7lGQ==
X-Received: by 2002:adf:9b88:0:b0:33b:216d:70bc with SMTP id d8-20020adf9b88000000b0033b216d70bcmr3033646wrc.42.1707307490826;
        Wed, 07 Feb 2024 04:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAVMzVycVD1s6muTwkHOso64lMG/emDU5TiblalPWX7ZMHPJ5//3sDLDgEuNNZ2aejKW5KK9QN7rDbCTgQ2Wj/UBuVCg2IXUOVzlU5gB6mNN1onRg/Jsmvj9MNWKST7hrSIBv2qCpxV4AxqG6CDKNAZqjBq3PsymshtpNimVbZJPX4GC7xX/WWsSaTzZknsKwN1XOo5G8bnWTdaVmBfDL/TIeiHwE7NYFnJRI5RXe+k5TSIk4H33xzDkNeqod5v4+3vhsGtBzwrYiLOywBnRWzgl04dRvB5kwuD/+yuqmjC9UqOizl+brwqNY4GqGKADdhdSrMxTH01oc8sE5ntbRmHTtCKTLkl7joeouwRxmGAACiPA6Qq98RFng40UhReyhxs3JGqC4atlIgyOnV7ERYsOdt6gLbFhEJOucDrjhUWqPFNPIJjVRLs6ty16nLLqdFiX+paCeYJouUXhqtJtN8c0Y9l1OiQPYQyCkFWJocTIClBepJQa2sqjQceA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:50 -0800 (PST)
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
Subject: [PATCH v5 13/17] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
Date: Wed,  7 Feb 2024 12:04:27 +0000
Message-ID: <20240207120431.2766269-14-tudor.ambarus@linaro.org>
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

ETIMEDOUT is more specific than EIO, use it for
wait_for_completion_timeout().

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4cafec877931..bcc00cb5e0d1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -566,7 +566,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/*
 	 * If the previous xfer was completed within timeout, then
-	 * proceed further else return -EIO.
+	 * proceed further else return -ETIMEDOUT.
 	 * DmaTx returns after simply writing data in the FIFO,
 	 * w/o waiting for real transmission on the bus to finish.
 	 * DmaRx returns only after Dma read data from FIFO which
@@ -587,7 +587,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/* If timed out while checking rx/tx status return error */
 	if (!val)
-		return -EIO;
+		return -ETIMEDOUT;
 
 	return 0;
 }
@@ -617,7 +617,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	if (use_irq) {
 		val = msecs_to_jiffies(ms);
 		if (!wait_for_completion_timeout(&sdd->xfer_completion, val))
-			return -EIO;
+			return -ETIMEDOUT;
 	}
 
 	val = msecs_to_loops(ms);
-- 
2.43.0.687.g38aa6559b0-goog


