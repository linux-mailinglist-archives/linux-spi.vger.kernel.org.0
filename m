Return-Path: <linux-spi+bounces-6790-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A12A32D8D
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202B51883252
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB025C714;
	Wed, 12 Feb 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DOG40+jF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027525A35E
	for <linux-spi@vger.kernel.org>; Wed, 12 Feb 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381600; cv=none; b=MiV2j3Ng0QiInrurDLrJgyEnQxyDS4yTl3g422Fn/rhSQCWO0Hjsn6WG7hYTudhQ661GtWK65GHm2kMPGutQi4GtRP3m5Ro51y39dfzd5qolgh4pYt1K9z4MXfhnEhDJfNKTNV5Qx8Pjop3R+3WJYRaeoBXVUvqyjNd6PXSCZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381600; c=relaxed/simple;
	bh=n22EqJ2nQnrLzFIJLAStjl6g6PS2JMh1kLsvrOG24uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7VWwWzNlgtoigj4SWrVvWmFX49Y/l6iElwIEiMvbXV1wKg8rYtFrbojirsF+01NE6oG0HNZxQeKj5SCt2nXJ7dg+gOecQlpeIdhG266bOl38H/rqjxHJQbxVG/Oxc7BZBlxa8c0t4Dt5wrPcM9LJy8zWLIC4T+ToaRVs75j+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DOG40+jF; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-726fd9257f7so116936a34.2
        for <linux-spi@vger.kernel.org>; Wed, 12 Feb 2025 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739381597; x=1739986397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVzkZvmnvhzApmruysTSX1Nt4iOOeCqfMujbI7HV23Y=;
        b=DOG40+jFqD/arkQURdtJBx7UMw/kZVIGJnC3w1jQkRx8j6firSH20Fe+Se54tOOLeB
         5ILUz094fAJ4kOjlCcKvlPJxMNFxjZBEpgmlZ2+H2FYQb743IvPEHomKE/JcLsiJXJsA
         W8BhWO4jt12ZCDwsZBZag77UswUrurIcc7/vu8hnBWrhh2x84GqIkg293nE8qZ/DvofO
         G7aP3Xh/QZO3Qt6ohXAeZmqg12c6sQrdalNXRhNPjiqDRlizl4KXMYCZDBCjGAhxKk5j
         OabMj2sH8IZq04hXFfCq9SKIg/ubBRm/bfA2OboPC97Bd91C1TyX0k05+liKvfKWgVTz
         AiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381597; x=1739986397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVzkZvmnvhzApmruysTSX1Nt4iOOeCqfMujbI7HV23Y=;
        b=o0uJq9t3jbJ632gi6JuKN490iPOqZYffT7aJg2lb6y2LH7oNzWJRX1F/98ldYRZrhN
         Aa9eTVPuux+2Pfo0KWSUKzchQzLHnshHtot6rqnTczCSTLHYMa7TVpVNXNi09Tfjvypa
         96uPDLGP+nVqAymPduc0GjfyLjlALt7ay9tTM+3/WU5p4teCr7Ky1SwlaOizXSoykSli
         dFjPvFgsj4Mrcj6F4vePNv3nJaRiLfsoq54ka0Fi1fQos6RCxXAb2Thf74BbLelUR4pF
         E21moJmIZ+qli2w/QlpL81WTv4YeYEIQirf4+TRD3PQTQrGWiZ2e2waC0UqBdzisNVsN
         Yx4Q==
X-Gm-Message-State: AOJu0YxJ7WIbsE++SNg11l+hVT4upCIwy7ITrQyaalL/7zr16p2t/zu1
	Eb7x3NEUspy5BxaCLCLU6GbYywyyW4OH0ohi9fEcBxVGPcLSedONvia4UrDxj2Q=
X-Gm-Gg: ASbGncv7Ll3U/lCd/j5gg/B81R0Wk/FxYYM2DVbUxf0P5GITZ83tY+Nxij+3mSnYnME
	3pHZqLTvorjhTYHeulOUc/Gtf0T/qZyaTI44uAUY1CNYdNVsful8j+YjIQTdw5/dTfNmc9nVE/p
	PPviDNeTXSNErZF7wR9TKmeuYUCCcNrW06DN6VtbMaZbh30+NGm7ZpleLT/JSwaGbGC0uBenpGh
	UD21dF4nGymBDwPR8FMtUWWdc8XcZwI57CeBruxZpPp11wtVDzvlNMToeajQzBr/YSSJu7DDa4V
	TcAF8kjg/Qwib1iYd9QXIxf4xwvvrBYBaYrLy60bbUwzNLQ=
X-Google-Smtp-Source: AGHT+IHANhVLAmBTAt1jn+3ZLEIQuul0W8yVFirn7Itv71qH29IIUy5H6bUe1yqlQ+ekk1urTD5BJg==
X-Received: by 2002:a05:6830:6e08:b0:726:f139:42b2 with SMTP id 46e09a7af769-726f1ceeb21mr2931274a34.17.1739381596961;
        Wed, 12 Feb 2025 09:33:16 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af9343c2sm4720190a34.20.2025.02.12.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:33:16 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Feb 2025 11:33:13 -0600
Subject: [PATCH 2/2] spi: offload: fix use after free
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-spi-offload-fixes-v1-2-e192c69e3bb3@baylibre.com>
References: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
In-Reply-To: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
To: Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2

Fix a use after free bug in devm_spi_offload_get() where a pointer
was dereferenced after being freed. Instead, add a new local variable
to avoid needing to use the resource pointer to access the offload
pointer.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202502112344.7ggtFzyn-lkp@intel.com/
Fixes: 5a19e1985d01 ("spi: axi-spi-engine: implement offload support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-offload.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index df5e963d5ee29d37833559595536a460c530bc81..6bad042fe4373e8b91dae3154ef5e22744a4acd0 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -108,6 +108,7 @@ struct spi_offload *devm_spi_offload_get(struct device *dev,
 					 const struct spi_offload_config *config)
 {
 	struct spi_controller_and_offload *resource;
+	struct spi_offload *offload;
 	int ret;
 
 	if (!spi || !config)
@@ -120,18 +121,20 @@ struct spi_offload *devm_spi_offload_get(struct device *dev,
 	if (!resource)
 		return ERR_PTR(-ENOMEM);
 
-	resource->controller = spi->controller;
-	resource->offload = spi->controller->get_offload(spi, config);
-	if (IS_ERR(resource->offload)) {
+	offload = spi->controller->get_offload(spi, config);
+	if (IS_ERR(offload)) {
 		kfree(resource);
-		return resource->offload;
+		return offload;
 	}
 
+	resource->controller = spi->controller;
+	resource->offload = offload;
+
 	ret = devm_add_action_or_reset(dev, spi_offload_put, resource);
 	if (ret)
 		return ERR_PTR(ret);
 
-	return resource->offload;
+	return offload;
 }
 EXPORT_SYMBOL_GPL(devm_spi_offload_get);
 

-- 
2.43.0


