Return-Path: <linux-spi+bounces-861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C2F83DFC8
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FB0B22EA2
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738D22F0D;
	Fri, 26 Jan 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afhk/5YR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33AD225DD
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289369; cv=none; b=lFGrQSyTLlJsCkyxZDPWMKQv90uBjrH7L0WS3BI+7jwbtNQvvuR76+zmpfWC7JaextTIyL9DrUkca0Ma3BBGy8SvYwLrtDSqqdENC0zrTR6di+mSzKz44llex5oJ8PWHq3fv5xdFBidnPCr61vEuDz4bX63F6URePFOwSSxgmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289369; c=relaxed/simple;
	bh=raOIdRyhO8tHaPvaux5xDqf2Hk9QTHy/XAkEcRROgas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LC/I+et9ST9gc6IwnzM6Zezv54aqmO4CWJS5t1b17G1lQhCMURWz729yn0BNQefua8hze4KtETKtDuSwlcISUvSLzdUsYfjFv0q3lXQlPL6E2v6rwKQrXK6WI/Cl+3OF1raXeR8nstAm9l0GlhHCorJAHT/fr6B1isSjepVbEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afhk/5YR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ed1e78835so10012655e9.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289366; x=1706894166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3BUKyeiRYW4jeA7TZoHpkhbR6vvjhTD7HPIsfioyFU=;
        b=afhk/5YR74/ZEy5ywVT8LbSHfOvT5u9TpYE3ou5/fO8jF9//waWgPQOH+5YPjdvaQa
         XEaYf++hM7ixBJ6UdSA6mew98hYKVSKYK/HGjHBE7t9Rt4cCwEPrbRJedvaq1pOmLH/v
         IjrLXM4LZ4Ll0rmzJ8QiqnOzsNHzdvisBNs6LmsPwjWv2a53Bvm7q9uKLQjfjhmnIc31
         sFaXE0ufEEmNXbHLi6oDQPyp/aG8E0OycJCqqAMRljITcAgb+WDDL2gdvRsBnDQmEJ/g
         hZDhE38pEclpER0kqTtYPF98AbaElDMBczjQeACwE1D7c3Ss6UrDov8ozlndYL+L0JSi
         flqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289366; x=1706894166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3BUKyeiRYW4jeA7TZoHpkhbR6vvjhTD7HPIsfioyFU=;
        b=n2Zts+gyZXFLLlKxRuzOXeJ/M8G6oR1TJiBbk9d3JHJLNPswODoIUUl7g5h160t5iN
         e7tnq1k17iu7PB0fdGuobmpOqgJtMjX5wuNTEPdBvxFMNCS12SkhgsSF1BUrySDodNjB
         oWfILK2+ebpeox8oWlAOt7Wf/+KGh7xf7DfMcn5thJpqV77T+SotqsGZh1d7tIOuOvuI
         cuouN26aLmkrQA4mGvppDMV97u0sd8uFK3smfId0eIN0K9EKKG35sn3n6Tp/C69oR8u+
         W2jUfHf3F3kiX/PTWWHvuUVAclyiKUKbKBO9LaKvTKRHw9bRDfTfnu2d2pdJVjRC0Dy1
         0V4g==
X-Gm-Message-State: AOJu0Yy2u35Zouf4cWe8YOi47E01QsoxTZwSLw5+Kd3pQvcQ72D4srH6
	BekPMyqSL62tU4ewDp7hIN10jT5YVSK7H9AOFjvkZgchXsP8cui/OR7T51lKDTQ=
X-Google-Smtp-Source: AGHT+IGXA5OdbN/hZ+PSA1B3tx0eYhNTDcxU0ip6939VswQMQ+86fcDQfDoKgCsYLdXwu540N2Mj+Q==
X-Received: by 2002:a05:600c:5698:b0:40e:44af:8b1e with SMTP id jt24-20020a05600c569800b0040e44af8b1emr66917wmb.160.1706289366387;
        Fri, 26 Jan 2024 09:16:06 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:05 -0800 (PST)
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
Subject: [PATCH v3 14/17] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
Date: Fri, 26 Jan 2024 17:15:42 +0000
Message-ID: <20240126171546.1233172-15-tudor.ambarus@linaro.org>
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

"samsung,spi-src-clk" and "num-cs" are optional dt properties. Downgrade
the message from warning to debug message.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 08ba14adb428..dc779d5305a5 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1109,14 +1109,14 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 
 	if (of_property_read_u32(dev->of_node, "samsung,spi-src-clk", &temp)) {
-		dev_warn(dev, "spi bus clock parent not specified, using clock at index 0 as parent\n");
+		dev_dbg(dev, "spi bus clock parent not specified, using clock at index 0 as parent\n");
 		sci->src_clk_nr = 0;
 	} else {
 		sci->src_clk_nr = temp;
 	}
 
 	if (of_property_read_u32(dev->of_node, "num-cs", &temp)) {
-		dev_warn(dev, "number of chip select lines not specified, assuming 1 chip select line\n");
+		dev_dbg(dev, "number of chip select lines not specified, assuming 1 chip select line\n");
 		sci->num_cs = 1;
 	} else {
 		sci->num_cs = temp;
-- 
2.43.0.429.g432eaa2c6b-goog


