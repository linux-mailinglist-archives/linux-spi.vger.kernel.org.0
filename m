Return-Path: <linux-spi+bounces-8852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E65AEC35D
	for <lists+linux-spi@lfdr.de>; Sat, 28 Jun 2025 02:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52191C26F0D
	for <lists+linux-spi@lfdr.de>; Sat, 28 Jun 2025 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F540634;
	Sat, 28 Jun 2025 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="WDOnKSBJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E01854
	for <linux-spi@vger.kernel.org>; Sat, 28 Jun 2025 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751068957; cv=none; b=JgNaIbbfmxHuWmoyFudqluJmcCoXK34pJJly7bzp5YaN74uQ734PHlCnqqjGe7PrfkAvuo1x4NSWG9eF9jxBEwOLKCz7jRNwzE2XPuyCeEvpPfI5uSMSrMqtnZkINXrqdXGAQkPX1phbtkZbhDI94M4CqiJdUkqv6yl6SdxoMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751068957; c=relaxed/simple;
	bh=Sj/eX0Tuqh+sN5LbYLN3mf5yADRyM5dTtMQscDcucHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnZOirZUrFiZmeHbR9gsCN2mUpcsiHahrSjSijmG8djnhZcryNqAH0e/m8eUCUo+adLClBxJ9loq6Bwo4RjMg8ZFWb7UptXCON9OrKAmGupxcHQqRm5igT9TxXz31h2EyKgrifaTTnkQLPHPdcoGExQiNfh2eQiSKM1PmvQhOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=WDOnKSBJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so145910f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1751068954; x=1751673754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VzxBghiapRo0aX1nK0c+nhbUFh9iAun9Qlu08MsGo1c=;
        b=WDOnKSBJVDO82fOuS2sJ8YhvrBOu2+d3bVZLUU6UEMLDanGenh+04GUoODdJn7mmZR
         DKg/mILlftqjaK35FEXfC/aTLFYILVYmIiOo2Beaz5X5yf+8qa541S7vXikIGbN8uITL
         n4oxal3ZkXxHdpmfCmXMpY4t2P6dT8XsQwKWBnkTBirmnToAtDTjZJeKVl1WIH58+m7D
         /PRPdaH57M8VlJhZZslVJvQ5Eycp72L1vUE1lOhvzw85mNt7Ztnp8AuZ1zug0uzLYriE
         8S5Ok9uxch9/pJmijnU0O6Up4okHEVP9QRcB2LUbxtjzXPisWFpxlh1sRz6rAQOefqCN
         jHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751068954; x=1751673754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzxBghiapRo0aX1nK0c+nhbUFh9iAun9Qlu08MsGo1c=;
        b=cZOZO9E9jfvqRM2zu5V3Qq/wAPWBxBAzsRnsUD0L0e0/Gmm2CwQk0lgq+lJXe2w5oP
         1GAFr9yS59NPEkCiqwoQG23TAwWZ1+4byGzh/sPp9JGWEC1G/27CfIJjE+l3y8VrBg+A
         QOzXu+Yk2eO0+JweCoX52HiGHFThRRKNDDV7EV3OZc1KMDH+54slTOoEG+8Sw9ecbd7H
         //twYJDnQExFfoHs13xidfEVjPPulJItCSupZbTalvO4jVEG1CTYrt/TmUnigbZsyDGq
         3qgkLAy2kkShqAms9Fvhm1gnzvpQj+9vOPra4qFUlZoT0wf0pcD+s/cHcCpb2uZnbQOY
         3mtg==
X-Gm-Message-State: AOJu0Ywp/sQ6Uamwu82okiFlYl7vjV1V7CTreUpxcz1S8xzXTwYYgzdR
	bF58XKulG62m/oj82u8pqDSlMNLacB6zeJ3dTXU3MIGxa9ZTilBtAOCqjPWAJ+iNL0jkQ8yp3Yk
	df5mh6TA=
X-Gm-Gg: ASbGncuGgMwvIBOW45ODm1bhhgmCqg2vTWGFZ7KAtd0upUimwvTuH9G1wnsOa517V/P
	oIcza2XJMj6ANS57EFAaeSWuWwyRUUy6pgK/W3NafWNxdm/Nn/SikwCkrA32LQ6w+RqcWpXsbZi
	oHZjZ3Xl6beM8nJTfxZP54xG0sbQ1Y6uUXz1MXFlMs5uS1fxZKpdRW0iVvlVwdN5byGQVcC+glD
	aP9U9zvmhPK1D1p0VOHPqu1xc12R/7EKEEF4SnWrLFxbrfYmW4/lhl2nWaL/3/ATriWVg7DfOuU
	7Eg2tVyNelTfFZIi7AROxTGSvqKtDpVbYpYM4JMP02YDZ08R1gKxwP7pNFHS1y+cpwS1yljhajI
	bSLt4pjnexIPn
X-Google-Smtp-Source: AGHT+IECU//FZnUMFlsTYIRoyghzMGUC/zod9WnPCi6VKfNKXOA/f3HCNrR2SW3KH5umXabnco5DLg==
X-Received: by 2002:a05:6000:248a:b0:3a4:c9d4:2fb2 with SMTP id ffacd0b85a97d-3a8ff149554mr4015024f8f.46.1751068953621;
        Fri, 27 Jun 2025 17:02:33 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:9bca:2bf0:5e15:c50e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm91685845e9.10.2025.06.27.17.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 17:02:33 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-spi@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH] spi: stm32: fix NULL check on pointer-to-pointer variable
Date: Sat, 28 Jun 2025 02:02:27 +0200
Message-ID: <20250628000227.22895-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In stm32_spi_prepare_rx_dma_mdma_chaining() both rx_dma_desc
and rx_mdma_desc are passed as pointer-to-pointer arguments.

The goal is to pass back to the caller the value returned
by dmaengine_prep_slave_sg(), when it is not NULL.

However, the NULL check on the result is erroneously
performed without dereferencing the pointer.

Add the proper dereference operator to both checks.

Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
Addresses-Coverity-ID: 1644715 ("Null pointer dereferences (REVERSE_INULL)")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/spi/spi-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 3d20f09f1ae7..e9fa17e52fb0 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1529,7 +1529,7 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
 					       DMA_PREP_INTERRUPT);
 	sg_free_table(&dma_sgt);
 
-	if (!rx_dma_desc)
+	if (!*rx_dma_desc)
 		return -EINVAL;
 
 	/* Prepare MDMA slave_sg transfer MEM_TO_MEM (SRAM>DDR) */
@@ -1563,8 +1563,8 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
 						DMA_PREP_INTERRUPT);
 	sg_free_table(&mdma_sgt);
 
-	if (!rx_mdma_desc) {
-		rx_dma_desc = NULL;
+	if (!*rx_mdma_desc) {
+		*rx_dma_desc = NULL;
 		return -EINVAL;
 	}
 
-- 
2.49.0


