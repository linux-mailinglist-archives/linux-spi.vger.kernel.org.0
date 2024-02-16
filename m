Return-Path: <linux-spi+bounces-1385-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3240F85765D
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 08:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09651F235D5
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D414AB4;
	Fri, 16 Feb 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raa9/M0A"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF314285
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067164; cv=none; b=cZdBoCFZungjaaUmbWeOnEXvkCJ7yJJ9QUHvtbEjqRgcUyvQGu+UZ2mkC1sqoto0T75TseFgEjrH9OZbj38CzGJ4z0t8LWNclHJ9l7tVAX00eVr4NLW12R7I70SfbiUu2GlUy3ANONHSKJ7b6jNn8bIy8/JNSja/GioEhrwlc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067164; c=relaxed/simple;
	bh=UumdA+u7mJW1hsa/1bKQOt92hrmkFZLp9HYQzcowhO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgKVybOoGBPF+gfEbN66E+U6IflQJIFoaF2QygRz9EhLP/+IO1OFjOVKAU7B5uetUwk0RCKVS2NDjrnzCL7uCYWYHNIyfbbcHHfri0xENS1bRnYfZ2T85uVyVr1PyL3U3jt2XrjLjE+ONeUF34GrwmO59PFHNTNcbb8Qsqn8bfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=raa9/M0A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d07ee22eeso269973f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 23:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067159; x=1708671959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFOh+ffUHbTzqoNg7f3NtavVRglY5kTfBM1QkaehxhQ=;
        b=raa9/M0ADHybg3Km+WVEYYYwBWYohUB0O3J1xjZLFhytcuPrIUNKFpHIyP8HcCfijk
         vv/zWvRRcWacWxBvMMdnWYCfPcHohzwZ6lDHBhaQtnblk+EguFOaAvjctmZrLmjQJ48T
         JCUP6r8nHoqGci6loztw/OeBrJ9h93uHNH9m5tvpbxgUVcMRYoaScOlue5a2w5M2ZCcZ
         L6tvKYisrc2F+cD+OK+1wPGbB8FcIwxU04cutzKQ8ZcgZEuY1ytjoQkriL/FE2pdke7j
         0Z/uDS7PqN6Xj7HnFT/o0D1XNSLZi6PSj08gGB55USt9LQe6jWUApmeGa89PwZzXhb+Z
         XyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067159; x=1708671959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFOh+ffUHbTzqoNg7f3NtavVRglY5kTfBM1QkaehxhQ=;
        b=ZTEiEU9AEfr+pvxmfDtmAPA8SCCuJOFEAAvj+aJnBsQvUnoip0KWkXBOUmsPvc3Aib
         nSaYnKEbzqj8mU04mHxHnpKjlrAALelqgr4Qf1eCMllkF2nE6sQdWsUccasXnpC0Mf0N
         xatnPsf5YuvSZ75flklqLlzjdIJXMm1Q7x2VVJgoo3xf3GPc49wSOXjKnPqmhspTcPXf
         uZdrtoIqn2DLWwgir9W+neNXrToU96hDerpg7VKktw2o/VLBa5jBeAVeZBPwZuxe1rIH
         rDZYsMtl2nuDbvqKXgicTx4xPahlAwvk0keLiopwmrTnk1J4VaE94LJdZ3nYr64lQ0/5
         k/vA==
X-Forwarded-Encrypted: i=1; AJvYcCUuQe+5re5+L7ydPBaSEtokeeyVBBSMp1fjpdl7BR5Oh25nhYaw2ZPbNhAfRrfUx98kGHWn7FKY8Fsv9XOhTh7qV7EhmwcQ7rrN
X-Gm-Message-State: AOJu0YxE8JZg5q5Psw6MaukTdxqVtpWEXBTTPWBWpWCEpYe2PWdGqbN0
	nnjVI5xPbNcyg3lB9LRxpn5lpAHeuxBL8T2qASzN+jvSNrv8EJOvWU2YtDuQSO0=
X-Google-Smtp-Source: AGHT+IGy0mnVYtYozVNTM9NIVBhX9/4wYTRqXkWmb8HX1VziUVkIvro8ChPAqsm7xYi9J/dZTIyEkw==
X-Received: by 2002:a5d:4486:0:b0:33d:d32:2a5b with SMTP id j6-20020a5d4486000000b0033d0d322a5bmr2407932wrq.3.1708067159298;
        Thu, 15 Feb 2024 23:05:59 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:05:58 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 00/12] spi: s3c64xx: remove OF alias ID dependency
Date: Fri, 16 Feb 2024 07:05:43 +0000
Message-ID: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver was wrong as it assumed that the alias values in devicetree
have a particular meaning in identifying instances. This immediately
breaks when there is a dtb file that does not use the same alias values,
e.g. because it only needs some of the SPI ports.

Tested gs101 SPI with spi-loopback-test, all went fine. I updated
exynos850 as it uses the same USI.SPI_VERSION as gs101. Maybe Sam can
test exynos850, if not, we can drop that patch (12/12).

v3:
- fix indentation in dt-bindings
- collect Rob's R-b

v2:
- update bindings to consider the asymmetric case where the RX FIFO
  depth can differ from the TX FIFO depth
- update commit message in patch 11/12 to describe the GS101 change
  (I was wrongly mentioning exynos 850). 

Tudor Ambarus (12):
  spi: dt-bindings: introduce FIFO depth properties
  spi: s3c64xx: define a magic value
  spi: s3c64xx: allow full FIFO masks
  spi: s3c64xx: determine the fifo depth only once
  spi: s3c64xx: retrieve the FIFO depth from the device tree
  spi: s3c64xx: allow FIFO depth to be determined from the compatible
  spi: s3c64xx: let the SPI core determine the bus number
  spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
  spi: s3c64xx: get rid of the OF alias ID dependency
  spi: s3c64xx: deprecate fifo_lvl_mask, rx_lvl_offset and port_id
  spi: s3c64xx: switch gs101 to new port config data
  spi: s3c64xx: switch exynos850 to new port config data

 .../bindings/spi/spi-controller.yaml          |  27 ++++
 drivers/spi/spi-s3c64xx.c                     | 142 ++++++++++++++----
 2 files changed, 138 insertions(+), 31 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


