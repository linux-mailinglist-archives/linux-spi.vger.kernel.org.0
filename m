Return-Path: <linux-spi+bounces-8602-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC1ADBC8F
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 00:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A0F3A5749
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 22:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF8231A21;
	Mon, 16 Jun 2025 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iVSfe482"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013822D781
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111281; cv=none; b=dcJlKJvJsYbBzO6nRn2W01laaRUzNenMlcHiWW6hTpJxxHe1v1b3ADoDAgdsiOqE+0UQmTXaADGIpgvFKtvxyX/fDKvk6MdBiJEPaerSIsKIkU+u6d+R3txSP7OK2NDejHW+NbJWjy3IwGKFodZCsl9HHqK+Ai8+E55Q1bIuoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111281; c=relaxed/simple;
	bh=vCP/PaR6IG5saR7yXq+ikd9n8NjFbEdzOfmfr1VN9Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrT1JILLvX9OTi90xLyhZw44ro1PhpUCVcIXK0GAnc87xxzrIJ/H74sV/Mjxa14JHEvbae3PuTeK/1V3AxNyEWLlbtku2dajislQMi4JDb42xJQk1XkeYGERTCxEhNDDE05yY/CEusIrq/yzePHnSUV7OxL/U8WiHaLftZP5TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iVSfe482; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750111278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYfaovqReb0YC/IVKoaet5lnN16Aykfnj2HI88YzzQU=;
	b=iVSfe4829NP8fycZu8j2fpXmtjF/KVdc9OyiEFUGfAAeDc97G2/yleYdCKG++p79wq3CqZ
	vvZQ01SnJykyrg3vFPJBHUT96AnYHB+6PgkH7ajQbyXXB8oCwB5tZIdeGn11n9EoVNwvWH
	h4LI5mWdcBlHSrBUwsJ0FCgIEEgvuPo=
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
Subject: [PATCH v2 4/9] spi: Add flag to determine default bus
Date: Mon, 16 Jun 2025 18:00:49 -0400
Message-Id: <20250616220054.3968946-5-sean.anderson@linux.dev>
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

The ZynqMP GQSPI driver determines the default SPI bus based on the chip
select. For compatibility, introduce a flag to determine the buses from
the chipselect when the spi-buses property is absent.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 drivers/spi/spi.c       | 7 ++++++-
 include/linux/spi/spi.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9fbf069623a8..d9d0c24cee0b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2470,7 +2470,12 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 
 	if (rc == -EINVAL) {
 		/* Default when property is omitted. */
-		spi->buses = BIT(0);
+		if ((ctlr->flags & SPI_CONTROLLER_DEFAULT_BUS_IS_CS) &&
+		    cs[0] != SPI_INVALID_CS && cs[0] < ctlr->num_buses) {
+			spi->buses = BIT(cs[0]);
+		} else {
+			spi->buses = BIT(0);
+		}
 	} else {
 		for (idx = 0; idx < rc; idx++) {
 			if (buses[idx] >= ctlr->num_buses) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 70e8e6555a33..cea93b0895b9 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -621,6 +621,8 @@ struct spi_controller {
 	 * assert/de-assert more than one chip select at once.
 	 */
 #define SPI_CONTROLLER_MULTI_CS		BIT(7)
+	/* spi_device->buses defaults to spi_device->cs[0] */
+#define SPI_CONTROLLER_DEFAULT_BUS_IS_CS BIT(8)
 
 	/* Flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
-- 
2.35.1.1320.gc452695387.dirty


