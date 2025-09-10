Return-Path: <linux-spi+bounces-9971-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC4B5238C
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 23:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88BA97B4D8D
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FA73115AB;
	Wed, 10 Sep 2025 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNkmLWoP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264F2DCC1C;
	Wed, 10 Sep 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540149; cv=none; b=il94IRYTTRX+jof4/D1VdEx8pwnfKGLbteUzLYMmuz8fuj8+2V84jRGHxCzs9FI9jLvpf6Jvsci7W3Y0HJ65rc9YE4e0/sMZJBBxr5RGBuFMBibycEAo5iqy0NJkWCHl6dygFlVkvCFuDH4SZJNQau2yeoBlrmC9BDg+IznRiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540149; c=relaxed/simple;
	bh=qjBjUv5snqHXXynANQ0UNS91NtSdBGR+HOLxkT2GCF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdSbKkXV/jjuLHNv40CX3OzygaxgLMcRA+yDpX/Wf5gv/CLxqa7WjtUUhslncjGfSd98NHzvjmQXjnTHRIivVTmxVRo4J+lVVVCn7utMI55Nm2ehKzpkOT2BgFUwPecORiViTBNHoJN9HiT505vPxlu3g5GM152uCOLM+YmBNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNkmLWoP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e751508f21so73264f8f.0;
        Wed, 10 Sep 2025 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757540146; x=1758144946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uZ4Gecv3Q3BldTcSK34g4YoCJ5ltF3zPUz6IX1qhgs=;
        b=fNkmLWoPvlJWqwjBKGBtfDSeKUugvt/4iNIZllSCkcroGYZzoTrt6HwuUg6txTA/vL
         kJrnKin8/8vxX5Whk4cjcIUksTfqlVfuQWKPqzu32OTZLh5DrYT5ISkdVpxljNPwSN0P
         VHsG6WpjOmTaDw63/69ttg0GQPlRA9aFuCpF2K2oSppuwScuCNjKgkGjg0g586AW1V0N
         9ugQpVy8oC/3WIwNawxVmqv3TqaEcVJnkjv1QgYSJ9jUy/cwPJqGOXrIdgWHKlj3jZAg
         zJ6M0XyFFXKpd5U6gUcDSeBRvH7ZlmDM5n3El7CID2uzm7KhJ2//OpiV66u0IuYxNQIi
         Vy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540146; x=1758144946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uZ4Gecv3Q3BldTcSK34g4YoCJ5ltF3zPUz6IX1qhgs=;
        b=uf2YWl+IqilcCoyFI2frMYF+ltz3L004Ov/E1jqewRAOn7hKxe9ikmEY1m9GzogCEJ
         zEjsIDpyGYwUJCsYv/1faBnUxeWcIjBnxQEv5jnLFaYx54bDx8ChoqmmX66D/e7sd22J
         5iWHujCsHeJx59NuppOuK5o6mWTZxYFkOzc+ppvpUz7vr6ciBArPKpLZYsh3zLVSjyz0
         lZjXsPdCMIJuRqB7+Xb9Jsou6A1+DEonfd3g/fzR5u2sxUzLUkzrGjIwdpg5thGqmKr5
         amdD482UPhs6NFif5ul+qTQ2fwM+DAaaKLKKV6pe7nzuxqqrkwcSqsEl8ktrqQro7n/Q
         LBSA==
X-Forwarded-Encrypted: i=1; AJvYcCV1EmeMgHFzF/kKh0fz1/wP5SRAxzXqmc2I9VjkIGqDaiY/h6BLD5OruZvUzJ2heNtJyCItN9Kg8nVXmKA=@vger.kernel.org, AJvYcCXECnb1KbyFLIfnVRFdXbO3h67YD5RVYVOEOBWK6CKnBx+yim/F+jqIi14D4OuYCN9BPuYaL1CG24USP3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPhfJ0JsOJygKah4wdGBB5SZKEHHHQNWI2/4RpRQO8UqzBEC8c
	03hZ+HIWBK8BPaTUriWqCI7kgAupLmGTtd5jqIO6SPHzo6uGifmpz0DF
X-Gm-Gg: ASbGncupjD1nioxkRbiTkFGBecloQslh9fIbh8UhYBewmGQgAuGuEILt5hL1O54JeAZ
	BWos2Lp2YfotaTbuifFLCBl/nJ8RsKrGPGo5I1+YEYHJbdICWYINuFt0GlAlXt5B3DqEKn9JseX
	UsLvwbIPjsKfmGQYRTsFozrZInJGQBpU7FwQ0txwwhHB1V8Dl3q7Nz/ct60Wlshen7qmN/080XD
	7zRnhqjcyS7DsriaOYT300qSEBVrIGdV2atJbcaLCEtN3EdfNeMJ6Zb6mCE+4CKMmkWDPg6BAnM
	9ZZ7j1n5RuF1xUf9/N7aFwihKFP3ZWLynhwBHjkanRo9Z7PXPy7Y3ep5KXYqk50aYcYK3ZfUOku
	vEk3uwDHDDMtmSPhMdVNlV+JWuR/I
X-Google-Smtp-Source: AGHT+IFs1IObFmSvEQSjOTKOvzzXzWVoiuuIoqFs4VlqyZQPeQAZsT/ju7a+bazAtF4B6KrU8nfmmQ==
X-Received: by 2002:a05:6000:2186:b0:3e7:4071:186e with SMTP id ffacd0b85a97d-3e740711d5bmr8851748f8f.4.1757540146183;
        Wed, 10 Sep 2025 14:35:46 -0700 (PDT)
Received: from pc.. ([105.163.1.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238832sm8073502f8f.31.2025.09.10.14.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:35:44 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: ldewangan@nvidia.com,
	broonie@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] spi: Replace lock/unlock patterns to guard
Date: Thu, 11 Sep 2025 00:35:37 +0300
Message-ID: <20250910213537.553673-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace lock/unlock pattern with guard cleanup macro.
This simplifies the code flow path by replacing the conditional
jump with an early return.

Generated-by: Coccinelle SmPL

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/spi/spi-tegra20-sflash.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index d5c8ee20b8e5..5367aee56545 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -359,7 +359,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_sflash_data *tsd)
 {
 	struct spi_transfer *t = tsd->curr_xfer;
 
-	spin_lock(&tsd->lock);
+	guard(spinlock)(&tsd->lock);
 	if (tsd->tx_status || tsd->rx_status || (tsd->status_reg & SPI_BSY)) {
 		dev_err(tsd->dev,
 			"CpuXfer ERROR bit set 0x%x\n", tsd->status_reg);
@@ -370,7 +370,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_sflash_data *tsd)
 		udelay(2);
 		reset_control_deassert(tsd->rst);
 		complete(&tsd->xfer_completion);
-		goto exit;
+		return IRQ_HANDLED;
 	}
 
 	if (tsd->cur_direction & DATA_DIR_RX)
@@ -383,13 +383,11 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_sflash_data *tsd)
 
 	if (tsd->cur_pos == t->len) {
 		complete(&tsd->xfer_completion);
-		goto exit;
+		return IRQ_HANDLED;
 	}
 
 	tegra_sflash_calculate_curr_xfer_param(tsd->cur_spi, tsd, t);
 	tegra_sflash_start_cpu_based_transfer(tsd, t);
-exit:
-	spin_unlock(&tsd->lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


