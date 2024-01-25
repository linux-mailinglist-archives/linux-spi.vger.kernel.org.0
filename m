Return-Path: <linux-spi+bounces-768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197F183C581
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3236298620
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC4E81ACC;
	Thu, 25 Jan 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLFMDj0M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D207C0B1
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194225; cv=none; b=ZGAn4r8xHjkZ0Qh0emaNMfA6uv7V4bD55+/Y68wQKEEDQVH3DBrKzv7Cz50xXr4riU3jWR74W0pZUet3DWJmx7mwFZfvst6ESoB3quz1LKjXOhjZ1QRV5Bb9QxInoyyOA18EXWOpOCpkKErNXjg+eFQSmX/0+QXSJ6tr5qkmFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194225; c=relaxed/simple;
	bh=smOZuVUAjnUrW8CLXiRwc/T6T2SJMV6zudqfogFsgUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8PPIJ1+xcYexzQGt+MO7OG3ADFkQlwjMwKEcnDlMa1YZBr64cmUoj2WE+HQQSJVr+H0dhv5ts+NDXRkkoG9Q4t6db3c4wXtFkqr0dbyS48pSZ84t2uKvEl5giO9LQE6H8FAFH16e8SAD8MFnlC9bGvOoXnGyPgEnEdt05b08rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLFMDj0M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so80031025e9.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194221; x=1706799021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMGH3dLP6JGckYmf845pnVvdK2xfKfvG+tA1Jxqwbjo=;
        b=CLFMDj0MBPELtm8GwtXRgcvKrU6exVDBFL9elWV21DXCdCwkGoVneZqjMKjitUL9dH
         ZeL3qkKa0RYNw6iudMOqMVcFEHj1FLdYRwELi5gAxHdiCj5H4UvqV90oSdjLynpBipGN
         bru5C6wTy72c3A5h59HUZWdNjj/AwoQZWz1cxmd6oRo4rKBPoNi7PN8ZMwad1yS17r15
         uP+Y091G4+aAUdRgzQOnLc75TdJ9iKMNNk0XGGEW2Hcg6moOSdjXZRDBr7A/vruG9vES
         dkzOEwRfvbVcD/GWJDb4l1zSWAvA0M5VUvm0KSJn8YwL7ytb7ghUHroRfUGeudppZljG
         4KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194221; x=1706799021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMGH3dLP6JGckYmf845pnVvdK2xfKfvG+tA1Jxqwbjo=;
        b=E3BFldM95qmo1pe41VYTPyMGZk0fVs4GGoNcZs64mvo7uKUcDOGTRH+od8y4Rugpb4
         hxvo7oRG/pXCmEndJqDX1Ma6F0ZTs2emYvCAwx2UUn6gaRimMXahTa0SZTT/MHTF9NBK
         StEyoex3AyDjtQ/21YExRS4iGqr91m51kwR4BIfdeO9lInZUKWVRB8aN+FiQhfPHlO1t
         8N1Ic0tCfkAwTFXcb/5rcRs8RtL3bROwXnAvg5dHHKDTumxySRsB6w25XTWJ1Q7qffz5
         BxCp5WHsHa0hw7qLRbdUjCew2NHJMqeRevruBTDZ1OiBq4A96MLD0P8d7gv+xmHx8bKN
         P6ng==
X-Gm-Message-State: AOJu0YyidlH78E0cIzVAMw327rrpM18vKBh5oGvDcHTooUh0ED3t0doF
	9BISykUaXSa4uvEN/IohWX9ho582YEWuZlpQXw0GIKcYbOYArnKsjJyag1ynkp4=
X-Google-Smtp-Source: AGHT+IGeP8EArDMSlTRrMTUaMcVjtEt1A1bBBuSDoS/dgt/tngq2Oix/mynKSP5H+4fbXQ/xcWQZog==
X-Received: by 2002:a05:600c:2b0d:b0:40e:8f3e:73dc with SMTP id y13-20020a05600c2b0d00b0040e8f3e73dcmr408271wme.105.1706194221342;
        Thu, 25 Jan 2024 06:50:21 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:20 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 12/28] spi: s3c64xx: check return code of dmaengine_slave_config()
Date: Thu, 25 Jan 2024 14:49:50 +0000
Message-ID: <20240125145007.748295-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return code of dmaengine_slave_config().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 107b4200ab00..48b87c5e2dd2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -297,7 +297,9 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 		config.dst_maxburst = 1;
 	}
 	config.direction = dma->direction;
-	dmaengine_slave_config(dma->ch, &config);
+	ret = dmaengine_slave_config(dma->ch, &config);
+	if (ret)
+		return ret;
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.429.g432eaa2c6b-goog


