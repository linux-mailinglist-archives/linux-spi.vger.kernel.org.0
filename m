Return-Path: <linux-spi+bounces-4187-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BF951D6D
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0B81C2542A
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575801B373D;
	Wed, 14 Aug 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYq8n8+S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD801B1402
	for <linux-spi@vger.kernel.org>; Wed, 14 Aug 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646293; cv=none; b=be5eBe+xj0hN+xeo/F37Hoxayy1o+oNLUPP8QmF4eI38gc14TcF+XxpzZvmVRMPee7sYDrQ79sLRZUYknPj78KDqsEOElknf1wlj1rtN4EDc4WeOFROEqlf7YhBTgJ1FTT0EpJhZ3q9Oq8J+yMAJ1nH1U7G6cGCFrax+lVDZdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646293; c=relaxed/simple;
	bh=3C9sDsuNmN5dsBAPIyEtXc69OWMzSrGVnjgwXX4ZS8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn0Wvlv8OsFG5Vso9PrfPu6tDrkABGgRqBozEOUdM2+i8arjjbfZVaZ0SkZ3J/zyRELuPxHGa24/gTAeKENzUjXugfHxBuYVHV2d5PnNcpkOii6VOi28VMy2GEAYlOyqKPy3uCcoYy5xweM+bN51pT3GCJwOqYwEWtsP06M17Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYq8n8+S; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36d2a601c31so716f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Aug 2024 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723646290; x=1724251090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ7y9kq+0U5TtPwB6PI3f0VcMiF6i1YIq/oK4o32aJQ=;
        b=DYq8n8+Shk39QS6DQTFec3VO425Zq13rFSlrjH/ubt8I/ejpexMdFDrYceiHMI6/o0
         apRQg5V6DmAIyj6ZBhq0wWwTm4wfgZZLRm62wSaQ79vZ99T/FJSeqRIiiUyKyRtErr/i
         iSaeDOeYu+o5wSY1nBoKhRjRDFZiGplMOID5CzH4HQfyH1aWBXOVv4weRV9kcr4S2oo7
         DJCvwp3GebVjPtsOHFuYz12OrGmfwfVPk293qg8njhN07AWlPINn7eOsrjpH7mbCEmU5
         nTCgOkKS7nhavjjf0Q2e/kNFkdMyF9nVvcecNGtIXAUBHIS9CaHhb4W+x1q+lZ7HMTBs
         VNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723646290; x=1724251090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ7y9kq+0U5TtPwB6PI3f0VcMiF6i1YIq/oK4o32aJQ=;
        b=JU7dvsUBiJAseGV+xHma3Z+NvPMybvEIyhAcK6AECtYWjVzqyZfGnDO09897m21RD0
         YFkMNodqPWCaJNbPuagbUGSoY7EwTEEbIcofP/LYOS5AA3QkK5vS4CayGsO7pzQoJuO9
         +Z1yogPd7RN88r0usrfO5kEZ/U1ZVPB0m7Sh7q7hKuJrf0wCG2lhB+tvn78QgizZi8BG
         qzKq8ZGIfRN0oAKbvccKit0c6wuN8dz1ZiKYE6Up5ztqw0M2AM/9YsrCEwpaP23RFBbd
         RFgB/pc+VIvEaxkLXBzgwkDBieo9xyDt1EZSz3PvIWcEZJo3ODeYWxDvc6nf9dg4nowF
         QAJg==
X-Forwarded-Encrypted: i=1; AJvYcCWIwLQ/CahhgCOrxG9BrD3Nvso0ZNJXnvB74K6OxqtSJZDqgLetZli6RhEPVMlIfJUOtN6IDpKIF+M6UuG9ge0RwZGQ3Nqq1N5/
X-Gm-Message-State: AOJu0YxNEgDY4EUXUbgSufQAbInyEdFlLZex+R95Ph4Wp9dwuYW9pKie
	9A41MLjJ3NiTPP044cKjBkW1KpemNlXYZQI0eJoRvRgV6nxite2EhbQqtem3JtNiK/E6ia9ObZj
	M
X-Google-Smtp-Source: AGHT+IGJxPY/VQIeXxWEF0kHpYxBVoARtRKch9O8Y4tth5MUPOgrnnXR2EvLBNXZdgU1mMmSfBGe5g==
X-Received: by 2002:a05:6000:d42:b0:368:5b78:c92e with SMTP id ffacd0b85a97d-37177764092mr1943457f8f.24.1723646289611;
        Wed, 14 Aug 2024 07:38:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36be4dsm13080839f8f.14.2024.08.14.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:38:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: cadence-quadspi: Simplify with scoped for each OF child loop
Date: Wed, 14 Aug 2024 16:38:05 +0200
Message-ID: <20240814143805.98874-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-cadence-quadspi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 05ebb03d319f..9c0a4fa5128a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1662,23 +1662,20 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 	unsigned int max_cs = cqspi->num_chipselect - 1;
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct cqspi_flash_pdata *f_pdata;
 	unsigned int cs;
 	int ret;
 
 	/* Get flash device data */
-	for_each_available_child_of_node(dev->of_node, np) {
+	for_each_available_child_of_node_scoped(dev->of_node, np) {
 		ret = of_property_read_u32(np, "reg", &cs);
 		if (ret) {
 			dev_err(dev, "Couldn't determine chip select.\n");
-			of_node_put(np);
 			return ret;
 		}
 
 		if (cs >= cqspi->num_chipselect) {
 			dev_err(dev, "Chip select %d out of range.\n", cs);
-			of_node_put(np);
 			return -EINVAL;
 		} else if (cs < max_cs) {
 			max_cs = cs;
@@ -1689,10 +1686,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		f_pdata->cs = cs;
 
 		ret = cqspi_of_get_flash_pdata(pdev, f_pdata, np);
-		if (ret) {
-			of_node_put(np);
+		if (ret)
 			return ret;
-		}
 	}
 
 	cqspi->num_chipselect = max_cs + 1;
-- 
2.43.0


