Return-Path: <linux-spi+bounces-7365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08BA7645A
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E332E3AAE5B
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E21DF987;
	Mon, 31 Mar 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nw2dJP0v"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55001A7046;
	Mon, 31 Mar 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417376; cv=none; b=AQHa1Y24Cvi5itKz467LONlUckW1/McsBe2Shya1FvSp2l7SYNaML1Spt/YgCXewCx7lL948jC9+CEKoZRcClF3YTvKqj1oFPZvIA2clBabEy/6rBuTP4bQOHr6L5DFTvuHmHuxV03wumlcXv4Ci32HQMy0dl7KD0nmEcMfDglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417376; c=relaxed/simple;
	bh=WHHBDa6ne12H1fKPIha7nBKDfW1fudV7sPBpeiBdnRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMDxTDgbWCyW35UHzWTepIG0WjMh4niQnsMXt0OI5eCPJzJOLlP3eycM1kkJyY9tgUzJQOxnxZ94qNaHCvg4vuXtbMWyEgcP6BfBCk8We7WrWr3LjWoC4kfNPjQIbUj1zsMUCbAiF7SVWrL82JIzSg49T598y9gtJTHwTkomP20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nw2dJP0v; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743417375; x=1774953375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WHHBDa6ne12H1fKPIha7nBKDfW1fudV7sPBpeiBdnRE=;
  b=Nw2dJP0vcXnIuGtKkVZ3ot1SIoHogmcDdJLQb0kk2WjleNvlEUmodhr5
   kVutY5kybN3wUu5lsAgKtW9NTqk5gkzXpTGoI8FZmeQJ9P0Sf5Kn326AG
   4R/MjWF8XVUT+3ERUpkD1EIq8mvEFgIOXTCfXhoDv3395Kq3sigbvaiel
   eS0tAsY+ipBAvqmTgEqpYNLGAXJw8JSFqK8ipM99d3ePrtZhcGR5UHys+
   fATV2nm/tQ7j/cQ8vbmBURWg7R/8y4kW0921LGNpH5e8mEDKlC0yzzpC/
   YTmTtWqavlUIP4TdI/wmcM6dNPuotUgdaroyIQrCSvv0ULbMEmqM6Dd9x
   w==;
X-CSE-ConnectionGUID: 8OXfLxLZQjmwoDuOvabt7A==
X-CSE-MsgGUID: ar1zcvyPQnqr/vFfpPXIVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44876076"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44876076"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 03:36:14 -0700
X-CSE-ConnectionGUID: muj2aYzDR8O4Ecqvo3OClg==
X-CSE-MsgGUID: YdTG/3YESEeLVufUHJCl/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="131065560"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 03:36:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 363531CE; Mon, 31 Mar 2025 13:36:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] spi: Group CS related fields in struct spi_device
Date: Mon, 31 Mar 2025 13:35:59 +0300
Message-ID: <20250331103609.4160281-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CS related fields are sparse in the struct spi_device. Group them.
While at it, fix the comment style of cs_index_mask.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: used correct base

 include/linux/spi/spi.h | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8497f4747e24..e934f9cc6a4d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -134,13 +134,6 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
- * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
- *	the corresponding physical CS for logical CS i.
- * @mode: The spi mode defines how data is clocked out and in.
- *	This may be changed by the device's driver.
- *	The "active low" default for chipselect mode can be overridden
- *	(by specifying SPI_CS_HIGH) as can the "MSB first" default for
- *	each word in a transfer (by specifying SPI_LSB_FIRST).
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -148,6 +141,11 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	default (0) indicating protocol words are eight bit bytes.
  *	The spi_transfer.bits_per_word can override this for each transfer.
  * @rt: Make the pump thread real time priority.
+ * @mode: The spi mode defines how data is clocked out and in.
+ *	This may be changed by the device's driver.
+ *	The "active low" default for chipselect mode can be overridden
+ *	(by specifying SPI_CS_HIGH) as can the "MSB first" default for
+ *	each word in a transfer (by specifying SPI_LSB_FIRST).
  * @irq: Negative, or the number passed to request_irq() to receive
  *	interrupts from this device.
  * @controller_state: Controller's runtime state
@@ -160,8 +158,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	the device will bind to the named driver and only the named driver.
  *	Do not set directly, because core frees it; use driver_set_override() to
  *	set or clear it.
- * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
- *	(optional, NULL when not using a GPIO line)
+ * @pcpu_statistics: statistics for the spi_device
  * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
  * @cs_setup: delay to be introduced by the controller after CS is asserted
@@ -169,8 +166,11 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @cs_inactive: delay to be introduced by the controller after CS is
  *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
  *	two delays will be added up.
- * @pcpu_statistics: statistics for the spi_device
+ * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
+ *	the corresponding physical CS for logical CS i.
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
+ * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
+ *	(optional, NULL when not using a GPIO line)
  *
  * A @spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -185,7 +185,6 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
-	u8			chip_select[SPI_CS_CNT_MAX];
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
@@ -216,23 +215,29 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select gpio desc */
+
+	/* The statistics */
+	struct spi_statistics __percpu	*pcpu_statistics;
+
 	struct spi_delay	word_delay; /* Inter-word delay */
+
 	/* CS delays */
 	struct spi_delay	cs_setup;
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
 
-	/* The statistics */
-	struct spi_statistics __percpu	*pcpu_statistics;
+	u8			chip_select[SPI_CS_CNT_MAX];
 
-	/* Bit mask of the chipselect(s) that the driver need to use from
-	 * the chipselect array.When the controller is capable to handle
+	/*
+	 * Bit mask of the chipselect(s) that the driver need to use from
+	 * the chipselect array. When the controller is capable to handle
 	 * multiple chip selects & memories are connected in parallel
 	 * then more than one bit need to be set in cs_index_mask.
 	 */
 	u32			cs_index_mask : SPI_CS_CNT_MAX;
 
+	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select gpio desc */
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
-- 
2.47.2


