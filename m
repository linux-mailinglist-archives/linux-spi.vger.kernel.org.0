Return-Path: <linux-spi+bounces-5032-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB03989472
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 11:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2892A1F2455F
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91C15688F;
	Sun, 29 Sep 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SQzVQMAM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77213C3CD;
	Sun, 29 Sep 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601759; cv=none; b=BlFSYyEf+EiIDrXDsPLC6N+7IZm/Khz3hBze4VfOiJUImSaEQNsBx3mo+O2zl5RZNVYJH5qQiTfpklVpMQcKh8ioW0EoBdgM5tqWA73mnmx5/Q8yUjue5r9ZpVLkANnH1CMpiRyHLsqSQlLZlaIdqhWSu/6gtkP8M9bRbFW70CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601759; c=relaxed/simple;
	bh=6Yi5HucFpGn1vLMidv2Pv6SSVoebYZfE0QhcyiONPvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWHYTX3Phuld+Jj7eH1iDuodoL0nrnw9/K//pIi8LsG8lPm+qnKl0kgXkJ1qlk4ugzd0QF//gFImGdKTCyHrZi8muAFaI8sd2H1PLF3SJQBUQT8lXPfun5ehDHjDVmDrmGoJzVy9PhLuttPqC/9KeV1cLK4zAZdVwdra+YRZ/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SQzVQMAM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727601744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVqzY/8n0kj3yAF96lmKr1C9k/wOn5fp+Ckfts8zEko=;
	b=SQzVQMAM2CP0fe/Y0AL8iWa5e9oNhoOCl2GK2YZhWRAXhWYP82MOtxJPUUbtP4PHCjXUc3
	vvzN7PQB9etip21RLoZnNsY9dLHJla7REwNKlx8RAb+DMhfgP5905MXDRUpeojLL0ZeNBe
	RLfiFY95WvF7mAfgl/ZkGpdVubzQd9R04MTxqYiSR9ikDwD6+k94V+qlPQ+7PcmD8s3mWj
	2u/N5qukwQ5jGgWUF79ktBOBztAcCHoO2sFyHPzMZI+BE7PwJz/MeLBAmnYp5amQuIBBzN
	qW/c7F3unxboekjK4eZOKgkhZx9xXwbddchiBNPESaYO88oiad14V2ZF9hGCAQ==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] driver core: Add device probe log helper dev_warn_probe()
Date: Sun, 29 Sep 2024 11:21:16 +0200
Message-Id: <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727601608.git.dsimic@manjaro.org>
References: <cover.1727601608.git.dsimic@manjaro.org>
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
 drivers/base/core.c        | 129 +++++++++++++++++++++++++++++--------
 include/linux/dev_printk.h |   1 +
 2 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8c0733d3aad8..f2e41db0c09f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4982,71 +4982,144 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+static void __dev_probe_failed(const struct device *dev, int err, bool fatal,
+			       const char *fmt, va_list vargsp)
+{
+	struct va_format vaf;
+	va_list vargs;
+
+	/*
+	 * On x86_64 and possibly on other architectures, va_list is actually a
+	 * size-1 array containing a structure.  As a result, function parameter
+	 * vargps decays from T[1] to T*, and &vargsp has type T** rather than
+	 * T(*)[1], which is expected by its assignment to vaf.va below.
+	 *
+	 * One standard way to solve this mess is by creating a copy in a local
+	 * variable of type va_list and then using a pointer to that local copy
+	 * instead, which is the approach employed here.
+	 */
+	va_copy(vargs, vargsp);
+
+	vaf.fmt = fmt;
+	vaf.va = &vargs;
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
+	va_end(vargs);
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
-	va_list args;
+	va_list vargs;
 
-	va_start(args, fmt);
-	vaf.fmt = fmt;
-	vaf.va = &args;
+	va_start(vargs, fmt);
 
-	switch (err) {
-	case -EPROBE_DEFER:
-		device_set_deferred_probe_reason(dev, &vaf);
-		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-		break;
+	/* Use dev_err() for logging when err doesn't equal -EPROBE_DEFER */
+	__dev_probe_failed(dev, err, true, fmt, vargs);
 
-	case -ENOMEM:
-		/*
-		 * We don't print anything on -ENOMEM, there is already enough
-		 * output.
-		 */
-		break;
+	va_end(vargs);
 
-	default:
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-		break;
-	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_err_probe);
 
-	va_end(args);
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
+	va_list vargs;
+
+	va_start(vargs, fmt);
+
+	/* Use dev_warn() for logging when err doesn't equal -EPROBE_DEFER */
+	__dev_probe_failed(dev, err, false, fmt, vargs);
+
+	va_end(vargs);
 
 	return err;
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

