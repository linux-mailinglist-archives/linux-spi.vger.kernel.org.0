Return-Path: <linux-spi+bounces-9322-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB0B1E8FE
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 15:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739F156378A
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF87C2236F4;
	Fri,  8 Aug 2025 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK3Ltem9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92720ED;
	Fri,  8 Aug 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658947; cv=none; b=RyEiw4RrsxI7ekR76KD5I/RgqqG3+RkCraNrPU4vzWfHw6V+vYgIfpH2S2T7KvRvpKi9OR1GON2u5IQu1p/3WnGCwHla+F8FefSgU+cYMB//S0X1UIE5QqIDJGTGemquKkXeYm5sNVgzZ/yxMKLsRZRIg6kBeL5gogJZj0gWry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658947; c=relaxed/simple;
	bh=/c/3ELZFI99gW6DcjSHSORefHFslQVq9cw8quq0LzQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YHbjzH+gBzoMwUfG9PGcN9CQPHPjHmw1UxOBaj6TJ8ICseI2VOoUBPrj1tymgwBkzZQ9OLPejhfrM91XZHsJyvxHhGSVbMNLB00cSehejh2kloGFvWY/VZd5JEVjjGWyQ4I7nvs5OmPcyfHe4dFTEEpP2IdaAB9oibPG4I2yrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK3Ltem9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so22153205e9.3;
        Fri, 08 Aug 2025 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754658944; x=1755263744; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ry6x22Ql3nl8DH94R/jPFtjKq2AMKet/YwTFTMtNZxM=;
        b=JK3Ltem9nUwBRxAdeic5lDHMpqQKQPCWtw/eW/pQq1UijNnNPdyxDZJS2AcWbtCQE3
         jpUZODwoFHpPbId+EhH+Kk3IC4fwWB8ehkBr5ETjnwWzAcKHGLMIWpQlfI6BAz78CuJM
         X8mH+tIvqMmKU8NRrfHxRmDBfE6gHAUeGO+eTFJvKDBlsCMFU5GEsOd3ZzIkdy1HpS3t
         XN0qRlRtNoxXMW36uwk6SqFVkn1Yj9rga09/Raw/RHnHPfIQG+nA3XbkwKr0nUMb+P+6
         MtpWZIbmqH0F3uM2Q1+Kkz0bYkK+ZSGh1blFXW5bHMBTZjiULK4ul5J4h3GB6ThCD5W9
         YdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754658944; x=1755263744;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ry6x22Ql3nl8DH94R/jPFtjKq2AMKet/YwTFTMtNZxM=;
        b=qGW2qaELKJ+vsWZpVMpYdN39sn8bR4+1XLAb7+MFrRCOFUB+tjOKhfaO9WEScyQz6D
         Te8LuMu86msH/z/scankeCoNqj7YU20y9WoaeFHwI7nDFaO/+zlh/y8D7FjVhNO0KJ7F
         kyXTchiZE/a0ZG2n8anYNhWs9HyORphyzhxqsgG16e03KQmGZZReACyKjKcMR9WIxjw2
         loltdTn1L9SdQ/wsH8epDgLIrN+IW36ZfIGqVEzUdmm7mhcmSC8N5eA35J9jzAXqFErF
         bFfM5MWKBsgIYzSe7HdwnmfkVqWsIcImzwQvHieQxRMFK0ZVc11/kyHh9T1oSy7GdNAC
         4P4g==
X-Forwarded-Encrypted: i=1; AJvYcCVyLGD09XKLSsQjl/yKCf4MMIjjKQtTzdNNvjsx+nLYBdVJ/TvvGQ/r6gzYM6kCv5FAfIRD/SCdljAqydY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Z4aR9oEdhXPbZ+RXX7Z2z/+eb1DC1lvANuMOLG9qgAfNdJhr
	YY8UA52TcGRxBmULD60MTcE1VeI0RLC/lAztkIy2hSeg43Hx9ikn4mXDvWQccA==
X-Gm-Gg: ASbGncuCmh/MneaeX9EFCKvsjbzLzwEKbYhlAzeYNpp0haqzGBfg+WWmQ+M74uXJuyi
	Y2hH9LJExstBXGh93PewAQKAE3+u/M+g5Uy3PgUmd05qxV4In8v7YPGdVlDgPMdbLuZjVlNCw37
	aSXILd/gSXaR8+7x+UJId1rlDZ1XFKUPo4cX89vjPvWv2Jn8IlFl8zZfOCY7JAul95s813ytrWi
	8hjH3OsaYGEqEOBh6/W7kIGhoTwDL5G0jPM/Vg5LgYKx9Ef1RymR/gqowlh0IfuS84Yb917ANWh
	saRqIOu14gOvpMdUT4syIdME0+euJMQwcs30J5uGpjZpjf7yDipofMZArDOO1blu/FnzDOCd3Yb
	31A5hWCg7ELrHivN3C9VRXJ1b5OnxIAq4kA5Ev/DiiO8PNIIVe5YLj3ZYyu+8Gg==
X-Google-Smtp-Source: AGHT+IE9H15nh3QBwoBfhfP06cxPUaX8QZME5vr4bQT5ni/lcw4mt4p/xQCVMxg3f6Z+yrtLIW7rgA==
X-Received: by 2002:a05:600c:3589:b0:459:dfa8:b881 with SMTP id 5b1f17b1804b1-459f4f3cfd9mr26391955e9.7.1754658944127;
        Fri, 08 Aug 2025 06:15:44 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e587d378sm133667145e9.23.2025.08.08.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 06:15:43 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 08 Aug 2025 15:15:32 +0200
Subject: [PATCH v2] spi: spi-qpic-snand: avoid double assignment in
 qcom_spi_probe()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-qpic-snand-double-assign-fix-v2-1-1a3d0ed0d404@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHP4lWgC/33NQQ6CMBCF4auQWTumJSVQV97DsChtgUmgxY4SD
 eHuVhK3Lv+3+N4G7BN5hkuxQfIrMcWQozwVYEcTBo/kckMpyko0QuJ9IYscTHDo4rObPBpmGgL
 29ELbK1c3ndZCGcjEknyeD/7W5h6JHzG9j7dVftcfrP7Dq0SJule6FlLUTaWvw2xoOts4Q7vv+
 wfSVjPDyAAAAA==
X-Change-ID: 20250801-qpic-snand-double-assign-fix-cf4d78b9904a
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The snandc->dev pointer is being assigned twice in the qcom_spi_probe()
function. Remove the second assignment as that uses the same pointer
value than the first one.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - fix a typo in commit description.
  - Link to v1: https://lore.kernel.org/r/20250804-qpic-snand-double-assign-fix-v1-1-9f4970107859@gmail.com
---
 drivers/spi/spi-qpic-snand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..f6acf095fe196c3f778ba1c16157fc4bf273b66d 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1541,7 +1541,6 @@ static int qcom_spi_probe(struct platform_device *pdev)
 	}
 
 	snandc->props = dev_data;
-	snandc->dev = &pdev->dev;
 
 	snandc->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(snandc->core_clk))

---
base-commit: ffcfd071eec7973e58c4ffff7da4cb0e9ca7b667
change-id: 20250801-qpic-snand-double-assign-fix-cf4d78b9904a

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


