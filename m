Return-Path: <linux-spi+bounces-11621-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337DC8E5DC
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 14:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9FF04E1D9E
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6A1D95A3;
	Thu, 27 Nov 2025 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kd6HYdDQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA817A2E0;
	Thu, 27 Nov 2025 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764248539; cv=none; b=YyJ0qEy+gFl9+FfSZ2jZQd8ZgOX4WMXdp03JhX6SY+GLNSEsiFZAH5mPE4GgDHjThL+861GhI6f+L7fKq8TGAZSTpOmnqBbI3aXrf9P+2KFtOFePO0prD/F/0sG7g+ZdXuS+iS5P06EQ0zwtOdVoI+Ce6dKgxr6RNAuSq2q2mIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764248539; c=relaxed/simple;
	bh=Mr2gJob250IF5m3hkxY9l+DLZdnptgIWRG/2caRCf3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhxUO9u78IV/oyisGsJknt0DCEe7EbvqPcALBU3bkV99WA/vKBgoV7YfQjdj5NCnhr1DjY2HibtR6iPJ7TnJJV0NeRnjQb5+npvhSiuYDJXnePoqt9RRYio0mg9ZvKQWHYSweakJ788nzoKzZU12WvHCcd41VITdqNxulCvrIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kd6HYdDQ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764248533; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=620i7uzNM7X9/+8hz9OS0WcqtrSoqZfgXVH8v3keeGM=;
	b=kd6HYdDQ666KqV/oD+doGujpvIld2mYe78T76eCXuOrUv3axWerz9am21ipta8A+KnAOTjKqGyGYXihAfyN7wscc6Lo7VFXF2LcsFB+CkxWqXNIT6CrDHD9BWj8HK/9MUCJmb1Siu9pyAxkJA7BmM3gZDrDp+7hku7XNVvW/dXQ=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WtXUvRd_1764248527 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 21:02:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: tegra210-quad: downgrade the log when fall back to PIO
Date: Thu, 27 Nov 2025 21:02:07 +0800
Message-ID: <20251127130207.43754-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the machine boots using ACPI, Tegra cannot use DMA and falls back
to PIO. In this case, logging these messages as "Error" may confuse
users into thinking it is an actual error; therefore, these two log
messages should be downgraded to "Info" level.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/spi/spi-tegra210-quad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3be7499db21e..2189904b931d 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -823,8 +823,8 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	tegra_qspi_deinit_dma(tqspi);
 
 	if (err != -EPROBE_DEFER) {
-		dev_err(tqspi->dev, "cannot use DMA: %d\n", err);
-		dev_err(tqspi->dev, "falling back to PIO\n");
+		dev_info(tqspi->dev, "cannot use DMA: %d\n", err);
+		dev_info(tqspi->dev, "falling back to PIO\n");
 		return 0;
 	}
 
-- 
2.43.0


