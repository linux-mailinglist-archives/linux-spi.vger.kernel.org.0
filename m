Return-Path: <linux-spi+bounces-10791-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715AC02D22
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 20:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10CB1A6847A
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7F34B1B6;
	Thu, 23 Oct 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Yy3zyUXT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551A34B674
	for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242373; cv=none; b=L3LD9tUjb89tbnyTJ3jBGOhmZNIkI9ORAAhWkfFLrOuSClieVhXBl6bYddr8fxKh6edSJOqJcPG9tk/xRW6aS/V3obTsOxKvKrIdXTE84k3v0Kwno647R65aQfZCZkaxhnyDFoQEwdbTa6Y/GM72m4JVM3tvikX8D5xSptfg9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242373; c=relaxed/simple;
	bh=7ez/6EjkIlh33htYKjsePGy3T2mVBjoqatOtR9I8D94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/SeRbSX/jJp0mA65JlRbYqk1YS29ol64/SzsNOCdEChbK1kWgGLgIbdwCrZycT2UTPCSsiuBKdbBaYYKQR6sr1A2eP52tMFaNqpm+Xpkk7KxOk8mylM5HzAQw+EJ8nYsqeqg/qyvtwNBQc+PIoHcqI71EEKlGzmuBmY+yKx2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Yy3zyUXT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so1161425a91.0
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242370; x=1761847170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpdAYbWvJ67Pq6SWW8TZBr3xHWfsprNvetly1iKihCo=;
        b=Yy3zyUXTi+0e3vmKG2Ui+yTxn2tmKz7PF/q/x5L6n2piFr8kq4CpV9Gp4W9036zQav
         y5NxRSP7pO54xha9gPSM8/nTGJT4uAOSQYyPYnj2p8mhs8X3yHFQOB8F2mb+/SBJJ7G8
         bypFwXrYvpFuYQl0xuxyinQDP95UavbkoFvpQmnZV48nIgKOvGGMxICJRl6UD2yPaKM3
         uLGnsoG9zfPsat25xZO35LufyRdzNq/JnozHuhcGar/fBHUSVjPponG7k6FMRQLlSKqU
         LY1FWKfr/D0FBFdDgfOhEdvAg7QjvD28lKVs3gJApPjxAEmUi7HsUaGRjZLvE+u/OwPL
         c+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242370; x=1761847170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpdAYbWvJ67Pq6SWW8TZBr3xHWfsprNvetly1iKihCo=;
        b=Fff95+0bFLIi4teOb6SN/uOhs6LY9ARVu/eqXzoxF4WJaMvreppX1z29k+tE3do9A+
         LKy3mdg3X5yeM4ZT7vQ3R5bGDAS6nvGWvXThRgkmYJxeHGwm03HTMJLkGvFJxYVXUw+E
         PVc4+Z60JTQwle1qZB5nZ9f8J46wVvaz1+HEE+lilakcSkGGHTBhJ9DSAtCysWdjZKpN
         8g/9LnqFg/eD/PZ0kbtrNGinbMhDtE5dfV9TAE2ED9sgQEbSdvcf5545VzRBcIv4uyqy
         x3/MhIAj1IGRngnjwEkmDUADLdfuDuZKi8GGSi6lsE9HY2VAne91FdsOR5wIi3Kl064I
         Dk0g==
X-Forwarded-Encrypted: i=1; AJvYcCUyLz5xNFnfeOMlct2hrL/7xSMf39Ajmv1PXxNrl7zDJG28KGF+cjbueQoVBQBmS+hZRCeaFn4YeJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6Sd8+b1g1o4LNGPCFwwIlIkN4siVpgSwJ+j9RBWYzv9EweKy
	zovs1XqLY10wI6BCldOymAxCoGhp1GuY5Hc7xpdknjobrAjUelU+5ef/vzgn0RLIuqg=
X-Gm-Gg: ASbGncuhd0fnOpSCKRFDMQ7ec84vqkI2uCEi2kPKRpwzgTshkN8yLjMu4JEtfQMv8gf
	tikQgzlJmwDdjr2J6dx3dDogKk6cV4htHvV2GnmmeGY6gCVoUKA9GqI46wRrng2fjlmCg185EU9
	pPtuIP8XuTY6geZRSTHlceAbzVjvAZfCbEb5Obn4ROY0kuJTjklG7MAVw3D9zH1cr3F3Tc7JapQ
	OUBjYuCLsoQtHLAtVF4XToASdYwYvBZmf9Ljp/1m/f5MHBOR7s2szxx0Ha6yrv6wtwFKae6KGjo
	afS3azA3Qd5f84d2opgvxZ4yJGyvKwEKnIheihO+QjJshLSgMqozuCZl4AghwahyEVplc2P24FH
	sQJoUhLsrMoYtRZbKdNxlrQ06wWRVno5vy/N2HmqDfpYZ8iG43dhqJ6wi9dXzBAPSNfbSfMaPJb
	6SvdIWHM+c0NR9Ep7igTnXzmA=
X-Google-Smtp-Source: AGHT+IEsHCRIEchVGl1aiqwGIr3m1P1UsY5mh0aI0l1e28xrZb5I36C7fTVFMh7HosCXyjh0AUoMEw==
X-Received: by 2002:a17:90b:1c0e:b0:32b:6ac0:8633 with SMTP id 98e67ed59e1d1-33bcf8743c0mr34004618a91.16.1761242369714;
        Thu, 23 Oct 2025 10:59:29 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:29 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] spi: fsl-qspi: switch predicates to bool
Date: Thu, 23 Oct 2025 12:59:16 -0500
Message-ID: <20251023175922.528868-5-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change all the needs_*() functions so they are no longer inline, and return
bool rather than int.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - New patch: predicates now return bool type and drop inline

  patch (patch 4).
 drivers/spi/spi-fsl-qspi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1e27647dd2a09..1944e63169d36 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -276,34 +276,34 @@ struct fsl_qspi {
 	u32 memmap_phy;
 };
 
-static inline int needs_swap_endian(struct fsl_qspi *q)
+static bool needs_swap_endian(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN);
 }
 
-static inline int needs_4x_clock(struct fsl_qspi *q)
+static bool needs_4x_clock(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK);
 }
 
-static inline int needs_fill_txfifo(struct fsl_qspi *q)
+static bool needs_fill_txfifo(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890);
 }
 
-static inline int needs_wakeup_wait_mode(struct fsl_qspi *q)
+static bool needs_wakeup_wait_mode(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618);
 }
 
-static inline int needs_amba_base_offset(struct fsl_qspi *q)
+static bool needs_amba_base_offset(struct fsl_qspi *q)
 {
 	return !(q->devtype_data->quirks & QUADSPI_QUIRK_BASE_INTERNAL);
 }
 
-static inline int needs_tdh_setting(struct fsl_qspi *q)
+static bool needs_tdh_setting(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
 }
 
 /*
-- 
2.43.0


