Return-Path: <linux-spi+bounces-849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF283DFA1
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D9C1C22608
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59620335;
	Fri, 26 Jan 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j69YWkrT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FD200A6
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289355; cv=none; b=ss+0FGpSy+jUCtb+0A938f8MYQOgHxBuKVTpYUKtPbELVj8ipzFYIzaBj+0jFM9di0TKA63ca4eODmUwsbGybSqwHN4t4MEOsbdfyrgvl/1hP5VfuvsFdYuhwUqZvwzfo0kfXasbe/AUZUmQnpQx30ct8EHsjHK6DjwNfaOFEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289355; c=relaxed/simple;
	bh=/bUj8RLEZjYthKdQPh+B31SkdTcIYenu7ITI+3MnkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rX+6hvaI11wQNsNmqVXj8B7PmXghUKXBSab3tIphxs/ipWfPAHPuHeHUnBu0g2YvjXKzZpomIH0VQ5HaF5dy0vfOd5XavXWY1vxv7cDIonr+zEhcc/SShBatyf0Lbbo+jgioAZIk1hOFD6WyNLEJhEHjsH66Da8yOIjv4D9iL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j69YWkrT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ed1e78835so10008185e9.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289352; x=1706894152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV8ITwl1O57QlGGOA7a30fekUIiUXq0J9XlHzcfvV8M=;
        b=j69YWkrTdXJh3Sc3GxAPdndbbSVV3eHyHsLn7hnXdDGFmAHH4bttsILKKx72ht9qUv
         QN0ktjRpWHjoT9STE+Nsgq5DsIKaMtI4sZ728lO9GmwCbkPX1bZG/n0/WD7dPOEwulC0
         ig8RHeGa88NbXzIv6ai11WDZKPu3v/R7pmZkETPiY5qTA6nhtTgbE1w9CbF7NCRansUU
         nvM1+XlpiuHMBZ9oW1pF66jMU0bhaDAG+hY+HWtls7ODggFg++v5Asz/NdjBxyiQzg+e
         3YV+4/CCSVk4SIkmU3+ROp2iFyO4L7XjPUPYaRmFWYn0MQeAFEzAxNkwAs6iTfvSRWix
         OZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289352; x=1706894152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV8ITwl1O57QlGGOA7a30fekUIiUXq0J9XlHzcfvV8M=;
        b=CRQ0Q2TtKT41kEMSww/H/S46QNGL4Kn9njsDpIHG7cnDWSjAK3TlFuwalP+BjXXG75
         JNpi7v+9jevAQc4pgVbFTAhPaKrPCanrJonBYyKblS0GDNcqU7xKoSC/IQjsn4XLuQnd
         EznKMz00RWL107kYw+QehlVmU1mtmnhCTOPGvqgkvANmz8jbXCkF+170FifdZFIKTO9B
         N13MK6otaMbaF31WMunH283uXV7jW1wkArbMn0KuDloDXCuAU6xHHAAYAuWseM2NEdlx
         wToiRgRfkqKNr9GUZBbC272CViuVkYGw+i9uo8gLHFJcqp5ESf2fSpNMv5gx1ftNB0xe
         m1dg==
X-Gm-Message-State: AOJu0YyW9A0B7Fb8YhOCrFxfsFF9W6TD1pimCiQ3aAjdg3MpJ+3GAjkQ
	OWRUyy1AMxQeKvJ1xwEt/pWAl3FvBRFkViKJ6BvKOagHdIEMA7EGQ7CbVwhfI00=
X-Google-Smtp-Source: AGHT+IEvNW5DbdU8iWYCHzL7THeKzP8fEDzX/ESRePAImO9XzqkTKIuqDrCsNewY4d6xeB03PZgS4Q==
X-Received: by 2002:a05:600c:378b:b0:40e:8bb2:6bcf with SMTP id o11-20020a05600c378b00b0040e8bb26bcfmr75031wmr.151.1706289351730;
        Fri, 26 Jan 2024 09:15:51 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:50 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 03/17] spi: s3c64xx: avoid possible negative array index
Date: Fri, 26 Jan 2024 17:15:31 +0000
Message-ID: <20240126171546.1233172-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform id is used as an index into the fifo_lvl_mask array.
Platforms can come with a negative device ID, PLATFORM_DEVID_NONE (-1),
thus we risked a negative array index. Catch such cases and fail to
probe.

Fixes: 2b90807549e5 ("spi: s3c64xx: add device tree support")
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2b5bb7604526..c3176a510643 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1189,6 +1189,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					     "Failed to get alias id\n");
 		sdd->port_id = ret;
 	} else {
+		if (pdev->id < 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Negative platform ID is not allowed\n");
 		sdd->port_id = pdev->id;
 	}
 
-- 
2.43.0.429.g432eaa2c6b-goog


