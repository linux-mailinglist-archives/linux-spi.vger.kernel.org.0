Return-Path: <linux-spi+bounces-5017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F5988DC8
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 06:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B438F282D01
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 04:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0015C14E;
	Sat, 28 Sep 2024 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="y2WoFxeF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD71154454;
	Sat, 28 Sep 2024 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727496789; cv=none; b=mgNM5rALO3vFHGkVIsv1aJAVL4sWwy96fTRl1HPWQaUJ8eYsj6YbEfyHLmfLpqdCuYnrhXqSQUODXi5zQ9UO/tGs3CnUXyuvd4+wbYu4pl8bztQO/Mr7Ol/dxqFemf6EB8Vnis1QiDiNuTL41jhFRkbrZXda8Tu6PjhNcB3hUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727496789; c=relaxed/simple;
	bh=T4b5SCDbPtpznM3ly/UqgYB98QDVOVTAORg7GBHsgrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPTrS5Wc/3/H2RsExG1IrTonDEaMkNMbWRr4F7c8/LYpSH8PeYRSI3cooDFrkfBs1ZZ+mjyAKzkfPGYdidLs1GnQIVN/WBPt7mb9xCdX3+QGQLZRKjBrtAbq7BvcvnIBXasPCHcvd9FV2CfUdbpEIXKk09QIZORX4xpzhE/pSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=y2WoFxeF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727496780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKsTa/7rhm4a+RlN32Byj4tfrxf7+of7JzY7hJesRZ4=;
	b=y2WoFxeFfI2AKDIiPU6N0JB5zuc5QehUTZ35W2W1yLQNoFk7BdxJHHjy/ylXFRmZVttB4X
	ZMCfcuC9tqWEg9nbfEoY6DHtRp5Ogbe3l8hteoNlQEhGmvXIpuwSvO5S+ybexoC0AwkFf6
	I6aMHf4TX8kNHavMvxzIGLlPgnXi5z1twYr6xRDGnNBDwv27cRbUgJK9jxxoZMuRxOR1fu
	l7tmbTxqoZ491jQRH+lEdmqG/4rKPIEsnFcT7+58fUssip0THFtN38ptRHWgBhdWW9NXpl
	8F++KnEbrpMk0/uO5jGrIgYvNAhfDUQYV6myNXHG/YstnNPWNgiIYdmUMvPrVg==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] driver core: Add device probe log helper dev_warn_probe()
Date: Sat, 28 Sep 2024 06:12:48 +0200
Message-Id: <2fd9a60e0efe906dc7a203cd652c8d0b7f932470.1727496560.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727496560.git.dsimic@manjaro.org>
References: <cover.1727496560.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Some drivers can still provide their functionality to a certain extent even
some of their resource acquisitions eventually fail.  In such cases, emitting
errors isn't the desired action, but warnings should be emitted instead.

To solve this, introduce dev_warn_probe() as a new device probe log helper,
which behaves identically as the already existing dev_err_probe(), while it
produces warnings instead of errors.  The intended use is with the resources
that are actually optional for a particular driver.

While there, copyedit the kerneldoc for dev_err_probe() a bit, to simplify
its wording a bit, and reuse it as the kerneldoc for dev_warn_probe(), with
the necessary wording adjustments, of course.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/base/core.c        | 110 ++++++++++++++++++++++++++++---------
 include/linux/dev_printk.h |   1 +
 2 files changed, 84 insertions(+), 27 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8c0733d3aad8..a4592b7ffa5d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4982,71 +4982,127 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+static int dev_probe_failed(const struct device *dev, int err, bool fatal,
+			    const char *fmt, va_list args)
+{
+	struct va_format vaf;
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	switch (err) {
+	case -EPROBE_DEFER:
+		device_set_deferred_probe_reason(dev, &vaf);
+		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+
+	case -ENOMEM:
+		/* Don't print anything on -ENOMEM, there's already enough output */
+		break;
+
+	default:
+		/* Log fatal final failures as errors, otherwise produce warnings */
+		if (fatal)
+			dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		else
+			dev_warn(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+	}
+
+	return err;
+}
+
 /**
  * dev_err_probe - probe error check and log helper
  * @dev: the pointer to the struct device
  * @err: error value to test
  * @fmt: printf-style format string
  * @...: arguments as specified in the format string
  *
  * This helper implements common pattern present in probe functions for error
  * checking: print debug or error message depending if the error value is
  * -EPROBE_DEFER and propagate error upwards.
  * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
  * checked later by reading devices_deferred debugfs attribute.
- * It replaces code sequence::
+ * It replaces the following code sequence::
  *
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
  * 	else
  * 		dev_dbg(dev, ...);
  * 	return err;
  *
  * with::
  *
  * 	return dev_err_probe(dev, err, ...);
  *
- * Using this helper in your probe function is totally fine even if @err is
- * known to never be -EPROBE_DEFER.
+ * Using this helper in your probe function is totally fine even if @err
+ * is known to never be -EPROBE_DEFER.
  * The benefit compared to a normal dev_err() is the standardized format
- * of the error code, it being emitted symbolically (i.e. you get "EAGAIN"
- * instead of "-35") and the fact that the error code is returned which allows
- * more compact error paths.
+ * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
+ * instead of "-35"), and having the error code returned allows more
+ * compact error paths.
  *
  * Returns @err.
  */
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 {
-	struct va_format vaf;
 	va_list args;
 
 	va_start(args, fmt);
-	vaf.fmt = fmt;
-	vaf.va = &args;
 
-	switch (err) {
-	case -EPROBE_DEFER:
-		device_set_deferred_probe_reason(dev, &vaf);
-		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-		break;
+	/* Use dev_err() for logging when err doesn't equal -EPROBE_DEFER */
+	dev_probe_failed(dev, err, true, fmt, args);
 
-	case -ENOMEM:
-		/*
-		 * We don't print anything on -ENOMEM, there is already enough
-		 * output.
-		 */
-		break;
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(dev_err_probe);
 
-	default:
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-		break;
-	}
+/**
+ * dev_warn_probe - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This helper implements common pattern present in probe functions for error
+ * checking: print debug or warning message depending if the error value is
+ * -EPROBE_DEFER and propagate error upwards.
+ * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
+ * checked later by reading devices_deferred debugfs attribute.
+ * It replaces the following code sequence::
+ *
+ * 	if (err != -EPROBE_DEFER)
+ * 		dev_warn(dev, ...);
+ * 	else
+ * 		dev_dbg(dev, ...);
+ * 	return err;
+ *
+ * with::
+ *
+ * 	return dev_warn_probe(dev, err, ...);
+ *
+ * Using this helper in your probe function is totally fine even if @err
+ * is known to never be -EPROBE_DEFER.
+ * The benefit compared to a normal dev_warn() is the standardized format
+ * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
+ * instead of "-35"), and having the error code returned allows more
+ * compact error paths.
+ *
+ * Returns @err.
+ */
+int dev_warn_probe(const struct device *dev, int err, const char *fmt, ...)
+{
+	va_list args;
 
-	va_end(args);
+	va_start(args, fmt);
 
-	return err;
+	/* Use dev_warn() for logging when err doesn't equal -EPROBE_DEFER */
+	dev_probe_failed(dev, err, false, fmt, args);
+
+	va_end(args);
 }
-EXPORT_SYMBOL_GPL(dev_err_probe);
+EXPORT_SYMBOL_GPL(dev_warn_probe);
 
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index ca32b5bb28eb..eb2094e43050 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -276,6 +276,7 @@ do {									\
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
 __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+__printf(3, 4) int dev_warn_probe(const struct device *dev, int err, const char *fmt, ...);
 
 /* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
 #define dev_err_ptr_probe(dev, ___err, fmt, ...) \

