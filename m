Return-Path: <linux-spi+bounces-5284-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADC9A6BF6
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51B5281BC0
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A71F1310;
	Mon, 21 Oct 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I7ec5WMy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E41EF948
	for <linux-spi@vger.kernel.org>; Mon, 21 Oct 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520479; cv=none; b=rMa1/CENAiyLORN6KBr0mw7J+fNsxYkZ+oU51Zi2t4Z4YxWlQA0xBW8ala3hBRHj+CyBZ6Y7b8yBGrZJzjGX1hMj1zmo6NosQfocxIK7uz6mXu/0S1iQNn1JR2T1n7examtASSkxVPlKVoPRaFzXPgYDFfCwNB+9UNJyq1uiDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520479; c=relaxed/simple;
	bh=Pk7BCk2e6Tq0X4KPVHwA0sk6evakMDLdwaIPHrcoMc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSHh8lTP1sUKIdQmxyGnKDgTmATFhnT75H60CPoWGeTvLU7F94ozS1yxQmzH2LEHjLnIKOURU1oXRi5QoxFKFl0lkB746RusG9y7VA/jtoQnPQ4OuPSPE5gsgCFrqW59SX23Rb2Eo0EYUFhrKfllXXOQjYTFsdWQOfOA0YBMCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I7ec5WMy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso3636574f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 21 Oct 2024 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729520476; x=1730125276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkaTmiyWUTvag4SMcJC0bEMzINljnOfy+tQcywiph9o=;
        b=I7ec5WMymmAfgECyWbhGP20PIkc99sFesl2Z/W4ZXzaE+t5XOiLFogt2qYy8Es84GG
         vvlzJTac2NrzIRTGcHYQ09PS5o0dIXDOIFUOd7Qh6AfgVufT0pHopJ/QrvA3MJ2b/15Z
         SCoJATQE2sZdbl4O/y8bGUMOP6z1nz4xxrga2UdHnMKUggBdkpQrWATMacMxEClqSf1A
         z3A69zLPFMNoth41IoqOY+V6nlnhmjq4crrSKc9UarOu51HZDatHmAbR8ETXbOoiiRXI
         Vmsieq9Y0x2+bJBowdS6r4wg80J+7EzYsbS0a9PLc38MrPmEvF87AdUeZNUxjoS6ocmo
         btHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520476; x=1730125276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkaTmiyWUTvag4SMcJC0bEMzINljnOfy+tQcywiph9o=;
        b=fY5k3e6MT8zJFW4kImIM7AIKMHdP5OHA+dIustTScy0JC8lRUoMf5hv6paMeMkZAns
         bjIDGkHUkePeFAdMCZw62QPSBoguMDP3zTkYtpUGyw83QnjjdMxaz5YHosBjIwFvn9xf
         gRyWY6yZYXEmW2y9j6AN7GdNFL11M371daT9VSdnRY5xaJuNsuj5DFk6neWrzN5qrobG
         HtYI5DPC4jmp5jl/55Xwuw/rgV9aKwR1skxi+8HUSumA9yVvAeBAh9ChEUnzfi7z5jxn
         bhPZKWhO/jEvaax9pU1ZwThaScRskEkEcSzAr0ycLjnR+gM3La+FH62zKacFUTzGlnPI
         f+Bg==
X-Gm-Message-State: AOJu0Yww9xPLpd7q5KdpyjUOENcGMGfwIA38BAXVohNhKAMQuhq3eDKy
	b2VaMlYx8RSnac07R5xTMb7g4bv74W15z7cZOAkxmAzXMHZ+NSsVohSLzX4OZ5k=
X-Google-Smtp-Source: AGHT+IHLWSsrOMX/0aibUNkp/wI47N0y5vFtzl7noASKKkK9+W7PQoaQs8bf2P0RENiwFNs+Ip8tIQ==
X-Received: by 2002:a5d:4452:0:b0:37d:393a:97c5 with SMTP id ffacd0b85a97d-37eb488cb8emr8199985f8f.28.1729520475745;
        Mon, 21 Oct 2024 07:21:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b384sm4430211f8f.57.2024.10.21.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:21:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] spi: mtk-snfi: fix kerneldoc for mtk_snand_is_page_ops()
Date: Mon, 21 Oct 2024 16:21:13 +0200
Message-ID: <20241021142113.71081-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The op argument is missing the colon and is not picked up by the
kerneldoc generator. Fix it to address the following build warning:

drivers/spi/spi-mtk-snfi.c:1201: warning: Function parameter or struct member 'op' not described in 'mtk_snand_is_page_ops'

Fixes: 764f1b748164 ("spi: add driver for MTK SPI NAND Flash Interface")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spi-mtk-snfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index debe0e3c1c8b..2166a56aeb02 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1187,7 +1187,7 @@ static int mtk_snand_write_page_cache(struct mtk_snand *snf,
 
 /**
  * mtk_snand_is_page_ops() - check if the op is a controller supported page op.
- * @op spi-mem op to check
+ * @op: spi-mem op to check
  *
  * Check whether op can be executed with read_from_cache or program_load
  * mode in the controller.
-- 
2.43.0


