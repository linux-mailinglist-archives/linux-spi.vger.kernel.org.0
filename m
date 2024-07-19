Return-Path: <linux-spi+bounces-3907-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8267A93770A
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EF31C21239
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCF384E14;
	Fri, 19 Jul 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMnzPGGB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E24D1C32;
	Fri, 19 Jul 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387587; cv=none; b=DPGPd1UoHSv3ZoUD231+mn+QCWUdsxiPcTYDdEF4aBpV25gmz7fjOe2iS27liH15V5OTPmUK7J+D24rbYFw8c1GBL0WymLQMGFcnMXVCQcSYSvGgjpT66egRWP0vw642v8sSoPhjHHUzhvdeaFff55CYEil07KLD96qcMKEcMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387587; c=relaxed/simple;
	bh=DC0ybkMEDo0yBYqDnFPittEcjXU8kwE86u09ZjMNB0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vESyx8cwWVHh89Q+bwVr5PZwThBuWyKx5gXJvFYPUMSumWWGaSDidf3WNgOcDMvcW4wQgk2z+hhQcYbkXFWYmGCB9kPQKJEb9pm2HXKBjRghTXYw+JHaJA9JwRrgeXbWynq8/DuLm9/BuuWwyTgM5wXg7qWj9xmro5PX5Yjjo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMnzPGGB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb71213df9so188109a91.1;
        Fri, 19 Jul 2024 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721387585; x=1721992385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwdVs2DLSqHKbuCZG3VODs1iI5brfh8JkJ7R8DvpfwM=;
        b=UMnzPGGBW248ffahtT8vmPGII+7ggdxaQaliUgNIQx4YOl9pkZf2fDHSsvnHBamgav
         npr13G8F4hFnvhZX1cioTzgx5OnazizOKzoGDddJTNAWRyGf8nEKswDscYfawVDlokna
         sJblvl/r3ep7GM1ni0yQtfVqdGJtfvghkLacbpuagnMRwmVqb2H4LRADtIBjaRXarjzR
         qk1moaIeJf6BVsZHWS3mpYp51urUT3fB30vpVkSNxYZ1WkJowAE2BMPvhF2NhGTc1Ovc
         4IF+oLrVQAeWfSChnbxcCTLrLwA4t1XO+i9WvxkLEXGLremmoA1Dz28sBY0/hU23gFGx
         qJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721387585; x=1721992385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwdVs2DLSqHKbuCZG3VODs1iI5brfh8JkJ7R8DvpfwM=;
        b=oQXj+Dwe3BFcLv28fPcI/VKyW158xVMJUs5rUFUBSWLBff7us+oSQJ9kvXNAaa3aZX
         j+EBZn0WnA7PnSL5cw35KHjpKNEb7qXmIYUL1xsZF0ybeskQECQF0eRgPUsDlORFf8PX
         UEKg2V7eXDW4jQg8EiYVzIcYt1uj7/NVK1uKFpbqlyPSV+rOKhEaL4pGjvMAf+x1a6Ej
         NksBuu+iGX1pecgClezVNQU79MWAbmapFa/dueABX9GsBbIZJnU2VlDrLUoUTot2zhPD
         4vde1jwU+8ix57AorVuDlyuT9IumNmjjiLsO4nxW2c8WQmzvkc1EktxcEw03VUdHUGdY
         XOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlDxW7/Dl7BkZMDa6tUbt2mnXKF78QANY9qj55LCGteKufuBdCF32zkCJW8RZXThly7X0bFRON13rMa/Dih+DMJlDslsA+iolfsg==
X-Gm-Message-State: AOJu0YxZOV9McMreIT6SBbzk06oLexBa7yYNRtzPYQwek7hOdSXP7Fyh
	zxi0rkAd2gTJX1XvcPX1Vr3w1Wvq8EG8lUW08jxYoHjs3My26rue
X-Google-Smtp-Source: AGHT+IEyWkYrn2f4kY/UJ4e4OMVmD6NdgqFqxUPqazjVXgiIm+1d9lxT1kLGea3m1QnA1vdO2nl2xQ==
X-Received: by 2002:a17:90a:b392:b0:2c9:36d3:8934 with SMTP id 98e67ed59e1d1-2ccef64f937mr1598516a91.1.1721387585336;
        Fri, 19 Jul 2024 04:13:05 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc92:63f4:6f0e:1985])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb76a619e8sm2303031a91.0.2024.07.19.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:13:04 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/3] spi: spidev: Add an entry for elgin,jg10309-01
Date: Fri, 19 Jul 2024 08:12:09 -0300
Message-Id: <20240719111210.1287783-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719111210.1287783-1-festevam@gmail.com>
References: <20240719111210.1287783-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
The marking on the LCD is JG10309-01.

Add the "elgin,jg10309-01" compatible string.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Use a more specific compatible string. (Conor)

 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 05e6d007f9a7..316ed3664cb2 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -730,6 +730,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.34.1


