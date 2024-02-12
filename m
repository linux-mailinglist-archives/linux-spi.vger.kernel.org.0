Return-Path: <linux-spi+bounces-1284-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED938516A2
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 15:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30F51C20968
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64624642B;
	Mon, 12 Feb 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTz7MiLs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017034500F
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746642; cv=none; b=WzciLV1LZwSXhZNwyngIRGC+jLxw6BBr35M/8ugJEygnC+MgeWsaKfHyK3NORi0raxK7UA8yvpbnMECjEGKl9ReRLySPkO6emounJmyxml91oMVaKZjUM/rzXKDS9zK7Q8aKO6WP4EIAKoPlJJVVWQHP/aPXDXKC6Ym6yhbLxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746642; c=relaxed/simple;
	bh=/J3HSWrt3Z+UiY24EU4Lkl8TbqvMM7ckFq18eXIR03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icF00Xq8h/93XeBuSZyDYRpFxAGgHTrxywpBV53wWc9DgSbWQ+hEA64UXuj8bOHdx9ZX4Y/wAQv9SpSGFJ7JMKH7smc3+oOKlYRpa9wgEYlwfJGVw6hsqXN4YutN8Iu8XkIfijHL4PnOe71R0M5mqrDcyMi2NUoyNvmguSvAqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KTz7MiLs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b18099411so1905850f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 06:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746639; x=1708351439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTrzZqM2Ss1d3JLf/TDWyYpLJTs2h0kZukw/0ZYCnhU=;
        b=KTz7MiLstpfLI0z9H/1teSzffwLk3pNZHtsZImtpAEQGiaQAwv/hvqhdtH0J8TZkXK
         6J94o2nGDgn1NvY2fd7y/t0RqthQ4gqQ9hi97AnCK2kIBBeJ7an2g582JtbdWWawrCzT
         GmdfhBAuSc7RIoPLw/aGgH5H9hpqp1AtbseJw/Ryjm/d5Hhcd5YDo64tHrhNos2ZkTt8
         22gRoKHDQNc88BeXm6UhA2ngPLJ3XWZ5TMAnOhYOvyHSCHeUu85ttY9nM3QqPCxOndwW
         OUBjAAlgDy8DLIg2WiWDjeSYoU8M5HLfiYiduhqojLxV3rL//f61oOpkn+JbwzFvs/yD
         81hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746639; x=1708351439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTrzZqM2Ss1d3JLf/TDWyYpLJTs2h0kZukw/0ZYCnhU=;
        b=fLHO2a84+TgpcyTj5IX0wKDx0c/Tf/Wnfkwr9NjKTMaAn2nQOeQaX432L6FN6gT1nI
         WL89OzoVJuIYZOiV7reqstIqk4cBZKAxd5viphfLHxdgAVqKEcpDLwrxuyXdvax0pEaH
         PQzS6nlItqpj0o+GLh3H3x/7dLMtx/j+etmKv5UCGWpZGGxlPMdNEHn8+Q7AAMOx8u2c
         ACv6qTNSAnUMLaJ6ynSSHQqUYmVuic/7cJMo/kqE9N1Dgz3e7y9Nj8IHM7f3NQLVuZFi
         uDRW2jA4VMYMO9QdWM7OXqzAYaf/S+4dP3FqMbZgEQb0OiKTDVb4ooZ5ub5tLaU0jG+o
         xWQw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Z8MSrwNCXTBdZMxaKnk7Grm+keX95jdDJgg+dyi6GNoXHPa2uGvYFM7Pa15Kowatx/ozdVDcCDF6bJZv/Vp60GDVWxixeTiY
X-Gm-Message-State: AOJu0YwntwJZ5u9uBw3/HUZqdqhdiu192/izwgVatAhrJdF2gr3XByyp
	MRFHUy2/54Kk6D8SrKiPxeKtZ0zSneCFV1+ohAH5tu4ILcoY+oDVfDB+Avdjk3g=
X-Google-Smtp-Source: AGHT+IHe8AP9Dw8wolP7N78fXQjkB4Fn/h8j7Uc6WIIgess7pG3SedXldeeOTzKTSsK/F0AG9gZq9Q==
X-Received: by 2002:a5d:65cf:0:b0:33b:1bcc:3be5 with SMTP id e15-20020a5d65cf000000b0033b1bcc3be5mr4450299wrw.71.1707746639324;
        Mon, 12 Feb 2024 06:03:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlANfbZ8m+T1LP+cim+3GEYRHtlP15t/9gHZXViQTDofn14kjIknDINvOVYOR6vmxFlfUStZTWdOG6zC940DM9gEdcSYpAJat7dHZV1/GhpmuH2mkIFZeX/wzm256H3ItmSWgzRA5gXTwu09J9l9sECJz9CR1926Hrn2JUfE0uTHRJOcTAHOxgv6FxIYNQkujb9XEvvdGgF8ZT6lZ0XjYBjXbcdWooyZLKfQluQM8C3Eu4gnkkJmKAhZOmA+mmxxFqSl1YdQvWSFVDvN9p64Nfbp0V2rNMTsgDWac83u06lQNq5awYi0RPtLwaBE2tptRRDl0ZU1z3//WjnDK8IzkJewItN/RaANod2YfTjR8k1bza188Af6A6/ni+T4Fag2MouhZVapoYhCyDyH6sMOSs0hxNJWIbVKfDdojj3E9Rk+idLKFA+Ac4w41gIWPCYInt4i+o0ufV89VDDcCb+fggUhvaCsLIuBn4B/C+b4Xj2oM8FgzoEQ/NHC5Cgc1w17cgxld0qWhJbGMRutqJXlX2gTRHfgXkVlS002uP42NwWWea56Ocq9/zrvG3T3MW6P9aHSvF731DoqYzxFpCPF6j0CxIWVp9TcljJdlXquuBfwTEQh8=
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0033b843786e1sm2135356wrq.51.2024.02.12.06.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:03:58 -0800 (PST)
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
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 08/12] spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
Date: Mon, 12 Feb 2024 14:03:27 +0000
Message-ID: <20240212140331.915498-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240212140331.915498-1-tudor.ambarus@linaro.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
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
2.43.0.687.g38aa6559b0-goog


