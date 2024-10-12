Return-Path: <linux-spi+bounces-5206-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC799B2B0
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5649D283E61
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE88153836;
	Sat, 12 Oct 2024 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXu2z9sG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F614F9CF;
	Sat, 12 Oct 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726867; cv=none; b=EFm452PAvxzSwxBstIIPwGjnthDPxYRczda//8QgPWkEHa4ojkcFXfVlZOa3tFcTV4vXTqqsTlKW+bKeo7U4xqA1spz+uVO16dbbgKtIdiaRGCkTR8D5UYlm6obfPsS09aDQLGkQ0RVj5G1VnZnUPhwWtiTuXv3YYjM10q+FTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726867; c=relaxed/simple;
	bh=fctVUFgjURSsjGlyDkemHSFEutnocSZ1gDP17Fsw6Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNEh5bHU/s0XCrd8vww02XcXmtTSIyBmdoTj4bSnZSszPDG0HPT+H/eelZC7vNC8y3I04C80fIJTu3BjK1pBEVS5p4qbiL3XI7/SG3YVAzk/ql7LGmIkuPacbR1WJIyaQyUvL7OqWcE8PHs7hrWxP0Cx3ZfoDS8xUPz7nrbr9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXu2z9sG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso20498066b.3;
        Sat, 12 Oct 2024 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728726864; x=1729331664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIqunMSrCwkf+DyWUK239/3d0MJnoZNJjh6FmyYnDTM=;
        b=gXu2z9sG5yoTPuK3/Sq0kvOnpdgf89pkCSTVl6M+8YDufYf7PDrUFFHkXDhicq3uB1
         4yJbpabbYMrkKlR0cSx2Yq9R6lUgRJqnlzLaEjmgguWBqgNHSgbdxdT5VFce6cwV+Ywy
         sqq4N0nJz84fdj3rhEdkwvH6KlYGmWNsfn75OUWNl/+XGDeh28P2FSlW6Zj05q9QB+F7
         UKMOLk/x0ELLRh8/BbT01Bh4jpzNWA7tWSsZ4Gj0KQS8PBLo7g99clqwHAACUOyIbrhP
         8MwR1CM6pTjMy7hlmesJ02qGbNiZfVRsT6GyvUesxQrydkllWZmNWVAYeVZIyJjFrODp
         0C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726864; x=1729331664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIqunMSrCwkf+DyWUK239/3d0MJnoZNJjh6FmyYnDTM=;
        b=XQQqW1ghTYyoXC2FdjpIJixY+Ek4oCWe3ChqSzsSM+Pk2q79NRFk9D2hGegQG86wkv
         5G8UoFMY/Ylxe6cwjTY7uTRW5i5/6h+pJtOPeilYsCJUW//VK1VuGh7u1xhJJfXR7evo
         IqCRlcVxrJbjIytoVIiTsjYL+/tIjzd744P3OAGpeelTkR9SCPQMMLIN4RJNr5iEy9TE
         AdjWidrhA2GY+Ar3UTLI0iqmLIa1qK9ZLfBKTYDox7VGMH1oc5Am9Hub3mlR8J9UWEnX
         Eykc2d01WNI/m3pkBGBOVlpqvL9Juiy3ZBb+XEhIB3Ow7+rnYv44NW2RotqjSj6VeLje
         SPMg==
X-Forwarded-Encrypted: i=1; AJvYcCWGnpgZ+hy4TxGW3O8I/XKzdXnlz/bmvnqso/1TqumxZnRDKV3R/W7KCmC8A9+xdp5GzY8yS80VWr43qtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Zh9xpwF1DQlj1yo7XkVKP5WyoKU6Z28RhpQ1M/VuZP77voe6
	juCQ3M467KulvTchoqM+BsNtr3yFe6Az5NDSnWmQ1FleLoG04sx/QvMi62XA2Gg=
X-Google-Smtp-Source: AGHT+IHllUVcysEuC9LWDHgZzH7JRql+CETS/pVf3Ld/eGK6TRuDveJ53z+sNFDAHwksiBIKE3oDDA==
X-Received: by 2002:a17:907:1b24:b0:a99:c9a4:a4d5 with SMTP id a640c23a62f3a-a99c9a4b7b6mr385576766b.29.1728726863775;
        Sat, 12 Oct 2024 02:54:23 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80bfc5esm309314766b.142.2024.10.12.02.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:54:23 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 12 Oct 2024 11:53:36 +0200
Subject: [PATCH 2/6] spi: keep track of number of chipselects in spi_device
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-spi_multi_cs_cleanup-v1-2-dc491113880d@gmail.com>
References: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
In-Reply-To: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

There are several places where we need to iterate over a device's
chipselect. To be able to do it efficiently, store the number of
chipselects in spi_device, like we do for controllers.

Since we now use a device supplied value, add a check to make sure it
isn't more than we can support.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi.c       | 29 +++++++++++++++++++++--------
 include/linux/spi/spi.h |  4 +++-
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ab38978e9c58517bb671d7bda017c8550cc82d58..15b2f4e02a685b2c778b27473289197ab08987d8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -587,6 +587,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
 	spi->mode = ctlr->buswidth_override_bits;
+	spi->num_chipselect = 1;
 
 	device_initialize(&spi->dev);
 	return spi;
@@ -636,7 +637,7 @@ static inline int spi_dev_check_cs(struct device *dev,
 	u8 idx_new;
 
 	cs = spi_get_chipselect(spi, idx);
-	for (idx_new = new_idx; idx_new < SPI_CS_CNT_MAX; idx_new++) {
+	for (idx_new = new_idx; idx_new < new_spi->num_chipselect; idx_new++) {
 		cs_new = spi_get_chipselect(new_spi, idx_new);
 		if (is_valid_cs(cs) && is_valid_cs(cs_new) && cs == cs_new) {
 			dev_err(dev, "chipselect %u already in use\n", cs_new);
@@ -653,7 +654,7 @@ static int spi_dev_check(struct device *dev, void *data)
 	int status, idx;
 
 	if (spi->controller == new_spi->controller) {
-		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			status = spi_dev_check_cs(dev, spi, idx, new_spi, 0);
 			if (status)
 				return status;
@@ -675,7 +676,13 @@ static int __spi_add_device(struct spi_device *spi)
 	int status, idx;
 	u8 cs;
 
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+	if (spi->num_chipselect > SPI_CS_CNT_MAX) {
+		dev_err(dev, "num_cs %d > max %d\n", spi->num_chipselect,
+			SPI_CS_CNT_MAX);
+		return -EOVERFLOW;
+	}
+
+	for (idx = 0; idx < spi->num_chipselect; idx++) {
 		/* Chipselects are numbered 0..max; validate. */
 		cs = spi_get_chipselect(spi, idx);
 		if (is_valid_cs(cs) && cs >= ctlr->num_chipselect) {
@@ -690,7 +697,7 @@ static int __spi_add_device(struct spi_device *spi)
 	 * For example, spi->chip_select[0] != spi->chip_select[1] and so on.
 	 */
 	if (!spi_controller_is_target(ctlr)) {
-		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			status = spi_dev_check_cs(dev, spi, idx, spi, idx + 1);
 			if (status)
 				return status;
@@ -718,7 +725,7 @@ static int __spi_add_device(struct spi_device *spi)
 	if (ctlr->cs_gpiods) {
 		u8 cs;
 
-		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			cs = spi_get_chipselect(spi, idx);
 			if (is_valid_cs(cs))
 				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
@@ -1025,7 +1032,7 @@ static void spi_res_release(struct spi_controller *ctlr, struct spi_message *mes
 
 /*-------------------------------------------------------------------------*/
 #define spi_for_each_valid_cs(spi, idx)				\
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)		\
+	for (idx = 0; idx < spi->num_chipselect; idx++)		\
 		if (!(spi->cs_index_mask & BIT(idx))) {} else
 
 static inline bool spi_is_last_cs(struct spi_device *spi)
@@ -1083,8 +1090,12 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	trace_spi_set_cs(spi, activate);
 
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi, 0) : SPI_INVALID_CS;
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		if (enable && idx < spi->num_chipselect)
+			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
+		else
+			spi->controller->last_cs[idx] = SPI_INVALID_CS;
+	}
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
 	if (spi->mode & SPI_CS_HIGH)
@@ -2459,6 +2470,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
 		return -EINVAL;
 	}
+
+	spi->num_chipselect = rc;
 	for (idx = 0; idx < rc; idx++)
 		spi_set_chipselect(spi, idx, cs[idx]);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8497f4747e24d4ecd85b74f49609ac1c82c73535..77511c7d40df7085644cecaae325c982fb306afa 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -136,6 +136,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	The spi_transfer.speed_hz can override this for each transfer.
  * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
  *	the corresponding physical CS for logical CS i.
+ * @num_chipselect: Number of physical chipselects used.
  * @mode: The spi mode defines how data is clocked out and in.
  *	This may be changed by the device's driver.
  *	The "active low" default for chipselect mode can be overridden
@@ -186,6 +187,7 @@ struct spi_device {
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
 	u8			chip_select[SPI_CS_CNT_MAX];
+	u8			num_chipselect;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
@@ -311,7 +313,7 @@ static inline bool spi_is_csgpiod(struct spi_device *spi)
 {
 	u8 idx;
 
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+	for (idx = 0; idx < spi->num_chipselect; idx++) {
 		if (spi_get_csgpiod(spi, idx))
 			return true;
 	}

-- 
2.43.0


