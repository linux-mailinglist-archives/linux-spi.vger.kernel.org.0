Return-Path: <linux-spi+bounces-9694-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0129B39968
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AE21662A4
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59830C62E;
	Thu, 28 Aug 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TO5M9yUL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F630C37C
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376140; cv=none; b=GmPKRKztov64BZTMMBZdec1iXHrAqi+OsyumXD0gII7Am5HaXNBo4uW/17pETZvm9bNYtDugSS64bZcEzNXhNgSl2qc33LyLG1fAkbKdPdxMzR1EJW5KEJlpZSjdHqNGhxOy5PsLf5gXojNhxFIV83RSYCydGLQS0avvg70cu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376140; c=relaxed/simple;
	bh=sqvq7B3cYnX+SujuTdequEm7LjrP2GZ4Bizi9Lc/GkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mu/VuKe4fIgKx9Q8oiHglYc093BEhdiH2ruoV2HrPYpCGPfaCoqFE1ErHequoBspVb3U/YCGqauERxu43c8g9AigRZ+H7lOlAwjnRyBWFCX7PvNxV+vcs00wlU0UnlkgXlDByrHejeWRH0thU+N6NEnplyiSyt+e6bB8IgA2itY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TO5M9yUL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so4511535e9.2
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376136; x=1756980936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mslvKWnCwA5R0GFjrE3cKfPnj2WRNrIsVGNIIEDmLGY=;
        b=TO5M9yULhi8I/dBKP2llgFRJvGzFrBd2i7Mg4gBCT1GhB9YR3ZiMEjKEDA6hxSRV4g
         Jo/mw8c/klsiqWkOoTwc6CUcIh6s/UnWSlofxXlFt0wim7DWS8mGqZi2dtflJZ0eHU85
         3a626MqrVVHaNijvS/C1PwftlFkRJ8wAnzAiAvnGZ0Y/UpQ3q9inWaZKehX2mKzXXzly
         mGe37A4LYBYHRGweq54B+OtB2mrliGgT2kvqORbSnzmS3N9aqJCeKTFFvUVRs3+Kxzvr
         qQwvz9IeEUSZ3iGpWV+XvIR2091SFQvWtY9nSNr/+04GAJ8wHlSDT16WGi46E+MKTVQI
         L9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376136; x=1756980936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mslvKWnCwA5R0GFjrE3cKfPnj2WRNrIsVGNIIEDmLGY=;
        b=ni3+JT8MaZ/wi4Oa01jHyofytDR2wCmRw+OoVlg+Fe6q+ymQ3QI2DOO7O4FOPT4Le6
         /tah+Ea9AwVgUJ2K+7aNx3sRYcdKRf5kOZq2iQ2sH3j1KD1h/BS5SMGslbJIYEWUjQKd
         1ZFaXjUMfM/oKyvhvhOG4RR0Wes0dzl1W3AY6ElzT8UajUCUZUtg2EZReW/9zKyuePJK
         U9UC6RiM0qExokK/xplUdYvNCFCvEcTKJSY0TobBwOyI5fv7RPD19lvdReYMl7Akuwpc
         F8hbuh6P40A5b3eHkxvcTL63kjTUQTvqr1iDlMKa1C22XmhwFw8IUnYmbDZiZ+zNDbNC
         AKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUl1hZDo/WBSiBxEV+QEAl7dBg+Q54NxFsEt3PLpXEKhvAfT+gd8ilhK5oSu8vEPnEMUm52r3FmQ/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwABOL5erBUp3+rCOwlkUiC6ArKfjl68QpTIS3KbSg9H3/fZh5I
	OqUG4uZLbsDpflMmkIWtV9P0+xNxpk7Hl06e1f1FiBU8KNiQRU1p0/tJi6pTWXiNZPA=
X-Gm-Gg: ASbGnctL+YOUwVzGZy8jWExscuhvhsryChSSVotE7PGLNlIIOV5GxR+6DoXhYJioUq0
	Q/66n1Bw2tYD4xJbqJQ1xKpOXVvn5jem0R1Z0TvVld0RUNcq3sh5DpiWrERF3XrWV/3s5swrFQP
	N5/uwklPU6bvnYzNEPTAR78C++KorWyVI/zvKSf8Cr7xz8er9Oy7hpfi7hNlayOnX50weAx0zui
	aKtJsQsTvRr+gGS2mXxUbIr4NV2UT68FnH6601q790h8xogXRD8jNJpRgXz+geOdbVpZKL8ZQdB
	IO+qcME8A1ysqeXIUtya9uFSXrykWYE++geH0XnSn50a796ofCGYk6Nsi4p0DEEryHuR4X23AdT
	5Ot3fh8UQV6EBNmeh9KCGIh02JiNXHN0=
X-Google-Smtp-Source: AGHT+IGJFSfoE0AxLWLgGJCGXq0di07FqhCAiZYjub0zCcHk6GFk3QmjgumNtkoxiIwRhmFNhphqsQ==
X-Received: by 2002:a05:600c:1c1d:b0:456:285b:db3c with SMTP id 5b1f17b1804b1-45b6a660252mr64082875e9.3.1756376136508;
        Thu, 28 Aug 2025 03:15:36 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:46 +0100
Subject: [PATCH v2 7/9] spi: spi-fsl-lpspi: Treat prescale_max == 0 as no
 erratum
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-7-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

This erratum only ever results in a max value of 1, otherwise the full 3
bits are available. To avoid repeating the same default prescale value
for every new device's devdata, treat 0 as no limit (7) and only set a
value when the erratum is present.

Change the field to be 3 bits to catch out of range definitions.

No functionality change.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index f16449cf42bb..ea25e8dab0a4 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -86,7 +86,7 @@
 #define SR_CLEAR_MASK	GENMASK(13, 8)
 
 struct fsl_lpspi_devtype_data {
-	u8 prescale_max;
+	u8 prescale_max : 3; /* 0 == no limit */
 };
 
 struct lpspi_config {
@@ -132,15 +132,15 @@ struct fsl_lpspi_data {
 };
 
 /*
- * ERR051608 fixed or not:
- * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
+ * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise there is
+ * no prescale limit: https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
  */
 static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 	.prescale_max = 1,
 };
 
 static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
-	.prescale_max = 7,
+	/* All defaults */
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
@@ -324,7 +324,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 	int scldiv;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
-	prescale_max = fsl_lpspi->devtype_data->prescale_max;
+	prescale_max = fsl_lpspi->devtype_data->prescale_max ?: 7;
 
 	if (!config.speed_hz) {
 		dev_err(fsl_lpspi->dev,

-- 
2.34.1


