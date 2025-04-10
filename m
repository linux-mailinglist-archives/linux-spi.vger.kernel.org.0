Return-Path: <linux-spi+bounces-7508-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E8A839FF
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 08:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2B33A7364
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964A2046A2;
	Thu, 10 Apr 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHEtjeS2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A7204695;
	Thu, 10 Apr 2025 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268201; cv=none; b=bvAdUxqCTlMehUjt6LpHegK/DWsKBeasRRcUHlM0TihddD7nZnbxPDYc2qS20udXgZEULwZ580hw4a5fHL7Odsx33/DQ+/tT59nHXLGkTC1bWrI41DZhsOO+Ph+7kTI1OerGR6c4Aq7zRIcdFrWlLU/jx3iPMMTdCyII+XyIgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268201; c=relaxed/simple;
	bh=2exhL89MqmM920DtFt+LW9tQ8zlgpzvyNF6wZM1vlN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgsgidHqjtQPQJNcLO/JMZx2HTd6Gd4lCaNPAsU/S2bRPModqUxHvwRFGH6xUfxXAB8zgaW8bD+fF16yDx8bmtLHXzcksPOqE8u4c5tqQB6qeJDoQ8AAVecoZVrbZpwmb/4jtT5AcYWAoJwaskwOUC5/GQolavYi9VeVMSkVLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHEtjeS2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c560c55bc1so52826985a.1;
        Wed, 09 Apr 2025 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268198; x=1744872998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+/a0pAy49kNjJeFKeUGOEY733n8BvKpFhFfUlVsDvE=;
        b=jHEtjeS2AesoldNlR9XyvhFfZh9FoDhfw1ImndUTV+0RpjRi0/rQL9Anc0bKU/89Cm
         V3uOxnQm3k5Vn/w3hy25wKhxD91nU1PYC/agTvq8hQl3DK9JEruNuPii2C8ioyTFz5la
         j3bgaNahKstxXWABn+/YH+eveXDBAWQRHnvStE8sUZW7W2UrZfZBrYqpKrBAxXa0sAjO
         cmb7BPXTS9+3bZyXULdXPHN92K9UUdjLlX94ns2vHURCd3FbS6Q4EHjIo9zFf+5cjl9F
         iB/Zvl+W1BKs9YRNusSvR3jqOWuJIEIv0cNVrvy1hpwzGKx/D+Dgslxtr3NJkt+tdZwT
         2xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268198; x=1744872998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+/a0pAy49kNjJeFKeUGOEY733n8BvKpFhFfUlVsDvE=;
        b=oruVL+mmZo2ZJN2rbCRzZ1/RwdeXHHDlWiHMXnmwwILEIZbgZO6uySyZlW34f6B++z
         5NlQUhtDwlOaouJVUcz/5RvrJUIzaX5h7ndPom2HJQ5gAqAnATiV5dQe5akU9Ijf3t3F
         ynKoyXys6MH7yglTB6pdd+LzVNsoSEN17bDi8A0R1aCzLWz78aIgxwMQ6iW6SsFiiGJl
         eeki44NYTsy/gvG73MHyBeBuHoCbnMWRRsKL1FBH4CQpuG4EA46BKf9leeaXuVniH0rk
         4YcUfwKdOcVEJYdSVXj2bpAqo8+DXOLijFGNGVyGpq5tmvKuEaA9CVSWR61hS3WNVMrT
         fEwg==
X-Forwarded-Encrypted: i=1; AJvYcCUK/dnuhZlTUnbc8ed9PrsqpaFsmmkEnCakPLvjTHzjxo4aSh2NJLcL6o6VGr76e5bBcAPGpQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQ7lUd3LQw9L0O5EjOcecBr7i7sj1lllTYSWM1YbD5zFKxuyK
	wWqAGllsEMv1Gm1fs3SoFgNVemcDPh6aRMtj6c8MkcuQxRNDQAe6OmKF/NcD
X-Gm-Gg: ASbGncsQbU8f6ks2DflqYV74YTUdeeRpQWhnlLwNWwSldNbUl4fYyTebJny+zVBGof7
	PoRRLkWxREQF4Dvo/4g1cCW0C1PcoNXfryhbBYRES26y51iNGMjfvO+w2grwjk704LgNO7i/JYw
	4ZT9JTCgPbuYX95Ds6LixHzthpTPZ/V1qJYuYQfZMgdUeT93h1Q6DdNnK1XclH+rYh0hMlAME8m
	amDUbiOkzAL7w4dnBqa9JKp+yDrUjIZr+/ftFa6XbrOVye/6TkgAGMD/L5E3i0NpAMPzEzvdaCN
	8JWym19kX8IitY25glKKiBAeqAd/qYu3n8e3YH9kCfi7oqNmJVY=
X-Google-Smtp-Source: AGHT+IF6b6LGSAR4bHA1yLJXiYlJx62ZHYX+xSEbpgOYOLW5RvtQmIEVa/c8wIWrL/FXunsXjsemwg==
X-Received: by 2002:a05:620a:4550:b0:7c7:a543:d878 with SMTP id af79cd13be357-7c7a7654195mr189133985a.12.1744268198407;
        Wed, 09 Apr 2025 23:56:38 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89515e4sm46547285a.26.2025.04.09.23.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:56:38 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 10 Apr 2025 14:56:09 +0800
Subject: [PATCH 1/3] spi: fsl-qspi: Fix double cleanup in probe error path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-spi-v1-1-56e867cc19cf@gmail.com>
References: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
In-Reply-To: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 imx@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Commit 40369bfe717e ("spi: fsl-qspi: use devm function instead of driver
remove") introduced managed cleanup via fsl_qspi_cleanup(), but
incorrectly retain manual cleanup in two scenarios:

- On devm_add_action_or_reset() failure, the function automatically call
  fsl_qspi_cleanup(). However, the current code still jumps to
  err_destroy_mutex, repeating cleanup.

- After the fsl_qspi_cleanup() action is added successfully, there is no
  need to manually perform the cleanup in the subsequent error path.
  However, the current code still jumps to err_destroy_mutex on spi
  controller failure, repeating cleanup.

Skip redundant manual cleanup calls to fix these issues.

Cc: stable@vger.kernel.org
Fixes: 40369bfe717e ("spi: fsl-qspi: use devm function instead of driver remove")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/spi/spi-fsl-qspi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 5c59fddb32c1b9cc030e7abb49484662ec7b382c..2f54dc09d11b1c56cfe57ceec8452fbb29322d3f 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -949,17 +949,14 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
 	if (ret)
-		goto err_destroy_mutex;
+		goto err_put_ctrl;
 
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
-		goto err_destroy_mutex;
+		goto err_put_ctrl;
 
 	return 0;
 
-err_destroy_mutex:
-	mutex_destroy(&q->lock);
-
 err_disable_clk:
 	fsl_qspi_clk_disable_unprep(q);
 

-- 
2.49.0


