Return-Path: <linux-spi+bounces-3570-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B9D915AEC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 02:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093C61F22421
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 00:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8974437;
	Tue, 25 Jun 2024 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6JPhxKM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AF184
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274843; cv=none; b=k+iVTQUU2Luran0cx09L3DERxIIpkX6nwZnF9W2rOja672VmoOGjG+6LBdR30z7eidKnatES3mv93u6O97KDmWrsVaMT7ts9aDUls/QGiHSWqfbE9WX3hjxIeFsppWk3vBCihUKp2GxUhHyqmpPhS2KoOF/kd7n2DgEztFqbV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274843; c=relaxed/simple;
	bh=p1suwUFD0rTGP6SY/KOO3rleeioiKQmFUzYU4dE2mzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wjsz4/53OfyyRAZcngQV6I4FAqFyskW7Rpnm3ckPNKuEXL5vvDQqDrbcFxQOoTamzYcJkf5lyNfFhNq9V7X3FYI1W/Aj1LB3yukWV0nkUMJ2qWuOrxfeVA1OUuBcXZHew4amNfUceyE7DYck2DeHlwIaE3QLLkV0ZQi+1j6UDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6JPhxKM; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-71d125f2d96so226810a12.2
        for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719274842; x=1719879642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpOPOc0m7l2zOTjNdYHa+1JNk7lo/Ki5SFDkJ6R+5uU=;
        b=E6JPhxKMqxJKRjsO5zeOvTuw5ImC91JECw05pGYlmILJ477kggdPJK46y8BlYMJfpE
         KgZzgGq2vTKKoVwLE6AWgeOpY3vmKulIgC3yDC2rL5kdyCBbJEnkkAJYjdYujHymAYMx
         8HQ2ynHN9wmuNS3Ra2wLhav8ZLE+UtlnA0lalFvbeMGq+jSBt95ZBM43UKVso9BFXT0x
         I6CeN20XChowtpEnMpG+zogM3dZ5vkDp7XofmAxZ/JlUoLzHxCkwgdBoVKgiKekvIbqS
         mXzFsvrAAfOU/yErNZ2p8/OKwtk/fuj38uZVpjT5xhTau3YjMpq4GIkXfoiZ22bn3wvr
         y5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274842; x=1719879642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpOPOc0m7l2zOTjNdYHa+1JNk7lo/Ki5SFDkJ6R+5uU=;
        b=u/1VYmFANA7LFsAMkRAqGzGH7FIYZZBqwBuxlX0geNG35nar5GLtY+aqxdfI++Xp1C
         WESNeeseq9zRWGAeTJwY01/hAqDYRvPuR5Z8zG8HVtOGJXtVntA7RUTCm7bbWrzhxSP9
         AIkTPF3KFjuPvgE354A62uPsTGkl4NIJ+eNQA8ApAfueGbSMWNxv9dHghshnEuygoqUs
         BJDt6nJHxDCqJa8KJylg/lZIMkMDku3OzBS5iG8vmxpFHWqgVlBRcdLmRbixybrUKq1y
         j6WL2hWpmAZOSgtn6Kp0U/SoFWlrYkpARtEcJ4u5/s5bcW2/k7BkAom+I3Izmf7uqZf0
         Ynyw==
X-Gm-Message-State: AOJu0YyBlOB82rnGAAqVbYJjsWfwcL9/qq7QkKkPgY3jw43rEZgtUJZz
	N/Jwf+AsfUJCLiNi/SShGzZE8CnBLBjgMjtPVadR8Z3vaaGFzQgqSu7vRA==
X-Google-Smtp-Source: AGHT+IGo3EN1Rm3riVVX0FzrH3QX5DWASmWbN1jjk7oNGGFRelaiAC5DyBBBHhQIG45oF1m+7pGCiQ==
X-Received: by 2002:a05:6a21:622:b0:1af:cd45:59a9 with SMTP id adf61e73a8af0-1bcea4a1cc9mr7190905637.2.1719274841634;
        Mon, 24 Jun 2024 17:20:41 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:91f5:bdad:d063:87c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbbb5fcsm67913805ad.281.2024.06.24.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 17:20:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] spi: spi-fsl-lpspi: Switch to SYSTEM_SLEEP_PM_OPS()
Date: Mon, 24 Jun 2024 21:20:23 -0300
Message-Id: <20240625002023.228235-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625002023.228235-1-festevam@gmail.com>
References: <20240625002023.228235-1-festevam@gmail.com>
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
 drivers/spi/spi-fsl-lpspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index aa5ed254be46..2908a5532482 100644
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
 
@@ -984,7 +984,7 @@ static int __maybe_unused fsl_lpspi_resume(struct device *dev)
 static const struct dev_pm_ops fsl_lpspi_pm_ops = {
 	SET_RUNTIME_PM_OPS(fsl_lpspi_runtime_suspend,
 				fsl_lpspi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(fsl_lpspi_suspend, fsl_lpspi_resume)
+	SYSTEM_SLEEP_PM_OPS(fsl_lpspi_suspend, fsl_lpspi_resume)
 };
 
 static struct platform_driver fsl_lpspi_driver = {
-- 
2.34.1


