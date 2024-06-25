Return-Path: <linux-spi+bounces-3584-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0E6917062
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DE51F21732
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 18:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A0C15382E;
	Tue, 25 Jun 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4F0NSf5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57A148FE4
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340772; cv=none; b=Pxw3YRScGr9U35rh66BplQWZ1F1PviramXkFBeez9lmf45YfWBwZ7PmSrRSlIH3TMy97Aekl/4Xb8zT0Q7hJZmuiophuze199um3pKhGsXvMvcg5thuZOT6OYnmUMM6pg5Y7ieaom6kjLe+XgBsVpDhrCosemn2oAti0WJu56BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340772; c=relaxed/simple;
	bh=bqPOhaG5uTXkfMorWrpTp1+q5sThDjFhRlIarbLO0pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dASkDV8Jbbaz/LMWT8Qs2hiKwfx8iXt1xNarqMRsWkPLutzymUffQwiM7kY6cj3MfKGNZFeJMZxiZDv8kp0rKmcuXSN88AABq+1wvFDaV/Sytd7vVXSKqHSpKCWyaIkh+aX3eK9cKgzDz9EU8M4DcCBqLebXLqIkhWDaXSlbJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4F0NSf5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9a617f88cso2544515ad.2
        for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719340771; x=1719945571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWY+m8OVcD1OyoW6KLjeMtA7beVl8G3UKjx1JZfkFlk=;
        b=Z4F0NSf5xbhm0GZWewPqMjQ6HYt+Y7YO7HVbi31+9zXAs0bz7HexyufGgFCQ/yzKrI
         TItgXhpBonOIRhTsbBjzpxfauFcpLIsTuvLKoqbjRpt7xz1XDT9dNy5cd5rsP8nmXCJ1
         4MNfewa+Wn4tSjuH0k+7cLOqZq9rY2T2A6amTdSU7mRaX1GmstAADaGbURs5Qiq+DROS
         lChB9AQqHnFM/Bdhb2cyBoGeg2mVvH0rZ9ko8wr6GrWyo6Dx7Is5OnT+gwRHhcS803Jo
         rFGISK33ic6lOTn+tM/rFqs3Kk/7nKcUgK1MB8AtyIGchLpkBteYmsn/XbASvSfbxw5Z
         FeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340771; x=1719945571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWY+m8OVcD1OyoW6KLjeMtA7beVl8G3UKjx1JZfkFlk=;
        b=T/fw50eiJxUmdKVwU7SjqF1GZCwyqI/U3by6Q/yzQVswb8n/51o59Z2mC5OP6KqUUd
         JlRITjBv+nTNqbfsP6kU6MqvCGPdslbvsfy5nJz130odygDxeJawV44Dc+HbYJiId8qc
         pV+PttrHwAeI6FVw6WP9gzzH8YOSJLvgI0oNy7vNHjYXEshlByCBv4djDhmt8cKq+5L+
         JIkHuAVXbMZOCXiTvSClFxhcVf8GSPagW2NFYez3BaAmSGkaIu59ornGGUHoWd7BzSab
         fBafyW5fZPKI2cGkRC1uBQPwLMqd90LuLyw/Q9vTv9ZUu5iHoqzB0trFBMmuH2riVNLG
         T7Wg==
X-Gm-Message-State: AOJu0YyOcgP47oY3QRig78gFEt8NfwT2owbGmbaVaicAgBKTzPXyiolQ
	RTJwsStHfh9duWiMyNswZUWS/DTfsY1G2hamI6WVcu6IepdYwBqiC76Vmw==
X-Google-Smtp-Source: AGHT+IG2cl9dGo4+x8gfVaKYcoEdfgVpyBpsOgAX7F21s8MpZjiXoiK+1gd/wi8LzJSpUAtHOBZxAg==
X-Received: by 2002:a17:902:e888:b0:1f8:6e3f:9e7 with SMTP id d9443c01a7336-1fa09d94a65mr110050555ad.1.1719340770592;
        Tue, 25 Jun 2024 11:39:30 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1451:872:213b:5880])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f0545sm84437145ad.27.2024.06.25.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:39:30 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] spi: spi-imx: Pass pm_ptr()
Date: Tue, 25 Jun 2024 15:39:18 -0300
Message-Id: <20240625183919.368770-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

After coverting to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS, it is necessary
to pass pm_ptr() to the PM operations.

Fix it accordingly.

Fixes: a93f089ccf82 ("spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index caf36fb785b3..4b325220a7ab 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1953,7 +1953,7 @@ static struct platform_driver spi_imx_driver = {
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


