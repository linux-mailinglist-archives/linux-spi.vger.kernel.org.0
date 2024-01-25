Return-Path: <linux-spi+bounces-757-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13F83C54A
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E86295FA3
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A57318F;
	Thu, 25 Jan 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WStO+iGr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628E6EB7F
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194216; cv=none; b=s69B9wxAFa8aA6IuO1LPbNibQh08XooVoEamWspPTKM/YBaHZrHnvx85w87xbgxw3nEScRHHd/KA4Q23YAhFjA9I4dEg3patHX1TvpM9PZPheJn73lEjbFf4Aqa/dqyr+jYrBK+Ad20zHsjfRxO/DiVkkxl9Da56y7LAcZzWS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194216; c=relaxed/simple;
	bh=ESbWEf4Jl9fYqrFI7JEFHOnujDBpgh6Ob+8gu7+WPuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUKIKzdjoMA2UIMhG+e5Z+1Dq32+Uklwb/gFZKA4xR8zmXTxwQkL27Prrlw9b2Xb3PHIbaKWhWjXSH76q3ds6JxLvOiproajzVgQu9HQ4mAvdJ2VVUI4VU97vRJfsDJT4i8yJnVdLvBTQ8MKI+1Ia5LxW3eApJ5X12cHz3+HgHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WStO+iGr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eccccfce0so18418395e9.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194211; x=1706799011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=600VwywIwYkKhIBCMOdOgBJMPRHlSjpGBD3EGORG+P4=;
        b=WStO+iGr/5wpfdSt1NLmo9yZqJuzerEHKe3BT1t0HU60Jnb3MwGdoFrVyRFxvyFUWH
         9/hVv4pwCrXXSbjmosye2fC2WQyKkNRLjjNPZpvI78Uq2tBfXVskeNOaLfepRyW/hVka
         JDdTtaSXdD26U6rMMU9djs9U4MSPeNn9rwmWXF52VYZ6nR/4YWl2a1JwOTMvuFTHHHx+
         YEvN11g0bPSZ9pLkIEQh9zc6lmwGSfF2b5iaAhO3CzFbfFMjxCIbZibXYQHip/fN5Nqb
         gyfGh42gauoE5QEq1gVjhKOV0JzfujuuZ/qZW6ZpQJnGARhQA/qxKLRYrXwyKTo0Jndu
         kKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194211; x=1706799011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=600VwywIwYkKhIBCMOdOgBJMPRHlSjpGBD3EGORG+P4=;
        b=EsiukJDaDM1dv+sqYNB45NzwKc2lm7dvNsF4IInydQT8W55F2EC5dJfQY5sZxEeqvJ
         wC5NAmUMtBMZIHjLY5lNSV53n/sN+1QSJsRM9f7/IuIrDCzoYdYhnRE3vSt/+GJfETo2
         7HNGn5tpIrlHanBpnyoqpFnUG5DhQOBz3IM1E8A3yXLLa5k8tNhJUVz4wS7AAbaiJvDC
         Qun0RPrpdTVC/AHS2nUSaOM5kCBvbwYRbIn6PQVIEyTuCJFj16GUoZeN79gICz5TOrJ6
         frXLr342R2iiCnIkubjrwLKg50x8jniQ5LiTeyhepFowiiFeeG4hyFwXItLqR0b7aojU
         ljdA==
X-Gm-Message-State: AOJu0YyBLpTgXgzanYvmtE3QMlxCj9KYNHl8U7/EDYJKVWYVWRpXKRIT
	3SqkrM/PUl/ILVKndqaVT8t4GYcK06YA7qUIE88KOYh4Bc0sNVYUZDawGDX7xtzTswTwYjnJPs8
	USck=
X-Google-Smtp-Source: AGHT+IEaYzPIhvI7nM66SS0HQQAjOEL9yTE6fWlerWtlckq2lzwAF+Fj0dxMxnPO6we+g9RXHphCpQ==
X-Received: by 2002:a05:600c:44c9:b0:40e:50e7:db2c with SMTP id f9-20020a05600c44c900b0040e50e7db2cmr564908wmo.177.1706194211539;
        Thu, 25 Jan 2024 06:50:11 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:11 -0800 (PST)
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
Subject: [PATCH v2 01/28] spi: s3c64xx: explicitly include <linux/io.h>
Date: Thu, 25 Jan 2024 14:49:39 +0000
Message-ID: <20240125145007.748295-2-tudor.ambarus@linaro.org>
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

The driver uses readl() but does not include <linux/io.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7f7eb8f742e4..c1cbc4780a3b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-- 
2.43.0.429.g432eaa2c6b-goog


