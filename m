Return-Path: <linux-spi+bounces-9876-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE6B41DD2
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 13:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D09F685AFE
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A12FC019;
	Wed,  3 Sep 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsFKYKJE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056492FB99F;
	Wed,  3 Sep 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900593; cv=none; b=okH6/Ruh4wL2i+oiocwor5zX55WBbHvlZsgK0uqaBhwIc5uUmLigq2kZarP3ndYB4d3UA2MqN+Sz68lJF7xFIVYjMiAj/6i4QE6LgzYlhNgVdzO+ulsi1PCAwNYrr9tn4YcxPXP4az4NxuHPgW07hDhHdFlBKR44oKdjk1kw00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900593; c=relaxed/simple;
	bh=5rNlgqqgTlr+XudfeqyOQYFJPrNNPYhx9KLx8acUYqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q3j+tppLzo1sL7sxF/rGn5T1H8cfQCRGXf/jn+bc4t2KU28SiSvt9ZyJTqVyfVAX6ua/xnCOqgjxaJt31AsJ4LNqjq53q7wOaiaBNPto8a62sVlbIYjjZh2w+I+ECYO1oQ/rM8ajOh9tJHR8J04uLDUe39Gv225Lr5pBdoGweDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsFKYKJE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cebce2f78so12216861a12.1;
        Wed, 03 Sep 2025 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756900590; x=1757505390; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bgQ4mzV7w6xYRm/v1nasWaTRjoxbGycA47ijfOscHNI=;
        b=HsFKYKJEQGEXXQq6e9z5DESQZCK7FP9JgT/Q/uSNe+03X5sPy4tvIa8BiovlKwJmNj
         SjMcbh4jMBO86cg25ruped7vJLl1ZY6cRz1SHyPsXBzTmCxYeIS4fQp+fDnQkS8AI+u3
         AE4n55meHah5BgE0CaAjLFqA00IjUVENNsMCk/f6uZZ3L7O2I7+0gS2MqwFPR42dpPj1
         f7WMCmuVKZivuLJrLD/ppE/S3jxn7FzBoXRWvE50ITKkWkhHNvkwBiYfeVjfbKVGGziD
         hjtpLp9UkfY+8xY3H2a10Vqk49keuL00rr/kGi8+cemvMSbOtlV67uGjMfTv0mdpWWic
         XnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900590; x=1757505390;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgQ4mzV7w6xYRm/v1nasWaTRjoxbGycA47ijfOscHNI=;
        b=iRKqbTSEJVNnkL5WNYPxn9ew0YE+XakGmYP5DsMAllZa668OtFjU3/HDluxGtXT73v
         qZ9e/+O+MjBomMkdxwc1DRSHmhs1xlQQZ3TNzwR/Q5pu7faVIb7u95slX34Vc6ye/3tH
         7jyjHlboRrnLEAZceYEmGuW9K81Q8eHE9KtVAZ+609rk9x1irWBEf82jOB8H/Mukr5PU
         PGQIK8CpIuLWVGGZOcvyI1wH5EhtuAxcFAcZNsZF7k7RecOra/U1x7DWvOGs/xmnk0rh
         EB75yiIW1g6ERyEPD9lKvjTCynHeGhOhK7UOvsdQPPyR1Qp5qfb79iZV80h9hODH2x9p
         G9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKbw3izjRQN7Xp8tpTwE2DcW+kyJiOiP16oC0KuOFv8bS2gnV1qzTF94voHSQDZlThlpg9nAMwrrfej/V7@vger.kernel.org, AJvYcCWw2Hv5OXem/Ns+OfVD3JMd5YEMzeAR9Gq90mE2vMfoMGWAIM83lqOAERCc0IAr7zP4G1gaivmtjqgA1Ofm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq1x2LgLyWzDWwfOn8qnruEPrQ7YH2hiCNfh0HRbtu/GS1J/7E
	pOWsmxpp4V6PMySFyDTT9YtIOPV9QL+Dv/REeFvA+mgTkf4qK3Q+Etae
X-Gm-Gg: ASbGncu9RiElw7AdaTghUv23akysahw+GhWvwmZ1UwL6H8xA694Rn186FmiHXvf8H7D
	tpxJ4zkbcldaoRXbe01/7siG9fyrBtFvJ8ZTikgEsxS3i4bP30xBpUx2UrXqc95oO/Cp4Ro5ws8
	rGwppWEW0WF6MPg+5WYPPECOLuESNG7kuhoBSsP0G6HW4Ys271UUTdIVO7ekvZ5xTtHkOndJ78d
	TDmPhleaAb6TmCH9nYamTqPuqEhBZlIUlWoqiGChwl9JQC0mCIuhxcOZG7zqaTTtiV1Vh/LixHK
	/dj6e9v32wHBZh2TDrKEpWcJJbfz/5G4EouucI9QsM3EOor5isXywVQX796hjjjKeZQOyYsyDSp
	rciAMRbWnAFYHU9FGonuTSzT7DyLNNg8q+0fi4ov7QivkcR3qC3Ae
X-Google-Smtp-Source: AGHT+IHlpVkoZ714lm9sCOc6c6toH/Ap2jpLri6VfZ+0i+mVGwiseAQ3UC1Rjt/7WHA2hxWgBLDh9A==
X-Received: by 2002:a17:906:9f8e:b0:afe:c6a0:d116 with SMTP id a640c23a62f3a-b01d8a6b700mr41197066b.18.1756900590218;
        Wed, 03 Sep 2025 04:56:30 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b04252103f2sm785506566b.50.2025.09.03.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:56:29 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 03 Sep 2025 13:56:24 +0200
Subject: [PATCH] spi: spi-qpic-snand: unregister ECC engine on probe error
 and device remove
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-qpic-snand-unregister-ecceng-v1-1-ef5387b0abdc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOcsuGgC/x3MQQrCQAwF0KuUrA1MR4eiVxEXJf0zZhNroiKU3
 t3B5du8jQKuCLoMGzk+GvqwjvEwkNxna2BduimnXNI5ZX6uKhw228JvczSNF5whAmtcplxrmeS
 E40i9WB1Vv//+etv3H/Svi9RuAAAA
X-Change-ID: 20250902-qpic-snand-unregister-ecceng-572ff57c4e31
To: Mark Brown <broonie@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The on-host hardware ECC engine remains registered both when
the spi_register_controller() function returns with an error
and also on device removal.

Change the qcom_spi_probe() function to unregister the engine
on the error path, and add the missing unregistering call to
qcom_spi_remove() to avoid possible use-after-free issues.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 2812ffc421d27a7e932b8e11731bcbccd0d23600..28755dbce399d836ab6209e44f02f05532386344 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1606,11 +1606,13 @@ static int qcom_spi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed.\n");
-		goto err_spi_init;
+		goto err_register_controller;
 	}
 
 	return 0;
 
+err_register_controller:
+	nand_ecc_unregister_on_host_hw_engine(&snandc->qspi->ecc_eng);
 err_spi_init:
 	qcom_nandc_unalloc(snandc);
 err_snand_alloc:
@@ -1632,7 +1634,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	spi_unregister_controller(ctlr);
-
+	nand_ecc_unregister_on_host_hw_engine(&snandc->qspi->ecc_eng);
 	qcom_nandc_unalloc(snandc);
 
 	clk_disable_unprepare(snandc->aon_clk);

---
base-commit: 793681dc7cc6482484fdeb658f5ac20bf0a570b9
change-id: 20250902-qpic-snand-unregister-ecceng-572ff57c4e31

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


