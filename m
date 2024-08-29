Return-Path: <linux-spi+bounces-4420-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0503964315
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 13:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E41C228C0
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD372191F97;
	Thu, 29 Aug 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX6OVxnP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38982191F7C;
	Thu, 29 Aug 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931146; cv=none; b=UZ9/lTGH7CDwY5ADgm3eS+XyD15B3/+eytIUNBAX5QU4XhI3KSUp2aZHSA5g63t/2w8tlNtB1mKxcNJQeDHa1p1mqYVIWDosZ0/Ju64VZYwigY22m7mVb/W6naCaT3x9uXUuatLsCZjYxryq6kpV/cCDsCMaWKSKx5k7mB0O760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931146; c=relaxed/simple;
	bh=1JVY0NYSAUGDETc0dN7ezxbZ31/ZiYFxnQ4y9C9C97U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/xbKhtIj0iHIbS7N/u1AgS+CwbNJr2THYttRLfga6fXTDCzHHzvlKmP5C1Y7IeldCzEEj0lpKp6+SszkMLwIQCzT2z1BMzpEA9w39uR1yhWHLfOge6ALZ/bPzYwCNLYMWerZCyY2q9FQXlrFdTJ6iryLP/ZAlHSLwX8mF8ZFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX6OVxnP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20202df1c2fso11687015ad.1;
        Thu, 29 Aug 2024 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931144; x=1725535944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve5miaNHTj/DG8kxyX2sEyvCSTRto6cBtski2G3f/4k=;
        b=SX6OVxnPldU/YAIjFk1CG4i/Wmrv3w12YEMhk6FitLLcnWZ2lr85HAr3NVmS0povjC
         NhWQbQVZLMJ1BcZc4CHdof7DiReYbFHFbtaJZeIyq/iHhSdFpiJ9BvAab81moSFDQoTt
         tFqQTcx4P9m3J6xdbH+X5EJLtYOY/cxOOFUu3dIsXOWU17dlPB0cLPdJiYJwDrr97ZKr
         MMWTsBFINLn4p4F31jK01L6R686guG0fhDNDpl1ssNM6ClVezAiXEcsur6Q6jEnxmdtF
         Za+j/TYWnZAtxW5nVbVfNTuuZybC32TyneFioESrOGVjCT9nlsYwJObAF7LMRFCux3b2
         X6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931144; x=1725535944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve5miaNHTj/DG8kxyX2sEyvCSTRto6cBtski2G3f/4k=;
        b=o4cRw5Dsuwvr+4NMtJ1+mxrM/LHN1lZnBl31MZO6folzjHUr9bOLKsBCCTQW8uaK7j
         u/NXVcpau1o35Xhwg2e2A12MynjWZGijyFYkSf4qhuw+8/0sOe1dby4xPL2E9VPdwERK
         kvsJjvMrxNrHbgzm6KTvNCDd0NQZTmHijH40SUqfRd9AiyKFkFTADCx7ZxyJ9LXaMe49
         XB9sBOUWcq9gJngZ+zBchZBHOj9tV4pqzXTa06jkqn6ug9Eb11CBb8nGdLYmcv/DWyx3
         Ng1NGZ++9ogrczPhLpZtDOBSrHIOW6uS9oLTn4Z/ThtwEf/cy+JLhsjplT9hTm29JJHK
         LIpw==
X-Forwarded-Encrypted: i=1; AJvYcCVbnLP/ig8d2yZr0iOyAoqbKdcxjX+nFWukF29oamF+3kFifWeQ9OZOAaKSyb51KDauvZcbeRX6tHzB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhg3Ls2dcDreP8OQO/AtCDfYBG+lD3LP2+QazSA+6H/5DV/n+P
	KYVaGEQCgVnAjb4eAuBxta4H2E6TkNVJd1SbUedCOu22NPCugMORo0r8hw==
X-Google-Smtp-Source: AGHT+IHyd1LjKOk4YKRCWX3gAojxcPy3igfQaJXsAr+L+Sn/Kh/NRJHCLuIjaQPn0Muk7reTWePrkg==
X-Received: by 2002:a17:902:e883:b0:1fb:80a3:5826 with SMTP id d9443c01a7336-205166dac83mr23677115ad.4.1724931144345;
        Thu, 29 Aug 2024 04:32:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:adb0:3b7e:78c6:e307])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20514fce4fdsm9652665ad.0.2024.08.29.04.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:32:23 -0700 (PDT)
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
Subject: [PATCH v4 2/3] spi: spidev: Add an entry for elgin,jg10309-01
Date: Thu, 29 Aug 2024 08:31:57 -0300
Message-Id: <20240829113158.3324928-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829113158.3324928-1-festevam@gmail.com>
References: <20240829113158.3324928-1-festevam@gmail.com>
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
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changes since v3:
- Fix the series numbering version.

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


