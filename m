Return-Path: <linux-spi+bounces-12435-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB64D2FB7B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 11:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3522A305CE78
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F688361DD9;
	Fri, 16 Jan 2026 10:42:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94220361DA1
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560129; cv=none; b=RisKD/Tz8rKx0PokVw1XxPSXW+ezHm8tykE2RBB9Dk/gvoBDUIg6MhT5OaxPVOfxXfo5pCRQp/XWDXJrnJmmByqAKb/5CsMdrZNmE8ytEIETRzlEXDl5l0gdxUHKbyZVID0ORrzWzqZmTu8KzCTHJhuKa9unjY4MVd9Z8Z/De2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560129; c=relaxed/simple;
	bh=rXTI3sY64hoG5V6aBH3z2wkNQ6wZUnODcq5kb+6G3tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLdndsOm9xdOgya3kyq3pTrLdcv3AdFLyXN9HPJveNsEZrDw0NnROaV7ba6JSCr5RtXBI9K6LqziWhs+Kje5vrWVgo52aR6GstuBY5V0pT/wiYZ6h7Rm3+3jMltLEY858Zv5P2wuZ6P6vg7Krnf73MoQXrkhVZriU+t8c44txW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7cfcebf1725so1265882a34.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 02:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768560123; x=1769164923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0AA7Y0IuqP0pVl1HcO3QatRU7TWIdgT6ORxtlbMnz/0=;
        b=gAiF/uML27nFUX2ANxt6oYCXFfu8A8MYWSZW60L4unClbfZu1LbmRlefaGKZouUQQ3
         r330PiQH2eRzr3XjRhKvNlfaCIMTPdvJxmyXLZoh46Oac4RFBTvzRRIxCRYxJyAPkXX2
         WwG11sZImnqlI0at7TRUb4SITsQDzaGBhj1rHwipVm2Ce4f7SrZieFphbHKoIQMpVOwr
         9kBSP7yIPk9QqcMIMljTiVZ6QlU7KeAg26nLaEWddUwn3qDZ94qFaSlg0IOPd2gs++f8
         1fOwOWMdHbF9GLZOTyOTvQ2FeZtMq7zyXuCpIvFSfYsf1FgIbGm5YHs3vS9QRT4tCaNS
         n9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlDUfGZCYAkQCp4l6Zdu3oRXkIyvkHkhSeddivspTltVz9iB1/EZ+Lrmq8EpBflrQt+45oQ95L15U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzID8WZwqbdRFlbQsvXDtSZksZvOQL5x/xZTWFResA0ccyxW9Bl
	pAWIHt/fSZeaGpuJuHZB0imQKXcsda7GpeNkSfN9l2KnspT4RQzFRmMG
X-Gm-Gg: AY/fxX5mG7Z3h1ux8wNy4DuK1GWjzK9VFhd71ubErJdqmfxtSnMEj9t3f3n1f7y8TRD
	WLfygbbgugE9fbYV5hbbCv/a8uCp2mne5GVbKpBKLUMc91zpH4ZT3g7xv0DSd3uL4LzuYL7nrW2
	ZxwsEZfkq2JyjPW49QIRIFAm75/s7BJu1BbXjm9lkjMgsn60s/iy9C1VWRlIjMwOgEz9rmajrZE
	iU8belNcqO7CA+vRxzds9vkLoGK6bsb8Pmn4b/+f5LqCTM5yEHuG7jpfr3fBxlBqd2mxRR/DtpD
	oNP6Rk8R+eumv43fUZdDTzIxKcT+0UEf8N9xo1e2KUP6cxDYebS3e8nrdJl69JIElp2pQNceB2N
	5/n5wsL+SvjyKb72q6MD1973aUQCZXoYEGdvRjTVYeoAMLE5IGjvJ/d6aSdC1w5zha/tq/DYE4g
	==
X-Received: by 2002:a05:6830:82e4:b0:7cf:d0b4:bab7 with SMTP id 46e09a7af769-7cfdee8f50emr1640254a34.34.1768560123395;
        Fri, 16 Jan 2026 02:42:03 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0d9142sm1480880a34.1.2026.01.16.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:42:02 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 16 Jan 2026 02:41:45 -0800
Subject: [PATCH 5/6] spi: tegra210-quad: Protect curr_xfer clearing in
 tegra_qspi_non_combined_seq_xfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-tegra_xfer-v1-5-02d96c790619@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=leitao@debian.org;
 h=from:subject:message-id; bh=rXTI3sY64hoG5V6aBH3z2wkNQ6wZUnODcq5kb+6G3tU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpahXyKDqDLy9UiFdHIdAnuTY95cnWgrnwOfWdb
 X+yE3bypBGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWoV8gAKCRA1o5Of/Hh3
 bfe4EACtv6gkekdzoWC0uBpx8BTg11Qj2SxS+lMOa/KXjIBBZrx9Vq4YfUrFK0WRGupFU9VAA+6
 E3rQLJ14PsLpEjBxO1imfKO4yNi6A10oCPKAmL9Svk5VgvPx3KbMcuc9dg8iPCW8aJjdg0rMj9b
 sEyWXfoa1kIfUGqpSQ5ZyVbZ7qTl8ZBCOL8WRumWVda+QCYWQph8iFVVRoknhyejv1nx/KNbLua
 yWAef/c6s8JdwA49o5TsD66LhOwDCTAw3B1zu0pgPbwJGd3BcY0DSsikVFs1UyyLl2jASseYPN6
 A4VK8cpfci1rSIuXS7V57N0PRhcv4Jno8K06oZP59OqbFHCD+Q7lkGwBP+ojf+R46fmJChCywdZ
 pLCYs64ioYh3CDNl6usNLABSMxF4U2x6ut4JX0zUECdzRowk4hB5ibbBSgzixZHXHcY5l1g2/Xj
 waIXTFR6d20JspOHFu8qWBt93haW9vac8wrgm22s5oey13Wlb3k2a1LNZpWSuMo36Jzc7owoHSg
 mleEkZW4yi3BWXat43Ys/gUixMlmPmsHBMTX25hPruCOWl4Fd9aXBHyhjLEfrZ+MxePO/+FN6jN
 bjaBDCoEwdwUi8S01QE2iqtv01QNIEMpBQ4BVpNwRFvakn4jjhASR/8Dh1fX+pOAOiSNhTKJTZ7
 9J0z3FoDNW9SH2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Protect the curr_xfer clearing in tegra_qspi_non_combined_seq_xfer()
with the spinlock to prevent a race with the interrupt handler that
reads this field to check if a transfer is in progress.

Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 669e01d3f56a..79aeb80aa4a7 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1288,6 +1288,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_transfer *transfer;
 	bool is_first_msg = true;
 	int ret = 0, val = 0;
+	unsigned long flags;
 
 	msg->status = 0;
 	msg->actual_length = 0;
@@ -1368,7 +1369,9 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		msg->actual_length += xfer->len + dummy_bytes;
 
 complete_xfer:
+		spin_lock_irqsave(&tqspi->lock, flags);
 		tqspi->curr_xfer = NULL;
+		spin_unlock_irqrestore(&tqspi->lock, flags);
 
 		if (ret < 0) {
 			tegra_qspi_transfer_end(spi);

-- 
2.47.3


