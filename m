Return-Path: <linux-spi+bounces-11579-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20895C891DB
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 10:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FDF3B5F04
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A52FDC27;
	Wed, 26 Nov 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YNCjRUmr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77B2E2DF2
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150634; cv=none; b=D+6ezXr8Q+9pbZOWky8tO29J078+G2yqWk29WXkyJY768KbMt07JxS5kSFdLRGnDvebIngHE+SaubKaPC5JnqB3aIIzKdysonaYOG8II+6TqnicSG4ahgBx6i0R0MD4uQm3t5Xs1UtzB5EMWCjo2lYAIL1yYKGayv0mghjAhx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150634; c=relaxed/simple;
	bh=+QMhaItaPvaKsCJRuF4FnI2nCLh31pZzb6c6ZkW9QNQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LvJOrSp1mFSWD/DS/t1yr1B4FkBPI/gINu08eWFfimYcYri6G8RWqboSN/DjuP/zwV4fNm61CSn+2rn0j99h3x0LeoIckO/imfGJv+w84SKbHaKckZeJxjUY7NxhlAYShKN1TxiAyt+wtmB+GlHcSCx8ecWQnSeKXaGb+iHwf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YNCjRUmr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b735b7326e5so120264766b.0
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764150628; x=1764755428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vC9N/Oa0HyHHHX6atTJMhkARacm863t/cd7HBXcour8=;
        b=YNCjRUmrVZxPZXvbVcWvlIN5YMhk9rH6LztR3KB7cirdLcYTKAhwNLdgbk5OWBu28a
         UR5ZERPttWVHM0Qwj7od7nfc3u1FHZvX7wCBMHjrFHBF80ns6+ZMGPmP9VoMwJCz03Ge
         bLd1+19EGqdi7n4TJT3QodMAABXEpX3MMs85w+0yBovbp+omTg2ZTJBWm//P7ttoUKDv
         SBDN0kBweOFOYgK64v/dlGuWrkkCLzNg695LgDcp+rZ1io/nPedURD7avQnGrr3l9KiU
         ULZ33FnjzxYhV7MlyXOeklWOe7RSLG+3BmF3KLqyIWyy4Pf6nujJD+r/y5dJVw1bRCFZ
         IgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764150628; x=1764755428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vC9N/Oa0HyHHHX6atTJMhkARacm863t/cd7HBXcour8=;
        b=h6aRH+jmBli2ZLX3reTjeMEVT9btO2S9Lz3i7oYB+eoDCR/VUAZf1aQ7fIe5XLosdM
         SuQ67GLPCPBs08jGmehRNAatO8qlgEYl20xcvgLl3ltqhyYj7OA1uban74+cxqtHEE2P
         O/zGJOQUM7rgi+9Dc9C2NI1QkR5fXpKgKPfKqNHH01RCtuzu94WTzdWK8LKc9XIwW37Q
         h5Uy4mf9GMU7Fma9QGwQK9uYxuDVg6mWK9vmniN5gIFaelIvAW4z/orHBQb8+UY9I+NF
         O/4XEs7krIYyIPnjDOz0f7tprxnhMcj7prbethxXklzAauZFeS/XRTJHrPrE8ZzenicF
         bxzw==
X-Forwarded-Encrypted: i=1; AJvYcCVPynXLIoaDZjpC2YSjoMRqmy6O7esNHoFBAi4svhVyceINaf7VqGfzft3N06c8PADauTAJbZLVOM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8B9iFb6dT9Nsko4ESAZ0QW1e4moawW5lgptM2Jp4Ay/Re5sXL
	dJVZMyEVfWN5Sq/1TgzugACpn1HbRfUdqCi274hdGlbfX6rskKpY38TEEJCB56Pkf/c=
X-Gm-Gg: ASbGncvMlsf2P3tXst46uwRcbfkGefGLmGQKYoLIjlu3IaFc8n3u9Yv1wneBG5A1Nk9
	hfpMWahbA28G4yCArYPvQFrDMVYstcqYdhDZjnWvOsPXPd45qCfMUVIlPv5YehPNdvp4l6B7cKj
	fqMFbCPDilchEei60poteGZTNmYDEdqCFnTFQvU0jXchnzIX7IJBu335SZqCciBeyNWvoC9kuuE
	gmS4x0F6Hs/2Kfx+jHa4RDSGX9bE8NVOvPX0EUUQOMyg7pChagARxVfU8d6aJ2stAnaLKjA4Vbm
	JAfDE7fHLM0U1bE6LNL/DR0ER9QPqT+dPn6Vnf98p0QLgouGbm+u/JDL9goJTQ0UrgI6Pk0IqFI
	ZJdWf2kjRUWrkikg38XpG/QXPvWR2/XuZnmVuqAnLl6Rpo3C7DUPhOVteGg==
X-Google-Smtp-Source: AGHT+IFFx1F4ynCO8VULdkxAhvVV+cysYm/Kfpq0aDoflTV1H/IM0SOBnENlcx9uGMs5FA4CDRg94Q==
X-Received: by 2002:a17:907:1c86:b0:b6d:3456:14b3 with SMTP id a640c23a62f3a-b769844d274mr611135666b.20.1764150628475;
        Wed, 26 Nov 2025 01:50:28 -0800 (PST)
Received: from localhost ([151.37.182.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e8esm1831856266b.41.2025.11.26.01.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:50:28 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Gautham Srinivasan <gauthams@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: tegra114: remove Kconfig dependency on TEGRA20_APB_DMA
Date: Wed, 26 Nov 2025 10:50:27 +0100
Message-Id: <20251126095027.4102004-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=flavra@baylibre.com; h=from:subject; bh=+QMhaItaPvaKsCJRuF4FnI2nCLh31pZzb6c6ZkW9QNQ=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJs1M22yLhpsjBSYUYecBc9qAJVmpzWVLpbHap X3/RW4rZlOJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSbNTAAKCRDt8TtzzpQ2 X1rgDACArhocGsFKujFazlIfSCHAVMOAKOWC3Vr+E+ycGYxJfgWyS0Jd47dByln7VL43M3x6KN7 wrHRcbClf0DQkmBqcdmWyGlE6h9oabJA3CVAhLnEsTfm3l0ad7MeUgT37DD9iUFabkM8sDFXmrp ujzAYJKHoM9WDi+/O/c97IIOHCYIDInjwgmb2ArDTmJa8vUT4fXgljzjMm/gLJbVJiOqsqrSdID BHpxSqUbS/LiJLxAwR5FvXy4BzMdg1R8t2wS+2pmbgqPJoDMkd4/a1G/u/Ih45nQWMLNR/L1LpX oe4+7gFCw3HkTBRDay/bQx8t7805f//64R+sXrPaK5r9asjgUqZALR3sidQXezyHfVvoI0bUHxL G5cOM4xnZJoDy6jena1gFnkYAk8DZ3F1LNmThgHy1AhjeQyD1twm4p4wwpfoEw/PgeeYrCXXC3u gWueUEMoFGf2C8Lts7oyesmYCDMva9R1tKl1vEAkfbGBbkq1zP/89ax3xeeHuida1jO0w=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This driver runs also on Tegra SoCs without a Tegra20 APB DMA controller
(e.g. Tegra234).
Remove the Kconfig dependency on TEGRA20_APB_DMA; in addition, amend the
help text to reflect the fact that this driver works on SoCs different from
Tegra114.

Fixes: bb9667d8187b ("arm64: tegra: Add SPI device tree nodes for Tegra234")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c564..9f20cb75bb85 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1170,10 +1170,10 @@ config SPI_TEGRA210_QUAD
 
 config SPI_TEGRA114
 	tristate "NVIDIA Tegra114 SPI Controller"
-	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
+	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on RESET_CONTROLLER
 	help
-	  SPI driver for NVIDIA Tegra114 SPI Controller interface. This controller
+	  SPI controller driver for NVIDIA Tegra114 and later SoCs. This controller
 	  is different than the older SoCs SPI controller and also register interface
 	  get changed with this controller.
 
-- 
2.39.5


