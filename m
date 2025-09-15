Return-Path: <linux-spi+bounces-10032-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B62B584BE
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 20:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0E71A283EC
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D93191B3;
	Mon, 15 Sep 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmKOYmxY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330330F801
	for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961467; cv=none; b=DbMArQX9K4E6iNwMSym/32W/v9RAd/gJW4CBdvao4WVjcGpjYh1UOACQ2rEs5couBANyv+H0BjwudmbPsouywg8gPyfeEvEKRbSiVaGRUEGubGDR2tz7qPLjRTERGBhRqJViKDFIunGHhqa41lWM4eCMFoY73gf7p3/IliVkGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961467; c=relaxed/simple;
	bh=D7l1i7Tso98Yp3oxSA+xRb+WgnIZVt0f20hEA6CTpEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrzlH5l7+aJQls1lid7lJzAAV5o7NjS5CGjgq+4MHxoGrOs73c2tU4Fdjhvr3qqJR+Ah66aRooPfOuPQku6Xp+hiidsYs4+7G2/C2juCZKTT50nqDT296haKP3weiLJJ31v6Pw7hfTpRhpxNX83YoxYxszSnChPw+i5VPQemnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmKOYmxY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07d4d24d09so146444066b.2
        for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961464; x=1758566264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeZpyFc4Ckatn0hgt18UAr4UISB/Kvr7U8EfP7dfVc4=;
        b=fmKOYmxYsQbKxpl7ZdipV8Y9fsUxTh8mLAJTHqE7eZK+oZ0vXV6hsSpEjTj10wy52B
         xGSC6mo5GV2GR9fN6wqTXu7SR51mzxmvEyjP48BXs2th9xyX4fIsNRAcEBM5YVaE6PVZ
         FFuzPaRcytdPuPENx3LkQ0uuh1mvHrnKLVGKcLxTAUXuuQup3mmCZql62sy517IIpcWY
         evsoMHgEvQ5BdySaJf+BR71lypeq8GOlK/mBZIf3ZOsI6fFwvLSJ2Tsj8Ox/lNBiinVJ
         cuCtw2s3BglSXWXdWiiPl1EHplo3AbyyjH0JSmdOvEVDNsZG/vWhR7fOlIHRkVzRZ4e8
         0fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961464; x=1758566264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeZpyFc4Ckatn0hgt18UAr4UISB/Kvr7U8EfP7dfVc4=;
        b=fx9FxzlFW3+6hpSHoRCBwvaAPkp2uC9cCgh4Id5Cb+cw3MIFmnVyiNj/rlylM7Amwu
         cwdyxvqu+PmAYJY8KLb01sIvhAg05b1glu9W9eSGJnWwBzvU3iKroIBuwcLDDT/7NNpy
         ensxPGXWhlhYLtCB1BqUy7oyKZ6eNNg+/Mwu1dFko1QgYCs15iq4qx4u1h9LFIfEQPH6
         a92Pj7gjJT4MYIG7neAwtK46A3h+fXlsBuxTsWSIWhtMqiqBpS5WcIifFaHCqcgB10kG
         3OmvWuX1/MCEUJ05c2HafE3u5Ijne994pGe0KT75llMQVrXY8IEhflfINbOuafLFLfEh
         U8Jw==
X-Gm-Message-State: AOJu0YzJKenxgI85sPBPkBubS7HmhGNDdSZx6LIzxeiSk4LMr7KyyiWk
	fanuI1A8z3DbXj0kQFPJKc4mCQrn54YvUdNJjyVeWR8lyTcaTNEOddFK
X-Gm-Gg: ASbGnctbdGFNAuGWGVUAz79cPWaGv87nFIctzQCIhtZ0LPnbcq5F/i15LR63OjgYpwB
	6Z/YDHpQoCELKxfoaKvFsZM9cAvO+4hDAJdUmXB9u30kooUauhzfuMr89+jIC63r+WQVGcZnTgh
	kMg1FpbNtOCH80vLIXr3HaHejOcMA/gKdOAqFflpIzx4Sl3Z9SuDSlEq8c8TQzQD1tBf5XRB+8q
	RTT5oFVR2XAjCEg2CU7aYjEvNV+1rH5ZfwuOR2hPLNz2fOd8GjdqowN8kuDxnrT+FQHPfdACFmJ
	y21CVrGPtLKfkFPTGIlBj2C1jpByYyPSwWJovb9FREniEjWmnC5wfZlPTTLvS/Cb8g9QVThGGHn
	ZWjELTeyXH1cyouuUmA6RlZvlDfJHJ8F23FdcyW2jNWkdQVn5Dk2Qz38oolor16csYfd6/NiMJQ
	bAkmvSFQuQnATnLA==
X-Google-Smtp-Source: AGHT+IG4ukwBCnrVrafYVIfnQ2fBgnMS356P5egIxyTNPI1AtkBlvU4TPcYBay4AUhoWx6zE9fBkLQ==
X-Received: by 2002:a17:907:3e1f:b0:b04:25ae:6c74 with SMTP id a640c23a62f3a-b07c354fadbmr1221786266b.9.1757961463847;
        Mon, 15 Sep 2025 11:37:43 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd3e4sm983305466b.54.2025.09.15.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:43 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 5/7] spi: don't check spi_controller::num_chipselect when parsing a dt device
Date: Mon, 15 Sep 2025 20:37:23 +0200
Message-ID: <20250915183725.219473-6-jonas.gorski@gmail.com>
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

Do not validate spi_controller::num_chipselect against SPI_CS_CNT_MAX
when parsing an spi device firmware node.

Firstly this is the wrong place, and this should be done while
registering/validating the controller. Secondly, there is no reason for
that check, as SPI_CS_CNT_MAX controls the amount of chipselects a
device may have, not a controller may have.

So drop that check as it needlessly limits controllers to SPI_CS_CNT_MAX
number of chipselects.

Likewise, drop the check for number of device chipselects larger than
controller's number of chipselects, as __spi_add_device() will already
catch that as either one of the chip selects will be out of range, or
there is a duplicate one.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* no changes

 drivers/spi/spi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 91e2f4f504e8..2eb361e9e44d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2427,11 +2427,6 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		return 0;
 	}
 
-	if (ctlr->num_chipselect > SPI_CS_CNT_MAX) {
-		dev_err(&ctlr->dev, "No. of CS is more than max. no. of supported CS\n");
-		return -EINVAL;
-	}
-
 	/* Device address */
 	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
 						 SPI_CS_CNT_MAX);
@@ -2440,11 +2435,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			nc, rc);
 		return rc;
 	}
-	if (rc > ctlr->num_chipselect) {
-		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr->num_chipselect (%d)\n",
-			nc, rc);
-		return -EINVAL;
-	}
+
 	if ((of_property_present(nc, "parallel-memories")) &&
 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
 		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
-- 
2.43.0


