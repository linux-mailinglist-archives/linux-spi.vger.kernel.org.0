Return-Path: <linux-spi+bounces-8603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E429ADBC8C
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 00:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA30E18931EB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 22:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10FD235362;
	Mon, 16 Jun 2025 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jrwOh4Kh"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14E233156
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111283; cv=none; b=oGZGMqUBMSp+JXhOYoGOD6C0ubz8KbDlRqiMFh983vUE+p06aQzLx1GRvgePass8MZJjHaKRKEDek4SdDTajEnbf7+863TNgUJNuGNvpBI3E2J9FqrHZfjY5mt42C8RHZtSeeFPy9JSlmC5rmyVOW7+lDgySk9aX/+X/mTd8GII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111283; c=relaxed/simple;
	bh=J3HRmysUvAMuPBZHaaEJ3p7CVlln3bfpkvyA/v/2xVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFuKlG1DngloKConFWFpJtfWhvBxz2AtaX7IKAJr06gvy8i1QBOdMaLCIMtNxKySQkwKVXjnpgYFj6nu8ntzmz2QtfweFgedKicw1VC0RtIIcrGg7ODLZRLbsAHErQUKE6rJVJioAq+LpU9aHTWJM4RgCOO8FAKQJi9g4ctpzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jrwOh4Kh; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750111279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKeCmjqMfNPPRNpjK82ZCg/Ku8sd60DeUcDOkrmPcJw=;
	b=jrwOh4KhAkiVpQJgns719VppdBhUkBodMTpMmBIxn1pEQ5ZOseJMmS01AU9i3k9usbeX2m
	AIQPuPtqEC1V3cZQr7KCdMicMohKEb8K9jjExEpMsKQxQe4Qtrmpv9A3CJW4ifwu0iDv3H
	RX4HjQtW2x1O3p8JTtFDKs/Ju8Y8O2A=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 5/9] spi: zynqmp-gqspi: Support multiple buses
Date: Mon, 16 Jun 2025 18:00:50 -0400
Message-Id: <20250616220054.3968946-6-sean.anderson@linux.dev>
In-Reply-To: <20250616220054.3968946-1-sean.anderson@linux.dev>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, selection of the upper/lower buses is determined by the
chipselect. Decouple this by allowing explicit bus selection through the
spi-buses property.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 drivers/spi/spi-zynqmp-gqspi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 595b6dc10845..add5eea12153 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -465,13 +465,13 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
 
 	if (!is_high) {
-		if (!spi_get_chipselect(qspi, 0)) {
-			xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
+		xqspi->genfifobus =
+			FIELD_PREP(GQSPI_GENFIFO_BUS_MASK, qspi->buses);
+		if (!spi_get_chipselect(qspi, 0))
 			xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
-		} else {
-			xqspi->genfifobus = GQSPI_GENFIFO_BUS_UPPER;
+		else
 			xqspi->genfifocs = GQSPI_GENFIFO_CS_UPPER;
-		}
+
 		genfifoentry |= xqspi->genfifobus;
 		genfifoentry |= xqspi->genfifocs;
 		genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
@@ -1316,6 +1316,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		ctlr->num_chipselect = num_cs;
 	}
 
+	ctlr->num_buses = 2;
+	ctlr->flags = SPI_CONTROLLER_DEFAULT_BUS_IS_CS;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
 	ctlr->mem_caps = &zynqmp_qspi_mem_caps;
-- 
2.35.1.1320.gc452695387.dirty


