Return-Path: <linux-spi+bounces-10031-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B8B584BB
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3661A2820B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C00314A7D;
	Mon, 15 Sep 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgEe1LH5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC933064B4
	for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961466; cv=none; b=OHWmQvmyo8mpGZwqTvnoWfvTlcrfFuFsMmbWcgbcXQYZ/NNK/4XmZgN49QLiqCXXY1IcvolcVony4ArrH5dZxVGjgk7kaHGDoQva/f9Tvqbxz/HxerGWQ02chcTCkPxoCL9nJhvTkOUEtHpvwNcrXA4g7Te+7PqL/7zWRBO3/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961466; c=relaxed/simple;
	bh=KHf1K07NTwkhv6Wp3wTHX8eW6RchNhIV/ZMDf7/E9CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXW8jFcJnyYiViAwvn4uwjpCwKGkQ5WSwH60RPwsmntmdXa61aWTOiG8QY+rWUVAIXQSFNL2dqqKaUTO9Rv8kTJIRqGDSzS8M+TEpBpDZdWAzai1tD24c9ZILOUqAzykF6mkWdRFF1EUAxwAGTsrW+YLeVHnfzpTPSM3RWYLQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgEe1LH5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0aaa7ea90fso110030966b.1
        for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961463; x=1758566263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGAd5EwTueREEYaKyLu1qn1htBR/b/MdV1Cw2/PFlS0=;
        b=IgEe1LH5kTWDDWZYM9ujEEIwXqmYMMskqvPFfzZ8FoXThu/Kf3HhqtwDi/2FwewdHl
         UBL29cU/bdW+tGUV7CP1XrdNfhmKYs/beAqp2ckAbc/kB/1IeCgADklf4iycbmVgSgfg
         PVhgrqwzMCvIgW7a58jqSggkiHUnI6DETgtPd5qxWxz7iM/MO29hhKduePAqBTMyd/vo
         OrIq/aC11SoKXI+O+rSIRuzrCNTkGYnYSIxrAZ/SUQmqhc46c5ohpImeolZw63oOZbEn
         SVKoKmCGeG52nM8sH500c6xxp+eCxhGsUoN38a8aFWEtxnKfsRpd9XkEPaui+923Pgrn
         adeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961463; x=1758566263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGAd5EwTueREEYaKyLu1qn1htBR/b/MdV1Cw2/PFlS0=;
        b=GiE/xM8byVwNUe8ejmeIgx3lqdfqf+qQL28Xqg0CANXGJpyFk4ttNDNDkt0QD9xS5J
         O9Anhyb+NhS3a1i6330vLBNAE02gz/zj+daznmDft2yedHGjJufZXZSyFKu5XpxsZy4D
         S/UZeu6EEUVQwsqsK57sQ2TYSjdtn5fUbnu1MwuHIFcVf42m/gAOUcVolne3umFr3UrH
         hRLaGqvS0OFhxKM+zSzKhad3C3kXxlor7UE0iINzZhq0eVUHhibcCaTfGSpazFjoEFvh
         ueRQNjux16Bj5WUf6zGhmphduqqcI0XfEWQDFI+Mo3P8h4xyDsHj5N59hBuOhF+TU7cw
         YHIQ==
X-Gm-Message-State: AOJu0YzyQ/Ac3JlMbpoodtIpeoCNPxOgFrgsulrHglSjSlR/R6ILJ8mO
	Twcfd18H3CiH9mBSoPeOQyBYxNBfBP4BfNgjCdR4oyIdqyPTbO+lhUTX
X-Gm-Gg: ASbGncsHqSenJmLIgfeH88exbjtZoo6VT5XRg74JiLboQayOi1yEapAygcsArSLgxkD
	jIH1HYLQ00NBFvguK/8oVo/Ob/PlsYeycwNQSsGO+oF1rEoJu1mQSqKgBb5Xk8RFsu0gBzKs4eK
	q+d2vueYpgJIh5KCJt/BSQpGCPUJCN6fcYjUrEhWRzwYD3bgYGCofeIAdqV46UQlkP7WxJz2mby
	ON0ABAG9D1p4hkDSL1wR8VJW21YEQHhxnmPg1Y56auwCSQxo2Wm6U6gjw+3YteZALpOAPdU3hCM
	FEmBqFyFranxMXwf4AAtjFPOS8rcCgHwOZ5NnYsVHu3doIBOxvn9ygi74kn5NNZ8/kDxx8hfCB0
	Pho365VU8jfS4fmUMxOAwL8cKTCLtPU4snd8YLAiPw+BbsOZ5mCwCQQyBhhxf9/BWk4WJBMocwa
	MpvLQ=
X-Google-Smtp-Source: AGHT+IHUmkUWx/CNy9iKmZXK/Te/bh1246ey7N6I2lziuHZZC5hu9GTBD+URO/efKjEPAxGfYJB4Ww==
X-Received: by 2002:a17:907:86a9:b0:b0c:be67:f556 with SMTP id a640c23a62f3a-b0cbe67f693mr747768166b.38.1757961462682;
        Mon, 15 Sep 2025 11:37:42 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da33dsm1006476466b.1.2025.09.15.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:42 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 4/7] spi: drop check for validity of device chip selects
Date: Mon, 15 Sep 2025 20:37:22 +0200
Message-ID: <20250915183725.219473-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we know the number of chip selects of a device, we can assume
these are valid, and do not need to check them first.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* dropped removal of initialization to SPI_CS_INVALID

 drivers/spi/spi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ad965eae9c9f..91e2f4f504e8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -623,11 +623,6 @@ static void spi_dev_set_name(struct spi_device *spi)
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
@@ -638,7 +633,7 @@ static inline int spi_dev_check_cs(struct device *dev,
 	cs = spi_get_chipselect(spi, idx);
 	for (idx_new = new_idx; idx_new < new_spi->num_chipselect; idx_new++) {
 		cs_new = spi_get_chipselect(new_spi, idx_new);
-		if (is_valid_cs(cs) && is_valid_cs(cs_new) && cs == cs_new) {
+		if (cs == cs_new) {
 			dev_err(dev, "chipselect %u already in use\n", cs_new);
 			return -EBUSY;
 		}
@@ -684,7 +679,7 @@ static int __spi_add_device(struct spi_device *spi)
 	for (idx = 0; idx < spi->num_chipselect; idx++) {
 		/* Chipselects are numbered 0..max; validate. */
 		cs = spi_get_chipselect(spi, idx);
-		if (is_valid_cs(cs) && cs >= ctlr->num_chipselect) {
+		if (cs >= ctlr->num_chipselect) {
 			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
 				ctlr->num_chipselect);
 			return -EINVAL;
@@ -730,8 +725,7 @@ static int __spi_add_device(struct spi_device *spi)
 
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			cs = spi_get_chipselect(spi, idx);
-			if (is_valid_cs(cs))
-				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
+			spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
 		}
 	}
 
-- 
2.43.0


