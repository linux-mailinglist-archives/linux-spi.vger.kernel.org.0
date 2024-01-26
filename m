Return-Path: <linux-spi+bounces-863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7583DFD0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B630282859
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D11B24A07;
	Fri, 26 Jan 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtJIxCz8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334E22EE5
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289372; cv=none; b=VwMhQXzxKtPyw+EZIg0OubFeRQjNHelQ4Z41RSwyb+0IkLk6FvSmP6dxpngORgGdJyv2BZN0C1e8pVfey0Nan+i/jtYNxWVTxlsKceOHtRibAyhSk8+EQOwVx3tzMLPH0GMbl6vCQAnFfCVnLFXr0yZrE1Zpw1DC/bgmuqrIFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289372; c=relaxed/simple;
	bh=Lda6uhylzUEwPqctZ/bYWn6dBNKjWS7g/L6QLlibWu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZIh2vhx6tJakTLovthlyZj1MgYD/qONqp1aWhaKW6O2cBSZYqCG8xdZjTCB256i/TsbMvDdhapGzFJd5fngxmOj1mVIogkoWtcnfygZ/23LPZ7ARC2Lwm1J3/8RdC+OUrjjnzZLEr96bvxrOk57RTVxujqM9l6+TtrRoLLdDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qtJIxCz8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e7065b692so9309815e9.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289368; x=1706894168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWAxzMIZUJGbfnyG/OlNotr0pMDtQfjiFLXbcGRYeAQ=;
        b=qtJIxCz8OkSFzWLgDtIjstS8l0+8d/rbf/fgq+ilcKgyEzuOjb+oo8rx+UbeCE28nA
         sXCSI82Yalf9Mw5r4liqjeI5yp8v/DWV0YjW7UvOE8Eucbrl0Rw/5GVw7fSUDJxygVNK
         t6nnSW7mPLZg/4XnqIS8rwcKQul5f56j/4t8h/sb6P7cooZPSoVEI3SV1//qFUXL1Bc6
         6t1RMPPuY8+jpBW/3xLOnimhdwBxZ9/gKiv06NwwyvSTUwK26Yi+WJHwy6rrgWp7siRO
         fLO7TOZKi91PnLr2+24Shj5qpF2VVjNxnC4J0fPmUVvlw9OZrX00zVMdEOpTGgnVP6h2
         katw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289368; x=1706894168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWAxzMIZUJGbfnyG/OlNotr0pMDtQfjiFLXbcGRYeAQ=;
        b=Jnu2iec24fxUrZ9MumSvSvVuhM41JQ/JsGLVIn0ZMJ6lNwwudnUdE4MGLU/QTKOwW6
         4N7Py9HQociYW7Or9oEpsvE4A4klUTyx8qK0PKVbbpXoLzfHv1L3GHDaM3VGFOMi3CNl
         HHrzthEPFTbzlzrlx2NR68U2N+r0yem4rubXhrbBoLBV5GOUu5pHBZ9h3kXvhwOFsA+r
         w54a0fH4SdBZELGARd9oIQtBmbtvTFGv0HQZMyV6Z3lJgX8eRaX8QDyHt20FvZJv3yuo
         J/dLxx3D6Vqsa5TqsFkhAbUd0ErCYPiUPTZ3clRx3Gwh8iWFQ1xXzNob/M6ymyVumpH0
         32jA==
X-Gm-Message-State: AOJu0YyAu5CbYGBL21vOV5WUBzN+TGAGMkjBO2DDuDC0Sqcz8k7FqMov
	b90TYcYNSZEj7O6oaxs4fXa+cE5E5HjgeXizLxXNXQCmRQ3Y4yexW5LxGxV4YbE=
X-Google-Smtp-Source: AGHT+IGsOiEDkiB2xffnZw17FMX/xnuVHZhIvhWnxlSn6346ayQ0rGAqxJqIWl1P8tDQMLFabx03FA==
X-Received: by 2002:a05:600c:ad0:b0:40d:5f48:d1ed with SMTP id c16-20020a05600c0ad000b0040d5f48d1edmr89438wmr.66.1706289368230;
        Fri, 26 Jan 2024 09:16:08 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:07 -0800 (PST)
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
Subject: [PATCH v3 16/17] spi: s3c64xx: drop a superfluous bitwise NOT operation
Date: Fri, 26 Jan 2024 17:15:44 +0000
Message-ID: <20240126171546.1233172-17-tudor.ambarus@linaro.org>
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

val &= ~mask;
val |= mask;

is equivalent to:
val |= mask;

Drop the superfluous bitwise NOT operation.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e9344fe71e56..43b888c8812e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1089,7 +1089,6 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 
 	val = readl(regs + S3C64XX_SPI_MODE_CFG);
 	val &= ~S3C64XX_SPI_MODE_4BURST;
-	val &= ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	val |= (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
-- 
2.43.0.429.g432eaa2c6b-goog


