Return-Path: <linux-spi+bounces-7363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2729AA763F5
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C462F16828D
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0F1D5175;
	Mon, 31 Mar 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyHGEpNg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDA27726;
	Mon, 31 Mar 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416214; cv=none; b=qG0eelpA1jl53QWKlVgitLwKToCIfqX0gBaretbernJZiSYi3DqNLipP/Uxx/po5KX99cSL+j+1YGqVGc7bbuE7EnzfmobWQJVXxy2pxf+UAcwKN5+AZesWaP98CxRxepA5ywHa/AdUNwVFyNv7olTFvHQ+WtGbYuq0JLaLH3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416214; c=relaxed/simple;
	bh=WqVq2up8e5qTqJfd90zclKxq9683pGIF8UmDoxOfr1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=If+51s9lOVh44BdH0sgBMeoZ8Bsx+2O5X+4mbAAAsdi4P2UYd3/qmwVr/7/nQGOjq7AajZW8IYQEYCsIzENnYJ68ewj+wnU06A+lojpIa96S+EUqw0JEmwmBXlxDuSDS9G1b578hHtrPS0+5UPJGj4p40AbaCzKUnoWzyiby+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyHGEpNg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743416213; x=1774952213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WqVq2up8e5qTqJfd90zclKxq9683pGIF8UmDoxOfr1Y=;
  b=kyHGEpNgef0FmzlhtcqRIiPJsxotGH1iquLvVkhjZw7t9jij7mah1Qr9
   I/fa9kWzWBzeRJXHkA/8gwrLXZme//ERI+GnuNA0TMRR/4EIGBJTRby0r
   yTghIcZNCr6yB8Bflo2LPiM4Wac0CRI52WAvV+I+/oY9blATJBmcU/V9J
   dC0chHR58RmchiooH0ziOJrl1SFXdI9DLoJldc/sWlZ3MjqvYH1CPzO9n
   U8yhdPU91HgT7Gh3IRXXL4/gOK0KzG7Qbd6klFW489BML9JfEDp+floxU
   CPoxYVf1gCfXHpZE9w544jX/lBFaL9Nf5l59UagDSQmaY2YHLdMSAoTfh
   A==;
X-CSE-ConnectionGUID: +A7Q8oIXTAmxfvxRqpKTTA==
X-CSE-MsgGUID: K89owBSDSduxCSUI7d/Rhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44704089"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44704089"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 03:16:52 -0700
X-CSE-ConnectionGUID: wuvqW3DLRFSI/kC/p9L7Zg==
X-CSE-MsgGUID: +c203wkvRnqc3a/j+uTYUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="130758783"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 31 Mar 2025 03:16:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AC1141CE; Mon, 31 Mar 2025 13:16:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Group CS related fields in struct spi_device
Date: Mon, 31 Mar 2025 13:16:48 +0300
Message-ID: <20250331101649.4054627-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/spi/spi.h | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index dcc79c9af8ed..9591655cf1a6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -138,13 +138,6 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
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
@@ -152,6 +145,11 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
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
@@ -164,8 +162,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	the device will bind to the named driver and only the named driver.
  *	Do not set directly, because core frees it; use driver_set_override() to
  *	set or clear it.
- * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
- *	(optional, NULL when not using a GPIO line)
+ * @pcpu_statistics: statistics for the spi_device
  * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
  * @cs_setup: delay to be introduced by the controller after CS is asserted
@@ -173,8 +170,11 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
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
@@ -189,7 +189,6 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
-	u8			chip_select[SPI_CS_CNT_MAX];
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
@@ -220,23 +219,29 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	struct gpio_desc	*cs_gpiod[SPI_CS_GPIO_MAX];	/* Chip select gpio desc */
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
 
+	struct gpio_desc	*cs_gpiod[SPI_CS_GPIO_MAX];	/* Chip select gpio desc */
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
-- 
2.47.2


