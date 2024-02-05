Return-Path: <linux-spi+bounces-1032-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E3849AB7
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BDE1F2378B
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737F122EF9;
	Mon,  5 Feb 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NK2B4voH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1461CAA4
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137125; cv=none; b=P91GcHVro9S0wu7/sllMuc2lJ2zsCCb8slTALL/wp4glywC5fC/x+rrZhqI7sAfWQvK588mG/lhWhY6cr9kB4ojdkAxxYtiMNbq2rkmefvqtbY0vz4Ru1Jpt7B5WjVB6TSqHI3pmxJ6g8Mv298z0SQSyVM0qA3JysJeH0fxn+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137125; c=relaxed/simple;
	bh=7nZy1kjX8oYl6BiD9WLVkh0bXeWbHcZfI/Pdmt/baMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6lSS1TDWeSkypQNisrjy3ZCB29o7KaK+3XFm2qODW6PZ9zkLZXeDvjeJcbRCAyZwuxDMym+WQd/TgohfjA4LQM9UR8pBIqP3jZhq6frdqDcfZJVCiZv0224YLUtdF5vjDYq0N45R+gecMiqV1S1aFnOuG0PRWpYtqLoiD729XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NK2B4voH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b29b5eab5so1313163f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137121; x=1707741921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2PV+2xLiiEx0u7i0xiK8BO9Wv2wYApgzlDJ63/0dKw=;
        b=NK2B4voHJCQkkijaZydQ3dpPnAFlkz5rgTTBwrVcDBTF7oQHq7puYrMZg7f1eNERX7
         C5IQ58TcvEQWAeP/tbEobKcyOfcX2wbvguR5ZVAbpHgKzftztwSfsW7XGZNFl0a/547K
         YIZoBRW2Xspm0vJ9B5YA0ul/pETSbEIS/zrC+nof9foT6YSuSXMey+7DK4DUIfVIsAOJ
         0Og75bbd44YjNpMTKBNf6vAnZNERcNZHthmQCyv33zpP8sGAApQ6OR3cvy8tfI9LF8DP
         VmeB0Glgq5zQr926ilGaEtifCqP2iV00ZUyhn36jUHx8eAP6yqXg6JfCzDJdsb0NlaDQ
         ZRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137121; x=1707741921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2PV+2xLiiEx0u7i0xiK8BO9Wv2wYApgzlDJ63/0dKw=;
        b=Hj929OGx2wjhG0Cvu4xZGVx5GhBa70xoiw7CE1IOHCsXbKbV6G5iJo6LWYGikcznGN
         cMrWxD13lXVWPUWpCG5YKnOdbxhhk+l9N6sLT8FjjfgkLGhFKcozYARg3F5HillQwYFl
         QyJtGccHpQ4I6Bv0dG5xVyQXNtUNKzxnUedud24eya7YwO/AcATuUdwVMtFR6FdAGOyz
         rMep/J3Hsjz/Qa8rXAYxvqMRH/R4u1eVvAKF15WdEKoEstNk7UAH7p8NpSlbzN5Obn0W
         Nl7kwAn1VM+QUjWx2oB3mwZWDEXViXvalB78b6RG7hLiAXBdHeAbalrma8LvxLVkGDGD
         dR0Q==
X-Gm-Message-State: AOJu0Yx3w+pea4QB+R5t4Uzl4Ia+/Jns/THSHIeUECbAbLiTlcLUMur0
	5Lt2sJ2v+/XRxVCnRpneILLgQmcu8XgD5ZgW7GqnyOqLZ2+R5b6d8QZ4+PAJi48=
X-Google-Smtp-Source: AGHT+IEuMR0ZRLWGw37NoH1Zqp3+O7Jprt6LM3gpDZR40q6RTfgnXr50yLqhP6tQPXGpkUFkUupYSg==
X-Received: by 2002:a05:6000:118e:b0:33a:df1f:c18d with SMTP id g14-20020a056000118e00b0033adf1fc18dmr8072680wrx.50.1707137121436;
        Mon, 05 Feb 2024 04:45:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGMfma0EN1z5FoQBginlFOPQ514vwJSuFrlUAxZpiJfgYEsovYbba6ktClwtxo6O8Ti9yHyvJrVMfsJzaqzlZ493BEMH8JCmzu96BVZAAEDexcHp4v3CTlBAQiz4HAPhrwfH8TNmt2RQRAIv+Mg4dmtZr6oDHNmrA79YVU/as54moz0bxiwlwaZ/zhga53Q/IcWvZkeSfsMsvcVhKBkrvJNNSzASvTE5rWWbjI4nEUpbKS5ySwnc8l+NGYSG5f5FHWMs+6/rt+sPPfP73Yuieaiv2z06VfdogYi33P1Y5AGos7EE7/CmZ1T+xkkXA2K1AzGCXXLG1IFH1qfN79h8eMs672K55Pcb5i6+JmJ6aR/Ww+JRIcnSgrRWVVwGua4NUxpUUpvo0Z4nAwEqR1gVkvTjTSqLqI8ZxzOskDbc0pVEXDlY8TCJMPmJfmTCyE8S7FJ3WzPg7uMO5HjZ3okLEpjvxuK76r7aQCMCatSIJCkzuYVH8eHtUZltL66g==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:20 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 05/16] spi: s3c64xx: sort headers alphabetically
Date: Mon,  5 Feb 2024 12:45:02 +0000
Message-ID: <20240205124513.447875-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorting headers alphabetically helps locating duplicates,
and makes it easier to figure out where to insert new headers.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3df4906bba34..ccb700312d64 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -4,20 +4,19 @@
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
 #include <linux/bits.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/spi-s3c64xx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-#include <linux/of.h>
-
-#include <linux/platform_data/spi-s3c64xx.h>
 
 #define MAX_SPI_PORTS		12
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-- 
2.43.0.594.gd9cf4e227d-goog


