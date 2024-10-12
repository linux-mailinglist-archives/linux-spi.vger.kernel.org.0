Return-Path: <linux-spi+bounces-5207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D433399B2B2
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 11:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FF7B22FDA
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC30155325;
	Sat, 12 Oct 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOX3/CAk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFB1547E7;
	Sat, 12 Oct 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726869; cv=none; b=eiou0dEo/efmOROcPWmGWxlJDfEPqmafD7QFDK/a+AlN+G4x+wU97cW7KhOdb3J3oudMp6fJozR2LPoj8K1YC+Y0sQlkWRJTub53CotBOva1uHh28gSKgDt0f1H45v7uBWeY+w57065gK4I0+DUQgEF3if2er9QRc97IPc2odU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726869; c=relaxed/simple;
	bh=YcKm+sOPug8u9u63+P+tGGXBa1Xo8VYubGbrOh8hcGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLU0uHOEZD7m+j35EeCRtrqQPcc0/5suAdM5ieSw+nWTTH303n3Yc2j6a01tlVpDpg2IKV9Sgu0+x0N3B6gMzDOkO0ZiNAubbWpLdfBX/KPvcyABVfB6P98LXQoZfJN7p5/7nq9sDk6W62Si082GxN/KSCkPBJNsdUMMhuzRYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOX3/CAk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so5324292a12.0;
        Sat, 12 Oct 2024 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728726866; x=1729331666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rn+arkCODA8DGO4i9/YKd4mdYzdhdyNcf7NV++kFN6w=;
        b=lOX3/CAkJlnRq7zhbaTOU6Gl3D1nmaQ+OW0lbA7nJm8nZzI6jixTmzdNmhEk049LYi
         y1WovBhHPqqye2qgrqoASdXS+1atNN0lkfVJst64NLglXyWU/RRaDk3SasPUF3RTglI5
         MYw8IveOMBn8wounQX/fvKKCgsx+v8VZMaWuyIEDtmTi9Yo9C10QHQAJ0N/HdREdWEUD
         MJRSo2G3W9zvN6zhu36CY0/WjoqT66Z6Mmfrx/ZqJd02JzViZn9l4DIDxfclQWv7U3eW
         t8ZJdTFCBUHnen8mS6mCqnwQBwi+wxLxiJX2T102sVLFfFCuaUM12j5ItHIi3DrwZMui
         psVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726866; x=1729331666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rn+arkCODA8DGO4i9/YKd4mdYzdhdyNcf7NV++kFN6w=;
        b=UiM5VkDZs5rRotu8ZDwk55K++ifToJsEC95kVtVPchtOnZ9sMKBPXFoeIOrOHPbAvG
         Ka2oreujSCnoFWILwhKEwCfdU4wED3cjiAiA8/H8QBgTGcsP+B6iYjhJAnpAVMIyY7gm
         KQjRT2DtWda7QgvLMRcPrQIaVAYFLpUjhEv6GQglKAkIR0EaaI0Ziyo18Ex2A5F/zbOV
         TTzCxhGrFleGx7Ih9lixX7CpPhzKcXurTPU9aMEeCUXSmdHBhB02xpcHsEr2zwFMWa54
         rY6C6ON9vaPqcPR+QrbUfc4hbgfBJu7RQ0pfmHoU+vle/8e5X/eD/4gNZpSnLUIt0JpF
         zcVA==
X-Forwarded-Encrypted: i=1; AJvYcCU45F8yf0cOydopdnYGCTO1q531RZneOFKJH66q7DUtOQM5JJ340sOVHR5fRvOLVMjC2mti+43u5qwiqxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lsE5rGgjasPJxSgXBjwULONKoo+IlQYQpFU3HTGpamaWO5V5
	1joISXf0H3TwhajYMkVuFotlPLZRzCSj6RlAzgyQppfOJrHmx5OD9B2k9ccpFV8=
X-Google-Smtp-Source: AGHT+IEEIZy962sS0NqhiAH+/P2/pIf6YHJDUZ/5UnHVdtEXH3Fq9ewNxPFXkoswpQkUFlUKGQc8Ww==
X-Received: by 2002:a05:6402:50d0:b0:5c8:a2b8:cab3 with SMTP id 4fb4d7f45d1cf-5c947417730mr4682541a12.4.1728726866227;
        Sat, 12 Oct 2024 02:54:26 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2251sm2733449a12.12.2024.10.12.02.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:54:25 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 12 Oct 2024 11:53:37 +0200
Subject: [PATCH 3/6] spi: do not initialize device chipselects to
 SPI_INVALID_CS
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-spi_multi_cs_cleanup-v1-3-dc491113880d@gmail.com>
References: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
In-Reply-To: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Now that we know the number of valid chipselects, we don't need to
initialize them to SPI_INVALID_CS to be able to know if they are valid,
so we can drop both the initialization to SPI_INVALID_CS, as well as the
check for it.

We cannot drop the define itself though, since it is still used for
spi_controller::last_cs[]'s state.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 15b2f4e02a685b2c778b27473289197ab08987d8..495b391710d69a46beaa56c1a4332eb6677d2f45 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -624,11 +624,6 @@ static void spi_dev_set_name(struct spi_device *spi)
  */
 #define SPI_INVALID_CS		((s8)-1)
 
-static inline bool is_valid_cs(s8 chip_select)
-{
-	return chip_select != SPI_INVALID_CS;
-}
-
 static inline int spi_dev_check_cs(struct device *dev,
 				   struct spi_device *spi, u8 idx,
 				   struct spi_device *new_spi, u8 new_idx)
@@ -639,7 +634,7 @@ static inline int spi_dev_check_cs(struct device *dev,
 	cs = spi_get_chipselect(spi, idx);
 	for (idx_new = new_idx; idx_new < new_spi->num_chipselect; idx_new++) {
 		cs_new = spi_get_chipselect(new_spi, idx_new);
-		if (is_valid_cs(cs) && is_valid_cs(cs_new) && cs == cs_new) {
+		if (cs == cs_new) {
 			dev_err(dev, "chipselect %u already in use\n", cs_new);
 			return -EBUSY;
 		}
@@ -685,7 +680,7 @@ static int __spi_add_device(struct spi_device *spi)
 	for (idx = 0; idx < spi->num_chipselect; idx++) {
 		/* Chipselects are numbered 0..max; validate. */
 		cs = spi_get_chipselect(spi, idx);
-		if (is_valid_cs(cs) && cs >= ctlr->num_chipselect) {
+		if (cs >= ctlr->num_chipselect) {
 			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
 				ctlr->num_chipselect);
 			return -EINVAL;
@@ -727,8 +722,7 @@ static int __spi_add_device(struct spi_device *spi)
 
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			cs = spi_get_chipselect(spi, idx);
-			if (is_valid_cs(cs))
-				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
+			spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
 		}
 	}
 
@@ -781,14 +775,6 @@ int spi_add_device(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
 
-static void spi_set_all_cs_unused(struct spi_device *spi)
-{
-	u8 idx;
-
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
-}
-
 /**
  * spi_new_device - instantiate one new SPI device
  * @ctlr: Controller to which device is connected
@@ -824,7 +810,6 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
 
 	/* Use provided chip-select for proxy device */
-	spi_set_all_cs_unused(proxy);
 	spi_set_chipselect(proxy, 0, chip->chip_select);
 
 	proxy->max_speed_hz = chip->max_speed_hz;
@@ -2450,8 +2435,6 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		return -EINVAL;
 	}
 
-	spi_set_all_cs_unused(spi);
-
 	/* Device address */
 	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
 						 SPI_CS_CNT_MAX);
@@ -2596,7 +2579,6 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	strscpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
 
 	/* Use provided chip-select for ancillary device */
-	spi_set_all_cs_unused(ancillary);
 	spi_set_chipselect(ancillary, 0, chip_select);
 
 	/* Take over SPI mode/speed from SPI main device */
@@ -2844,7 +2826,6 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	spi_set_all_cs_unused(spi);
 	spi_set_chipselect(spi, 0, lookup.chip_select);
 
 	ACPI_COMPANION_SET(&spi->dev, adev);

-- 
2.43.0


