Return-Path: <linux-spi+bounces-9970-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB173B52303
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 22:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0723A81A8F
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6B245028;
	Wed, 10 Sep 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFa6BmnG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2572153E7;
	Wed, 10 Sep 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537432; cv=none; b=lQdkI51gIjvIBd9v/6sMgYAvv9y1aJBntlSNqUYC16Po4UhAT/THgvdyH9ujVm4kpOxOck7PSDIId85GFjqMvndoWSHVWAGQFEE6xa2y7sbpyAq36Y5S9ue1xLocAzaTH15F/EwErsgk59ivtKFlZeQouyfHX6UtSnScqem3OZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537432; c=relaxed/simple;
	bh=zCrrWU4+I84+eL99CFwFMBilFmwiaY54cp88tLis1wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZE/I/zJIPkKArpga8L91AbebvMruZ5kEPtWl1QG3sqAnv0OfdZOSkzI2iI0Qmfre+sv3PmZC38wdo58sFoc1XKns7pkMRUZQaYKA5k9XsCd2OsJ2aUv4G1qkU3g4XcFXFi1nUSW74JQor7hAhTfum7dNfsDCNJXWZLf6I/VGLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFa6BmnG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso206335e9.2;
        Wed, 10 Sep 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757537429; x=1758142229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr+o6adacQ3Y9t+4EiVEXOmwmZruCHEfmNH1+hFLWY4=;
        b=dFa6BmnG2Q1OgAuV81oy/VewU2clsdgywvQ6tPnglMHp2RFArFD209qp91s8KyR1H5
         AJgg5mQ5AlAZ2WuSjBuBB/bUh6IyOokLrPaId4qXoBR+mHAqLiFOiOUPtLH/KcTMiXcd
         3lfcRxzvdi7wKQ+gAMbc2pBAKf5lLdbUlcvIW9BzpAxrAbWPmyx7A5PH7qKX8CR3+xSd
         D5sK3rQ+OUKUgR+vuMb32SHy/4cN2uPlDgRrsjvB1gUlEZZb6stf1Ea1OinO7iBMScWH
         G46a4RMIm7TEFcXxVjrTtGK+px2ngv8MiCj5lzvig/XHGo/0Vb1btlc6vo9V2zN19UXt
         WjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537429; x=1758142229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr+o6adacQ3Y9t+4EiVEXOmwmZruCHEfmNH1+hFLWY4=;
        b=NRn0/B2uuAinf2Nj8OvhAIbYHUEU8EaHoGBMETvkpV2C8ZI3Hjn//ozP7pd9TK1pwL
         jBBmHc623UMCpwmHWGbFICYwpS9lArRk4h01TTMKKDU112BqSYPPktJbFaLDG/2IB0l8
         p2L73qXRMUmaa9pkSbbqILtVM0eWkTma35UQSdDgV3fGiYanB+nTOs/S5PjZcCvPu+7B
         MjGFN+UdUU1ypuzLVG7DBnBXrY48Y7+l/lTLF1WwIqTyRr09d15ii7g/L8ET2ZVjnzOH
         8wPj9+Syr3zZQk57fKFRev7uODBH7nWse1zvQ1CMIN/VlRkGPgygYu3WczwW2CodC2sy
         Fjhw==
X-Forwarded-Encrypted: i=1; AJvYcCU20O/xSYncjN6iHv1Ah0mxdQkk8nsQNrRx0wQ9UXFPJ+m4dzA+3YikY3zNUQSgKlg9PCXSTYs/y4U1@vger.kernel.org, AJvYcCUDaTsEVfFazCt8MIYZLT6NlZBuwBNgmOiXDgVR+j7Mj/8CHLqf+Qd75dnaSQc4ZRpJzCSIqxqTRqiUieM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBM5g6sj6wfFgunj7qSTOknbhiiEGmEGwdE36xMcQKOkywx7a
	7mZqfYQlqIdyr+YAXusgegMpUL00hQqpoXuC5r733lKwEemWgSY2UiJYDRVgYjGi
X-Gm-Gg: ASbGncsyYHF+jRyWe+dNMOtbFReYwVQ3cXU6O2aNPLNccbe86bPMBVmBKGjVnqVHtmM
	MSD+KPLA+DVLVnUSWzwEVPXRDJlraoPbhPgLbS9IB8hD6OlcqEo6nhkJxUeVOz3PuD3L2WeQfrA
	WQq580MxYXmj22TDKlls9mpN8DBFsUrfSkK6WynUs1D6bmrbS3jNnP2cJfLAmmWgOsPP6XRpZKa
	qFHyd84ae/2vz8TovZwb8JsamnF6sCL0oWMaxDwdjxwJNy6bSTjpbDdPR9L/pxOaKvFHTTcOzO/
	JJci87v+9IVdGDS5A9likOzPa/qVOYyVH1xgeIa2nYvRkvW/Awu0/6Dx3HwOQqqgFnNXnAXKGvL
	U5EuC4T5mP6UGL1R+cIlictwei783
X-Google-Smtp-Source: AGHT+IGvu07f+l/TsAJDYLsIB1XmRUSZhy6g4+mA6iuRUPfi4Uw8Fv4uiBWrGYrmk83lJNixQsRIJg==
X-Received: by 2002:a05:600c:4e13:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-45de19f4ea7mr157925965e9.36.1757537429425;
        Wed, 10 Sep 2025 13:50:29 -0700 (PDT)
Received: from pc.. ([105.163.1.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b6aa2sm795185e9.0.2025.09.10.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:50:28 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: broonie@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] spi: Convert lock/unlock to scoped_guard
Date: Wed, 10 Sep 2025 23:50:03 +0300
Message-ID: <20250910205003.421067-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Siplify the lock/unlock pattern with scope based cleanup.

Generated-by: Coccinelle SmPL

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/spi/spi-qup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 7d647edf6bc3..ad4f526a3705 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -654,10 +654,10 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
-	spin_lock(&controller->lock);
-	if (!controller->error)
-		controller->error = error;
-	spin_unlock(&controller->lock);
+	scoped_guard (spinlock, &controller->lock) {
+		if (!controller->error)
+			controller->error = error;
+	}
 
 	if (spi_qup_is_dma_xfer(controller->mode)) {
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
-- 
2.43.0


