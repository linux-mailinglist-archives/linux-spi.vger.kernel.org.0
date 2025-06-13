Return-Path: <linux-spi+bounces-8501-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC659AD8AE2
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96627188B5E2
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217172E6D17;
	Fri, 13 Jun 2025 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="y6ceaVp2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A52E62D7
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814935; cv=none; b=SQ3XgTuJJheQLvpW7jROWVtyiyilqBro19RLINgNrbj9lQxbQU3tr7YZBQhzfSYQ9i7+flWKp5ZT0efbQRL3JutVehlOvIQpZTWDSPAuFmErtXOJEw6Dnusl1hafMv/kgAaJq9pOAzAFKxf4BgUKzykUrK9dNaNe/ix41tk5fzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814935; c=relaxed/simple;
	bh=Nl0M0mtMMwH3HQiDa6E6C3fv9pPm34SWpTCcbO9Pcds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3BDeCkWBEziVtHzt1eBIFBu7S9rDyLQqR9Ysnmv4Ho2Y8OSOk4FtwBNJImRNFCDqU+JvthzNuxgcgxzOgn3Ubl5DY1flfWiXQRvslUXVenCRxv+E5vROYvHmSgrmzuYzao2avKkBLm7ycWqk/p0jRRebAIMEBBvEY081ZCX5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=y6ceaVp2; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-736f9e352cbso1222405a34.2
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814932; x=1750419732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE5/rsY41g/vAp/0hcg6OhOgOrChXE3RFe9mIYZZ5WM=;
        b=y6ceaVp2CQcBou9Cp4Y5oNH0xtPtDgIeDv9QAP0Sn/WJFUywu4fOWBXjGxAIl2nvcg
         QktQReL8/JROek6VZ1O7cDxCPThbPChtqnvE3xoJ+eF4DM5rI4NYWczLBafDWsl2UVWp
         Ugr/oqG+VpiO6NA4GwSlMBAajYAN5g1O1/vSAGnfCMoBieaCfpCTDhWEBLJU9jsUJVpe
         /xQfBdY3ol5KNbnfB0kgis6qGHrtePEuePTjrVKg9uNXvzQ2aMcRzFaVYYF2fMBuvtyP
         /dZ2TCswCfssYbQ34tClHs4/tRVpE8R+7APjPZu/7RzqX9oAzPPx0my9Q9Unrv+Lp627
         AFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814932; x=1750419732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE5/rsY41g/vAp/0hcg6OhOgOrChXE3RFe9mIYZZ5WM=;
        b=CYBEQZksO0+/GvFfdR6KaWBrIVidHOMUXqWHUZpuTenRfix5UdQGvH3kB8+zR9Bb7M
         cR75GaEZquFiMeWkVTd3GUXaw5YHIMYfC/LciixTjDI7TkY6eU/S0u8qM9jjZM7aldRP
         PEze1La3hBO4J5e3e5fyvb6GxfPGpRR1Lc0drIuAcBXcfecMgoLDbXwv8/mxX84b+iA+
         fcGTJ+h4VyZoR0mPhE+XdVIPM4wU6oCXtAGGZ3YXfxAVBrHse7Fti6DUNCSldwN6avJG
         /hG7rEgtyF0ovlZkZiygjqzf/Q0HiTKctmQee68z0qsZ3de20rkuXCcuNnYOlyEapdv1
         V3VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTjB1+FtrjE3M76GSSZnxlb3Z9UWErxyAdAQz0yPO9KlfE4aSpRnepcgJiaDSgKXyjVNjSyFoYoL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBn4EW1GiNx4Jtg0KR+yWGdRC4J5a98nn2xf+7EaxhGt7aL27
	Fow2KXR4j6AJy9/fVWYXFN3Bu1WUCvUs0P7tM4IO7C7clxTZVEyU7NSJoLHz2ydMWtaRiXmvU/0
	VQEZR
X-Gm-Gg: ASbGnctB6d5Kvq2LmjtDCPH2veLEE+X3dn1N+UqMe+GSaYE7V0tBjRpDCKTXL3XJeAV
	gszsuUNQICXYggBUB3SHub4VwRbrobnUOxWjCF7rhrp8CajVlDUkhhNPdj4sZ4obg4IjOhA4F8V
	gUAll27CvpMqQGBek6bkWoGRcDFZo1fWpl5/JfSmnH1c4qzKTj2EJgIwkWpLqyRPlM0IkSd7lGP
	fSWl/EUzoRqYbWoqsSHfCdy7aGS8PP71UAR+6lBgOROlxtJlacaKb47vCVsKz8D3knCDEIf+aSo
	/M5372eu5lMLMILCSXiVEXTko8IRpaVVUjvOitqeqKHwi2f2JkHa+99dHem5a4b/MRtXMp7N7xq
	LvEiw2krJawjG/l4VoI3jow==
X-Google-Smtp-Source: AGHT+IF3wVYZI/s3wM1PNe5izmwye5C2dxIzh460VAl75DrcM6tXXLw5OFqnGApeHtjQqkaMBAsXNA==
X-Received: by 2002:ad4:5ce1:0:b0:6fa:eaf9:89f1 with SMTP id 6a1803df08f44-6fb3e685f23mr33483696d6.44.1749814921454;
        Fri, 13 Jun 2025 04:42:01 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:42:01 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	ore@pengutronix.de,
	luka.perkov@sartura.hr,
	arnd@arndb.de,
	daniel.machon@microchip.com
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v7 2/6] spi: atmel: make it selectable for ARCH_LAN969X
Date: Fri, 13 Jun 2025 13:39:37 +0200
Message-ID: <20250613114148.1943267-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613114148.1943267-1-robert.marko@sartura.hr>
References: <20250613114148.1943267-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel SPI, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 60eb65c927b1..3b0ee0f6cb6a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -145,7 +145,7 @@ config SPI_ASPEED_SMC
 
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
 	depends on OF
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
-- 
2.49.0


