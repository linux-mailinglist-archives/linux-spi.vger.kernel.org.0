Return-Path: <linux-spi+bounces-8625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A5ADDA76
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 19:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569D71946289
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6C18A6AE;
	Tue, 17 Jun 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bvJyziaT"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650552FA624;
	Tue, 17 Jun 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180100; cv=none; b=dVlmuaGfuzVcdWEDWPCgHNpf/OfBK4OJJdz3qQUj1C7JzdIv3TyDZ4Z36mUhabVtKO/UNBodXk/6Fubi5FBqZEx38p1KhiEAKAm4YD5Mf2O91h6SoZJeXhm1jBbnq7pkp0bfeabVnZCrEayOszfAU/2TBtJWPEFnQrOa4uB6N2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180100; c=relaxed/simple;
	bh=AuxtpYqs5FNIL0EGyqHv96U5R2IjhiLssoMKRhLVONY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKAwfpcwfqqCh7zFWhY2ni+JP6+KmrdZ08jlnp3Nl6IY2kUiNhHOhHrGox6KLn90oUK1ibI5wYAq4RpzyKwDOCZaCDLlhSU/UITjhzwEqPeVFDBcnYcti9u336xynJme1ptHElbwrcvbsBvwVfNTSEws7zrTjuLCT+d1Rz4QmtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bvJyziaT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750180095;
	bh=AuxtpYqs5FNIL0EGyqHv96U5R2IjhiLssoMKRhLVONY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvJyziaTj0OsANyUxgfo6buQZtHaJtyDKhjeLJ5DFCVT2SjCRGkHoI3xWxsWVDO5w
	 lEn5eYgrVwOjXpawpzIpRiYnqnchghybuNdGwYqSNzCvbP2H3oVNeEW5GdLjaKhZ3U
	 35/cWRRYqiWRjyCetcd8DStci9OeTCzGsiMqKeyU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 17 Jun 2025 19:08:14 +0200
Subject: [PATCH v7 3/3] locking/mutex: Mark devm_mutex_init() as
 __must_check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250617-must_check-devm_mutex_init-v7-3-d9e449f4d224@weissschuh.net>
References: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>
In-Reply-To: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>, 
 Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-leds@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750180094; l=2094;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AuxtpYqs5FNIL0EGyqHv96U5R2IjhiLssoMKRhLVONY=;
 b=znm+IVfmuIlwCHOFshJrDVyhLHYeVY8p6g360HaBwcKqTLL602/KIs0nHvkJxSaPeH7gJe3ky
 bhh1LIa3n1hCO+pRCyd4t0R6Remyw8aE4sf5NdKgA8vOoccivqNMK3x
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
marked as unusable and trigger errors on usage.
Enforce all callers check the return value through the compiler.

As devm_mutex_init() itself is a macro, it can not be annotated
directly. Annotate __devm_mutex_init() instead.
Unfortunately __must_check/warn_unused_result don't propagate through
statement expression. So move the statement expression into the argument
list of the call to __devm_mutex_init() through a helper macro.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/mutex.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a039fa8c17807c700d3b61193feac0418cad1243..00afd341d293ddfcc0a427b576efdce044955e38 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -126,11 +126,11 @@ do {							\
 
 #ifdef CONFIG_DEBUG_MUTEXES
 
-int __devm_mutex_init(struct device *dev, struct mutex *lock);
+int __must_check __devm_mutex_init(struct device *dev, struct mutex *lock);
 
 #else
 
-static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
+static inline int __must_check __devm_mutex_init(struct device *dev, struct mutex *lock)
 {
 	/*
 	 * When CONFIG_DEBUG_MUTEXES is off mutex_destroy() is just a nop so
@@ -141,14 +141,17 @@ static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
 
 #endif
 
-#define devm_mutex_init(dev, mutex)			\
+#define __mutex_init_ret(mutex)				\
 ({							\
 	typeof(mutex) mutex_ = (mutex);			\
 							\
 	mutex_init(mutex_);				\
-	__devm_mutex_init(dev, mutex_);			\
+	mutex_;						\
 })
 
+#define devm_mutex_init(dev, mutex) \
+	__devm_mutex_init(dev, __mutex_init_ret(mutex))
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.

-- 
2.50.0


