Return-Path: <linux-spi+bounces-6324-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80508A0A567
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2025 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E046A1886EA9
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2025 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E931B78F3;
	Sat, 11 Jan 2025 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+gkYpdw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41201B652C
	for <linux-spi@vger.kernel.org>; Sat, 11 Jan 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736621645; cv=none; b=Y+l2Iom2Rz6j3L5N/phj+DjbC7VhiGl4Y6Dox8JNilvb2MmPUeQYL4uVnOYxb0IGSXFaieO0FwgeqftNHFu8vglYWG5sp6NA+e1ObwsMfgvfS8O49PQst4OlEn1V6OHx+EiEQnha/EyctVvfUyP1sBT9DAGU+29Aubs6GydQzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736621645; c=relaxed/simple;
	bh=PYmz5fxKkNfylhSI/cK6XfE/gmxMt6aXY09Jad1QRd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeMWJhc8Xx4I0uSHrMinzmd7ZNXG65V684JnftBzRzn9Ir6Omf5jsBm9+xBdS0NBTbAWkrRPhfKQ767bkmaZWcftjrQ9aicUZBGwUiC2Vi42466yx7RdZSfcOey/vG/jOQW2dpkyNS2tzBCwvvyjyj44vlEovoxEVgyftB2jybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+gkYpdw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38625aa01b3so323616f8f.3
        for <linux-spi@vger.kernel.org>; Sat, 11 Jan 2025 10:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736621642; x=1737226442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k6+fOZKLjoF0hzDiYL7ecBMAbWjrcspBBjGm/Rk8kwY=;
        b=D+gkYpdwV1jkWSKJX2++B+VY3IKFc3JBSsoJDNRDTJL0awOO+/FQKHnu837sWzitXu
         d76bxvZ3SU+Rh5SWW6K+G56EY1fh+hEKyCrIklgAC5ENHh9LRtD7c4pRnftzqKfLq2kK
         iqSvrhhRe1ptdnXdNXaR65CtgxqhThCVxSBFlAQpFYL0m3nQ5qUppO9sNpttXRAX5cP1
         zZ5C/QB5pOKSI4EhKMgM2T9XFJSrub3NakFal/2pzFCQBWANB+xtZ5QHaxHvMSUV5c3f
         8OtkjMSuEnNWlGUDLZ1R9rZEH8Aj7wmfp5n74HDK1dLyYFBWWGUN+YIDx4BUnMHHmfeH
         CKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736621642; x=1737226442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6+fOZKLjoF0hzDiYL7ecBMAbWjrcspBBjGm/Rk8kwY=;
        b=RAa0YXUEKl830qnZQYhvnqvkkDKAM5fRCoEAVAZXYkUXY6cBgTSniPnHVBkGCrPEBM
         alXucNJ1nfaoiUXDv6fTAdI0skRuvovnURi7RNa50DoAYFRms1yeqo6kI3gWkp5OKa8V
         0DlMn3JY/byK0GGIlmOslK17hMzMu0RgAp1fa40AidVoYdmBzhyw9BFcHnfnt+z0s+zd
         IFjpw2nizrc5VLIn2R367J15WKS4s8tuEVOBvSxc+DRHuY9Dl21qMRjuR83fJ9Sflr5G
         pu9iNhdhC8vxeH2vabFvJxFmGp5HPD3hGGQmBNgthVxCHMGPTbJ1JPj2qWI4A51PPqJq
         rQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJHQ/ysVzwkjHOvte1/1aIIXtq6MQgEk2OiU0bq/ugR3zJatNwj/uXu4K30x8BkD+MI0J2CdXR470=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkOy85jgO7l7RXUN3NLFaW3ngrrSYpgGRTB+mdaDKx3Galb1L
	nHPLWuMDRQZKEj0mkxk6U8WBMgpErEwEof3fl6X4LkFkxsdLt226vWfoTvKgOdQ=
X-Gm-Gg: ASbGncum/h4OiQFx9AxzRljG0xfsjWrfw/kC99DjY37bTx1GVdSw/0CELxfeOmOUoHD
	3CqtMKFxtAYghjVrtiDIl2ucJ2FTbVvKAy7Xsiz9pkjGf3VQzh1RA+TNKHWKZczXscv0XxmIWjZ
	tRVBkE8dRdt4GgntTSat8YJwJp8WJoo/T4jlQ9ceFtj6763c1iKAXFo+6as9gYBXUe0lyhlJzBU
	FjabGirtqaAEoEiy54BYuu6iS4fuYejIViAKS8bWyZ0XPlWU2XUWWY4Vju1EYbCAdHeX1c=
X-Google-Smtp-Source: AGHT+IFSjPn3386+DCzwPtt8hHPamdmrOOxPaiL49mdJQBNGzm7TkqG+2qVNsmj5SqY9yc+4axlBbQ==
X-Received: by 2002:a05:6000:4718:b0:385:fa20:6583 with SMTP id ffacd0b85a97d-38a872d2e0fmr5190402f8f.2.1736621642257;
        Sat, 11 Jan 2025 10:54:02 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b05sm7779572f8f.88.2025.01.11.10.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 10:54:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: ti-qspi: Use syscon_regmap_lookup_by_phandle_args
Date: Sat, 11 Jan 2025 19:54:00 +0100
Message-ID: <20250111185400.183760-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-ti-qspi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 9122350402b5..64b56296b693 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -826,20 +826,12 @@ static int ti_qspi_probe(struct platform_device *pdev)
 
 	if (of_property_present(np, "syscon-chipselects")) {
 		qspi->ctrl_base =
-		syscon_regmap_lookup_by_phandle(np,
-						"syscon-chipselects");
+			syscon_regmap_lookup_by_phandle_args(np, "syscon-chipselects",
+							     1, &qspi->ctrl_reg);
 		if (IS_ERR(qspi->ctrl_base)) {
 			ret = PTR_ERR(qspi->ctrl_base);
 			goto free_host;
 		}
-		ret = of_property_read_u32_index(np,
-						 "syscon-chipselects",
-						 1, &qspi->ctrl_reg);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"couldn't get ctrl_mod reg index\n");
-			goto free_host;
-		}
 	}
 
 	qspi->fclk = devm_clk_get(&pdev->dev, "fck");
-- 
2.43.0


