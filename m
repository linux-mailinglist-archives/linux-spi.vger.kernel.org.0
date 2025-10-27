Return-Path: <linux-spi+bounces-10855-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED49C0E0FB
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FC0405E53
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F4264FBD;
	Mon, 27 Oct 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="TzEA9xaG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366662405E7
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571823; cv=none; b=Lz0AuzcQtg+VAkQ47aPmUzxI04BS07XRo3zkyY6hkou4X/0ybJobMIXN/h+SBGaE+xE1wpzsldwyzRU+C3Ag/nGVULwqH0sXXCZL3cdtIKsfZ+jujABNwq8IbkRHq7XiQkYPlJvPtBoiP/Qv7j+vKa/s5UrvUQcKBaMhut328z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571823; c=relaxed/simple;
	bh=vPwr/+nlNs0manNxtZHH/pbOcpE14vc/oDM+DidS90Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJedVT2/fkzr28EfdS+9zT+0KBE3cgRenEuHoB4dT7TkMpyrWd3xm/SSoCGvRE6aGS5JifxPCWM4NXEARhzPUcZWR4bf4Zf/tdvS5qbqFUleFlTpoNELRg9jTeiFyU3bqJ1gixjPvvKq00/Z1ARWgYdwO+/g26lsGOtbSqcU3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=TzEA9xaG; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-940f8a73275so541826639f.1
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571820; x=1762176620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59JPfJxdtbZVN0/1a3YIl7OOO3eshWQJw5UtvH1ggXo=;
        b=TzEA9xaGCJwptg52KarG8WGbXWkjBlJgigun7w/KEN2vyw2XZa1zQPiAs6Vf8wavJI
         n9l5YXzYKLqjEBse9K2I6H/hR+t73u+a6RG9w6kCGauhu9VuHb2X10tO6oFKONIUkbsq
         nF/ZK6qclERpSjR9hYNxC9cMCL1DitDbWH0XiiuUQsFBCV7n4/adCTrZiN5bf+HOfHcS
         BgchtWmWfDHh8VkL+wTZd69lto4vMHDhos0bkqwSJIPByL6I4xcF9rjKugwqmohSYZX4
         ImAhk+/CflHPJFGulTZW7hGoa7/qF1HaqziDzLwQ4jDVzk7dxp+i0qRUzI417kL/bnRb
         jqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571820; x=1762176620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59JPfJxdtbZVN0/1a3YIl7OOO3eshWQJw5UtvH1ggXo=;
        b=ZbOheouLxuEAFhal4ClwJ3eaifKda8tstS6AgHPibBNWAjt6VnQPqXgnbMUoHFnhFt
         FmM2Cc3g/RM5i1L/lXMkN2QvdbvTmqM/S6ba57rM61ho6yk3Fh0suZ7Hk2o7Dy7gbb0a
         lD7B/ydFlwLAVvtABYb48sRB0XpKwgQ2568AM+yy1Z1MVWO3NydJqqdkOzA1c9x7zoTy
         4Q3LudRJNjtvY/a6UlN4X2wKzaqLShpSIMVfxd6VUnwxh8hzB7lF7inwjG4e3Yuy5wb3
         p12baZBEysqb7tpCCRE9ZkzKX9mq1YzOU11gAnNl7LABElNHRYUZtuVUdIrOH5QakWC0
         wD0A==
X-Forwarded-Encrypted: i=1; AJvYcCUr4EsOdbvx2D5lO5hytkQqrF06gYLXjY8HiLSEmCiZgtzVv5zlRfC6LXiqAozqnUkdzGawTeqF82E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ma21zRV4FSFhC7d1f9XBxg9T26tFjksZovLODjtBGlLs/R5V
	RbMzN/W5VriQ1sxcmws7hYdTRpP0juxBHJqDZK3H03nUwwLInCT8VpDvw5ygKjQipPs=
X-Gm-Gg: ASbGncvv4YTF+WBatA/SBU7J6CnDwaovj5wmjdAivHhfPKCCq/AwHUESUUSaDcKNxkN
	ADbMFpAewcLcWelQbZY8/WlQgH4vRBQbXm+tTT3kFsmwuy86p4KhhJhU0Qg1lXSMZ0Px1WXuF/C
	NUNr2WSek5GN8M6tskfVvE69gF40a1GpOYEz1Wfv2WCRSVqggCzSUAgJprjFODJXk78dygbn1Bd
	p+CmbsUJq+Y63k+FdScTQusBF1MG6TeAlRUBV8FiAjsQSONuq8ob24NR/7u+dgT1QKWJHvAIQlt
	2paULuFdzQguhEZUGSGMFJdeg6ZvQo73X7CRndwlBxzwrB8EAVCmv/js9SJ5k3Q+sJUf4Dgofpr
	qhy6AP4jLawv+FjM896MsspEvDTdAQ6EjIakYkE0WhW/GofnJs6/9wW67gUD859aCJf+j+E2P+V
	wL1YnEKpULEJEK5Wxkd9pKIsGlmub7DIe++lPT/3sNte3vaD8fxPIJ2Q==
X-Google-Smtp-Source: AGHT+IEOMq9HwQy8lmaiH8m2VohckOU5pzhBNmgtnKE6agpQoWegyJcP4IEG3hVlkqulKDQU9Y3jXA==
X-Received: by 2002:a05:6602:29d0:b0:943:5c52:f802 with SMTP id ca18e2360f4ac-945b7d9fd42mr24171239f.0.1761571820080;
        Mon, 27 Oct 2025 06:30:20 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:19 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 4/9] spi: fsl-qspi: switch predicates to bool
Date: Mon, 27 Oct 2025 08:30:02 -0500
Message-ID: <20251027133008.360237-5-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change all the needs_*() functions so they are no longer inline, and return
bool rather than int.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v4: - Added Frank Li's Reviewed-by

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
2.48.1


