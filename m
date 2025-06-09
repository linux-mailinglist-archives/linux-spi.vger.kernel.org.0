Return-Path: <linux-spi+bounces-8412-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD6AD27C9
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 22:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555357A682C
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E2221733;
	Mon,  9 Jun 2025 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RQ/h7KoF"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622322129F;
	Mon,  9 Jun 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501543; cv=none; b=SPtmGH521uczbAxpJl3AZ3wck1oTSpfZNJK0/yNCC8FoLQ76TsN9KcmIMgpc50yd29/aToBY3p6vovmAbFKfM4OxTE95IgSZUBvif3EYYvh/r40xbtuWdE6Gcb7in6hUmT9C3e9GIg+sWvLFWaT0o5JKIyIEQKgLjpiN6hnki8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501543; c=relaxed/simple;
	bh=/FW1uODFNygTPBiads/Cgva/fZBdnCPVHS77URlMjjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5QlHZvYTJmfJjkuKMvmu1d7CmGB+hcKnHaRnCxyWz7nyz5EB6ogeSFt0LYJ7AntktET3j9YKwV5etXRZLM7Eep2GMmTfxY9ktfE4H5cp3++Ft9Q7/glK8SUgVFSYc6qtKZ4+PCS6eXRmzAy9GYLgXNZHQxwnUn5Cc0QMIyxIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RQ/h7KoF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749501539;
	bh=/FW1uODFNygTPBiads/Cgva/fZBdnCPVHS77URlMjjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RQ/h7KoFVxyEaL3gOrcwRIrSgiUi8tpf+8bZ1J3cmHacz1rZSlBzejqnzNA6GJH05
	 bfa6DvVbFooTRNtO1DccruKYL07wctByi6ad/WxxZxTwEs1/r55W8AD32nJcQP9ng9
	 k++3zu4wwvtQi17CUEWu2WFdHxXlKbqOsQHqAtV0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 09 Jun 2025 22:38:39 +0200
Subject: [PATCH v6 3/3] locking/mutex: Mark devm_mutex_init() as
 __must_check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-must_check-devm_mutex_init-v6-3-9540d5df9704@weissschuh.net>
References: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
In-Reply-To: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749501538; l=2169;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/FW1uODFNygTPBiads/Cgva/fZBdnCPVHS77URlMjjc=;
 b=XMIA2t76cWY8q3SbUJtzN8v1jQ4AwXiPpkwDqG5ui1Cd4AyjqNi3x12hCFUhxnv95kyToir+s
 tiAJIto8fDLApMRKWxsys9+vfQBWRGMaKFmhqy59sHuLny/dl0fQBvt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using the devm
variant of it. Tomorrow it may even leak something. Enforce all callers
checking the return value through the compiler.

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
2.49.0


