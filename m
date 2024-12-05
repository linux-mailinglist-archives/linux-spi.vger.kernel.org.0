Return-Path: <linux-spi+bounces-5919-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E39E4DEC
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 08:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C988D28225E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A3119D8B2;
	Thu,  5 Dec 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="SrjA26UE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3019340F
	for <linux-spi@vger.kernel.org>; Thu,  5 Dec 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382299; cv=none; b=qkPHnl2dz+eQ3enrEkb6652ehL/I5hEftuv9RjaHL9xss3FZgimtQlrVGBX2HQvsyOyPO3WAzzbW38Lz0uQKA0GHXDMuZldLGzbKkO15EW/lKfk8OXdnG3kQnvSuTq2KQgP5CujC463kULy6jfSbO8DtJytf4dZfkkFUYeO8hU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382299; c=relaxed/simple;
	bh=m/f97ERBBpFa/UpLrOvmJtyOnLOGKKbi6oDbmxStgPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYE8/0expMetXw/YrF4BI3HNJQ/gazc0vYWJKguxs4gTx3szn93d7Fs42sSKKLTk9+CxNplazNwVqyOctJKgYPv3HtjHB7Ws6FiBbcr+k5Hv6BlQIFOelGqZDEQmWRw1qgMgU3ejkE1S12loVQbyhV2DdVFBglxT4eUIbUg1Ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=SrjA26UE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215a7e487bfso4516435ad.2
        for <linux-spi@vger.kernel.org>; Wed, 04 Dec 2024 23:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1733382296; x=1733987096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7j/UgtFrcoMY8m73es7ngDsr08IcsBqItBi0rKEaWA=;
        b=SrjA26UEEzN7JGlWw5gmzRji3XMcGWY334DY3YgW39po/YevXPFBXDJtoJAT/aJmXd
         wycS1COlCD7nGA0zBBMw6yEWlOAiHSGnlyVkfTGIVFsqjYhlsc1avPE7CblAyV6UEbIw
         AjlW2TR5V+7V8/fC4F+EHip9DNjMxHS09I2Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382296; x=1733987096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7j/UgtFrcoMY8m73es7ngDsr08IcsBqItBi0rKEaWA=;
        b=Q8BMkz51sN2YvuL6+/8K/jKZHl+6oRcbGDoKM8mBHaxugA5fHAb1ViF51MukU0Ul0o
         m/Ak2QvkHd0pYa2iNxlt8/KB1qKYLeewzvpcF0/ZsT9LLCU7GDB8GERF//D8CGx2U/cR
         yWWBc9JEXCenzirGKa+HiyJQ0iCD23HRj2h95Vp5MiT6W3LTpbuJRXiHm35Y5bFB8ZzN
         nPtvnQWuTIwCu8j9C8zqP/X0RT5Wb9FkTON5CMmyXC8j5G3/Vc24zIHSfL4JdSmMQ9oL
         a8i0snNDzZK2s1xWUQOFGecDeAFiBMKz5oL5bD9fSevZRJGxcScJCbi07opyFo+YjpSe
         UzWA==
X-Gm-Message-State: AOJu0YwvDVU2ZIvHpoRUrk1TVND/eLCQpelmIwrCUdAssi6CNihOHR4u
	MQsAULIInvGONgpM9kEbI7yZdgjUHYU90WZJOVdxbmFqNVzJ2kcfK9qVtrNhHaM=
X-Gm-Gg: ASbGncsg5tuhjJsN1ZQlsxCQGriUIw4dacxJGP0bNDZ/3u0Qfc5DdPdPj64zzvyatvG
	2b21MEk0qUn+dlu9EM/cqvZpd3ixXUupZRFDwW3xpsflW0rm1D3mh8xKpEhmsFQ3XP+FRWla8JQ
	lBXvrR4aSpAs06+7p7yt6Jm0EyKj7al1l2+h/98VFs1+tp8DISp2gNz/Keno9BHDooIfHg0kmzi
	oQapdfTjiplXuqdhLWnYHOnVOmHa6NVLc0MIed17jE3NZCd31RKoAOXlH8ZMA==
X-Google-Smtp-Source: AGHT+IHKQ2i58trsh6LYFt/mJ/5n7Fwldry0srZBO/tlpGmiCU2xAa7w9UmZh3pU7B5cm7H3BIQ8pA==
X-Received: by 2002:a17:903:41c8:b0:215:f0c6:4dc2 with SMTP id d9443c01a7336-215f0c650cemr42892755ad.34.1733382296304;
        Wed, 04 Dec 2024 23:04:56 -0800 (PST)
Received: from MVIN00023.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f27189sm6099975ad.237.2024.12.04.23.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:04:55 -0800 (PST)
From: psiddaiah@mvista.com
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cminyard@mvista.com,
	Purushothama Siddaiah <psiddaiah@mvista.com>
Subject: [PATCH] spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()
Date: Thu,  5 Dec 2024 12:34:26 +0530
Message-ID: <20241205070426.1861048-1-psiddaiah@mvista.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Purushothama Siddaiah <psiddaiah@mvista.com>

The devm_clk_get_optional_enabled() function returns error
pointers(PTR_ERR()). So use IS_ERR() to check it.

Verified on K3-J7200 EVM board, without clock node mentioned
in the device tree.

Signed-off-by: Purushothama Siddaiah <psiddaiah@mvista.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/spi/spi-omap2-mcspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e2400a067a95..add6247d3481 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1561,10 +1561,10 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	if (mcspi->ref_clk)
-		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
-	else
+	if (IS_ERR(mcspi->ref_clk))
 		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
+	else
+		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
 	ctlr->max_speed_hz = mcspi->ref_clk_hz;
 	ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;
 
-- 
2.47.1


