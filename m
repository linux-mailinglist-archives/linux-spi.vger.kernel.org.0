Return-Path: <linux-spi+bounces-10470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61718BC53DB
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AEA3A5F82
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC2B285CAD;
	Wed,  8 Oct 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTRNAfIq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E222857C1;
	Wed,  8 Oct 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930724; cv=none; b=pT/6mE7pyLj3JPO2va48UVKNR7/e1NApnqXwqHdJCbeiKT/mHwV5ZXQeMUJeUFMZVg6Yy+t09Isl1M7/bbatIU41f3qCIpojO5ap1JJL8BeRHcLPwq2Z9gJ6Gix6gCI2zrHICtZ3Xo9sLmG6KE4RUImnNkOcMlwm0YySnAHoaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930724; c=relaxed/simple;
	bh=+muUzAG1lzz/QwKaxcLSk4/OjEYzc2TbNDTaJfcXIz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ETW8u8cQ8JA0MD3TvKrO0ataIlJ6DgCKNPpqSW5N96LFpTVUcGF3JGkNgXNsRaWqs72DJFys59Gr7QqitRoQOhf7xkP6sNRO2pREQHlhNH4bRXR9NlC08LPaqFQO/c7wynHCZK2Hjo2q5ZblRj3PbeWea8xYU15LCJVgqkyqtR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTRNAfIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087DCC4CEF4;
	Wed,  8 Oct 2025 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759930723;
	bh=+muUzAG1lzz/QwKaxcLSk4/OjEYzc2TbNDTaJfcXIz8=;
	h=From:Date:Subject:To:Cc:From;
	b=nTRNAfIqFtU8ei24fXxbYHA1f84E0BA89kBykVaMypBRPX7hEab8+n40h8Uth0jv/
	 tWft1BOznSh1dhsGiNgc5zYLawmuoqsWjl4zRm/75Rksq7Y/bsTYigFdZ+guY4Qxz/
	 vvoiWuJ1vYOyaXMyI5tD6fgM4WH6y1ew/gfnnnXckitoZOWblGdcDDCvdDIF9jDJ+Y
	 iIuKq0aJZwaqEa82jCi+453lHBhCqbP5t02hB32muZ7fIQyCfq69rIfrBl5knD5812
	 PSDj46PVVwFwvKWkdVR/jIKnLD2TkLZxYVU0nwESTmn2gG0eKeRTiSXo4FOLUJfP8I
	 CmsSQpQ/b5P7g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 08 Oct 2025 15:38:39 +0200
Subject: [PATCH] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF5p5mgC/x2NywqAIBAAfyX23IJG0eNXooPpWnvITDOC6N+Tj
 gPDzAORAlOEoXgg0MWRd5dBlgXoVbmFkE1mqETVSCE61MqQ04RHUiZ6Rss3+g1DcidvhLPtjO2
 lqJu2hRzxgbLxD8bpfT801IbocAAAAA==
X-Change-ID: 20251008-cadence-quadspi-fix-pm-runtime-bf8df9104577
To: Mark Brown <broonie@kernel.org>, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=+muUzAG1lzz/QwKaxcLSk4/OjEYzc2TbNDTaJfcXIz8=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBo5mlgNWTTSo19sqr/F16nqYJt3kwd77ATrWRXx
 MCP28FHc/SJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaOZpYAAKCRAZDR20Zk4Z
 NdliCADPvhecPiyebBQioWbB6DKrIVbLmCQr4mWqKYhssdKBPT3uTDs2CAGLeEVMvOVa+6IehFL
 meoFDP2erT6X8ptXt9aWmGydbanXh5aweseiwHPh3UqVU7owi9TzTV+17tpdwly+Q6UrseYA8rU
 0F14oGrRqRU//C+5ALHd/X5ylMlkPTxZqoQZM+lfq1RqMYdjiYjFrQDvFkEHfQstPnvqYIHwhmk
 XH15NGBbnwqG6YmDePFqgV6WaHgm9KNgt38efWrur8WLdAb4Z4S1RzjNrOCroMySpTs9fzZvNjt
 +Jf8itJBiH+WBzOCjKUeAkQ+s7tVExvrDvN9Ym8I1m5wNEf0
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
we handle the error by jumping to probe_setup_failed.
In that label, we call pm_runtime_disable(), even if we never called
pm_runtime_enable() before.

Because of this, the driver cannot probe:

[    2.690018] cadence-qspi 47040000.spi: No Rx DMA available
[    2.699735] spi-nor spi0.0: resume failed with -13
[    2.699741] spi-nor: probe of spi0.0 failed with error -13

Only call pm_runtime_disable() if it was enabled by adding a new
label to handle cqspi_request_mmap_dma() failures.

Fixes: 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
This has been tested on a AM69 SK board.
---
 drivers/spi/spi-cadence-quadspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8fb13df8ff8714d2ad5a019f0ae0ec3ee38833bb..81017402bc5661d08ff4e75017db954fda19ba2a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1995,7 +1995,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
-			goto probe_setup_failed;
+			goto probe_dma_failed;
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
@@ -2019,9 +2019,10 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	return 0;
 probe_setup_failed:
-	cqspi_controller_enable(cqspi, 0);
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_disable(dev);
+probe_dma_failed:
+	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);

---
base-commit: 0d97f2067c166eb495771fede9f7b73999c67f66
change-id: 20251008-cadence-quadspi-fix-pm-runtime-bf8df9104577

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>


