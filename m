Return-Path: <linux-spi+bounces-3571-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BBC91661A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 13:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9DF281720
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A717BCC;
	Tue, 25 Jun 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLm3AX8T"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280614601C
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314542; cv=none; b=hlixXRHfeI4+ueyifcQaxw38ifVYcTXjp4Y/q//4AKC2db9HQYON6DcFmctXnUzSD02wfrkzfKg3Wt6kDKrFE4xrqhV+qwRSAWpyPsEE+wPAa4O8VKDcmrQCBkRBFWoGuIDjtAUNeS4R6e5kI/VnpWhMRb7dPMFRe1DlfpP9cEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314542; c=relaxed/simple;
	bh=0RXuDcYfqhvMNTXPYSeO+4Emq/8IOrPEjOsZ4Evm1DI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NG2jXFabG8Nqi0u0SxHgp5PKzAWJD7VdYNmdGKFnTjzQABOo1gPNYIVCLT7HXuLc3ZbXy/tLZgYDG6wQ1yH4FYoTZrrvBmalEAR4yPJNSFKsP4lHajXlsMV2bDwnAOTJGRUdDe0wKB5U0TOE2baIFvKXJym/2R1tUJR2COPfePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLm3AX8T; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-254939503baso736043fac.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719314540; x=1719919340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRAo6q1YcsHj+WSAL550qdAcHPXUyPYuUXj8gpOP9b0=;
        b=VLm3AX8TX4pkuebcIoZbSmY38JK3xWH9q3OrSqjShRschr08uHVk9SRaiABGu/tKcF
         0Xlo2p3ItTpTPqHZq2TVUb8Cvn6+L6Ncr+C/MrDRrDYZ13lSjP2IEiH9ppd9fkUcSYb4
         u0boIXAQYzaybLhCZYvKuzp1hvmFvFxO0qs4xpSpHtyjMxxtI094zuELYCk2iqh7ilMF
         FmUC+L72yOD5pXVMJwwGI6TRapQltcq7IyUaOz0iW60EHRiODIk2LV5eS98gi4ZC4+mH
         9+0vzhAY4JaYTuF89Tc7hsGoEORW0iTFFaP3T0/yNw7PpK2HHsdH66LfWm41ahzroawh
         oJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719314540; x=1719919340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRAo6q1YcsHj+WSAL550qdAcHPXUyPYuUXj8gpOP9b0=;
        b=JmyyTcljQklu9MioBwh8CKHhnuuCtqG/qSXcp0ZaP3tZTbK2jf8S3OpR2eUpBSjolU
         CVAW/0A9flaR/OA/43n7GC1jJ+x0pjhPoJE3OQXpgWoaaAvVJzSSagFUe3H9jvCQE5FV
         1PhYXoVfVgVjMlTFlEnF4D1T8WxD4k94ChGiGJMDWCJPQqkQYOWyHUKC+InQdXR8sI0T
         xymAi43KL0reY/vOAEorZhSUE29VkDjz4rCRbt0u9TSeac1nb2wuF/nCOlf1JMtyKfZY
         pYmGp/0YDCVAFcrhNAvYA7biKWv1i4ReDNe7tFTSXh143e8MRnLIBFdLlIQFFErpkVuZ
         9WHg==
X-Gm-Message-State: AOJu0YzIjB5q9N+EkFCpqNjiN9f2GLEtw3PcbgQh957lzvmHMlILozoI
	+qsPCq0ro9gliNp8afaa7FwRayWVkaaVBzASuDP0zBIvLZGp0c4y7KSbsg==
X-Google-Smtp-Source: AGHT+IH6NUfU0uRBM7/jdqenE/J2fzwrtBdow5i+c9vuRo0VZJfK/sgWvB4nT0tzdD7zxKyfFQ5RXA==
X-Received: by 2002:a05:6870:b623:b0:259:f03c:4e90 with SMTP id 586e51a60fabf-25cf3fba001mr9077705fac.4.1719314540383;
        Tue, 25 Jun 2024 04:22:20 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2ef4:1eef:ef84:36c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7069eb83d7fsm594022b3a.99.2024.06.25.04.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:22:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/2] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
Date: Tue, 25 Jun 2024 08:22:05 -0300
Message-Id: <20240625112206.247804-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Replace SET_RUNTIME_PM_OPS()/SET SYSTEM_SLEEP_PM_OPS() with their modern
RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() alternatives.
    
The combined usage of pm_ptr() and RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
allows the compiler to evaluate if the runtime suspend/resume() functions
are used at build time or are simply dead code.
    
This allows removing the __maybe_unused notation from the runtime
suspend/resume() functions.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Pass pm_ptr().

 drivers/spi/spi-imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6f1cd3453c97..4b325220a7ab 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1898,7 +1898,7 @@ static void spi_imx_remove(struct platform_device *pdev)
 	spi_imx_sdma_exit(spi_imx);
 }
 
-static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
+static int spi_imx_runtime_resume(struct device *dev)
 {
 	struct spi_controller *controller = dev_get_drvdata(dev);
 	struct spi_imx_data *spi_imx;
@@ -1919,7 +1919,7 @@ static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused spi_imx_runtime_suspend(struct device *dev)
+static int spi_imx_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *controller = dev_get_drvdata(dev);
 	struct spi_imx_data *spi_imx;
@@ -1932,29 +1932,28 @@ static int __maybe_unused spi_imx_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused spi_imx_suspend(struct device *dev)
+static int spi_imx_suspend(struct device *dev)
 {
 	pinctrl_pm_select_sleep_state(dev);
 	return 0;
 }
 
-static int __maybe_unused spi_imx_resume(struct device *dev)
+static int spi_imx_resume(struct device *dev)
 {
 	pinctrl_pm_select_default_state(dev);
 	return 0;
 }
 
 static const struct dev_pm_ops imx_spi_pm = {
-	SET_RUNTIME_PM_OPS(spi_imx_runtime_suspend,
-				spi_imx_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(spi_imx_suspend, spi_imx_resume)
+	RUNTIME_PM_OPS(spi_imx_runtime_suspend,	spi_imx_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(spi_imx_suspend, spi_imx_resume)
 };
 
 static struct platform_driver spi_imx_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = spi_imx_dt_ids,
-		   .pm = &imx_spi_pm,
+		   .pm = pm_ptr(&imx_spi_pm),
 	},
 	.probe = spi_imx_probe,
 	.remove_new = spi_imx_remove,
-- 
2.34.1


