Return-Path: <linux-spi+bounces-11671-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B8C94CC9
	for <lists+linux-spi@lfdr.de>; Sun, 30 Nov 2025 10:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E99284E233D
	for <lists+linux-spi@lfdr.de>; Sun, 30 Nov 2025 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBDE227B94;
	Sun, 30 Nov 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdwjL5Vw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959F11CAF
	for <linux-spi@vger.kernel.org>; Sun, 30 Nov 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494052; cv=none; b=PzNvGnuvKH49CmiCrgL0SWKVg3Jw8NK1zLZOWVn80celCEu2nrNctaZ1TuqeESbHmy2hF6r0WzLZyt8ADBRzXD28N6GyoG+dLZ+vTJDvoW6nDBtTNZfGMzjQKFXkQCneabRw4OZTYOb1E186y8AuOYdj29ZW5pT9ioYtbuvE7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494052; c=relaxed/simple;
	bh=MGGriOeY9GnM5WbLP7Ub+yvZgeskrMWaNCIjfY8JhaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTywXTWkU/sHGDRF1kb9LsObkbuu3g4roiuwinlM2+Mh25mF20yqzoKdhUSN7blZu+Y5JghobEOBlobgTvRU+Aq/4WLXmmKscUmvLfSWfLR4wDtzGXEKWk51j7XGH7lC8F64GWHcRk9TlitfZTDCQMrRFFTkEcbDc/X1iAA+p8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdwjL5Vw; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso254454f8f.2
        for <linux-spi@vger.kernel.org>; Sun, 30 Nov 2025 01:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764494049; x=1765098849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qonFTC9cukq617453+SfG5fIkZheN8Tb5aZ9YtE+WGM=;
        b=cdwjL5VwwtarqPjWoinFvo5MjKv8TzenXQRDh3TMUuVXtSg7Ll0ncgt95uH8eYZq3m
         bVdSGZtKdcJiAIfliVK5yTgvXf7zckG37RdFCPj+uMO7/31ynKIueWTEE7tkZFtp9d8x
         kUzNi5OPz/fLiINu71ZRalxWn+1QTwV3yA4at/1GAHCuW6oa+RIviOpPmoBNTk7sx+bG
         0De02VQ7QGZSZfEacLnr12RsnjBwApWX0nYrO7u8W5ociAIiutck44V7adKiJ0gQFnh3
         uwdM4d03wyISMXu2KOZPhT5XWxY1v/7Qvivn1iOttVrdFlWOr0J2594l6194qNjoZuXi
         Xp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764494049; x=1765098849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qonFTC9cukq617453+SfG5fIkZheN8Tb5aZ9YtE+WGM=;
        b=VWcfM/E5DLj6fNa5z3Zhe6TNWSADz4B2GdVRyqw7ZIlh9E02QY65zjEDRfaCpJ14ba
         N1eqmNJwWWPxs/P90yhWDWNxQeMOW2LGgytfIA+s0x4ITU+/ep40xrmL1wYh5IfO/Oat
         qFgwNLxWiDZKtAFVt2+KF7vv172Hc+bqqHO/vys7LBYHTSd+bakLvEj+a0NVfDWZWrpr
         R7BqZTuB5Z895RBPD+Yw3BUibdYrmEl8QtzK3OJn4GdR0B23Bc11qIlSJ4PQeYfxbv/Z
         xw+AGouBBZzKw+Qwn/EilJCdgEweyFpLGLBh3EelO5DR8k6nV7lYgKvJIe94jnV+JlbZ
         IJSw==
X-Gm-Message-State: AOJu0Yy8Wk/e1iWTldRfnN6qwS2J+LBnPvxaEvSvCHY9JEQ8t2CEpjuS
	ER1LPw/PBv3ZLCUDKd+mnnjE1BqZpqFNLSwU7P1RznOrLWtWSflz8NTA
X-Gm-Gg: ASbGncuKR+mYow6iYvbG+75hrRdrIZ/PSpa7EbFRWroBGYezpE2YVXTh9DSxCwoka8O
	WoXU9IE0pVL5wo3xu3GJXY3pldte0Fbo6m7algcbIm0ZbNDDJYRVPdW1w1mrj8OjeDWv9Rw0Ofh
	9MYfExcFQa5t6AMDINHuK2ohg2b2MnyMp6bjqVpu0HHNem7f5NQf76VDiI9vvbArVrK17RvjVgx
	vr31/GDaVo/UelZc5BniQSzpavXjGsCOz6gpnwY/gKG2rnCKF7JIPoUOCfLtWLO1d4SRTJ7VA9y
	cStUQXcA8gI4VH9DV4osBzRziehSOej7P2wC15pAJ+MvYA6ZlQpThRf/bp6/QM+L156gsDnjI1m
	evXoc5fPv1mbnqZWMMuw0ElpuYs0WomvDfV1BK7BHll8gjAfBktAqgYsaGNou3+KPTpMikEobYA
	Ua9jnC6zJ/ERkQf+iXSrZF3X/X//0AtocxwG5suqO6Jy0=
X-Google-Smtp-Source: AGHT+IHcdFLcZ96GpxA116dFShtGE7sfX94uNLz5L013+p+MhI9x785xRWvj4LDpM1cT3MV1aytapQ==
X-Received: by 2002:a05:6000:26c4:b0:42b:2fc8:170 with SMTP id ffacd0b85a97d-42cc1ab8a59mr36772953f8f.12.1764494048887;
        Sun, 30 Nov 2025 01:14:08 -0800 (PST)
Received: from localhost.localdomain ([39.46.201.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca8e00fsm19230232f8f.34.2025.11.30.01.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 01:14:08 -0800 (PST)
From: Ali Tariq <alitariq45892@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khairul.anuar.romli@altera.com,
	adrianhoyin.ng@altera.com,
	nirav.rabara@altera.com,
	matthew.gerlach@altera.com,
	Ali Tariq <alitariq45892@gmail.com>
Subject: [PATCH] spi: cadence-qspi: Fix runtime PM imbalance in probe
Date: Sun, 30 Nov 2025 09:12:51 +0000
Message-ID: <20251130091251.12120-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe function incorrectly calls pm_runtime_put_autosuspend()
twice in succession at the end of successful probe, dropping two
runtime PM references while only one was acquired earlier with
pm_runtime_get_sync(). This causes a usage count underflow:

    cadence-qspi 13010000.spi: Runtime PM usage count underflow!

Remove the first redundant pm_runtime_put_autosuspend() call to
balance the reference count.

Tested on StarFive VisionFive 2 v1.2A board.

Fixes: 30dbc1c8d50f ("spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled")

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
 drivers/spi/spi-cadence-quadspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 81017402bc56..638edca3805a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2012,7 +2012,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_put_autosuspend(dev);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
-- 
2.43.0


