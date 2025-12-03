Return-Path: <linux-spi+bounces-11752-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F233CCA1366
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 20:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E28623140B4A
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 18:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79898309DC0;
	Wed,  3 Dec 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV7aHWaY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921853064A0
	for <linux-spi@vger.kernel.org>; Wed,  3 Dec 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786002; cv=none; b=PaVOq5dweui5QsZuFaeLUEBXG5P8b/l3CPg28c10k/jZyIQdGAI/y9BBGAK+Qv7V7Tw7rLU5NzUNB+2C/jkpXotv4lROY+B1jQ3qZEXRxRXGLYDdWAoA8NcQgPFyqItrMRaJxuoGpsYYkalAaFrUeC1JGZRmSHBu5ZBZFm08LrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786002; c=relaxed/simple;
	bh=H8AwiHRnq/MCnVsoklQdec+4YNyo2HGWFkIhf2lY4gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFQCGtCoYU+BfDYVGsLVwhcQChk2Sb3bXZjhPfhoM44oXdSkXlz1y/222xJD0resBKKgldOEX2Hv3GHNNwz7O6HURC5zVHjnbbs8vdE8z+YkdtYM4rsXM6YGUJJTiatdEJ5Ts9OGvESQUaP56ixkxcHsx4piNqVGrDg0Kd+whSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV7aHWaY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47118259fd8so602875e9.3
        for <linux-spi@vger.kernel.org>; Wed, 03 Dec 2025 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764785999; x=1765390799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9ZHiU1o0pJELuts86Z685yYz9R3gCIIvwtPmT4YfOM=;
        b=CV7aHWaYoUutndKZ6ZKahT/7buLw5+eS5p8gaDQTvzfbK9uewq+dp1vsnCbPqAVXov
         BvffHkLXZJqzqPPbLPZ3Sx8E4gZVSdPKBtVn6jpss32F1xMyN2Hv5ZiFlsB1XNIJb/Op
         UMjgsc1MT7Y5fm4sOKTFnSp8qA26TsDGXGT3xj1umJflgVVQ+k9xhLtzAnqegXZNfY6i
         OXEnku6uch+gAjiIyVBjwfTF98VYcWGKF6V90wNXEtg/1ZXgtH3KFVFy9LmIXTpKb4u0
         UuNjOpDBeRbjA5ZRCIQih9Hepi1XnFxnl9Mv71iaUcOe5p6g05Y+xfimrt+vea9lIXhI
         hl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764785999; x=1765390799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9ZHiU1o0pJELuts86Z685yYz9R3gCIIvwtPmT4YfOM=;
        b=JOfcoUbUGJgAv3OiaV5I6K03shsvHkXT70hV8DnGuiXImC7fhJeZ12nystB9RuUld0
         fv77FMRr1MGmvyuJVOWjESZe4YUkbzp0XefVJY7DDxmTte6G5xiGs9Fha2algG0yUVJB
         mFCpWAlMC7ghD4yRmwgH+cD3fg3Hq+H6ymAg4rEEtgvZtb9q4ZbnPKRC1QgVgmVPNg7M
         kDIaqgiis7sjrvKx2ZBM43UUzZ2YTnnJNcDp0OXNqcqaqIvUTBAJEHyehkv5C3Bm9I1B
         ovetfQzGdwa6e5CRvAJ7Q0lBplCxl1/2iHg1ne+YVVJUpF7PzQ2cz8/Bat44JhIVFj0U
         RZqQ==
X-Gm-Message-State: AOJu0YyokOdfDlPBmFj3L0sKkOzhCDzATU7EJEMRLCy8eONYjXaJK7jb
	dDwY0g/wjjmLJJWNP+tGd36l4+LRgPK1+xzMF9Q9kuByL5PsDFx8NoyG
X-Gm-Gg: ASbGncsH1McyZHrVI1JodZoQNZOszEgZiOSeMbRGbAPQLMUNUUN0Wt9eDGA1gzoGPQT
	E4DTpVu5u4jDAQr44hrTySADSSQkCLLMEtbWxkwwiNNzp/7umXneFwlq8Y6+TOtyyciIWpfQvVx
	W/LIVExMxRLe3RDN8tlb7KgSzJ9lsNT2lbQyS83GHlWM9bXl0dyBwSINypnzzXyAyucx0pbA8wN
	7jDWnNf0atgkbT/SUjwUgzCQ+4N3Y1j1zhQwQBdroH65Bs7ks3Ys0nhl4AOB+lVwpIHf1jnjLis
	AftAP++HV62aO82T92o+RyRkZWdzJU7RY1sQq8RaogMwQxlE3p5QdwIbLkEr1DIru27S07el2ZV
	gHDg8ygIhLfTOOmUzTpengI529F8sIKGFBosZw6tvp0/Jvc+utahvkuIP+6CNxmOE1UHCl2m/Je
	YR8h4CdxnLumK2aIEqxx+n17rq9WIorQ8/xfB5h4bEyE010+WIoDDy9Q==
X-Google-Smtp-Source: AGHT+IHZKgnW9x4VKIYpwKAtdK+00D4dW5+LduzrrHUqeHH4B0Fqr8ROUycf8i6Wv6Rqr/yc41RSiQ==
X-Received: by 2002:a05:600c:1d0c:b0:477:9c73:268b with SMTP id 5b1f17b1804b1-4792f39cc97mr171025e9.33.1764785998691;
        Wed, 03 Dec 2025 10:19:58 -0800 (PST)
Received: from akif10xe.. ([2400:adc5:14f:4100:f44c:7909:c68a:ff47])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4792a7975c8sm68766565e9.1.2025.12.03.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 10:19:58 -0800 (PST)
From: Akif Ejaz <akifejaz40@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alitariq45892@gmail.com,
	Akif Ejaz <akifejaz40@gmail.com>
Subject: [PATCH] spi: cadence-qspi: Remove redundant pm_runtime_mark_last_busy call
Date: Wed,  3 Dec 2025 23:19:21 +0500
Message-Id: <20251203181921.97171-1-akifejaz40@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pm_runtime_mark_last_busy() call is redundant in probe function
as pm_runtime_put_autosuspend() already calls pm_runtime_mark_last_busy()
internally to update the last access time of the device before queuing
autosuspend.

Remove the pm_runtime_mark_last_busy() call from the probe function.

Tested on StarFive VisionFive 2 v1.2A board.

Fixes: e1f2e77624db ("spi: cadence-qspi: Fix runtime PM imbalance in probe")

Signed-off-by: Akif Ejaz <akifejaz40@gmail.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 638edca3805a..bf0677949ba8 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2011,10 +2011,8 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_setup_failed;
 	}
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_mark_last_busy(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_put_autosuspend(dev);
-	}
 
 	return 0;
 probe_setup_failed:
-- 
2.34.1


