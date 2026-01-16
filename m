Return-Path: <linux-spi+bounces-12433-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05ED2FC52
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 11:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2B0312136B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928C361DA3;
	Fri, 16 Jan 2026 10:42:08 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B982361657
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560128; cv=none; b=RT8NsbL3L9iuXZSZp5DXcfSnA0k2l5p3oHrjYsKeaMOf07uL6NvlXOuwUDy87iZvVstRKO7DaiYVB6Enm4yDUvGcgauF+z3FCJQosOwW5d76siP1N2cs/M/plO7zN0TnPjrstPpbwYRI11a8j5BtVJcIC6czJDAVloqPzS6yI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560128; c=relaxed/simple;
	bh=7Bs83/3GKpZIet4A+GEy6AGATI40T938TARAD1FqpVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DR/6/Xck+G8+i0KKAgvqw6fsCwC4bNBNeaylmTnSRObTPfQ/VexT0aVXL7K232+v5NzP02hu0LMB1BsVJhBcMZJs9SnzifPdC9h6zB5xG2+Jid+T5zeMS4jFqp07+NqXxkQji6mT3QWqpa2UAkF3zjY6lGwrIMJqbGO/IQOX5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4040996405eso1205512fac.2
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 02:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768560119; x=1769164919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sH5vxI6dNW/ff+71XEyDBEVLOLjPNS7CrwRsoGXUEMk=;
        b=YKbK/MdahE9Hk5NjYFiYba4NUGP4rWffM7AhMaonc12p8B+7pKkALUPuC9BHHjXIdE
         tsWvYy0ArW/Y6n4BEJN7IRu9U8x8KlqkLvxm5tMJ64xcmemdBBQ50o39chzj099Jw9+u
         H0ylv5Xp02GcBRLPQqmuCzncDgLmbmBualyKo1ZFkLkIm+Dpi+Zvj8C0yDINs6pFn/Ct
         qlQYLtUikxfbn5FAP6yDvwCDA4qXzD82ncmZzrSaz9scFSn7zj8HB6JC7CDLStZvoo01
         cXergrgG7s0tVtdvg9vvRBFESn2zpqb2kaphPjwcX9tMpjmH1GSeUB0GV03I24w0OKOe
         i+oA==
X-Forwarded-Encrypted: i=1; AJvYcCU1lUuUBdfo3hBLE6zMIPKVoFQqFz0/sRH4TLN6yPY7AZhmU5LYNzY9t879U8N7OuveXdQND91Zj9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzHKdhLB5MKmsoVO5kv1awfv0nA6BY5jAuuB2MKlrPgl05ihx
	agqPf/L0hofVBzFhAMUq0Bibpll3peL529v0mwdpfygMKHSIX0RqgNOd
X-Gm-Gg: AY/fxX6/fVyYJrrKZPJvQA0D6Bau0RycoF5/5CJX+8Gp1Uj3lwdOWQQw+wNU75LrcQD
	rrQExsbDrUzcHT0cPfc3Ss6iig/UoN4OJS49DM+FefU/N5dhDGFoS4gZhnVRK8DvuUqLVlzPBnW
	WI7ML0w4NPPE2BbdhTeDSXZiVAzk8XYK22NcHoI+WPgvhZU2p7AUeQ8EaCNV/TUE4HwqyjEUZxY
	tQbYM5Z8qrwY1SDclI/kmKfN1Bk5rgFl7sVcy4v8vMH3SvxDvp7RLer6rvRIyiKs/mqyANUooWR
	4B3hhrmo6QutJSuOrQp1COEhnBI5BtgauTlZd5aROHOl3StoNRGqjDPRbEk18P+veX/Os33qGcS
	pVhhrA+Nu69U0mfMZfVZPU3doSQOnTITEknHowLhX3/CJprk6Zjg9ghME1NxxakDBwx9tjueL8H
	MgewF81pO3PoG/
X-Received: by 2002:a05:6820:222a:b0:65d:363:b874 with SMTP id 006d021491bc7-66117990118mr1027149eaf.32.1768560119255;
        Fri, 16 Jan 2026 02:41:59 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd150dasm1639426fac.14.2026.01.16.02.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:41:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 16 Jan 2026 02:41:42 -0800
Subject: [PATCH 2/6] spi: tegra210-quad: Move curr_xfer read inside
 spinlock
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-tegra_xfer-v1-2-02d96c790619@debian.org>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
In-Reply-To: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, puranjay@kernel.org, 
 usamaarif642@gmail.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=leitao@debian.org;
 h=from:subject:message-id; bh=7Bs83/3GKpZIet4A+GEy6AGATI40T938TARAD1FqpVU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpahXyQcmiX+lZ6+VH1IlXn9H2/Ow+031UEs7B1
 9pJkFfc28SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWoV8gAKCRA1o5Of/Hh3
 bS7DD/9DE0jwX2tOQ8Bch5QwkoSGgWuEnWGW62EJ8jGhgF8Q4Zuqhdwg45Fol0ls57+b1n/JoHt
 so8t5Cc9inZQqQqUJyifNjdhj168nrbkWC0Wn+hXlSL2mXT/Pt9peV+9yv+zpmQ0a4eSbdzMcUe
 YZZGMMTSyLdrJ+6RAvKWOxeOzPqOfWrX/hoi5cdSVEcTYChZUYlJbfuEEYw55iY9dmYBgjMiqgG
 KzRawCzdM3l98ObQluHtv212HYJlRWAUijDNsl3HpKHWHvdL8oi0kI0MVvw6C511kKAvlRlmnLy
 HDqsj/u8rsjZoSzYz0rOkXIyb8Z839JjE2be6zPGAbKo5W4jtzzg/AIRskCsTwWgobkvCVL0+B4
 v+WLk/qN54dWt/dyShTJgE7t9CTTMGcdIW51PGy4/FPe1B2GaOc7pwkEhDBQQDZUsxhlhzHMTlw
 zufcm2X99yGwpd5DnSzDc0a7QwOOAoGYm65xizvqsAtsqUAEG3/hjwXrgp4Azcm5qyG8tCWcb1X
 GxOWmT+Yn0CYs2s8ZtPjEj2dNSGSKG6+HRywgZtfnReBgYWfRDtGlbb2Cme1Ffuhmj7LlMSdLS/
 eeTIDkht/+X42QhFBiNGh4Un+EjnEaQeBIpj2j+RBCwHg/qAEuBm5wRM4Z8goI+BbVANHqO8E29
 hQnDuJEl5Wybfyw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move the assignment of the transfer pointer from curr_xfer inside the
spinlock critical section in both handle_cpu_based_xfer() and
handle_dma_based_xfer().

Previously, curr_xfer was read before acquiring the lock, creating a
window where the timeout path could clear curr_xfer between reading it
and using it. By moving the read inside the lock, the handlers are
guaranteed to see a consistent value that cannot be modified by the
timeout path.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index f0408c0b4b98..ee291b9e9e9c 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1440,10 +1440,11 @@ static int tegra_qspi_transfer_one_message(struct spi_controller *host,
 
 static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 {
-	struct spi_transfer *t = tqspi->curr_xfer;
+	struct spi_transfer *t;
 	unsigned long flags;
 
 	spin_lock_irqsave(&tqspi->lock, flags);
+	t = tqspi->curr_xfer;
 
 	if (tqspi->tx_status ||  tqspi->rx_status) {
 		tegra_qspi_handle_error(tqspi);
@@ -1474,7 +1475,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 
 static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 {
-	struct spi_transfer *t = tqspi->curr_xfer;
+	struct spi_transfer *t;
 	unsigned int total_fifo_words;
 	unsigned long flags;
 	long wait_status;
@@ -1513,6 +1514,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	}
 
 	spin_lock_irqsave(&tqspi->lock, flags);
+	t = tqspi->curr_xfer;
 
 	if (num_errors) {
 		tegra_qspi_dma_unmap_xfer(tqspi, t);

-- 
2.47.3


