Return-Path: <linux-spi+bounces-781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2283C5C4
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7E82872ED
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4175612BF18;
	Thu, 25 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmslO8nu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C712A150
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194238; cv=none; b=CR8N7fQxBl6xJDkFmjo/P/L7jjDyx3WhVEWA9A+Nj3lWLLODDnxzqPZTtzAylD0XvCCqEjxN+7gK4zhjEkVJJKYsxc9JEpTKRFSpCRHpkbyFYvTdufFcZI7ZjPKz7aPeAyQ+YLXxxgTtUUVupET0vs9veNjfemztJk8UJXwzyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194238; c=relaxed/simple;
	bh=kCchjwxWRpfAc5+SmKGpjAGXAy+gVUkzX3d3/qq1C+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggHt4nhPJwLKZ1R2zH3DHdAJbYWWgeJRkKcgsDwf+6UqO8GhgP5Na5XQdMA6bEdzy8uxwZH5yozNn69jeVB2bnuNvfPOcV9QDwq1D7bxMN2ZPqp10/5qfIPCVmOLcFOy/e8PnWLB9b+FfuNjuAdWrRqq6ZnrAiFUhhOTj4Y3Yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmslO8nu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ed28f8666so5691715e9.3
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194233; x=1706799033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9fJpsc9ntkK7Gm49ODwE4XlmIeMd92uqdDuqa4hcJ8=;
        b=VmslO8nulUoK1cB42SU+hb42Lj4xjfvtL7CS0Mi3KSKxH7uKuHVQuKuD3Y+tiwWW/a
         yu5uoVIn+NE+gxboumCDBovm1WqjRnUt/BXpB64GSG7vlLkLKTq3EWfLzr3YbIJAH310
         I4InOywqmlEsmSxWCnsvBl+ulzuhufvXgb6uDQ10RTss7mcShaUf+j5Nx0WUULmQJKI/
         T0t10GPJKv6WGgeLMewxHU9BNPe+5tSQsBaPawyeuQTJNqIbV/lppLT76C1EePoLvsNx
         C2sHpAT1/i3SWAjR1JxxcWoW/0ir/jeNhiV5Ne9toKa7TGI0MVATgX3PcFmypVUenqkY
         MCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194233; x=1706799033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9fJpsc9ntkK7Gm49ODwE4XlmIeMd92uqdDuqa4hcJ8=;
        b=u3xUUePVSx4T5pVkVG9G3Qk5FsWAH+RwuXHa9WpLhbdm/4C5boXNPWyw+swYl76YjF
         YaCXLoeP9kv2GaX32asKmCDQvnrz1m6HkZlgBFIoLojCZpOi0ECVIK4YBo27ASeeHH1G
         L+CEhTkTgkoJfNqFDJOYKXDjHVY6VEFHUjiwPn8YuOXNO6no/ofEV+cm9ili6/L8fvOw
         KUGaBrgz2/j3I54ZzJ5a3xEWj+LCx24Rl/WTyG47gZJyCXU25pIBPONjImzGRpHjed43
         dvVSM0U+t4JU68iJbQYkzmUvh9sPxcrBkmNg18K8zzBm1narcargF0+hw1kLfZTS72yA
         0/pQ==
X-Gm-Message-State: AOJu0YyLdH1s1dfXxaiB/hdq+WN0/JaXprapiKBfQ5Tv/ACZUBg9Mq1x
	wYWDkx1QSax+QyJm/H/VEO4f/l6T6rY/JPAWOCII+nCPiggPG/s+kZtKKaQ5YpE=
X-Google-Smtp-Source: AGHT+IHav9r3fWyDiEX8CdSvB/U4xaT1J9Vfk5kfMl/b6781KqaxDQ9QxWNs1mhHIC22Ki2pTVXdRg==
X-Received: by 2002:a05:600c:2907:b0:40e:6fa9:345 with SMTP id i7-20020a05600c290700b0040e6fa90345mr406881wmd.66.1706194233577;
        Thu, 25 Jan 2024 06:50:33 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:32 -0800 (PST)
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
Subject: [PATCH v2 25/28] asm-generic/io.h: add iowrite{8,16}_32 accessors
Date: Thu, 25 Jan 2024 14:50:03 +0000
Message-ID: <20240125145007.748295-26-tudor.ambarus@linaro.org>
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

This will allow devices that require 32 bits register accesses to write
data in chunks of 8 or 16 bits.

One SoC that requires 32 bit register accesses is the google gs101. A
typical use case is SPI, where the clients can request transfers in words
of 8 bits.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 include/asm-generic/io.h    | 50 +++++++++++++++++++++++++++++++++++++
 include/asm-generic/iomap.h |  2 ++
 2 files changed, 52 insertions(+)

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
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 196087a8126e..9d63f9adf2db 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -84,7 +84,9 @@ extern void ioread16_rep(const void __iomem *port, void *buf, unsigned long coun
 extern void ioread32_rep(const void __iomem *port, void *buf, unsigned long count);
 
 extern void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count);
+extern void iowrite8_32_rep(void __iomem *port, const void *buf, unsigned long count);
 extern void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
+extern void iowrite16_32_rep(void __iomem *port, const void *buf, unsigned long count);
 extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
 
 #ifdef CONFIG_HAS_IOPORT_MAP
-- 
2.43.0.429.g432eaa2c6b-goog


