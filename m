Return-Path: <linux-spi+bounces-9671-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7AB3745F
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7916D20415E
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CEE31A574;
	Tue, 26 Aug 2025 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksA6dj/i"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE72FA0E8;
	Tue, 26 Aug 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243460; cv=none; b=eK09mM8QccbiH+qRXVggyNt0eG5WxkDkeWL7AFiajDse+IxG9DgJcjx0768rjwaW8pdov7lv2uMUp1NWq4oIKvIg6BHAAOfhRW/b4joBSaRKTV2/JWEjnBjEhacJRDI6v0+fuCEM+sVyQbcjXY0ZCcpbDCQ0/8//p8Ws574KfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243460; c=relaxed/simple;
	bh=RAcy7NWxWBhxPVzmCf1xn9p74TqGBPwpt2JNZ6oZ//0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjDAhGqMEAp/qefn35UHS/jrp/mrJfa8AZWVnYCXq7bwysVYso1r8bqDn+eMBEx1bkcIbjN9vJaWPMI1SL6cMJMxbso3c6n3LF9Hg8A3NhMGYSab9napAk3YHqZ+st/nj4MFDXIsfX5xgdMzzDCCJ6uVi/FguQBCXQzEbu2CRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksA6dj/i; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c58e29so115198291cf.3;
        Tue, 26 Aug 2025 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756243458; x=1756848258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tf54ARgykYebw1T/qEQsnrX9CWrnnjsUdUJCfBDXds=;
        b=ksA6dj/iWODfTMs5Yg+JEGTShJVrrYbbbKGNYF798PVmuXSP8C3aG0l6bZDxgr53Gz
         rBDfMzeP3qWvrIFBJ58vAbRySvEVbegneu01ekouSxo2Cxz3AIeKRwKe+rNmzGia+U4S
         O8HUzpG8iHzaxqVf1I1g9zbXUtCdP/CkimB/u9/w8uDbGdcAs/wLPoGYObmswCZdkWrj
         gaUVN2kr7rRS0UWqv7/8qIUG+6txgh63LhXRILrrimJMJnW6T2Ej7ToAsFRq1eiht35L
         0YnqP4m6wkOzSamh4HPrFtTvUCIeyCn4k7tn9AoUiQUOrROxOwKGnUvGHzWHiJO/6rqB
         +dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243458; x=1756848258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tf54ARgykYebw1T/qEQsnrX9CWrnnjsUdUJCfBDXds=;
        b=cAGB2I6fqwhHizSIhspgs760o9TOnLjPtkmL6jNGeFSNIN4QvWkziS3P6AGa775M9Q
         mYZEZW6Pfmzo0EUFK9e71BwC/8b+7CE9WwPpMzIMEMyP6IWXzhWRlbqv2ZB0q18h35te
         zb1VZ3oc5JdMOF+cSdQtZI49ONpuEtu8EL+ZzJa/98q66bOtVTmSk9ut069gS4mgpcKk
         KL1FFVe9rc6PrUJquL50OnJPUUn1Sd/pktHfoPN+UruMEO5dOpbq9Ua1+iv5gKb6at+s
         rAn3+Fr4QjL8IAOQdGCAQYOxeLjcD1DHuQHYUtCBGF3UCYoPIxvrCgbjwnweeG6lvPUz
         6trg==
X-Forwarded-Encrypted: i=1; AJvYcCVjFI2Yd8Jn64zaqab7tNoNwM+sO0hyDXPqTI52peVSH8Cd6Rjxyi/MG6+Derlalpy4Vp5ZXI9PcEPXpHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRavi1yIa5K3YmxPQLwLqblAJADxXgSXKNJ2aypvOsjhlbUJ7
	3Jyv3yw+YQK7eRSNc8iZfkfibXUo122WMfBPl3hoGFxLOnKD+0Oc+MwlaCZU3w==
X-Gm-Gg: ASbGncsi8fs+09YugbLNgi9c7tfBa4QeIgRm/5DMK3cDVeXSEMKWfMBNGz/FjtPzKzc
	wHeoco8RtiaNe2FHZypNl33LGrw9x4K3C3VlsveyxmwjMr9MJk8psotSs7RfNJ8nnEn0nWYkohR
	yfHEft+CeI/NduTczdrmBK2A3fJAg9NF+7huKqLJW5ZwYUgj5dddUZiHXR8Fgp1SUHBbnEvnDUe
	y3ig11bT8tAcTUij1z5GUTyR/DRVhDGBa137mYskYaTeVkhSwAlsOYG2GrsuGlD4nl5+nVQi6GN
	ZADsj3FmD8ROzDsfR9q30RCl6L2UuA4yFxulDLQbAGcm65+vy7cBO2dlPBojqn05Hu/w+h+Jy7z
	OaowERgo3MD1FV3LJdDST4fY0lF2s/BPczG8UzHh2LFpZAoPBpSpAaTtImQTWL8TyHeQVvugrDT
	f/
X-Google-Smtp-Source: AGHT+IFO6U57WJ0FUsQI8L/4P9yAzKSF+aNckD4lA+M45DpSyS0/lewNKzbGRVmrO9ABzQF1r5rtew==
X-Received: by 2002:ac8:590a:0:b0:4b0:6a0d:bbde with SMTP id d75a77b69052e-4b2aab666d5mr219564761cf.55.1756243458047;
        Tue, 26 Aug 2025 14:24:18 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebe6069a17sm758731685a.0.2025.08.26.14.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:24:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	j4g8y7@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/3] spi: rb4xx: depend on OF
Date: Tue, 26 Aug 2025 14:24:11 -0700
Message-ID: <20250826212413.15065-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826212413.15065-1-rosenp@gmail.com>
References: <20250826212413.15065-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no support for non OF platforms. Better to depend on OF
explicitly.

Also fixes a warning/error about the dt table being unused because of
of_match_ptr on non OF platforms.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/Kconfig     | 1 +
 drivers/spi/spi-rb4xx.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c564..cdeaa8e711fd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -917,6 +917,7 @@ config SPI_ROCKCHIP_SFC
 config SPI_RB4XX
 	tristate "Mikrotik RB4XX SPI master"
 	depends on SPI_MASTER && ATH79
+	depends on OF
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
 
diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index e71d3805b150..a795e263299e 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -199,7 +199,7 @@ static struct platform_driver rb4xx_spi_drv = {
 	.remove = rb4xx_spi_remove,
 	.driver = {
 		.name = "rb4xx-spi",
-		.of_match_table = of_match_ptr(rb4xx_spi_dt_match),
+		.of_match_table = rb4xx_spi_dt_match,
 	},
 };
 
-- 
2.50.1


