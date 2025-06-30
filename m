Return-Path: <linux-spi+bounces-8878-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D7AED6C9
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 10:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196FD1701E7
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 08:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D71238C2C;
	Mon, 30 Jun 2025 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="NkniRxFJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2A238C1F
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271197; cv=none; b=GHk49cIU2r8gNzhvCVAYGnZxIQVzlEdhr9sBMSLOhcaZVRR/4ct94E1nsLtK8laDbNoVBcm1ULS0lJ7xbNz5QrZTjqVffqcFLKpko4CDKfKn2AZG3fzyhSbEr9EzglN0k+FEaCfWBGjz3f3iNCh42Xdqlgbkwxyc/sIOMJVziWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271197; c=relaxed/simple;
	bh=LLK/gnwY8utHm4r5nNU5i8/AGhwkVdhAb0A7QvXNt8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8Xh/CLC3y0Ay1OMXrdSLvVUDKJgMzTt7fsSkdERo6as+dyoNYA6oB728oD+07XkYa0q7alB/VYnN0RnzJ86MOUn5fohzEP/KnYn6G+rXyJQlqzlAR5GbQBCrERabrwYvADzop/uM6KdPhmf60P7fetnxpkFN98iq9x4T4OZzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=NkniRxFJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a528243636so2492306f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1751271193; x=1751875993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlnZvB/WCXPqtyuE7Jw0BGhm5yZL6emwd3gHblqa4CA=;
        b=NkniRxFJWkby18CWfiRXO8SvV9H2VhDnfPgF+wNGSYNElVdOCyo+nCkekPqt2jwlhZ
         lW5vxCAlqNvSSG3wYxH8AatgqAvPt8ek1zBMNJ7y75/89V4nUx2ztqwd5AXVrkr/YWWj
         x5wZwZahAjt1Az75yol4KtaHBo3Y0tsw5xGtqs0X1vDXa4wHjh+DCE9hylK4yFHyqhju
         T1leDAOuW2aOc9H3KCkLhhJG19NVhs/xvBxMlOKudq03dn3qDwBgXaxy2E6LYEhKcTah
         LsURgOw86GkClafet9N12BW8co7zxiC2/U+bQn6DhXkq93P5DnLwwVoX+CfgAV5XlRP7
         Tfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751271193; x=1751875993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlnZvB/WCXPqtyuE7Jw0BGhm5yZL6emwd3gHblqa4CA=;
        b=mjPasrxAx7uNchIbxAqmpClveQ8X0+qsITbSBlfZl6BZTe38BBdpB/czauOr2xUkRu
         CHHQ+pgHzCRbp7QqO2+/3R+obo9l2gvrx6XSGoWJ7qdfYwIKSEPDW1xsx95/WQN86HJc
         cbKASfPh2asLl+U/NfW2p9bXK3Nvo395Eu6KDAXpemYPR+ipKMWem2OF9SHhmCgxw0i8
         KzjDxIPNoyCO8u0ETZB6HU1NI9nJ27SRd0hRwpqd5ghr2hbkstpKKtqCF2jZLo1hsuMi
         7acFao7sF65JZNvCFbEkBq99DipIjGmjHu/7Xt3/RmEensGF76JYmCLcNvcBb+lMX3fe
         ptlA==
X-Gm-Message-State: AOJu0YzBjRWY3OX78BZt7BiGtcoftwonb9oxoYFwERXeuqSSEaPGERWV
	2P7UPHfGGYPZXwR8LigE2Sf3IEzIUzrBt4KbM+zFzDCg9CUebM3f7Z+Aguoc2TAa9M99xcRW6XH
	jEZtA4ZU=
X-Gm-Gg: ASbGncs1b4jZz/mFvqvIUUjJMM9GdhmjGI9BUeRjwuttdU0B9VqhDavOJge4GboLkyn
	NoRuV7JPErKWvJYiKq1IAw3I7a+3DOQ4+q7yFhKJVBMWSsdkoRelQOl3u3Py2RVvucGkAvTBKLe
	p1JxggGahRbhS5ucBtv3ngwq7ols1SCbmOed6n7knk6xRpZZUlJZzYpciXFPA69IqNj8xqJlDXW
	RCouKckkXn0qwup9bhjsH0IVw4sqRNP2Dep8gVd21o6hEVPwi+zPglmsUHkmNwImBuWB/LU1h+z
	efZpjZf4TRvHT0GkN+GZxPWBHS52509/1NlJxrekrQmYUZ/Op+NrJVZmuKn18N+AQ96N4199PEn
	yGf3AUUQXt5Y=
X-Google-Smtp-Source: AGHT+IG31LxT0ptg6EHo/bGKOyukJazY4oC/IxLI6mz15TAMA4SfoRER0gF+bNZj4oNhXngxmykf0g==
X-Received: by 2002:adf:ca92:0:b0:3a4:f722:f98d with SMTP id ffacd0b85a97d-3a9008557admr7908660f8f.51.1751271193346;
        Mon, 30 Jun 2025 01:13:13 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:f5fc:eb97:a20:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7386sm9612674f8f.20.2025.06.30.01.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:13:12 -0700 (PDT)
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
Subject: [PATCH v2] spi: stm32: fix pointer-to-pointer variables usage
Date: Mon, 30 Jun 2025 10:12:53 +0200
Message-ID: <20250630081253.17294-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <1f49b8f3-44c9-43f3-a3bf-b931fb0726f4@foss.st.com>
References: 
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

However, these variables are wrongly handled as simple pointers
during later assignments and checks.

Fix this behaviour by introducing two pointer variables
which can then be treated accordingly.

Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
Addresses-Coverity-ID: 1644715 ("Null pointer dereferences (REVERSE_INULL)")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

---
Changes from v1:
* introduce *_mdma_desc and *_dma_desc for better readability
* fix another instance of rx_dma_desc bogus assignment in case of
  failure of sg_alloc_table()
* commit title/message reworded accordingly to the previous point
---
 drivers/spi/spi-stm32.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 3d20f09f1ae7..4b7f074fdba9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1474,6 +1474,8 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
 						  struct dma_async_tx_descriptor **rx_dma_desc,
 						  struct dma_async_tx_descriptor **rx_mdma_desc)
 {
+	struct dma_async_tx_descriptor *_mdma_desc = *rx_mdma_desc;
+	struct dma_async_tx_descriptor *_dma_desc = *rx_dma_desc;
 	struct dma_slave_config rx_mdma_conf = {0};
 	u32 sram_period, nents = 0, spi_s_len;
 	struct sg_table dma_sgt, mdma_sgt;
@@ -1524,18 +1526,18 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
 		}
 	}
 
-	*rx_dma_desc = dmaengine_prep_slave_sg(spi->dma_rx, dma_sgt.sgl,
-					       dma_sgt.nents, rx_dma_conf->direction,
-					       DMA_PREP_INTERRUPT);
+	_dma_desc = dmaengine_prep_slave_sg(spi->dma_rx, dma_sgt.sgl,
+					    dma_sgt.nents, rx_dma_conf->direction,
+					    DMA_PREP_INTERRUPT);
 	sg_free_table(&dma_sgt);
 
-	if (!rx_dma_desc)
+	if (!_dma_desc)
 		return -EINVAL;
 
 	/* Prepare MDMA slave_sg transfer MEM_TO_MEM (SRAM>DDR) */
 	ret = sg_alloc_table(&mdma_sgt, nents, GFP_ATOMIC);
 	if (ret) {
-		rx_dma_desc = NULL;
+		_dma_desc = NULL;
 		return ret;
 	}
 
@@ -1558,13 +1560,13 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
 		}
 	}
 
-	*rx_mdma_desc = dmaengine_prep_slave_sg(spi->mdma_rx, mdma_sgt.sgl,
-						mdma_sgt.nents, rx_mdma_conf.direction,
-						DMA_PREP_INTERRUPT);
+	_mdma_desc = dmaengine_prep_slave_sg(spi->mdma_rx, mdma_sgt.sgl,
+					     mdma_sgt.nents, rx_mdma_conf.direction,
+					     DMA_PREP_INTERRUPT);
 	sg_free_table(&mdma_sgt);
 
-	if (!rx_mdma_desc) {
-		rx_dma_desc = NULL;
+	if (!_mdma_desc) {
+		_dma_desc = NULL;
 		return -EINVAL;
 	}
 
-- 
2.49.0


