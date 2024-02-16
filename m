Return-Path: <linux-spi+bounces-1394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5B857680
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7F31C22386
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841431BDCF;
	Fri, 16 Feb 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVWH9mWi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33C1B960
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067173; cv=none; b=IRYuWWmulNDxQ6WTooM25MUX1CRAYhtFDKMqdv9hM1vK4+Bl/e18koJuZJUqLFw0x6gsrMQLfkLDkyRcmLefyJ0NjzEGXZm+s+JiXKeV6bfHjqldEWrSRPFCwmEk41f46OzBvSkmkjeUqMuqDxK+i5GvAGW+qQ77sN5EQUzJBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067173; c=relaxed/simple;
	bh=jt5JbHtxEQ/3R/RLG9oKrCgGwgK9KhLa3lx7cD6uZPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWbXkGRlOPq4ZA46p8dO+xNSIL4YNJKDkVNmiuwxywNSDvIydQYR8w4fR/4rMzRYPBGjX+hsaGFqtffjiwxSuqsJmiWJxLiCf195IBAIpz8hN45uGVu6F1sJxrO85Q/XUiAO9RbLWi24lYEgWxHXZKEKGbrLPAo0sx6dbF1PpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zVWH9mWi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3394b892691so1118268f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 23:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067170; x=1708671970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkqCfr2t33L8Q9VhOTDSxHGDf/6G9Yy8lK28zIkEPyE=;
        b=zVWH9mWi6Mest0rjWx525lxM4WzgNPE1KOVEU0WNRBEdgu7XdOcmGmgYM2aUJ6lgQF
         iM6vlgu1dlfiV1Of0gCAg8iHKyUMrC2u+rZVbP2Uqn/x70DfvBEtyRzc8GPEi9e3BhR0
         wT06iSwzokBrcSnyjgSfrmhXi5MpsjiVVyR9acYtJ7VWQOxKdpt3GAV8fy1D7b2/zZZM
         mVwUjq8BpkWOb1hctGJWuU8vAhmsTwmG1DRMLNYW8RiP3MEPrqzLFq7FWLKuPdssbYsE
         OPAUV1IawteLbRnVxpen/aRlgD08IVYmpEnh1OYlQbTeXV4GFYDlmhKH8BJfTJRrFW9q
         5rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067170; x=1708671970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkqCfr2t33L8Q9VhOTDSxHGDf/6G9Yy8lK28zIkEPyE=;
        b=JEkXHp5yaziTpF6WKVfTmJ/jWC2/7MFwzXYWwXhasCBnjrIV6I53RvAbuRNzyVcCQP
         OXHS17AZm87my7Alh1q9oCoLwojxTUbmKDuPVM7LyX0SxDMHfcVZvAYoYBwp/mndVdX1
         swCEgCUVG3jLB8Lpbkn0bA3sKkqFI7ehA3j7HW9t0kORMTqhN4v0v9TzcKfIDL+/tKUk
         6PKJbJCRVqcZOlmtocWOAhteB6CHc7HXGIvdPIrJlMn0p/crSGDPJyqEXx9OBvDNguJx
         IJPFtPIC/48L4ewvGTs9ezQTJQeYNs3B4GielGwUNs0KTwfhZFBZPtcWo+J3t0ac2/N8
         KPug==
X-Forwarded-Encrypted: i=1; AJvYcCXzRBYFfo9bFfKL/M6N+tOHLs4yCkPelCnozS0JqNJDIMOQuHzve+7DfLSyaK/O5Nycthre5/vwDUnSI+Kvj6xDhb4jDTp2JFaw
X-Gm-Message-State: AOJu0YyiqUJXbIHO9+hcJZnAx1u9EjgO5HNbqJ2/92X5c57OVJ4xzdhd
	SuJtlh2AAGHxM9+/2l0HP19tXnSYAnDR+3cvXJ+Flhi7zyA7roRYvrtu+zc9/Ho=
X-Google-Smtp-Source: AGHT+IF9IXKPA/Y+ft0Qy0meyaCsdXG7oVlLehuRlTmOGdJbKOq6m4Wlzxzotfb9H950PZa7V7UfDQ==
X-Received: by 2002:adf:f706:0:b0:33d:c45:15ec with SMTP id r6-20020adff706000000b0033d0c4515ecmr3396246wrp.32.1708067169974;
        Thu, 15 Feb 2024 23:06:09 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:06:08 -0800 (PST)
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
Subject: [PATCH v3 09/12] spi: s3c64xx: get rid of the OF alias ID dependency
Date: Fri, 16 Feb 2024 07:05:52 +0000
Message-ID: <20240216070555.2483977-10-tudor.ambarus@linaro.org>
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

Compatibles that set ``port_conf->{rx, tx}_fifomask`` are now safe to
get rid of the OF alias ID dependency. Let the driver probe even without
the alias for these.

With this we also protect the FIFO_LVL_MASK calls from
s3c64xx_spi_set_fifomask().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 40de325bd094..d2d1c9767145 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1203,8 +1203,12 @@ static inline const struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 static int s3c64xx_spi_set_port_id(struct platform_device *pdev,
 				   struct s3c64xx_spi_driver_data *sdd)
 {
+	const struct s3c64xx_spi_port_config *port_conf = sdd->port_conf;
 	int ret;
 
+	if (port_conf->rx_fifomask && port_conf->tx_fifomask)
+		return 0;
+
 	if (pdev->dev.of_node) {
 		ret = of_alias_get_id(pdev->dev.of_node, "spi");
 		if (ret < 0)
-- 
2.44.0.rc0.258.g7320e95886-goog


