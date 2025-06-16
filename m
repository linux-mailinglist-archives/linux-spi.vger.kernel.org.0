Return-Path: <linux-spi+bounces-8560-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB542ADABA7
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7993AAFA1
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32FD271A6D;
	Mon, 16 Jun 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNzcIyXZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B826D4E9
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065606; cv=none; b=nPh+6vC721K19hz9qtspq5mefQ8OpD+BS6xnM9A4+gE3StbwdZBizgzzojGlgGab6fu2212JbWAfOQiC44I/GCeiJY2nsdZivSA7JzPCIJV5eEyWzGSY0qXxCqMmW596Mm8w/H081KsmfYEwalQjahV8fpVzrkKemB6MON6BuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065606; c=relaxed/simple;
	bh=SNag/bOAXJOjhxBCZjBV9Gk10G61ThtijECgTvWYBlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=oGnbZsrYD8ADMsUk+jpOTHcw0jZ6J7xOdkwblcUB8iFMOqCjepKcXrZK1avTcnQi2lLBbrrPdhOgtH1Mj9ptyYrIgp+wNk8sO5vANSraph9tH0NeM3N2LVE9NlcBKGiYbh7f8I77gBR719PKm/5Q7/VFpq387S2qR5pTlnGLHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNzcIyXZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750065604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2aN38x2eQAv5g2zQkakGSr4DbNCLimCT3gIZvjNzrH4=;
	b=HNzcIyXZDtIzQ4CAdY6Yw3HkAUBq0SkKkRlInk0ljUWPsz+JhBr0KB1VmLkk/GzjSxUvoF
	xscXKsMJUsDcYgHNS09uINTUL747smPXre/O2fVY+RXmSqWy0MD++U7XTbbnfw9SW4nAW9
	M7O3Vp9HibsMEjMWhc8TbI0dopdP5OU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-CnAEtDiwOJ6pJf7p0LzsRA-1; Mon, 16 Jun 2025 05:20:03 -0400
X-MC-Unique: CnAEtDiwOJ6pJf7p0LzsRA-1
X-Mimecast-MFC-AGG-ID: CnAEtDiwOJ6pJf7p0LzsRA_1750065602
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-adb32dbf60bso468702366b.1
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 02:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750065602; x=1750670402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aN38x2eQAv5g2zQkakGSr4DbNCLimCT3gIZvjNzrH4=;
        b=BQSffGJJuosnAs2rz6EGpXb5gihcF1CAXf/jr2GTeeeioEeBBpVlZOWgWCFKrelYwH
         HEXyGRIuUsMuXeZ0Qa09zVbPW8rJfXTNW4xNcGK1uXdokueJx+kTpd/JWKHLk7g5SR6u
         RxB8irNNA1uboqcis8dtCTPm184DEeATpRGeK7cYTsbiLm02kMyPovuBwKMQHj3ejBX4
         WmJoVZAs49HRvHuLvaKHOOKhW9gqKHIBGDE0AjDnzkx3jUvOfGK3Oo003Ehdw9InLtVf
         ZcjxF37I2YWybNiO1NbYtPfbahwjioh7mlE7i8P9DFbwnINxRSA966d8DAFRnsd3N+1D
         ocag==
X-Forwarded-Encrypted: i=1; AJvYcCX4JIkH8kIMn3n0hCmbuZ1OVqruzvO4KULEcnhe7ozDEULSg1CYdm3y0qfvkK4/3sPrzaoE86hmSgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmZZzeb14iK1yqeb8rrU9yDKH8vdyVtEix4CCTn46AzvFEx5t
	F0mYet9GQrMOPfEbaRuLANql+U4A4OdboC/9H5fC5j9gjzQ2G9uILtFwvYEqTrJKU+p4hkwYFUW
	lRpYDfCxJHdfNsN7kJMRHJOSrJzeg9BzZUaDmJHnICOUGvNwQrcIquXqfmGJuDg==
X-Gm-Gg: ASbGncszfssgAi+gl1qEDveym24bgXswcER6M9kldNnQ500BQlw8SGomJjh9xHuBWE7
	s10tMCC87LL32f3EeIhstQply35LgA44PYSrKsh0MDFQXrGbFrJkGnpFA0tO097MHv8BoaDpGCX
	eiKWwnkoFYnAX9qHvEpeOoLr1BnEEZpyIaO2+TgLAA9+2B5f4/ZK1o2zH7FO5+VA2kPr2rY6SJL
	PcUGnX0OpASiAVGYi1kk1UzCj/l6Hv5Cd1dgl3pbx9FlDCayw75nfH55REbKcAhDgI9KdxPCnv0
	OT3cPaTnwzjXL5/CT5CcTNrb/Ac7wM5sNGoKQGJ3z4v//Z5fgk+czn9o4JlcIa/JXG6U
X-Received: by 2002:a17:907:1ca4:b0:ade:399c:7a9 with SMTP id a640c23a62f3a-adfad5447bamr709040966b.37.1750065601653;
        Mon, 16 Jun 2025 02:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJKuhj5xyfGL3uzgbw9CuILR/QbgjEmvD0ydX72pNcFuNUu1+mxkyNoYCSx3RhwBrzPxddVQ==
X-Received: by 2002:a17:907:1ca4:b0:ade:399c:7a9 with SMTP id a640c23a62f3a-adfad5447bamr709039066b.37.1750065601216;
        Mon, 16 Jun 2025 02:20:01 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c5c3bsm626948866b.61.2025.06.16.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 02:20:00 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ciprian Marian Costea <ciprianmarian.costea@nxp.com>,
	Larisa Grigore <Larisa.Grigore@nxp.com>,
	Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] spi: spi-fsl-dspi: Revert unintended dependency change in config SPI_FSL_DSPI
Date: Mon, 16 Jun 2025 11:19:55 +0200
Message-ID: <20250616091955.20547-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lc77OoWsaNsV9-Sw4EqTVT2tOq2X0YCHmtrZToAar40_1750065602
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 9a30e332c36c ("spi: spi-fsl-dspi: Enable support for S32G
platforms") reworks the dependencies of config SPI_FSL_DSPI, but introduces
a typo changing the dependency to M5441x to a dependency on a non-existing
config M54541x.

Revert the unintended change to depend on the config M5441x.

Fixes: 9a30e332c36c ("spi: spi-fsl-dspi: Enable support for S32G platforms")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 60eb65c927b1..f2d2295a5501 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -647,7 +647,7 @@ config SPI_FSL_SPI
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
-	depends on ARCH_MXC || ARCH_NXP || M54541x || COMPILE_TEST
+	depends on ARCH_MXC || ARCH_NXP || M5441x || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
 	  mode. S32, VF610, LS1021A and ColdFire platforms uses the controller.
-- 
2.49.0


