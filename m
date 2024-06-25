Return-Path: <linux-spi+bounces-3585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C954917063
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDDF1C262C1
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 18:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879C179206;
	Tue, 25 Jun 2024 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl7KVDvN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E20148FE4
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340774; cv=none; b=Md7N9fepjNbc5Lbr+7wmwtzHuStZl0GFh+hhjy0Ohige7dypDYABD6e/F16mXpExt9dr21c/iEFQSADM9ye+qOIl+xzoMs7nj1G65IgOMRUjHKoqW/0BzytXoNa5ZnzrriaqzF5O0gqzVIhEWgBwOqd7RlUatuSiMWgrtCyWEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340774; c=relaxed/simple;
	bh=T7JaRzOUz4Ur+iq31i5D/WrqwCdnWUyNAuDCVI2GEHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OlK3YJ4sZDiYv7ISxQ0awAGdLD4jfgx7w2tpad1ieHjX81TJ1uxFmImGlNYlEVNtSsbeM+LO0FUVDtQO0e1r+KxBNIZkBuP0HKriDjGv0c5phMp9IqILXRtfN5j2opWcvrn7UkLqx+WifzKM7cLZlRZcJEg4PLkSZiXZnuueI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl7KVDvN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f99e2dc8cdso6373845ad.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719340772; x=1719945572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSTtw/y+CU7PPtzgaKBOlfe9lUFooh7eok3zC78VexM=;
        b=Gl7KVDvNJ0CMar+eQuA+bqAYuy8fdBqQs9aMJK7KEoYv1xNms3DDDiKJGXAFR5damO
         6UriczxSzd2CskPQImTqrpPBWcDfni4QKp7+Iulvb0WU8aJPhvl2t1L94uVu/txCedOw
         KOy7u0knFmAo5b0dy2oOY7EztVBFo+muFAB9Tuj5bTAum+5tAuvTjOsVQ2F3O48jqWIz
         Fr11gZTrTeMt2JOB89gfP+iAWaXiDGyPoF5emsRQKXTsKkqVWaAa+pHXeTfuh+kcvzHr
         mwBLQD1f1mqH3SlYOa9MLzp5f++IZD2Ow8fdtkWO5DajQoTTk3QPGGX0+Hkze/AuYXYx
         8msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340772; x=1719945572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSTtw/y+CU7PPtzgaKBOlfe9lUFooh7eok3zC78VexM=;
        b=c1wHD23c5YIYrSWlH8dqDn2oXXohMrNlwt0twMfDUvhg6jzex34WYuJ9b/SMWw5gUt
         QxZ+ACXrclyui7TH4PNXqS3o8QRjLcqQtrdjBHI58VckAcIaUXA5GQBFIRMVKy/lUkG+
         ZIO/BtUA7s4rs6g4LLlsRpMqs0lxzekSWdF41g5vRoah+scAFHXh1w2ELy6uc25sOGS2
         +woIbYTwUJjbCL3Wsg9tU9wTHQPPEYWI05T+RIFQNbA1gHirz5M4f0PWCovIFISLmKuw
         dgB8ohmxkWfCqSqKgdmWeGWgeokJDq4wSOeXsSNkD2iI2zaPsXLpMC+7A6drDtZxw5ry
         iANA==
X-Gm-Message-State: AOJu0Yyye0lSt3J19CEvWOXXWV8q+dFmq9FSrUNEk3L+9iJ+NvXw4HLB
	+BnM9jLq9bQYWPWA5UYYs22rQ71ixKt+9LZgZaLx3iGvynk+eBY5
X-Google-Smtp-Source: AGHT+IGnpHvSsvWTdAgqQqKvYJl2C0gZkKCZR1SMN1b/QzLd94BXJ+m2QjPDyJpLAtS7VafYijo0sA==
X-Received: by 2002:a17:902:f688:b0:1f9:ecaa:75e9 with SMTP id d9443c01a7336-1fa0d8166c1mr110352335ad.4.1719340772344;
        Tue, 25 Jun 2024 11:39:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1451:872:213b:5880])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f0545sm84437145ad.27.2024.06.25.11.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:39:31 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] spi: spi-fsl-lpspi: Pass pm_ptr()
Date: Tue, 25 Jun 2024 15:39:19 -0300
Message-Id: <20240625183919.368770-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183919.368770-1-festevam@gmail.com>
References: <20240625183919.368770-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

After coverting to SYSTEM_SLEEP_PM_OPS, it is necessary to pass pm_ptr()
to the PM operations.

Fix it accordingly.

Fixes: 6765e859fac9 ("spi: spi-fsl-lpspi: Switch to SYSTEM_SLEEP_PM_OPS()")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2908a5532482..32baa14dfd83 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -991,7 +991,7 @@ static struct platform_driver fsl_lpspi_driver = {
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


