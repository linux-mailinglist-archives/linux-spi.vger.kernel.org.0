Return-Path: <linux-spi+bounces-8500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D93DAD8ADD
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817DE189F053
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED422D5C88;
	Fri, 13 Jun 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="plC9ULUn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEB2E6102
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814932; cv=none; b=HGOOzGBBnNz+A9irq7+ga2oLE7/cnghjFOfLFjZ8lq/1uB78hXfLkVwk9ZSzwF+DH7ojFoubG8WQI8B5BCfX0oa5U4eaTqN78Ad7nDpc8EbDXjWLv6CABqytPOSDH7xMz8gzLnrf3Wq6ztmNaRKDePBEyKTJcrmyRLJ5V7VXcqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814932; c=relaxed/simple;
	bh=UjOVwgtEo33Ysf1DyH6d5ldmTFzYDqKUhAyLQVB9wK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm48G+EjvZ84ZVVcLFWBeuQhofjM3dAnM6mbaHrowjcJO/x1V+IiSHJZKhZewfzOrmh2Bco7l0LXFI461WSmQL5wb+W64qKZHclV87s7MVOleV7nrMbskSczkGgyWl7QoFelIKanu3YdmA2QcelhExRBJhM7/UNaNtYHQSRyN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=plC9ULUn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a5ae2fdf4eso34098401cf.0
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814928; x=1750419728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WlKCQdBK9LWxBVakFnX+t2/73xtUBtXu9i2PrxiazI=;
        b=plC9ULUnylGNLltJ/YPUOz5o61tneqDQCbYUViWc8yRcJPbUutA6Wh91Nks0pGLaRf
         U4qg6GhJ7CdVGxJ61wwfrMgPl+Uim6usuvApWZXRXE7eIDHJfsnoRUIStFDxnv3bLLyH
         XE8XCoNTQ8G3ivf1V+3FwUh0Ru9V4giBSI2c/69kHiqgVwM2hNzL+8lEkRWWVEmZYKHr
         BuJDBHycreZiGgXiTAQMuO9ZOAWIofniBOkiLCZPn6c0C8USAc75ectbFb0iyNEREENB
         IZVZxKnNkiYbvyxMRcBnD0Igmgmkr4mjbCZia+NHjd381jTdr8OgVywYSAEvF7iD5hGD
         MZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814928; x=1750419728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WlKCQdBK9LWxBVakFnX+t2/73xtUBtXu9i2PrxiazI=;
        b=XlkfwLrjEcPAcMN9lOMouzL/pWPUKcFp6s/jR9Bc9anl/oRGN+JYDAheyx6TCImhHD
         DI/6SuucI1r7xnkJXwPRBvKYA/pKbW0gW1QfLjrzgjOCB0JOOhkSbRVIy0KO+ohzsY51
         HMAAPJPDTDCirHeuZsa5Jeici+gs1pnMp51s8YmKjxybNCpgYufrOSdqPQTekwkjwrUs
         PY+5NU9XkbC21CSny9NGiE7YEm2n8JBp/pl7IV3Ks16QWwXq8swx68qWl8G7X5oUJZsU
         FKd1lQLl60LETJypDeTWdwY7yiBG1Ejt0AsvNZwr9hd8L72aoYt7sDeAg6yVJ1yyZIaB
         QQCg==
X-Forwarded-Encrypted: i=1; AJvYcCWOpXtQ9M4Y1hj4gOxwPXjG9Gyhzltk97lgPeB914J4x6oBvmORU9G1B38zOcCQLfq4yN77qPDsY5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3y72nfkJmPK9mtXI/j+UccwcYPbJwsMgXXAABUlExnNYXFNvv
	ogVief/lOREKeYaCC7UzdlWmnSDFxeyuCfnGJ0SVysFiTnJ3wXg4A1Kv1wTdIHDz/2M=
X-Gm-Gg: ASbGncvvhD+OdwpOfWTpk/XA1PoZ03GklaCQdtz8lHLsHTy2Lod0TiSvhuSjcotaZ4h
	NlxzcK3f3eT6GI6k7wirYuLmsUaCuswemXZZtNzCZkIeSdeTcmiQ6PW2yh4vvnwJUFCSz2zEB+x
	KgdfbURubRLnnhCnuICulB5dI9+TWK2dD50DZ2YSqaI6nY9vJnSGHt4L4R+OOJlnayyOwz4mgkM
	Jkwd2YHKA7L/zRMN9oKs78J5CmzGrhlEGJJ2Nh3JF05QJAfN5xWFM308Jsy2WM1zpOEZ6SCMSoG
	m+EYdCFLq728Zjdz+lwp5jz99LeDZ9B5VsZQl+Adklx9JbtIYsXUDhrptFxufMANcl1TtaLPgU9
	gD3BbpmpEkawy7CsP7EX41A==
X-Google-Smtp-Source: AGHT+IGoxDxx9zyPnLwBJu/HgiS6b9JD+b3qfzp8/xdsORghv63P60xiRPkYDDUy+K9jds0kDneIzQ==
X-Received: by 2002:ac8:7dc2:0:b0:4a4:310b:7f0a with SMTP id d75a77b69052e-4a739328f1bmr4762501cf.10.1749814928381;
        Fri, 13 Jun 2025 04:42:08 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:42:08 -0700 (PDT)
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
Subject: [PATCH v7 4/6] dma: xdmac: make it selectable for ARCH_LAN969X
Date: Fri, 13 Jun 2025 13:39:39 +0200
Message-ID: <20250613114148.1943267-5-robert.marko@sartura.hr>
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

LAN969x uses the Atmel XDMAC, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index db87dd2a07f7..0c3f14ab569f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -111,7 +111,7 @@ config AT_HDMAC
 
 config AT_XDMAC
 	tristate "Atmel XDMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || ARCH_LAN969X
 	select DMA_ENGINE
 	help
 	  Support the Atmel XDMA controller.
-- 
2.49.0


