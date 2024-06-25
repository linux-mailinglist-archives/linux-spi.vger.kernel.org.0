Return-Path: <linux-spi+bounces-3572-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E5A91661B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 13:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFB7281894
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EBA14A4FF;
	Tue, 25 Jun 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7TzSs9m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001E14601C
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314545; cv=none; b=K8zb88OewQDGYAZmAkDtIPMh0rzgNxnmIpr1GBvFf3zMdGPpAwcJIxgDssLZXr3nN84R8fBIhWEdxTw/hIU6Y7lTlt3LLfruQqXicSa079ccPLvMjQ1EhPogaUGK+I71JbAh8EPUDwfuYC0dy8W+ZCPxOpqepfsiYBc579yksG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314545; c=relaxed/simple;
	bh=sd+ovIrJtBShExsgUeg4gmDvvQ25ES/6M6Zjz1QNE9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/FlR3m8MpaYR6XuNm+e3OeEMUxJn2aFvmDlxguT2NbzG15NoJR5KreXAk2gI+fAb5vfgMOsdoagujXSvZ3motlDCjfYHq1H9xaOU2t9nIwZclF7PYgzP5wqEoKpVLG76BwPn+fHGhHGdekdLXd130tQwRdSo1MJftTVYmnvaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7TzSs9m; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d22323a3ccso273523b6e.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 04:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719314543; x=1719919343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMFbhr5lggSiJ83uKqWDi7qbPmeUybuCyAAkERmbGb0=;
        b=Q7TzSs9mE71i5xEKnmV32MoKQktnqgjVHhYF7JRh0J1vNj4VwuPgzE1las/4EpWzpx
         LSKHq0KdAoUbYW5XYfr4QAGUNYXEbN/ygwRR9AgJGNraMaT3TSEuOw7ok/c878rDhOC8
         40oSfJAY2wPsRmuFQDtHXRV+LOKbTF/nGsRzCVim4WUhpK1aWgN39REUlCBVPuAQZQUL
         Bi3tuLezkF6BE4SG9d2JCntmS1I0ZU863WPEG8KE0lF8bepHxTsLrTaeD7foMqybaqpJ
         px0Vbkz1laGxzkgAX0RMqcQwAZYamvAt1L9RDgNKaXxZJhJKtZigdvlCe4dH+vUB9Vzb
         KJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719314543; x=1719919343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMFbhr5lggSiJ83uKqWDi7qbPmeUybuCyAAkERmbGb0=;
        b=OdxVERWP+QlSldHqLv6seuyS1khhlAhwyLegVn1073JvO9VUqiGwJW4bqYm6IKL1Ks
         E7xTnhQvyJhjG4tSroc7lTa/ZQbOwpD+1IpEcTnmiFhIqTMzIFlmrkBjz9S/UmeCLhA6
         8Z69hygdu69iVZ9dousIWl1KzKDiU6I94yDzBd+f61dlZ96sYekwQBUS6qlNo06PFoi4
         WadGv42h24yTlyWHLeOHgkAuJ3e3RgQinAT2g+diRWrC6dNaSue80LnRTbO2M4eZJgYh
         Do525+KrQIJnqVrITh0PEsjd48HtxweEgt65A9XNtlYG5mY/N9lKVhMdP1D5a17bZRUY
         TlOQ==
X-Gm-Message-State: AOJu0YyU/Hr2OAGJ9qFGEHDf7xA++LAEEMdj+sBcoK3k+uE8z09CC26n
	N6ZaQH4bPhEnF+uBjcqUqvQ9qehCx2U3hqjoYaCHZ2nwUxP8HIMWan9PRA==
X-Google-Smtp-Source: AGHT+IHKJc67fOAnT5o36VnLV/1E9DUpoRoJPTuLFdEavWDygnKx6edMQN4Wm5NIkgWGcOtldGjbPA==
X-Received: by 2002:a05:6870:d6a5:b0:24f:e599:9168 with SMTP id 586e51a60fabf-25cf3c0544dmr8564523fac.1.1719314542700;
        Tue, 25 Jun 2024 04:22:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2ef4:1eef:ef84:36c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7069eb83d7fsm594022b3a.99.2024.06.25.04.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:22:22 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/2] spi: spi-fsl-lpspi: Switch to SYSTEM_SLEEP_PM_OPS()
Date: Tue, 25 Jun 2024 08:22:06 -0300
Message-Id: <20240625112206.247804-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625112206.247804-1-festevam@gmail.com>
References: <20240625112206.247804-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Replace SET_SYSTEM_SLEEP_PM_OPS with its modern SYSTEM_SLEEP_PM_OPS()
alternative.
    
The combined usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()
allows the compiler to evaluate if the runtime suspend/resume() functions
are used at build time or are simply dead code.
    
This allows removing the __maybe_unused notation from the runtime
suspend/resume() functions.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Pass pm_ptr().

 drivers/spi/spi-fsl-lpspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index aa5ed254be46..32baa14dfd83 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -960,13 +960,13 @@ static void fsl_lpspi_remove(struct platform_device *pdev)
 	pm_runtime_disable(fsl_lpspi->dev);
 }
 
-static int __maybe_unused fsl_lpspi_suspend(struct device *dev)
+static int fsl_lpspi_suspend(struct device *dev)
 {
 	pinctrl_pm_select_sleep_state(dev);
 	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused fsl_lpspi_resume(struct device *dev)
+static int fsl_lpspi_resume(struct device *dev)
 {
 	int ret;
 
@@ -984,14 +984,14 @@ static int __maybe_unused fsl_lpspi_resume(struct device *dev)
 static const struct dev_pm_ops fsl_lpspi_pm_ops = {
 	SET_RUNTIME_PM_OPS(fsl_lpspi_runtime_suspend,
 				fsl_lpspi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(fsl_lpspi_suspend, fsl_lpspi_resume)
+	SYSTEM_SLEEP_PM_OPS(fsl_lpspi_suspend, fsl_lpspi_resume)
 };
 
 static struct platform_driver fsl_lpspi_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = fsl_lpspi_dt_ids,
-		.pm = &fsl_lpspi_pm_ops,
+		.pm = pm_ptr(&fsl_lpspi_pm_ops),
 	},
 	.probe = fsl_lpspi_probe,
 	.remove_new = fsl_lpspi_remove,
-- 
2.34.1


