Return-Path: <linux-spi+bounces-1030-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F0849AB2
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06801F233EC
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C721BDD3;
	Mon,  5 Feb 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytmQxFes"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D41BC56
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137124; cv=none; b=MSopVnNaaBIJ+YoAUVNg5HJPEBA9F4wEZpvNoZsBDukVc67tE7ILco9BGrpgjc27TwtxxwkEMJCWyQOivrlHInec/KeOIUuezC11jdzTcE5p3D1DKJ1nuoBVa15Tk3eq0ecVFIo6y9oF+/UYH/3/d3b0DJ8VWdw4hQesL18GCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137124; c=relaxed/simple;
	bh=F124QJAevKWdFhGb5sj8HrO8muyAjVQUMric9Xoo0PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpsO5JUk1GGwE34UBymt86e1kAyjkV/Hs3+ChQ+I9sLBN2N1jO+446PuIu5Lvyv3it/NbwZFyCE64ptn395yHu76wjTuuCv91Ylb7DmY7RJKuIMWqn+qsc+IFWS9MHF+TCmvMAqO41CnNd0Je9hKU6TJGPiI95WozdY479noHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ytmQxFes; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so39930215e9.3
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137120; x=1707741920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOBjoaorUabw6V0kVhecCBVM+DqJR5V0WfMbUMGzKiM=;
        b=ytmQxFes1ArYQxU0/WAEZsWB7bHZI+JEABZFpFeehELiXjFZ7O+380widLKzXGvCN1
         wETkdeQnP++UbhJHoVYpz1ukzxR5f0BLpdGQZ1OaYolbrirexBCGp50q5up+HjOCLljT
         jLITSDjcWHXAa6SwKz6zeB23p8Io24BbY+69aDdJVW09pp2f360Kl9RwMANXd8wVVg0J
         O0SMmvvrAsNRZlR5bIWmYZRM1U3sKnyfqyMGGKnUI1vMHy+T++CBuLfSdL4O4u6mFSo/
         Pd0XGxJ9B3BQ7SWi7Grw5LRKJYUD5JDIBHh+j4MQRN3kaCbWqDIxCooaM3EgL0hkriqB
         8DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137120; x=1707741920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOBjoaorUabw6V0kVhecCBVM+DqJR5V0WfMbUMGzKiM=;
        b=Ouc84AtBH2v6UlRbGolwCntQNpyVh8gpSqw8Ooqp9+4r48/NO1uwo5iPhiptvkKRcD
         SPZ7jw/XU2t0Fgm0blNpGaqzgIjZPhGw71RV+3inKbtyHhPhX65YqE0pZZKktCdf7xeg
         C079AKtYMHxacVsEAtiQta2DNkfNCbOETyadh5EbW7mFOW5a+YgB0rAZltEwmADNy7bo
         qFWnhGNdZHgNq3nH87aeh1eNrZFsCOCLgxidiBU5ZL7+IQJIKJ4sZhCdsSn9nxAxagt3
         1svIN6vtRuktBlQIyLb0hn+itwEuCR5CMc+mYinVUy6ZR0Vw997NwmjJbPXAgIPCgPTC
         cK3A==
X-Gm-Message-State: AOJu0YzqOsPVdj/jDwTN8goR60bd+dVfzBh58TjwJxx+ZaBRmY4FIs2U
	gDW7cvaKEdsnDHJYQa26BB+9yeBbiVLrsVqT7ijJjDbDh+bggLImOhFJ8rVC1Hk=
X-Google-Smtp-Source: AGHT+IE/R//MpNPylh0UwnhF9YKZR3KGGY4fGA5i2/YHcwiL3Cuz8pM968aVwJ0sUeRb5fLUjg+zTw==
X-Received: by 2002:a5d:64c8:0:b0:33b:3b96:87b4 with SMTP id f8-20020a5d64c8000000b0033b3b9687b4mr2800257wri.14.1707137120374;
        Mon, 05 Feb 2024 04:45:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVMfIKOUFnj98diFmwBJtthJx6XEcrlECRzI+G2PUYmp9a0qQk6FHpzoZ9Ia24ALKuUN657wE98H7tOGJZHXUA8msOETP4O6LwvEYPkhKFL0nxyBUrL5e2O8PpjE8+a4M9P11ukmFcNBgXZEa5aWKSANDzieilHAieWiKlkvLrl13nCFPWQDtoDpKen60XHXzT8GvyRKD0vD//k+Qg1LxdRN+OAWLXIj1JfNpuN7SLfryV6uFyeKnFgV3lAGAtE909omOuHJ5ZKKnCxJ33RwVeCOHVP1+ZoaQqjUzQ/CMVw80T4NvSdqgiC2OQow6M6qnGiei69Mp7y7alVSVZkJ1ldjTF35HcXRcoCWooaacUQTyzUzMuFslAV2REvXdO+IicsZi5ls10DblwKzyoM1PGP0iWzrmPzgE0Bol6vhVkkb80eWfLhYsJwxLAt+xlvddzVmWCt7BqPk4BIU9IpSbhTdg1EU/O/4BVSuH2MpZeYc7sOZdT093oW1fodyg==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:19 -0800 (PST)
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
Subject: [PATCH v4 04/16] spi: s3c64xx: fix typo, s/configuartion/configuration
Date: Mon,  5 Feb 2024 12:45:01 +0000
Message-ID: <20240205124513.447875-5-tudor.ambarus@linaro.org>
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

Fix typo, s/configuartion/configuration.

Fixes: 6b8d1e4739f4 ("spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'")
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c3176a510643..3df4906bba34 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -180,7 +180,7 @@ struct s3c64xx_spi_port_config {
  * @cur_speed: Current clock speed
  * @rx_dma: Local receive DMA data (e.g. chan and direction)
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
- * @port_conf: Local SPI port configuartion data
+ * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
  */
 struct s3c64xx_spi_driver_data {
-- 
2.43.0.594.gd9cf4e227d-goog


