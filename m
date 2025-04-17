Return-Path: <linux-spi+bounces-7629-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455DA9110C
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 03:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553127AC4B2
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023532C8E;
	Thu, 17 Apr 2025 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvNVOPdo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED372E628;
	Thu, 17 Apr 2025 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852656; cv=none; b=lkUmnkfg/FcCxLCROgr+hnoXDzK1gm5HzeMQVVc3RbZOQEQfeKJvp2h6NOWhYFpPPV+dj/dEOAUmueFTZ50mg0iEB3murDPa2l6tJu1ePFWaV/8PnIWb4SM3crh4dnczaCe9b/4jgdgepfrxquQztMsGxDp9IiC4x45+gma3Bww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852656; c=relaxed/simple;
	bh=tAGrv9Y+ISX56kVJ642r8N1Gzi55R5eePdaHPLoZ/VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Csu0q/KyaoBHFukScoU1g2cenN8fr2kTemq1lUZWw4yjbGdcWfRj3bI2DsqbN33J/nKks/RwmGJmAYrmxhD3Ub+YjUPy2Ahu6VkYk0CkB0FmFmBjapuNpMRbNbT/zCYjq9dS6Q3mliHTJbWUPPI8erighSs3uMYWfQbXKOVYuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvNVOPdo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af9925bbeb7so150561a12.3;
        Wed, 16 Apr 2025 18:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744852654; x=1745457454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6kZCUyOGMeKdwk9Rr6GjPnU39uDn4efBFP4mrDY4n8=;
        b=PvNVOPdoQV5OVxfdHj4eG7O4k+6MAeUf8it0fH0d7qeYOxijbzCj1b6Zaw1BwVOybj
         1Tx51z62TXEn2CUX2EwSK58jbmLBooiU1I90GMJMcDkgjZvyW/NZwDUjSQQDnfwrghyM
         gJzmh0AMWP3Q7dWlJ7egN8S2TRjXBMPYbU+l5m+JeFBv6bX7UuVx4GDlgkb0h5CGNOSf
         O3a+zWr7lwUeywpxd1aEKSNL6XYXNsEIvMFUaIkFkgMYvoPDhaYU7mfAYq+16VkOAb9H
         pmih1xWMbfeBkcclmb51hIkltCOgANE8Nwg9h21yhtqVqyU3eLU89jvaDUHg38p5OCUt
         e8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744852654; x=1745457454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6kZCUyOGMeKdwk9Rr6GjPnU39uDn4efBFP4mrDY4n8=;
        b=KxrniFrzXECeh20GN7PcxQBpGArCtGA3olOIG9ptzD0womOZ+CN8xn3ojsk7/qpcfE
         6bsE/PJoJG3kTmkwS7k8yepOxu+emD6Luvj+qrlgvGsD3CQorxg+IIsOi6SIxKjFvLRr
         Rww/lr/A2XuwtcO0LjBLMGMWKtx4YIYle5B65ptjmpN0ILRxGmr9bsjdAWLLhEHSRsFt
         JeO6p/eQCF6ShJsPavbryW1cYeueWXZyhsV6XpgJ36cI1Uy90ZGQH6keDel7uuVuLueL
         2YLo7V8L1ACEt29GO5eh7Z1kEEcykd3klMpFGE5fh45arvogjXrUXHfpSP1viTiY+GOp
         bb3A==
X-Forwarded-Encrypted: i=1; AJvYcCVgtYeY9EdiJq1j/7CJprdPbAcyY0T5PfGHRZ0B9znTd4UBDeSNf2KFsTXsjuCyZZwSmf+0hgu4qJVCBMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM+hI5PP2jgO17hxUlRUmSYgZ1G+sC/muXKUP0upJ4U33I6EC2
	+3lwyXGWg1lhPsbIkPQNkYjWdRQTg6mwGZLlsQsO5tO96hFJfo+8
X-Gm-Gg: ASbGnctAVL1wUjzzE8GycyXFdlfU83VFgjJaWWBCM0tTw8fzNxiY2gsuHGw7Ff68tN+
	t/aOu/vRgX93pbdZHUKw//xYUFjc/2pd9NMQQgpkjtAUl/3lzwOS25tSOOvLKuhJ3zMXp23mjaT
	jlMRVYe6Ydh5fuq2UhRQ4/9JqSjBkzoetRxPHhZnBh5ULnIrxW9csZo6WQRbJgZiwcAEGUERM4H
	EXssc0rwoSSnTiKQIkbenac4tMA0m0xET+R61hjgglrOeNXb+ko2h8AWCoHF2mc2Lm6yHhUp/33
	1qsJspr8hVApYIOnf+jHj9c3oQXcBs1cxVr6OiZ+2L8I4cAmHpOE8apBH07S4yCjGgkWpYk8hiD
	Ed3pw
X-Google-Smtp-Source: AGHT+IFdCxEx27NH3yIHMAmLL3SGYxxHjyXgNtoivLisYP2O66x59yWDou7m+l9nKLM43nZ0EotW4Q==
X-Received: by 2002:a17:902:f60f:b0:221:85:f384 with SMTP id d9443c01a7336-22c358db3demr62326835ad.16.1744852654324;
        Wed, 16 Apr 2025 18:17:34 -0700 (PDT)
Received: from delphinus (p4007-ipbfpfx02osakakita.osaka.ocn.ne.jp. [60.40.45.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3086104dfd8sm2365860a91.0.2025.04.16.18.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:17:33 -0700 (PDT)
From: Tamura Dai <kirinode0@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tamura Dai <kirinode0@gmail.com>
Subject: [PATCH] spi: spi-imx: Add check for spi_imx_setupxfer()
Date: Thu, 17 Apr 2025 10:16:05 +0900
Message-ID: <20250417011700.14436-1-kirinode0@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of spi_imx_setupxfer().
spi_imx->rx and spi_imx->tx function pointer can be NULL when
spi_imx_setupxfer() return error, and make NULL pointer dereference.

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
 Call trace:
  0x0
  spi_imx_pio_transfer+0x50/0xd8
  spi_imx_transfer_one+0x18c/0x858
  spi_transfer_one_message+0x43c/0x790
  __spi_pump_transfer_message+0x238/0x5d4
  __spi_sync+0x2b0/0x454
  spi_write_then_read+0x11c/0x200

Signed-off-by: Tamura Dai <kirinode0@gmail.com>
---
 drivers/spi/spi-imx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 832d6e9009eb..c93d80a4d734 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1695,9 +1695,12 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 				struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
+	int ret;
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 
-	spi_imx_setupxfer(spi, transfer);
+	ret = spi_imx_setupxfer(spi, transfer);
+	if (ret < 0)
+		return ret;
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
 
 	/* flush rxfifo before transfer */
-- 
2.47.2


