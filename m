Return-Path: <linux-spi+bounces-11977-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEBECC6424
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 07:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997CE30C0583
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 06:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111EA2E4247;
	Wed, 17 Dec 2025 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3yiQRL+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8612E54AA
	for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765952815; cv=none; b=dYHpwRkamYfQsEc6GlQ8VHzlZ/q67PUxUcxn+WBl73inj1u+I6u7HR93jGhRc3x6NJ0doAoPxsNjDf1NXkozD9HB0OfsJ+smK2sNFXmIpHRfsOMWelvRb65wJRuoxGO9B2VfwvZAYEG6NWgx/TdO//SqRXD47Vn2201Duw++ADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765952815; c=relaxed/simple;
	bh=tk/vYTSu9kExYfYBF4YugpomB9Axi5NBZ14ZaDI0yXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNVRTRr1ap1kk9QQf7fFHIgw7JNqr5C7xtdtfeF7jiStUD1K0iD7sR+FtsVQODkcZswIo5ZIhGqYAvNwzIjvtaifqpvlOFfmmNqVZ5GezrRgZw2O62iIy9F8u7XtoJp/De7Js/8+NEnOlu4PjugEhCprbX18+slq5NY0NhTMSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3yiQRL+; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4470163b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 16 Dec 2025 22:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765952813; x=1766557613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dhMQODQXuVw+9I7B8O7Ta9ufPwTrKJPDLY/J8KwmSds=;
        b=R3yiQRL+q8/XyaZj8APlL4R+rFzCDEoEj0/jweoDq4EiwICAVxXFFboVOjLxq88t92
         4r2wGE2ItT39UVcFgrX0Yb1ZphOBXyyT9b3yh6rXRkDFE5u/GxuXYW8H5fCCax2QJ/NH
         xsvv2fjXD9ypp06LS7ZXak82lmfHzT4hpEOULz78fhwtZojrfIwLLNt0me+ea4Na8TRg
         b76fxpmNz3UhdoK/J7cjaAj7BNGLYUjmtd0ZvyE+oSO98TtWvWnulwuD9ySWiHon2ecO
         c/6Sxo3ACSG0euRslVjX7xq/Sfh062i2DOy0Hdj4MjpDpY/1IlIg2QVnqhzsq8ve2P8l
         ygcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765952813; x=1766557613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhMQODQXuVw+9I7B8O7Ta9ufPwTrKJPDLY/J8KwmSds=;
        b=gLznLTJr0RfeRZHcmukXPFi9OqP3QHRzx1IoGElsamuyz/oI80wVEXabBig5KVAWhw
         TOg8VEwdcW2W9HGbCvXx1MjvGKpFk1NlG/BHsr4Wp1WH4nRzz/WM+5LAWsYvNj17t6gM
         NiVkVJA50iuBeLIALVex1+6DSvnXf4UXGbdiGUKHq8SgGClAB9nIMXTPEMh+XYgbIDy1
         /KPzDrstbCHHjmtUNiPC5KIM5MT5VgO+lx+EooFQYk6M8yrfCtbTJGHt+yiLEsK28wVM
         j1t47Es3m8RsQrDLKX1S7bCDpGpdghjB+6bU8KxPfJBj2p/DkwwA0odwvyG20DInOjc4
         vlTQ==
X-Gm-Message-State: AOJu0Yw0E2+Do4ATVLfOLChZkrJLNzArbYu9AAk/Wzq/qx7Spj6A6Qld
	8jplp/ZerJQnmzstKf3jCOI+79oqY7FERLm0T8aSFtDLsz1MgUAbly8lybgZz14A
X-Gm-Gg: AY/fxX6xZo/1yqHYsgcW7v4Kc+0ySFxrpxOx5AeiWnHpkrcxac7P3DIKyvUJHrrlY2j
	lYP2wlbXH0yoUHEmas0T7/dFXiS2nUDjq1qZazYXXJDSG/ijIkCalAghVr0LMIVeDlZ3/HdpbO9
	Em1YJv1jjazfAtuWWof6fEvQuVCoQTXeuJc8643eDsm5vOje7e1e+gu0lwQqT7YVsGbzb9MeMQY
	QTWuKu3H3C0vOvqFEHFBpykI7uWuvx8l4pew/H4XDMmx6MwDSMh4+kt5uEjdhBk4kL/LiTW/3UX
	ZFESeg9dNg9Oug7bOv2FuhWtZ/idhFoIE0xm6tMiv4ZBs1QXj33rrgqKnuRW6YsSTjJM348cGMF
	vUqnjkYZTx2BMFwqilGMiK0ByKlQhEkt+cnHRDvk4cZLpHeMTaVLDSD3hFg==
X-Google-Smtp-Source: AGHT+IG8nJa+/YH4r/N97cqa0KCYtA8hNL5PMjMN2gJjpkl4umwwPNNsr92hA/6zBa1bvBKBCaG6hA==
X-Received: by 2002:a05:6a00:3694:b0:7b8:7f5d:95aa with SMTP id d2e1a72fcca58-7f667b2590fmr14466928b3a.27.1765952813263;
        Tue, 16 Dec 2025 22:26:53 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::c20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb87427besm1537163b3a.14.2025.12.16.22.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 22:26:52 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: realtek-rtl-snand: assign of_node instead of device
Date: Tue, 16 Dec 2025 22:26:35 -0800
Message-ID: <20251217062635.37764-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver is OF only. No need for device_set_node.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-realtek-rtl-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-realtek-rtl-snand.c b/drivers/spi/spi-realtek-rtl-snand.c
index 741cf2af3e91..6b857742b301 100644
--- a/drivers/spi/spi-realtek-rtl-snand.c
+++ b/drivers/spi/spi-realtek-rtl-snand.c
@@ -400,7 +400,7 @@ static int rtl_snand_probe(struct platform_device *pdev)
 	ctrl->mem_ops = &rtl_snand_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
-	device_set_node(&ctrl->dev, dev_fwnode(dev));
+	ctrl->dev.of_node = dev->of_node;
 
 	return devm_spi_register_controller(dev, ctrl);
 }
-- 
2.52.0


