Return-Path: <linux-spi+bounces-655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA03839330
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 16:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF56289D06
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68180633F0;
	Tue, 23 Jan 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9HzX+fx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F3629E9
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024086; cv=none; b=ohTq5l1QsYtGJ5AL4Okf/RoQI8s8Dxo7HDOOAP7nwEWi09KNm+dVKWUJESKXPObIBc9/18IjvBHtS8EcwOu0b7WdBsCkX+KlcCu1FM5yArRK871ndcACA18oduU51fPCICEQkXSOYiX0zfSDIFIoQZDoI1kSs0BkPdRCMMeWIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024086; c=relaxed/simple;
	bh=+FEK7zXvkUNPYoloHVBKujmewWPaUNrgkfydcuviAQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6G5EGnwxStf3qsXOqu48OAk2HwauzNBjHlBne2E8NPFyr8DTgqcQLupUzJv/sYdcgi+11UcU+G27qa68U4W7RqaoIvz0PBhpPhpim/vAdQaUjJVJazdyhsZmoOO4YpdReD7gkwfl58WrM+LfsPyk4wjY54TJkQJzMTULSjRJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9HzX+fx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ec048e0c1so4721755e9.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024082; x=1706628882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H+4vxpbUIDd45rCzEN2Z22Mxunqggm4pG1DkoeAKqY=;
        b=k9HzX+fxGHGhBRM9HiG54NpzC/9HNYzRkNHrf6ZjAql/yvsfySr+xVSx3aCiLlgjI6
         u1dVoIxstQCKfMqWKLqehMp9f+myUe5OXqS92n1D77Gd0prCXiu32uBSWxLw+/XGGgj3
         ADk3gPSFOdL8XCK9+GVhqZrHVHEHbQvCPgBQ26coqOv71awO50TrdYLu24Vx7LMwbPOM
         Du4m/a0xywWE36l3pCXeKYRrQAsQCgkwjqwmvKQfWL4foXcXm2GolIxVN+N5RkKkqwiY
         i2twN279l6iyqRlgJXJ/WO5lp9hkB54nLLzH63OXUUfuE3ervksl9Le6ZMf9c2VG48Pu
         dqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024082; x=1706628882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2H+4vxpbUIDd45rCzEN2Z22Mxunqggm4pG1DkoeAKqY=;
        b=Ugp0yEJ2ZTnvgYFPU/ckJe8URW4/pxbAlLwF2ZK2bRJ/KhiKMmWgSFrp9mnNDFzPF1
         W5mPtz8b5niLu6npjiqg1NaI+9Hy5u0y6E2NCFIkLz8YKksaKj72xKghFAZ0SpvrnT8L
         gLOq+1TIm4gdJYL41/bl+L/VnCBx5b0OeB3q212xtW/VZ8yJ1r8gk7DanU/hRPEFnwPj
         1+NAF9hcNuDCU92/tCyVv7g8Y4u6nnfI5XZjt7OFXj+ZWwcP9GJD5jZ3UiLvWF+9F/3M
         qmEsbswvLhKiJIGAxwkysRjG5UHrMFuyCAwIq4/OHqjpYJNHDG4FCEOMHiyn5bXOxqw6
         fhKQ==
X-Gm-Message-State: AOJu0YxjlJ1GVlO0rtaMc6l9LbuYtVEQGMy5NMEwBVCcBFRMWVkZoj81
	Lae8UY3+BYoYEqz79BKtHq9hAOx1poYSI+Q+IF6nFKp0bIf1QQksSNsawlROKEo=
X-Google-Smtp-Source: AGHT+IEdhulGHnMoRApGote5ScptZ0DoCltZHEA7gddglwiHhXxlIDhI6CN7Ov1Zuk+CJc7AAijQ6g==
X-Received: by 2002:a05:600c:4448:b0:40e:937f:16dc with SMTP id v8-20020a05600c444800b0040e937f16dcmr707423wmn.17.1706024082130;
        Tue, 23 Jan 2024 07:34:42 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:41 -0800 (PST)
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
Subject: [PATCH 18/21] asm-generic/io.h: add iowrite{8,16}_32 accessors
Date: Tue, 23 Jan 2024 15:34:17 +0000
Message-ID: <20240123153421.715951-19-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow devices that require 32 bits register accesses to write
data in chunks of 8 or 16 bits.

One SoC that requires 32 bit register accesses is the google gs101. A
typical use case is SPI, where the clients can request transfers in words
of 8 bits.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 include/asm-generic/io.h | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..1e224d1ccc98 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -476,6 +476,21 @@ static inline void writesb(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
+#ifndef writesb_l
+#define writesb_l writesb_l
+static inline void writesb_l(volatile void __iomem *addr, const void *buffer,
+			     unsigned int count)
+{
+	if (count) {
+		const u8 *buf = buffer;
+
+		do {
+			__raw_writel(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
 #ifndef writesw
 #define writesw writesw
 static inline void writesw(volatile void __iomem *addr, const void *buffer,
@@ -491,6 +506,21 @@ static inline void writesw(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
+#ifndef writesw_l
+#define writesw_l writesw_l
+static inline void writesw_l(volatile void __iomem *addr, const void *buffer,
+			     unsigned int count)
+{
+	if (count) {
+		const u16 *buf = buffer;
+
+		do {
+			__raw_writel(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
 #ifndef writesl
 #define writesl writesl
 static inline void writesl(volatile void __iomem *addr, const void *buffer,
@@ -956,6 +986,16 @@ static inline void iowrite8_rep(volatile void __iomem *addr,
 }
 #endif
 
+#ifndef iowrite8_32_rep
+#define iowrite8_32_rep iowrite8_32_rep
+static inline void iowrite8_32_rep(volatile void __iomem *addr,
+				   const void *buffer,
+				   unsigned int count)
+{
+	writesb_l(addr, buffer, count);
+}
+#endif
+
 #ifndef iowrite16_rep
 #define iowrite16_rep iowrite16_rep
 static inline void iowrite16_rep(volatile void __iomem *addr,
@@ -966,6 +1006,16 @@ static inline void iowrite16_rep(volatile void __iomem *addr,
 }
 #endif
 
+#ifndef iowrite16_32_rep
+#define iowrite16_32_rep iowrite16_32_rep
+static inline void iowrite16_32_rep(volatile void __iomem *addr,
+				    const void *buffer,
+				    unsigned int count)
+{
+	writesw_l(addr, buffer, count);
+}
+#endif
+
 #ifndef iowrite32_rep
 #define iowrite32_rep iowrite32_rep
 static inline void iowrite32_rep(volatile void __iomem *addr,
-- 
2.43.0.429.g432eaa2c6b-goog


