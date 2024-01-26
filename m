Return-Path: <linux-spi+bounces-875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4D83E2D1
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CBF1F2550C
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04A61DDEA;
	Fri, 26 Jan 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq86WRiK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FB22EE3
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298439; cv=none; b=RxXdxPHXWpi9AbQ7n7iFr9mil5n7RkvTC+c1dWBQ6EbJI4kDoTj9lseYb9D41fb79vyUI7X80qA1JtAIwqqyJxA6hIv+GOyLT7DLfVZatpEOloILK0mNGQbEgiSL+LX48zNiMBbGHr3UaK5pVuZ6iGLFiqq0AHxkXAz4U5yEYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298439; c=relaxed/simple;
	bh=fAasMHmySMninMIwMsubhqrtvsez7tgEW4+t50iw8vc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=fX2ZsXn67I6+hRdCOwJ5y4Orhg+ZWb1BQsE570H28F7vX2hL+Kui6rqfzUJYEf2hXkY6LzY0GFwhc6BkcGuJCiRD6MLLhGaMc3BsW5T959raoKXx0EyzSih4SkLjE89mKeRvYaVTBTjw9HAwEMez7m6hgEgDAEfp9tfWgljw2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq86WRiK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3394dc2ae23so1106141f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706298436; x=1706903236; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GSMFl5nllj5v1PrRTFHuxExKyyAx3NuOJlgSRm6sXPM=;
        b=Oq86WRiKdgJ4WolKXbkT6UEGJuyTN24D8/P5t3QxGZRGhYjEAKEJfMbioDto7TVPaS
         YXS1CgxPZnsYDMuYkfxQq+lvMTf/u4k1BfwG8IUGPl1i5MpHIw9CJvs2oceVyfDPWFr3
         W/jEtvTSLapAiTl7c/HttRHlk+8vy3Kt7AdudaxSNFaDfohQXRtGEm12ixOJ1erjsRm+
         +MmowwCqIcA1cpnjpE2f6AzkVH2V0yTCIFIw2A1Kzk2nLVzyW6yfApBoTWlbhBy2R/wV
         M1DqBL8gQWMqEhGxGBgc0NBEEpjXd7anmBzOcG/kg+7VkuK6tu5snJzJFbcdeGJx6ua7
         VmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298436; x=1706903236;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSMFl5nllj5v1PrRTFHuxExKyyAx3NuOJlgSRm6sXPM=;
        b=fZJOMsOQSNE0Z05WGUzkZkNjwuUNwMVXzzBDZNsRJ4EvDJDDGc/ByqVB6kR/M1XuW0
         SqtPpIli6k+FsEuPX5TIba+r5FVpId+ci8LMiLiTjNUrs8n9Cn8gcBK5lQtjmwAklGbG
         HMKXDz50CfW8EU/4o6z2yCYK7BZTMXBklU6PbRYlhH4cvlpMxZydmj4THOspODJaUxVo
         RkKwCzD1empIovPMJ1cXTbb41zCJYEo4T2ofwNmyyCkQq/wmDRmdvqkssb7SHkoXSynF
         i2bNV+gg0Xr3ZAXtxeeeDXizX7lu6zbdHV7b1eT9bNRENy8nBpEVbJhpXMxrfiJihzHt
         3VCw==
X-Gm-Message-State: AOJu0YzIKSmPI4UpzpC8YHNUbvWQ4bl0YVNdzLbwdwhUt7u5kYrwVCmG
	OkmhNmOhnwd6XLEkVYktBFwRek9N/h7hpJz1gpeEnXDhgJM0EP77yHGyxKDVPPKliw==
X-Google-Smtp-Source: AGHT+IF6Rga6mv64blYjD/Oft6VTs6a8MSrYnbKYGuy3EC8KRzyRoEb9bn2yxKYI0PL5WWPkLS1yNA==
X-Received: by 2002:a05:6000:1b07:b0:337:67e:a1ef with SMTP id f7-20020a0560001b0700b00337067ea1efmr100398wrz.7.1706298436373;
        Fri, 26 Jan 2024 11:47:16 -0800 (PST)
Received: from [192.168.0.5] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056000428900b00337d9b772c6sm1891773wrb.37.2024.01.26.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 11:47:16 -0800 (PST)
Message-ID: <fc9519de1d278c3f0f0ba8a9640b0499ae2bedca.camel@gmail.com>
Subject: [PATCH 3/3] spi: spi-rockchip: Fix unused chip select line when
 using gpio cs
From: Luis de Arquer <ldearquer@gmail.com>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org,  Robin Murphy <robin.murphy@arm.com>,
 luis.dearquer@inertim.com
Date: Fri, 26 Jan 2024 20:47:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Luis de Arquer <luis.dearquer@inertim.com>

This change allows the DT to use native c1 for a device while leaving
native cs0 reserved for allowing gpio cs operation

Signed-off-by: Luis de Arquer <luis.dearquer@inertim.com>
---
 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index e1ecd96c7858..e1ae62e8765c 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -247,13 +247,13 @@ static void rockchip_spi_set_cs(struct spi_device *sp=
i, bool enable)
 		pm_runtime_get_sync(rs->dev);
=20
 		if (spi_get_csgpiod(spi, 0))
-			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
+			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, ctlr->unused_native_=
cs);
 		else
 			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER,
 					      BIT(spi_get_chipselect(spi, 0)));
 	} else {
 		if (spi_get_csgpiod(spi, 0))
-			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
+			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER, ctlr->unused_native_=
cs);
 		else
 			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER,
 					      BIT(spi_get_chipselect(spi, 0)));
--=20
2.34.1



