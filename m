Return-Path: <linux-spi+bounces-8254-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A751CAC0EF0
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB465022BE
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E4328EA6A;
	Thu, 22 May 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEniJUFD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85B728EA4E
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925579; cv=none; b=cbcmaWGiWOHkc/VHpSQdj3pCLv+AfHvRJEyXswhUjycTkRxJdtxlemLrswW4U5jAnEh6hp5jTer3W4ffFOO2wpS+RFvNDh8uRJ4baV3TBhfdwFrirdmswpJZevZk/Gzho/SptukMAv7Jxji4djj81U+xP8fo6rLzNIIAYbZqvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925579; c=relaxed/simple;
	bh=k0PcdAJ0HJ4xwSr8Ni1t6OBhIXBRFHDlIiZHG4Apiiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGHaCPgzBCicTBBtHf70GfxUD7yWCU9HCSmXWDoMNXDrqmoSKiUqJ0VN7rF1ZvF11SlBM/KgANCrVMXMqXk+2uo/Cq9BG0to+SXOSrMFbpgpxOdyEAA1QOil/X97nt8xeqeXe5gKECc06nG0OXPioOc4c7PQTYadixVhXJgjzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xEniJUFD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4bdee0bf7so610019f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925575; x=1748530375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLFyEyvP8ZFrDRQwCY+ktHxPM5O5euwpWz07D5k+81M=;
        b=xEniJUFDXmGi6teLblwVfwo5TaN+v/muwN7FVywq86Vz4XABnHuN80Plj4xyCsMecO
         E/Jl4gwTKdJJl693OKP8tE76sbUbCn8tzQEMXjIppktCUh0SGbT0MeHowd/bvhKmto1X
         0MJ/buiJR4iU6/s9t4rkrcH230R9MrPjmipyMw/uTKeJcV7ebeaeKe9LkHgblio3FvlN
         veLjLUAbjamzZ1bBk7wYKt99GyMbx4qcI3+JqyqWMetkRDTUA7aAwV81WpZh/aN9v27j
         166pgmd5fTDP9xhBjJhUCcosJrAl10FPzmWn89EWhTRcdpVaalNLPP8QhnIUAOhciQlE
         lylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925575; x=1748530375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLFyEyvP8ZFrDRQwCY+ktHxPM5O5euwpWz07D5k+81M=;
        b=jQn8GaLNN2fAzI4VAY8n/w/Rq1+mu6Oo44msfvonv/TBbhtS4USddWC2HMQ0OBZgKq
         8p0EgGdniU/MOy/MnEcJYiybLClCmV4pWvlUpVI/sx7u2U9QaJn3WDTHS3yhHFNgIHYl
         f5gys05Rmtr0pPcIO4E+szGj/3F2IELP/NCXUolRsxBWRBh3ycK+tm6kfalu8A4rMkms
         pj7j/Ncu3oNrT/VG6J6Hlrx42iD6ZTEC/e0QemCQCtWO2SoNvwa4NeiPSOauK1wDgLjD
         XRlHEe85nwAaH2vMaSx+ri1MzJjIipiwAgzNQwnF9HP88u0tI7uDd8v1z5/bquYWdTg+
         j+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyNQ/BVuv8/kCRK3UI7b+4y4Njd/9+IlUGLPZxMQs77ez3n3seTG6D/1eC98OllSI8T8lQW6WtC24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY50yQTzmbVEYW/WfqNcsJuX1SgLolJ8SZ1XVZ6bJVlzde04jl
	R8Ydq0RLZWF4d3WjW+uxhc8v5QKLkzr5hHPVAHxXP5uUM0Xtv1Y2GnAapbI5BC9R2tE=
X-Gm-Gg: ASbGnct5CjMW1J+gnGtAEzd+nJiZ5nm/97ieejRVbLYVWgs+Zxu1poBt+bsZ7f9zfrG
	K74Ra2NgHhAn3+dhUfbAgz8WF1XbmZXdvjGmk0/Ws9cwe9DydbFFQkDYvAFNW5ZhjtEusFM2t6F
	DXCmicBSOn7HszxdBEpCB7KjoDs3eoeU97qJ3qZmbO2h0kVg6zYW+omQDaNOCK3Byf/AAuXr6K/
	gp2WnDmScw9mG/uvq+R9wcCctkpm4bhCV92Y4/MCLqG+UCD+vbGlzJo8UYFhrvXFx/At27jvI47
	bLRGsBu7QkrUTYt/M0/tHjpTADm4CUWS0Jjs5kO9ig7j36/CEUP03ohJ3+2Y
X-Google-Smtp-Source: AGHT+IHpujM/0/34jM6P3ZaQZmGH/9lm4oq4PRVyuyvqdp8HN5RGOmpnF0//KC96gVkhdqXMaCEYdg==
X-Received: by 2002:a05:6000:1889:b0:3a3:7e01:d2fa with SMTP id ffacd0b85a97d-3a37e01d307mr9061150f8f.28.1747925575135;
        Thu, 22 May 2025 07:52:55 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm104965555e9.27.2025.05.22.07.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:52:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 22 May 2025 15:51:39 +0100
Subject: [PATCH v2 10/14] spi: spi-fsl-dspi: Reinitialize DSPI regs after
 resuming for S32G
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-james-nxp-spi-v2-10-bea884630cfb@linaro.org>
References: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
In-Reply-To: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chao Fu <B44548@freescale.com>, 
 Xiubo Li <Li.Xiubo@freescale.com>, Lukasz Majewski <lukma@denx.de>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

After resuming, DSPI registers (MCR and SR) need to be reinitialized for
S32G platforms.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 77 +++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index db5a2ed66f68..a3efe1bd3b37 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1284,41 +1284,6 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
 
-#ifdef CONFIG_PM_SLEEP
-static int dspi_suspend(struct device *dev)
-{
-	struct fsl_dspi *dspi = dev_get_drvdata(dev);
-
-	if (dspi->irq)
-		disable_irq(dspi->irq);
-	spi_controller_suspend(dspi->ctlr);
-	clk_disable_unprepare(dspi->clk);
-
-	pinctrl_pm_select_sleep_state(dev);
-
-	return 0;
-}
-
-static int dspi_resume(struct device *dev)
-{
-	struct fsl_dspi *dspi = dev_get_drvdata(dev);
-	int ret;
-
-	pinctrl_pm_select_default_state(dev);
-
-	ret = clk_prepare_enable(dspi->clk);
-	if (ret)
-		return ret;
-	spi_controller_resume(dspi->ctlr);
-	if (dspi->irq)
-		enable_irq(dspi->irq);
-
-	return 0;
-}
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
-
 static int dspi_init(struct fsl_dspi *dspi)
 {
 	unsigned int mcr;
@@ -1354,6 +1319,48 @@ static int dspi_init(struct fsl_dspi *dspi)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int dspi_suspend(struct device *dev)
+{
+	struct fsl_dspi *dspi = dev_get_drvdata(dev);
+
+	if (dspi->irq)
+		disable_irq(dspi->irq);
+	spi_controller_suspend(dspi->ctlr);
+	clk_disable_unprepare(dspi->clk);
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int dspi_resume(struct device *dev)
+{
+	struct fsl_dspi *dspi = dev_get_drvdata(dev);
+	int ret;
+
+	pinctrl_pm_select_default_state(dev);
+
+	ret = clk_prepare_enable(dspi->clk);
+	if (ret)
+		return ret;
+	spi_controller_resume(dspi->ctlr);
+
+	ret = dspi_init(dspi);
+	if (ret) {
+		dev_err(dev, "failed to initialize dspi during resume\n");
+		return ret;
+	}
+
+	if (dspi->irq)
+		enable_irq(dspi->irq);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
+
 static int dspi_target_abort(struct spi_controller *host)
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(host);

-- 
2.34.1


