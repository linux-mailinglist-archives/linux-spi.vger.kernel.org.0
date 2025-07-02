Return-Path: <linux-spi+bounces-9009-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2D6AF6197
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 20:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC5E7B02F7
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB72F5C5E;
	Wed,  2 Jul 2025 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JRtB1/SY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60C2F5C59
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481595; cv=none; b=DoIHZjs/YGpH1harVyu1G39BY5ls5V03kuFMzRTdoHLcQGqwUbv8Xri4gJCYgh1kIe07xdS1Jaa1CUYzzAWShtnWMLmvrHoP98lGREH0I5U5RWQ/oUDEUMDTSgxC54qhJjplQnpQRofzVO7zA6LEsdvJY/EUAMnpD/e0F0zCObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481595; c=relaxed/simple;
	bh=rinGzCLeOfqarD788sUVMkKSqTzDgpo4gBTdpk6MIfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFs+QMfQoIpu5lpfiCgLa1xJhwEcrXlanBGeS1WK8IW2fddeU84n+0Axo0N/JpF+ZO9pPu38z+DVUe3XfEhPa4A3t1k3vEUsOKmRowDS7bp7fzgFhWZMvyyhyNQP9+wJuBmZ10r2iLEL6t4gbgSdrxbe5PZb/e18W5MRb9KHBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JRtB1/SY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234b440afa7so73007755ad.0
        for <linux-spi@vger.kernel.org>; Wed, 02 Jul 2025 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481593; x=1752086393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD4QPHjT8G71M31CBThmdXAv4qoEcXYUM9xHzhJ3pQ0=;
        b=JRtB1/SYcPo8MTrJm9+PmWnAeU9vpMp/x8E3mYRWcDV5R+sME73FQJ5TBC4cCtRqhg
         qDcLMDUtSFGhMop+rWxwZXCC71uzODb0Nmxn7soE2Lgqq5GSpgH5gWlu+mQDS0cKSl9k
         yy3iBTSPV0d4mCU+JqhUxaxpEi3YAZSSwDNye27MEdjeo4W6pfTcjnObPJ0gbKLyreqs
         4C854uoNSrSebbfC9SfaS+7zawAQT4x1/uNRYBqRl71JxA3fhft71cyWzEYx1rTxxvCj
         EWPAbPgFc2YfbFpi+qbR9syslWZn+7+pjddzViUk0E3Ur53949DJlA9Us40B2WnF8E3R
         9huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481593; x=1752086393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wD4QPHjT8G71M31CBThmdXAv4qoEcXYUM9xHzhJ3pQ0=;
        b=M83x892z7eZkI5ZWXzJjclxgPP6+IUOgUAX3H7V3Uoaz6ZqxkXG55VHioZ/1AvDe8H
         4kxTmQPCnqgkp3ccAFT9yi5M2f3wSdiTHLXrk+gWYXGoIylmjWchtBqR2pY/jOtzeH/+
         xWZkanwpzcHSdOH6PSI7jys5UHUHkdxF9Cv9GPDgP7JDh/iLXtAJncauMFL8FMIXEwZe
         q/ycQAwCdGhgSFbnNgv5xxQsviGjtDLr/pphKiXh6n4OiwDSMqzKDU03lV1NQzakMcxg
         8Qm5iszjT4ReqUO+4tX7CmIsZ+96wvjvlQVRM631hhhmleZjAIaBCceKpCAZKTdcGAQz
         2gnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvCF7JIJ878wRm7PSS7gXCxRAc7hvqOWWkswuONSAOXXkxQY7o50AEgmfc/Ly1kOhxzAbtiPAuOCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZI8kjTEElC/Dchk2AoWYE377v2UqY+QhiS3DDYhSsravg6lzx
	/zz3GPFWsEd85MytRpBlV2mhRVSYNEjgTqnjOce09BTMWqrVdjG0uADOVyyROGn1vI4=
X-Gm-Gg: ASbGncs7yFInoo6r55MDBCpdkd/TmkT4MZKDOXlGj+M2VNNplO13jtEM0NAM7DxQJoE
	+PwCfg/X7n6xfR4DsBtNdhNCU42ljdO/t36Jcs+zGIOq1+SaAQtqe9dgIXvhOnxvBxV8Fa0RU+9
	Q1F9V6IIN62cvC43jaY8p8aJQD74tY9TKqCNHZ9tqa1SbcaOKvFbfMxOTbjr3lnKxqyN11NaPaz
	Adb0CCw+Rx3rrfaMEcwlNA6bI+CIC6U2KAwC67ePt9cj4E03VbBHOVeMMVyVEpHCro+MWY7aDxL
	WYQy37cTj67Qk4coBXukj/fddUpGgXYIdszrDGn12J4F21Y30/GqizYtBuWp+YdiNBJ6My1P+NF
	Mmz8wqb2Xh3gUpzU76QW+wHs=
X-Google-Smtp-Source: AGHT+IGAQ7JmlYBOBzbIQlby/TAkB16aHlqrj6A7a2pC4QxXfKmUKta4phGLGtsgT8ahWX5lEnwzqA==
X-Received: by 2002:a17:902:dace:b0:234:c549:da14 with SMTP id d9443c01a7336-23c6e592183mr58648255ad.29.1751481593085;
        Wed, 02 Jul 2025 11:39:53 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:52 -0700 (PDT)
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
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 06/10] spi: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:04 +0200
Message-ID: <20250702183856.1727275-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702183856.1727275-1-robert.marko@sartura.hr>
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel SPI, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f2d2295a5501..a7ca7cd9648f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -145,7 +145,7 @@ config SPI_ASPEED_SMC
 
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	depends on OF
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
-- 
2.50.0


