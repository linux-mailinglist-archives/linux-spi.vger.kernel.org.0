Return-Path: <linux-spi+bounces-8601-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF322ADBC87
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 00:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2D01893014
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 22:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2352922A4EA;
	Mon, 16 Jun 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mn/zUG2Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4E225415
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111279; cv=none; b=Yn7x/+xdxXde9ktv4RuJYFCcYKDEui6DE+RXjFPqjfCVFKYjxZTLXVIN8ipvKvdAyshVF7GcCRe+BMhllCG6V4TlnrG/u88BhhRh/vcG0owcvIyURvE3sfrjFw07v2cdnDrjWSR0CphsHj6X5gSEJBB9pipCAdXcTalIm2//wdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111279; c=relaxed/simple;
	bh=AcUKZuHRVnI+4gxBISBOYegc/FcNVd9I4VO+rzYErV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n64j8cX0gfTzrbTJy7rMqv67E15Y5Agrr67SJyjyp2PW4LLCRJSP+0Q+5jUJYo9tACWkL2+rpNiNBthHOMIF3mVpdG2LBgtpjwiYw6RQAeFf0RECRKEepqMstA82BbcAFiqvYiIxd9+vk9OaJ21/sl+SxwNjz9XK/9+i4Y0NwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mn/zUG2Q; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750111275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXSa9B9J2FkeGT4PKUZGBGTcf10cHbFGccTdZDDZdaA=;
	b=Mn/zUG2QLLNhYeX2c9acd3FovpjK/9Kkpa3OQ1zhNTVCTlKrWbvOT6I9mZsLdHbw1hgEN+
	4mIeXOWd3L9iz6v9oOsMWIEtmrUhBRP2rrv0g3zAkSsvUefXApCC82XXx9JKbRzOriLwoZ
	o8lBHp3GA6DY5eRIaDsh+nci5t86Bf0=
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
Subject: [PATCH v2 3/9] spi: Support multi-bus controllers
Date: Mon, 16 Jun 2025 18:00:48 -0400
Message-Id: <20250616220054.3968946-4-sean.anderson@linux.dev>
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

From: David Lechner <dlechner@baylibre.com>

Add support for SPI controllers with multiple physical SPI buses.

This is common in the type of controller that can be used with parallel
flash memories, but can be used for general purpose SPI as well.

To indicate support, a controller just needs to set ctlr->num_buses to
something greater than 1. Peripherals indicate which bus they are
connected to via device tree (ACPI support can be added if needed).

In the future, this can be extended to support peripherals that also
have multiple SPI buses to use those buses at the same time by adding
a similar bus flags field to struct spi_transfer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 drivers/spi/spi.c       | 26 +++++++++++++++++++++++++-
 include/linux/spi/spi.h | 13 +++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1bc0fdbb1bd7..9fbf069623a8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2359,7 +2359,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value, cs[SPI_CS_CNT_MAX];
+	u32 value, buses[8], cs[SPI_CS_CNT_MAX];
 	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
@@ -2460,6 +2460,29 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	for (idx = 0; idx < rc; idx++)
 		spi_set_chipselect(spi, idx, cs[idx]);
 
+	rc = of_property_read_variable_u32_array(nc, "spi-buses", buses, 1,
+						 ARRAY_SIZE(buses));
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev, "%pOF has invalid 'spi-buses' property (%d)\n",
+			nc, rc);
+		return rc;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is omitted. */
+		spi->buses = BIT(0);
+	} else {
+		for (idx = 0; idx < rc; idx++) {
+			if (buses[idx] >= ctlr->num_buses) {
+				dev_err(&ctlr->dev,
+					"%pOF has out of range 'spi-buses' property (%d)\n",
+					nc, buses[idx]);
+				return -EINVAL;
+			}
+			spi->buses |= BIT(buses[idx]);
+		}
+	}
+
 	/*
 	 * By default spi->chip_select[0] will hold the physical CS number,
 	 * so set bit 0 in spi->cs_index_mask.
@@ -3070,6 +3093,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
+	ctlr->num_buses = 1;
 	ctlr->target = target;
 	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
 		ctlr->dev.class = &spi_target_class;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4789f91dae94..70e8e6555a33 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -228,6 +228,11 @@ struct spi_device {
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
 
+	/*
+	 * Bit flags indicating which buses this device is connected to. Only
+	 * applicable to multi-bus controllers.
+	 */
+	u8			buses;
 	u8			chip_select[SPI_CS_CNT_MAX];
 
 	/*
@@ -574,6 +579,14 @@ struct spi_controller {
 	 */
 	u16			num_chipselect;
 
+	/*
+	 * Some specialized SPI controllers can have more than one physical
+	 * bus interface per controller. This specifies the number of buses
+	 * in that case. Other controllers do not need to set this (defaults
+	 * to 1).
+	 */
+	u16			num_buses;
+
 	/* Some SPI controllers pose alignment requirements on DMAable
 	 * buffers; let protocol drivers know about these requirements.
 	 */
-- 
2.35.1.1320.gc452695387.dirty


