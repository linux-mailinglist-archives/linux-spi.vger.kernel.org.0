Return-Path: <linux-spi+bounces-9396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90202B2527E
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3998618930AB
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110EC2BE05B;
	Wed, 13 Aug 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="uCEjxzL9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0F2BE033
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107291; cv=none; b=JPphSKYtZOu4v8McOGhkjDDZ0a6RiMtR/gbvUMJOdXw4sRcpsrutMzGBvAWR/So5qwxhx5FVYLjqYPAWrnTom+xyB0TV2isIEu4NGrTJxYXB26GJjuXWJIJSWlEZELlfe3Vu7w4KAbWg5HyGhruWhnOuVTH9cOzA/KZPCVAJQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107291; c=relaxed/simple;
	bh=wVsDz7PLWcqLuNDyAizM/2yV2YynzKGFnsWWEvqGeqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdIU7N3AYW/b74dDqkoZm355l8xRVjoLoAi1RvF/dsjaiI5yzQqA+lDmRjObmWaz2DpGpSrLxbxXrDvY30sIlVC+NiqfEKYzZwN3kW102Po3Z4BR4ACoYRFHt7xdnMAAQaUH+D5xekZVP+UgGGUjyLrc5THD55LPX8kCgzlUm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=uCEjxzL9; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e8704c52b3so7643085a.1
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107288; x=1755712088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR9O5hej1zVdBrSrvTEY2n8cN8r/rUR8l5graqaiob8=;
        b=uCEjxzL9d6OxCyOhmQi3vdf6Zth+dnpTgzkFmF62rxI5lmbr9a7I3BT+Aqjv0s6LUV
         U9DBnlwEVGCAp/MeK/dxdFk1den0Y1v99dvqjj1SN+h1nI7sWIoVXEVfUNysmXYHEEiK
         fNLCmV5VNMAeiuRdQwa41npfs5rCwwEgsK5qqWlA30Kz4rvpyVWvqUgeNELha7yacjbq
         L2I/M3nup5RK+UmDwy5nsMUiczXNqhWxVz/yBQE2AySs8JD0jsnD1lMR24wMQDsdyedN
         pazjC5kLX5m1eILw5+jAU3+e+g6pW+2vy3F3PMPrZ+gaznpdDOQAyEdU3pLTcvYy4NcM
         5nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107288; x=1755712088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR9O5hej1zVdBrSrvTEY2n8cN8r/rUR8l5graqaiob8=;
        b=wSLdlkBS8RTy1OoPbLSjGMnpFVGdnfG+kijFQNtz7fYXK7iC+ZVY6IG6E2XNsx5Y64
         JKmmEf2EmikVZ9+P/858WxsPUX74J2zmRVzmh7q9ryH+hibW7hgdz/ACKwmq/IhRsF7j
         dlbXMhzZIHC9cX09cvsmb6CXkZfAVZM/ICko4DwtYy6S2bHh+b26RG/pafY8TSPwlswt
         ITFVxUcuPQadmfuyS56ANtgiwLaMfVf8Z3Vk97lZOIQ/K3gJ/e3yi1vq7N0xRBpNCVOz
         f6PbcU1ceRqZXX3hbaUhvxDcKKpFf9lqVAu/t1JAoBWU3wdUhdTAmk8IniMmsfZPkpGV
         2yoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLwg2oiqkvyAdqptuknzCJJq8fXxFE2s58RdyA009qI5DHX3UR7Eb5nKjxzyIA593BY/sFhD6/cCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYJiNSd3O3jfz25QpdVuuSKjjZj9CGgCl97qwoCLsSpieGPCL
	0lwyCwrbP6yH07s4mp0vIOzS8xST2e4Lzld7imeBAGik0bnTcYspED0IUNwFlerPCfM=
X-Gm-Gg: ASbGncvjC3Yo0vIkg0/CLAXrVEmDO1KBkzp8O/4HwJo2/EAKZIRhhgkJh9mfFA7cMbh
	YokOFXZ1jtBDKWHq94Q/ViftLl6MIx/UdWf1WJf6HDZ4ZPVOPqbXIpdNli/ps9ypVbdp+n63+sS
	bXvB3xyDVnCiaDFjsGI1hac3cObYm0zc+Mopb/b8ts1jHBFnSfPcUvMXkIWtBxDjkLxW0Q6jFs/
	BZy/quygQN1ShQjMGIEOBn2xGt1WyZhVFCOBZ2Fe2N+faaAhyDGQzjeiGSEMzV9M/yBVUJfe651
	Kp5HlHDO+GlZDwMQMDwhtuViJ85F/VbCLKBJFGRYHDv8DAdXU/FbRNkZ56dmEdHBgu+0inK860c
	JPG1qK9C9naixaEi4do7j1c1sBCljQO9fwu3IKFmYSg==
X-Google-Smtp-Source: AGHT+IFRs83sDqTRyEN7DfReHLOYn68Vpzc0LCiQZFoDgh8bJ2M9bgboNPmgbUyMB+oLX7FeYNZzXA==
X-Received: by 2002:a05:620a:1724:b0:7e7:12c1:8f93 with SMTP id af79cd13be357-7e870600b91mr33016285a.63.1755107288221;
        Wed, 13 Aug 2025 10:48:08 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:48:07 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 9/9] crypto: atmel-aes: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:45 +0200
Message-ID: <20250813174720.540015-10-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813174720.540015-1-robert.marko@sartura.hr>
References: <20250813174720.540015-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel crypto, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 04b4c43b6bae..7c1717c35b76 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -439,7 +439,7 @@ config CRYPTO_DEV_ATMEL_AUTHENC
 
 config CRYPTO_DEV_ATMEL_AES
 	tristate "Support for Atmel AES hw accelerator"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select CRYPTO_AES
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
-- 
2.50.1


