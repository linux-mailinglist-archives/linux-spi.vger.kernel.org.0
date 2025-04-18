Return-Path: <linux-spi+bounces-7680-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F578A93C68
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 19:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AF23B4CD5
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68A21C9F6;
	Fri, 18 Apr 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvilNk5W"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9FD21C9F4
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998956; cv=none; b=niPFluGY7ZYEHhou5ZQmhLgWLnQ58rNv6A/KmcvbaJ/EKJQenmcLSISB155SlEGhFgR+dYvPHBu0/PKr67JQPmG2+5T25jXz6P6BPEuBfeUwQCgpsRo2QIiUgS+MOP80a+o5bD4njs/O/lyiC7DvySrlpyJuQjvrEStOJG9QUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998956; c=relaxed/simple;
	bh=Gq1pqWL+O+VsYTdnZ3LUiKzwc3HpppxPZf6HXFmVsPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWJhp3DgRXZj01nMnVRTU6SEyIVftfdZ8fBqOUB277LhOtuXCoac6BYpEzOu6cHG8HtywZklKtICxWSC9hMwjalKoUjT5zPvZJt8b0H+sCw21WJIvB4qCyT8oY+JAMyQ/16XgOXBrS0BBGb15qCyxh3V8+OHDNApJx8FmLmpSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvilNk5W; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7042ac0f4d6so19489357b3.1
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744998953; x=1745603753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oq/GZND+Ud8bf4jIl7OMhVvFTB4dwmJKhoq5oPdNqOs=;
        b=fvilNk5WwaE0E2KupgjbOdLiab/JPUn5SOczhHSUPnl2PLWiAsNah5KxYebyJheWPV
         PJW/3GOnc1QFv+HHqsPbulfPbCrHKAxLZwOcw7wXXn4e2gIzlz70osrNmCXQ6iSyzVYu
         GY6N0mKPFCws2PicrLaQN65EHY8ue1po2ZgkGgffke3lVzL6S7MZ3r5I0+RYGEImeW4K
         j2h4ljoBnKZPfjXwEcYkVffeS6zNIJAJU0dHoT1Ldcd58quBiV7UvynWsR4iwVN4g5lq
         CYDv9PaKT3NnXSR5C32slXOP++ZjP4DRQeBFp13rzE57MPGQkV5QxkqYN3LHxAwkHTY5
         VyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998953; x=1745603753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oq/GZND+Ud8bf4jIl7OMhVvFTB4dwmJKhoq5oPdNqOs=;
        b=nOt4og8SJFppWEQdPXVpXW8vnYJUAOCTY4X6q2fKSndHsLbZR68HCZiRWq0gyu1vSW
         867K0CHUZgQ4IEh4wZyt1q1so3Q9ocm3nD9laeEEjp8SvicmQ7KMZ3DGTO+rd/lUHeDV
         UjOa7fWTCEuLgvP9NNg/vBhyXsCaSm+HklWwvJtOFyz204T8mYabLc14vqqitSyKThG/
         s1B01KJm3cUvzZ9FTf3ejZkc4nPmZXSCNX+qXppoaoMPMwOqu5fyR9XPdDus1TyAS1+J
         s6xXO66QZ2525wabFtFdGzWjfTXg9VbRK/Vs2hLxi55dcVk5H2fPQSvV6SYwLt3pFNWc
         st4w==
X-Forwarded-Encrypted: i=1; AJvYcCWy/ew+vdiMH+vr3JNmb3SabHs2kfKqMf+mFrNObrhs5uxQE2CvioyY8KhqoW98H4WFujq9veAzE10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjMyfsGjRJOGyZILD8yZeDJ1CVnFKNMvSqhzXnK1kbBe2W0Hq
	nb7ZGcbCkbjLHvpH+Vf+EMW8czQJH98QusNYqcHxIEf2kgv3KYhB
X-Gm-Gg: ASbGncvSgcQ5Bosi7b127xZ1lJiYztEFgPXLkB1BxTW/xFyQLHQn6iRieGKFZMTL50T
	UgD+pmwbjKi5+cYy3hwuH/5LQ4rEOJqq4SeyRjgSfxp0dDMmaft1KcDWj/nl6CRRMHZIieV5QzF
	h31hqYlnRM6KuVlJmsQj4fGTN8HzuL+m6CH7fljKui+6/S7dV5qzq7OilnPyG4qpDABRuWnWBFB
	Yzy4tyrl8b4KkCgpGYyHZXwmAG8Ml586Qv/nJWNI8cCDRm2aOp7sN1OOiNwQ79px0di9CsudMBL
	djG5bsCCygHgD9ITR+Ubff+fadXWwTceFA1gqAD1pg==
X-Google-Smtp-Source: AGHT+IEPrREw+KF/PsqlbwzM5+4BAANpBK3TWGfyVa73c+b3jLAPS1IKoJmigRPsjUVA9PY7g6dC3Q==
X-Received: by 2002:a05:690c:9a10:b0:6fd:97a7:1474 with SMTP id 00721157ae682-706ccce4b2bmr55456647b3.11.1744998953493;
        Fri, 18 Apr 2025 10:55:53 -0700 (PDT)
Received: from velo.. ([152.203.179.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca4501a1sm6223567b3.2.2025.04.18.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:55:53 -0700 (PDT)
From: Andres Urian Florez <andres.emb.sys@gmail.com>
To: dlechner@baylibre.com,
	broonie@kernel.org
Cc: Andres Urian Florez <andres.emb.sys@gmail.com>,
	skhan@linuxfoundation.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: offload: check for match callback when a trigger is being registered
Date: Fri, 18 Apr 2025 12:55:29 -0500
Message-ID: <20250418175542.13820-1-andres.emb.sys@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make match a required callback when a new trigger is being registered,
this allows that other functions like spi_offload_trigger_get() could
safelly invoke the callback when it is required

Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
---
 drivers/spi/spi-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 6bad042fe437..6f4c5188e6ad 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -434,7 +434,7 @@ int devm_spi_offload_trigger_register(struct device *dev,
 {
 	struct spi_offload_trigger *trigger;
 
-	if (!info->fwnode || !info->ops)
+	if (!info->fwnode || !(info->ops && info->ops->match))
 		return -EINVAL;
 
 	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);
-- 
2.43.0


