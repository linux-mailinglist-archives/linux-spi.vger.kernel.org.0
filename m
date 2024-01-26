Return-Path: <linux-spi+bounces-851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9FF83DFA5
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EA92830C1
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116FA208DA;
	Fri, 26 Jan 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltzeatPy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5E02031A
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289356; cv=none; b=LRD4Gbkl++KI1B8tcot4UAoRzJqySJpAemZL5Tmap7sM9KQ8/Y2RG6vGEHuIz01H2TcPEzl+c1KMSbBcl0JmpmHEf4DcxIE1M+R7ihPJlwPRHoU5l1Ome5O3fe4UwOjvElDyi5xgvxAqZdS6TjZRuOAInaFcCY7rlEI+a2CiozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289356; c=relaxed/simple;
	bh=AoGW2GcL8h1o+dsdkCi/8xC5olvRIKqtfKKZ6T6LaHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFgPP7rFU6VmI8r45p6DCohEdwWC8SfGl30RkJ7XAqXVTVx3Q9shb5Uo17+KexwTs24obOqzgYmnOdbfsf8d8dX57v3ByCDYO8mwGIMhQLrxITGdz00VmMQmHMAZw0/SFyRlaj5/QEnuqPJBCQR2fI0gvKygKkIn/U0Uq1HaYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltzeatPy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso13098915e9.1
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289352; x=1706894152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZyIu4b6YNe2wvKK+UomLqm5rV84CGo8FcGUcF1/2RQ=;
        b=ltzeatPyGovRRuSoHwtx6y16gifwv0P4vzl5R0F96oETsy5mvGd0k8l/VL4WPufwpr
         KGYVSBrwcNzE3hd9U/5Zjen0eWz/aOvM9tY98Sku2CL6AjBA4XKFHJyJR8RgU0HjB8Ty
         EPpWAC9QfbTNZcHEw0DiOyk/ikiaw9IOYlbtBPvdhBvX/cNWolC9f38udZT3c92A/++5
         Z+1uMpkjlmFa/rHpJus17zKDVyN7XK3XLj4FyR3xget3jLiYwClbQ1OJzIq8mODC9AWi
         gn9uhA9MU1ESVCKne0uOyiFP5wfCCnSxGQOHVV/1zPrcth1wJcrmxeT7IzGOq03buI/Y
         qKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289352; x=1706894152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZyIu4b6YNe2wvKK+UomLqm5rV84CGo8FcGUcF1/2RQ=;
        b=PTh/y06J/8OPS0sKsJZUpqbg2KjMgoNR7U9H0EjHTELluH0ha6Y3G6kQiWpyi4pZEr
         PUPQqx42JqEJx1L0jk38mdIhiP0N+LncKHlCuaqbB210xG0dH7CgQv50As9nAloXBjQD
         QUpmNmlzCZBw1C9Rt6Qa1w2RZSFZhkQHwqB4tEk7ctb5MX9xpGQAxEuFe2RLWVOhA0ja
         zdgdEQAisnErcxA3IvpztrHpfU8m5b1v8zwMrXMEeI4W7+cTF94HIi3uvqL1W05Y93Eo
         g6hpyOX1N4c35rYjF4Fz14ZF52I3Lzr81ePiFQ06NUjiAJ1hJQ/HwPIRGaZDENva5fyi
         +UmQ==
X-Gm-Message-State: AOJu0YxEn09hF+ypZ9f1TlwBjeb6G4beDfT5ZXOBoNeY5U6e/RuTU6iR
	/3+kFKVfvW/RJqDcToevNzA/8x78cbwYmeYthnYhGronSjpfMpKpS2EbcV9SVkM=
X-Google-Smtp-Source: AGHT+IGiRqB6KKdRJGfBC0XVbzCa+2WAHj0q2DYE1xYBRryatdCnKSiMtb1kLgtQZLGJlYfS6qjo7g==
X-Received: by 2002:a05:600c:458c:b0:40e:3a6f:9b3e with SMTP id r12-20020a05600c458c00b0040e3a6f9b3emr57710wmo.6.1706289352631;
        Fri, 26 Jan 2024 09:15:52 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.51
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
Subject: [PATCH v3 04/17] spi: s3c64xx: fix typo, s/configuartion/configuration
Date: Fri, 26 Jan 2024 17:15:32 +0000
Message-ID: <20240126171546.1233172-5-tudor.ambarus@linaro.org>
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

Fix typo, s/configuartion/configuration.

Fixes: 6b8d1e4739f4 ("spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'")
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c3176a510643..3df4906bba34 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -180,7 +180,7 @@ struct s3c64xx_spi_port_config {
  * @cur_speed: Current clock speed
  * @rx_dma: Local receive DMA data (e.g. chan and direction)
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
- * @port_conf: Local SPI port configuartion data
+ * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
  */
 struct s3c64xx_spi_driver_data {
-- 
2.43.0.429.g432eaa2c6b-goog


