Return-Path: <linux-spi+bounces-10006-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0297DB562E6
	for <lists+linux-spi@lfdr.de>; Sat, 13 Sep 2025 22:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC07F3BE8AA
	for <lists+linux-spi@lfdr.de>; Sat, 13 Sep 2025 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4725C810;
	Sat, 13 Sep 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxCTGDvv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2B25B312
	for <linux-spi@vger.kernel.org>; Sat, 13 Sep 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757794628; cv=none; b=GoOXZ6/5DlTAPRzDduKEtyvhICRz5p3lj6cfOqUFnkvNTSHBSkmiQ7kurdhq+0sP8jZ7+741XGM4HEnHRcC7XtJgN4G1XHflyw9+bMQG4gGZ/IU4ZdsPZaY6CmXV4qY1Pp/IJUODimLzBFJoFMgnjQcwI2oJnh99OO9cckpXq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757794628; c=relaxed/simple;
	bh=FWdFpDZXgweIgfaXmSGMrKPTFYGwmCSWLoLB9qphSGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aN/19juLirRY5JajGkMbnX3DNjeSR06H6vpvMR1HSajbRtmHjry4/aAxXiQw6kSpSrAHJ8luDJg0EjMpaA/uQQfSOxH8tSXeB2ahc7S194pwY/brJNId0O32gZDcsJ4RR7WXgk5illxpVKXLvS+AVzS2cIxeS2QHfXUi/bdKHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxCTGDvv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e92ce28278so380481f8f.2
        for <linux-spi@vger.kernel.org>; Sat, 13 Sep 2025 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757794625; x=1758399425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Koaj6pqpf5k3Jy2jPYnNq/imDVBkH5e1i3AFBAwM1v8=;
        b=JxCTGDvvJh5+cf1FVW3oQWiN2LsJOEtPGYJ5EsBoFS2r7kDzqe5Xfzjyj+fsnHrEJ1
         QUp7lXoDzayhmApFMRgU4za9/k4UNTY81NG84jcqDiGtFw7yZkON3NL2D6NQqMW1OBxM
         0UeKACHIzhFSTpLY6u3wKcr28sCVOQp2RTbgsCKRqddVLs+z7MAoisBq8ZtECxNkHDpp
         vL0+oJsyqQsza0UOjGF7bDc6brdvJBhyV4PZWMGtgyLklyJ2rcN0TMBh2UVZ11BE3ZOQ
         tAncBCWZsLuJvfXj+ZwSI2DttHnGX13ZT49jvTE5BvX/3fE1vcD1U1feu+qoZp73gwa8
         dibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757794625; x=1758399425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Koaj6pqpf5k3Jy2jPYnNq/imDVBkH5e1i3AFBAwM1v8=;
        b=ZR9WQCmyeeXQuwZdA0GgiZmw0Pg0WYwrtPCULNLnX0Gpuwn1BkYN2gnQvWWa33Hxg6
         c3a/6mLmIKRuCePAT4cPUKCfLNopziqfwdSNdZWriL9NJMTupHU410vhEDSMoDG5uGJ6
         HKTSmX60BiU7HIuJ/RbbVbrRGQxSwefd4cmB+C5mAo/Qh3khXmpmvDhRpU7umzTGgcU7
         Lruis9fwKd7ujBR9xuIwpYFOa4Kf53i8PXwTD+2mhkSuyK12aP2faysCOuMq8DZNZx2E
         2zyuMFk/cWTiIMyfWLKX8GQgPdKN/TFBmg2F/yhZPEAB855aDHNk0EBbjOz8jj7xa7qz
         xn0A==
X-Forwarded-Encrypted: i=1; AJvYcCXu/kUrZ2ZBsB6pOq+sWAXnhn/8Cv7h+9lzD4EJo3hxowvHzx3L31CaO0eDckUTy8XUAgINNszgE5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcM5lFAXmvcSMYO/AtjV03qITTZDucn4MKKHWid4WUOxmFUEZL
	25jrFi1UMWw9d1fssfvKBMdS+GPoHW/JbLDMi4hIsrLouQJ/ziAJyxgd
X-Gm-Gg: ASbGncust8s40WNke7qTwtiOag/PnOUW/Vz3ox+KUzKt4CDBecnfT7wonY7YxDBgoqs
	tHxWAGH5wTAjNudnIcl4H1em9G+MDDAInXipCgUO0jPriUNjf3WS0fYb7Mcthk3sREL5jlUze3/
	WxPfqmYeap8Xm1kzJ2tpmE8v1dvu+vYPcxtoeQAZVLEQGiqrYHhCQ0e6Ru5JbP6x8uaJF7esVr3
	oaEGH/YbIyCs3zGOi+a/7Kte52sPjEp6hjtqbqn/EIsfn6PKVS9Y+2P4zAaD7a5ptPZOD6WslB9
	s3dbhSvMv8yXmnDjecHrsN1Xd03wURKTzfq50dpgFI8bzV2p2X05zyOlX5ITYQ1imD2TBEb7H61
	sMXVjcjup3yGdA9JCjmPhpQ==
X-Google-Smtp-Source: AGHT+IEXKa6xffHEzbijIqHJqGxOlxCQ+oBv/ZWdVFhhrgUOoImOvsVfpGK+TXJ+kkkvEkQl8EtTxA==
X-Received: by 2002:a05:6000:2408:b0:3b8:d360:336f with SMTP id ffacd0b85a97d-3e7658c1c6emr6975696f8f.28.1757794625150;
        Sat, 13 Sep 2025 13:17:05 -0700 (PDT)
Received: from localhost ([185.63.82.103])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e760786ceasm11628425f8f.16.2025.09.13.13.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:17:04 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: amlogic: Fix error checking on regmap_write call
Date: Sat, 13 Sep 2025 21:16:11 +0100
Message-ID: <20250913201612.1338217-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently a call to regmap_write is not being error checked because the
return checke is being performed on the variable ret and this variable
is not assigned the return value from the regmap_write call. Fix this
by adding in the missing assignment.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 4ca8e82fdc67..4338d00e56a6 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -420,7 +420,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 		goto out_map_data;
 
 	cmd = CMD_DATA_ADDRH(sfc->daddr);
-	regmap_write(sfc->regmap_base, SFC_CMD, cmd);
+	ret = regmap_write(sfc->regmap_base, SFC_CMD, cmd);
 	if (ret)
 		goto out_map_data;
 
-- 
2.51.0


