Return-Path: <linux-spi+bounces-852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38B83DFAC
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D911F221E3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2081EB51;
	Fri, 26 Jan 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxAY51LU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E2208C5
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289358; cv=none; b=D9zIKmlPbaBPbo8eZdWwla7q6Ri0Wd99ZDyXGmzsnMLLlLIPawnySwAems2iEpiwQ3KU7KPjqvo7MABezyYg9BsV5yIDtiRXAaNeMmYj06XRZq2qv2hxtDe/ZBMMGD29QfJjQxO/MMtP5q8vcwoKByP12vQeFffBezfi7MhNhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289358; c=relaxed/simple;
	bh=SStrJwQuFa7t2OvEUi2J7utQ18708QxGZDcStbXQU4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkZYz4lygEiK6HtAvwrzH/vlJ13fOTa29hN1YdmeCPmDG8VmrLT4irSaNCkS1KLD1S0Z8iMFmYmZgC2GLHU7WQmmkaPOD793EXMqUPEnCvkNUP0Ko6K+EqS7RuqGqKNwox8kU81MypqBLiSrHZPya6WYnQTEejJDO9ErpyRvm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FxAY51LU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso17511725e9.0
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289354; x=1706894154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00eMbYOiFNSGCFFZhUzjrYBfwNvjnqx8W7WtHq0mAcI=;
        b=FxAY51LUi9OspEcFira0wkFHPPrcf9UZD5V9DEnl+Xgs/EGNaL3WiZP6JBpYqk4bC8
         c/IC9hulKhfIUHxgpPBY/xwSEDPRS0JmckFKirfaFvwpLc/ta0JqqFqw3UtkV6rfB4A/
         Y13M57fXvcXjR+9/LbLTi3G3p7Apu5YQgW+VNDfbd6saImPVlayoC0WnBsIknVaAYDzV
         d0/fh5/wy4d8EfvQnuzrkj65WWGlXAetbCthaVGxoYEiYGvX705gwiagrDsVkC7QRMbF
         FryIy72zZI4mhuY2kLIkk/8RJmxog2fDVTYknzDCLumyS+Yi06jqDZqzIIEUrDr1n5so
         PqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289354; x=1706894154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00eMbYOiFNSGCFFZhUzjrYBfwNvjnqx8W7WtHq0mAcI=;
        b=ioM5MO108Dnueq++TPUQBAhVlqxL5OpbNuC90ts9/bSeJEBnag2tE8TcWTbw/04VxM
         PANtwm70+z9OYiifNRxaIWkyRMxIQWOmVAQM+ZSVbCdaQG0Y7KpsFULiVGvJWVIpLHxM
         tJV8Qc+8/rD8cMcXkXZzZmA9+liLIWNHZutVFVYnkQsdN1wzwYUPjM/OqHxjtpQ0Gh51
         4TA7ZwTLlReQHEdhxTPt4qvG7MH59STpKqJwjmMYCoyiPG8iJLev7D/m7M0bK0ma1pyP
         jOtjC5gtn4lHkC6LFMaEAzy8ZeFL95yCWt13qia6CHr924EcWLWlXadZYsFBWjyEW8nm
         0S0A==
X-Gm-Message-State: AOJu0YyyHoL7VJCtKTkluPVLKCJTMP8EoD0F6C8NYlxy0d1nPFbaVi2/
	4cD6c4wHBrkanXyMB7+uE5JHYRYjaMtk3d8tUpajkWy6QN9yVfJBKf7LAlcmcVU=
X-Google-Smtp-Source: AGHT+IG+EKYw0gezAOASZpCMY5zJ1wkPy9c3Np3/+vChbo3+maOv9w50JzJ+NuLYQKEMU+yB1LQEEw==
X-Received: by 2002:a05:600c:1991:b0:40e:c52a:c3a0 with SMTP id t17-20020a05600c199100b0040ec52ac3a0mr53478wmq.198.1706289353913;
        Fri, 26 Jan 2024 09:15:53 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:52 -0800 (PST)
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
Subject: [PATCH v3 05/17] spi: s3c64xx: sort headers alphabetically
Date: Fri, 26 Jan 2024 17:15:33 +0000
Message-ID: <20240126171546.1233172-6-tudor.ambarus@linaro.org>
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

Sorting headers alphabetically helps locating duplicates,
and makes it easier to figure out where to insert new headers.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3df4906bba34..ccb700312d64 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -4,20 +4,19 @@
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
 #include <linux/bits.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/spi-s3c64xx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-#include <linux/of.h>
-
-#include <linux/platform_data/spi-s3c64xx.h>
 
 #define MAX_SPI_PORTS		12
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-- 
2.43.0.429.g432eaa2c6b-goog


