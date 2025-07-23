Return-Path: <linux-spi+bounces-9157-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D0B0ECCB
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 10:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293091C840EC
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 08:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7763A2797A4;
	Wed, 23 Jul 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz5X5GNB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85FA95E;
	Wed, 23 Jul 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258017; cv=none; b=OR8SnWl8IJodf0tuiGBcEOtieRZB5CGcEUeRUeMULHSLrSMhUbwu19gWIc0OXTOnrSYv5YhlP9U754LTSdbb92GpCQ2sFG973azYBamWTWsY54IuUMyRw6getgfM4RtEI5xVsFpBVSrkbJdzYM69sD+wqvm+gA8jII/TX8z8nUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258017; c=relaxed/simple;
	bh=eReIPFAY2mPW2djMpM8mJndQ9Ys2wnTjSj4ff9CRYo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r0EsLtjNRwPYLD/CnkZ7PkpUV/VuYxQyvVImHkbBpQ8ga9/7IEBbfDpXSUzjVkIkog7l5aM/jtXMGup5TCLDwFj4A660R8tTcUZ7/kNTZHPqNj4ZDCq/zrFiKnBud69iOjVVHEUkWSCtZ3fA2HzXel0ZlXxzgVzvJsDIG4Q/x4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz5X5GNB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3690004f8f.2;
        Wed, 23 Jul 2025 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753258014; x=1753862814; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4hGp9dWQqyiag09FeN6D2BgolKXHwVBXU9K7yKNplY=;
        b=Uz5X5GNBybJNHmdxnrapW5knFom3KPzRV4g6wEEzoHHX4VgMiBd84kUj7OxO5Wdh+A
         ghOv/ZDOQipdhMvtrP8HeiGBArtgTiIXlOjQHP8XkhrW6nSdWKUsz/RIdnFTDbQekan3
         8Bxdyl4sH82WDU+7S60KzyfgywtlKPcdd++DNRZ/WJJYsXJ1tMmjBGbWwWkyHLdF+sXv
         o37o6nKQJMPD3H3dLn5jj7Tu2FcpUlnjkNBR7Z0OBa6mLkkhipUxX3PCadJsl+Ih6dib
         +RypCmnx9+LgxsKBQkIUU8O5MDdU8uPIHt1kFsnwfMMX0TyOkn8S8AEbcfa2nzw0fAbd
         IZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753258014; x=1753862814;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4hGp9dWQqyiag09FeN6D2BgolKXHwVBXU9K7yKNplY=;
        b=IxvguqfELj6m5TFjBBypP8SfhjG85uNSOxCp/51KnqYjttKu30P/z+6qPzIh/Adqud
         ZdZTXQDaMvVaJ7QcHcZX/3bLwUMRNe3+QamytU8JTSwyrReGhODzFfvOsfehy/NRzKA/
         9kD4p7DpCM1FoNRwkMbkM8Fxc7MzbKbnXIOv1t/RCIU6fJy5uSlRecXJgjnmyPfdAra2
         xbxcfhwCVOtQlGLj7THtBvTShQi3d6fRmE1iUJlbZVbCfQBF8mtltVNktr3wv/XLtd4H
         bKv/oOVapByBCx9IEgihLfKfNK6MjwJUkxbH7muXk37K42st5Uroc79FF9wFoTE57PLX
         rdUg==
X-Forwarded-Encrypted: i=1; AJvYcCWXlIKJ4XMi18/tplI1au+SRXBT1le4EifAv/4RDsQM0db/Z2PARmNErau5p1N5h7/ggp+LIk7PD3IWIgpZ@vger.kernel.org, AJvYcCXapBaf0TBwIrgzN+RucrtJzkrWag+t8IApfElhSe+LUFvd++a4rx74957axoHv2GqypjvJ8gozBev4bCKr@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmMn+7n89evSSLFDyKpKZRBTILdsdu8UqUQiwZTcCTsN82q5D
	ZJS1ukc0flLmJsT8qwVBeQfa2Yi8FHkLasaT8oWd2pD7oEvZGj/jx5cP
X-Gm-Gg: ASbGncvEW+8i8Ujv4qQ0wq6YXX6Qv2m0l6m6ntIzKO5J4AbX942Vw16BrmAViHNoanC
	FONq573abyA3VhcDWw/xxqjTaUu8I9OtvWN5d4hFs40/Bj++uubt28V6PdIxxO0O2NKnp3I+E1E
	Qa5zLJ3Ewj/mVl0a+l5hnu7FBHXuLReXZIdsQ5k7kt80/wl7QHkXD7oJicGnzj8OymODr3mMabw
	u2qmU99RLGsu4ncJTwa0RnYAhdMOjZXdkBPLO03PHh1y5Lrxky8RFpNmYQ5lKZX+q61NB459rcX
	Ik6Ae29jpI9wGPqr862vhwL3UiiaVk2xZ1smOCDMGyeFehoS1gTF75M/M1zsX7839ReUL+lF4PY
	B36x5RflDTdf83rItNCSi7oLLzEvB1jkcqCBxpdWp6NKJD/KuhN4=
X-Google-Smtp-Source: AGHT+IEib0qqC+Z0x4lzasRoTtea/6+PQdl+D0+gVXii4BSRmjOi2y+wPGZYjjKAmHCqtrEeRr7YUA==
X-Received: by 2002:a05:6000:40df:b0:3a4:eef5:dece with SMTP id ffacd0b85a97d-3b768f163a7mr1507259f8f.35.1753258013571;
        Wed, 23 Jul 2025 01:06:53 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca315basm15560899f8f.39.2025.07.23.01.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:06:52 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 23 Jul 2025 10:06:43 +0200
Subject: [PATCH] spi: spi-qpic-snand: don't hardcode ECC steps
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-qpic-snand-fix-steps-v1-1-d800695dde4c@gmail.com>
X-B4-Tracking: v=1; b=H4sIABKYgGgC/x2MQQqAIBAAvxJ7biGNkvpKdDDdai9mbkQg/T3pO
 AwzGYQSk8BYZUh0s/ARCqi6ArfbsBGyLwy60V1jdItnZIcSbPC48oNyURT0/bBoZ0yvnIeSxkR
 F/ttpft8PSRevKGYAAAA=
X-Change-ID: 20250723-qpic-snand-fix-steps-d69b2c7761cd
To: Mark Brown <broonie@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

NAND devices with different page sizes requires different number
of ECC steps, yet the qcom_spi_ecc_init_ctx_pipelined() function
sets 4 steps in 'ecc_cfg' unconditionally.

The correct number of the steps is calculated earlier in the
function already, so use that instead of the hardcoded value.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index c49bf7079808a1933c8a630e0b07b5fd54dfddb6..8fb8895bc9b54f2095981c975c1f412045a5db74 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -313,7 +313,7 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	ecc_cfg->bch_enabled = true;
 	ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
 
-	ecc_cfg->steps = 4;
+	ecc_cfg->steps = cwperpage;
 	ecc_cfg->cw_data = 516;
 	ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
 	bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;

---
base-commit: 69e536c93242425fc65580b02d3f781a96403660
change-id: 20250723-qpic-snand-fix-steps-d69b2c7761cd

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


