Return-Path: <linux-spi+bounces-3569-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8534915AEB
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 02:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E121C21350
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 00:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682038C;
	Tue, 25 Jun 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCZYZzem"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA39184
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274841; cv=none; b=BfMJgPCffqEuvsgMC8YpMzhLhhSSy4YQm3Hjy4jxAUyNnRrzqeFUhB+oYI248JLGc19zXYCcln1bgEp8NaTRE8DTh/3taW+hOxTG725Fv5F/pVudXiad3g0yuMAHfL9ltaR5vKCh4ub2RxXxUM0luo+KqGu2JxoUG1LUVqAcgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274841; c=relaxed/simple;
	bh=LzvYgPoCULXty/7Vn6ISGlp4JZS7xPZl8pR/eWPeV2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkcFumw38/JPUQckvep1OekvS0UgCsfxRWHhlX4Y+yzs/Y/I4N6BOWizRjLcWIGPGF4FfRICMvpY1k6OUltRbK2dOO8YRNjTIOIcfgf8H/5gtMaVVvQr9B7aGkaOUCURg07I8ahYaXrUD24sVwnI+ummb+mWqj0WpvG1ln9wyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCZYZzem; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c87a7df96eso281818a91.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719274839; x=1719879639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpzkHsUO+Jg8sU9WgIECftJBeKNPYdw5mjZMnQuhjRE=;
        b=iCZYZzemlONVstPAPm6eYcmKKeV/bp22fWyHGY2h41Sil157Bvl8aG5J8J5YEaIxAQ
         GkN9mflpUXCxxjcByP4fwRQnEaUmPdZApCLVY1qGF50YmkVMcwtseRYVlMhjPQ9IJIjv
         JQryQWcETm7ZgtcWdtpG7a59vxsqeYAG3nBivvLA5VoSJBbHpYlGiXnSr/tP8+RuwP7L
         4lLFKTEg1viqo3UiZtlBi7h57errBHrBtJ56olXyef/g+muK4HSRDO3zuDrVW26Kl1Y4
         Ow3UAlq9M1rpWxyPWMgvuJoAjFiqAF4U4aIqyXcF5FTEwBZeZwq8CTzzZMh6QqH+7lzn
         sUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274839; x=1719879639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpzkHsUO+Jg8sU9WgIECftJBeKNPYdw5mjZMnQuhjRE=;
        b=XERcM9QpbULXuZ6+O24JhCCXhDFHChZv1G2qDzQRD3P+h5XHrD/fG6bbhaNTH0VKec
         2EtFEkxQLtGRCE2XQYxXy+JJstKa3G4s6f5J0evTtFy4V2pTSHPXpcIgh+j0alTy47eC
         TNiuaOGxuCiaNUipFyog58jAzgg9syqWYMe1F7ZQVhusgWvPQV1DHiV32KJyMllykzEX
         WX83CD8g0FeFHoP2XDAbbMTUayzo2KuupE2KFybOVgsUruXJYE1XevQ67evnVwWtpfUu
         ktaIZV/0Mo75ZU49RHYhLf/v1TyCLre4prnM4Kh5ymPfo9dQKYU4CSLtfjeBFpJrtDNh
         p2wA==
X-Gm-Message-State: AOJu0YyFeKG+ekRDd1JtW11xbQLRZDiAAfVeG7Uyiw5AzPLrsYZKFBgw
	F0ohUQn0QTmv8s1ADmXKfvW0QitUOIxj5raCHi4YKL9tEaboy3SboYotPQ==
X-Google-Smtp-Source: AGHT+IHUZrx9W/iRHD5tVI/4EPttxLO3FjTubiBHYsWORfh1Ztn7TOnFwczhsXMHY7W5xVuxZPrBIQ==
X-Received: by 2002:a17:902:d4d0:b0:1f9:a386:2b93 with SMTP id d9443c01a7336-1fa0d832b9emr85934685ad.6.1719274839349;
        Mon, 24 Jun 2024 17:20:39 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:91f5:bdad:d063:87c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbbb5fcsm67913805ad.281.2024.06.24.17.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 17:20:38 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
Date: Mon, 24 Jun 2024 21:20:22 -0300
Message-Id: <20240625002023.228235-1-festevam@gmail.com>
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
 drivers/spi/spi-imx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6f1cd3453c97..caf36fb785b3 100644
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
@@ -1932,22 +1932,21 @@ static int __maybe_unused spi_imx_runtime_suspend(struct device *dev)
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
-- 
2.34.1


