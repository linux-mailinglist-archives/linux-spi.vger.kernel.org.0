Return-Path: <linux-spi+bounces-8327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2BAC7E6A
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 15:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914A97AD746
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E482225407;
	Thu, 29 May 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ8UW6Gm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C0219A70;
	Thu, 29 May 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524164; cv=none; b=FYNIgaZ2X/uRODy7utYrsPrSv1P5++C4jVVWUVkwacsCJxWSBSYvYbnzfR1v4D74jtSdueY40xTA1abvhoXYdxBpWyOJGq9IVC1LqVOUyq+XbT8JN13xFTSo1kXvfPE13LSstS3fBBN2uAq6pEA93EQJ0DcPTEFOxrDfpJCMYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524164; c=relaxed/simple;
	bh=LUwqTL2nHcJFWGh/hwzPs/4zDQKjT26Xo8CSAxrmGZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyRhyLpzWOSol3Q3+sfAzMRLUqtKhBugB17LNZngg1yHW8OpmQ1cMpStebFsvFSYb75dcDuAcgCrqXtq3Zf+RLtM8NFzoZg9SsufmpIoIA1En4d5xhfZ9xaEnE4RjChLdSH+1mEWstp97eh4RmB3HEXrww3no/kyl9mFGkz9F4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ8UW6Gm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso5543525e9.2;
        Thu, 29 May 2025 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748524161; x=1749128961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q15ugRcT60ISY4yQxu9w4TKINSzLVWuUljg7TUvTxg=;
        b=dZ8UW6Gm459rOHEPceUkLG3OhPcuyTwU7t/hbdQpnlCqCFA73LBGDMrSt7oU27MZOO
         tjyKQPC+V6QhfkEwvO0cWlzyDzwdQgRlC4xBPueUzFi/4oNWih74Eulx93EkEZLE5O5C
         O1WU27W4qc5trcKMNB/sho6kmuCW8QtEu2o+Rjanh7bDUenVp4QthdjgRoOPlKGjm8Hp
         WZpFVuE7afsAu5hL1KsAs67H9ZtSaqiBAsdIEcNZwWSVidE3+oQm9r6gIG+D5M/O5frb
         PRQzWSmNdkbeuJr5y6ypBi8rTX5zw78QkYhDSqbIVrLtZX+0z/SPyAFptGFc7JJAKjUl
         6aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748524161; x=1749128961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q15ugRcT60ISY4yQxu9w4TKINSzLVWuUljg7TUvTxg=;
        b=DvNXGozLZMbc9zGxkyQNxOHJJShQTT2qXIeGbZEtnVrq19sEQEKbbvF3JJE36izgpT
         aFS9G2STy33kTU5/GS3g/T8hc2Uoc6Ionn+P3wofXPP/0kIFSUFjFwpJnG156dY6YXsa
         13+zn4ItQhjswjS+8rZe6qR/DIJCsBKmzfIOIArzqaNu5nLXCRygrmjw4aEtlGTHYcQa
         A8/0QVIbVMDpbBlqBkCVdQ9kH+xCdNfBgu6D/ftjrKWmjbwwMiVJDFzmWAHJlDDVocbX
         yWfeD811IVc2Tx02XExzgvC0Q8QjYBRjir3a6j4iRij86gitKFwDenYXtHbqvv/n3R6D
         ycBw==
X-Forwarded-Encrypted: i=1; AJvYcCVDAJX/HOP0YGzr/7uWzgpbApBptyF9cEeFCq9w+ClzREtuizJzRnyxvA6BjzEUoY/FyHQ1wlbZGs+Y0l0=@vger.kernel.org, AJvYcCXFq0cuqh1wOp1gFdq7wtX25oA+Ad4uCzdwal0N2ncxuuK1qaKKN0m2a+ffOyihXR8WMvZiyv7oSLD8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UcbbDyPUjVOFQP88Gbjsu+YvwMv+WVXxAzfp2181eJc+ljSb
	ZBuySABpVk2AZcLDLW/KO1T3IhnKBFCC/Jz7yuokaC/5qxfYWIqLVBNL
X-Gm-Gg: ASbGncshKzbF2DE64mpUZzQDyDcB8y//IUF8GIB1DiZT8YvJo4VwIjrWEn7NiRgmaSQ
	l1bJX91Sh3GXwhMMYMQLEtthnGCCesdgK9iaUETZFsumHFNzkjlQmD0DDhWBs6Gq/ZbdRcsP18R
	2CngXlyAlDbqYTEowRVoF2wyV44CgnX65eeGIapit7W1NB0tQ23zv4uDw50vdqpplLcZBS9D+Im
	TrCCuYFB6l96bWus8hxVWMTjJcmbAGIBjufSPWGrEkl+qd37anUR7W3mnjU9hCHBAHvJdu5BYqI
	rprRMPVYjqvH2wJ+df9ctIB9Cg/u1WTDI8HwgUORBUnNf76yX/jbp+ZjEjO6zDfO7+MrX8hERnV
	KQt1Y7da5fUpHBvM+qNV52sVWnS7FJHVUKJLE8KdhRsFokH08wZnN
X-Google-Smtp-Source: AGHT+IEV0ofrf75U8cmfkYa6Gi0HCGmJ6y/vnnMZNaDi6kx+WJMELtWcta25ThIa15dQttLtnT9SxQ==
X-Received: by 2002:a05:600c:4e13:b0:450:d37d:3584 with SMTP id 5b1f17b1804b1-450d37d441emr18075455e9.13.1748524160619;
        Thu, 29 May 2025 06:09:20 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc67933sm19439755e9.32.2025.05.29.06.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:09:20 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: dgcbueu@gmail.com,
	florian.fainelli@broadcom.com,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH] spi: bcm63xx-spi: fix shared reset
Date: Thu, 29 May 2025 15:09:14 +0200
Message-Id: <20250529130915.2519590-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250529130915.2519590-1-noltari@gmail.com>
References: <20250529130915.2519590-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both SPI
and HSSPI controllers, so reset shouldn't be exclusive.

Fixes: 38807adeaf1e ("spi: bcm63xx-spi: add reset support")
Reported-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/spi/spi-bcm63xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index c8f64ec69344..b56210734caa 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -523,7 +523,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
-	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	reset = devm_reset_control_get_optional_shared(dev, NULL);
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
-- 
2.39.5


