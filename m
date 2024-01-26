Return-Path: <linux-spi+bounces-874-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D09083E2CD
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A57A282B06
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE4225A5;
	Fri, 26 Jan 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anQSbQSq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B6224D1
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298419; cv=none; b=cP3E0EQU9l3TyDpBmn8OkYBBo5Ph3AfV8MRBwT2zl9vkpyAgTp0DT8cE9Qf8YqLLeEtdY0VfrFX0rIfuLx72YgyiUsWi62OI6NTNEdI2QqxZIl97fnPKE26UUvnrWtpge7riAiaYHm6y04cuc/IKalPbR0brPd8jfsdGJHQc2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298419; c=relaxed/simple;
	bh=wd4mMcJ6WsoBVRWMVafZ87B6uvpdvd70W4jhd0cTjXI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=IYRGzsm7Vysv+eAz5M6RAmGccEM+N7GLrYfjy60xXfkZMu6rMZPYGu+cOue/aWmCwlbg/OWB6p+Rsxk71spsgQqrrZvHYRtOUOpmlHFYOfDwtZrR/Cad5bcEipkOQAoJCA6QDCTzuKvon3MhYDSWiTBCJejrXgSUu7VOaAtsoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anQSbQSq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-339231c062bso840006f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 11:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706298416; x=1706903216; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0IIrz90wxugAXxqo1oEKAPrbqAXFmZOvUWx/sZLFUrc=;
        b=anQSbQSqshJtY3E3XYaBuJi+WtMbTbjDR44C2KCpoKGtfJV7lkSoSU0PtX+DXUXl3i
         V7M5vJc8ZhctZv1J+6aJRHeOWcSNewS5f5rqkikBUO2zKi5SBexukVORtGhNSB7XpLju
         FFz/xfzApTqV8R9GJRToLbkk6t+IYTp3t6ajyKssC/g2FFa7peeY+yz5zr4EU1pCep3I
         05JgNOkIVmXe+yx/znvTdXEMx0YbXMEQvOJd5atrsjoohf7l0PMAwsqPIwlny+S6Se5T
         ptBnWV0yThgkA55PJN9M9q2qKtpFweuW2x79pf+g5s19hwg7lxIoiLkOI0Brp4d9iMI8
         +shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298416; x=1706903216;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IIrz90wxugAXxqo1oEKAPrbqAXFmZOvUWx/sZLFUrc=;
        b=OSwOEJQXaBXZyUoasPIWmqngKs6PjMXcdy1Gqc0LUxxc8No1M8CpwIRO9ND8JJJfOJ
         /j2lkvElUgRE3mbuMpHEM4vSsZnIs1uPKt9Yq+W0ICC+aO8xrv5WIbacAH3Wy2mPhfXV
         skLQ7VSSGtcYPNRllGS6M30cSN1UF2Cqsn82wKyOJpeqbY6ty9iB8hDHRbnCUd9+QwiU
         DvZSUER+IYrPRRfNy8DPaHhLPFCKAt4+rqrAQ/Luwz2OURkxB1uFDjeyiF11B+twB1el
         V+lpZElzqeVyY9h+T4Th0Dqbhlgt6erOIzQwiG5KCGHDUOxInPe4rHPPPD5xzLfwFqYs
         eqWw==
X-Gm-Message-State: AOJu0Ywnn3wLblw3QmQW93Dr6t1nU2DGg3AQgLiZ7g3foVVrO5frYdys
	vQFzfoWswDHF5vrT44J6BSWggqIF+pxkO5Nl/RhCQzOOMEJhHbYnqC6bO/SeiOXcJA==
X-Google-Smtp-Source: AGHT+IFtcvfcwyggy7yof16qegpXOAcbCVaLwA7I4eH2tEs0+zqJOppVHA/couG3saqmW2UUqbqyiA==
X-Received: by 2002:a5d:694b:0:b0:33a:dec1:308e with SMTP id r11-20020a5d694b000000b0033adec1308emr138083wrw.116.1706298415756;
        Fri, 26 Jan 2024 11:46:55 -0800 (PST)
Received: from [192.168.0.5] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id j17-20020adfe511000000b00339214d70b5sm1876673wrm.85.2024.01.26.11.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 11:46:55 -0800 (PST)
Message-ID: <4d18808e85b85077761c5655083f20ebfd7d3770.camel@gmail.com>
Subject: [PATCH 2/3] spi: spi-rockchip: Fix max_native_cs
From: Luis de Arquer <ldearquer@gmail.com>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org,  Robin Murphy <robin.murphy@arm.com>,
 luis.dearquer@inertim.com
Date: Fri, 26 Jan 2024 20:46:44 +0100
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

Signed-off-by: Luis de Arquer <luis.dearquer@inertim.com>
---
 drivers/spi/spi-rockchip.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 2fb2d65bd5f4..e1ecd96c7858 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -160,8 +160,7 @@
  */
 #define ROCKCHIP_SPI_MAX_TRANLEN		0xffff
=20
-/* 2 for native cs, 2 for cs-gpio */
-#define ROCKCHIP_SPI_MAX_CS_NUM			4
+#define ROCKCHIP_SPI_MAX_NATIVE_CS_NUM		2
 #define ROCKCHIP_SPI_VER2_TYPE1			0x05EC0002
 #define ROCKCHIP_SPI_VER2_TYPE2			0x00110002
=20
@@ -839,7 +838,7 @@ static int rockchip_spi_probe(struct platform_device *p=
dev)
 		ctlr->target_abort =3D rockchip_spi_target_abort;
 	} else {
 		ctlr->flags =3D SPI_CONTROLLER_GPIO_SS;
-		ctlr->max_native_cs =3D ROCKCHIP_SPI_MAX_CS_NUM;
+		ctlr->max_native_cs =3D ROCKCHIP_SPI_MAX_NATIVE_CS_NUM;
 		/*
 		 * rk spi0 has two native cs, spi1..5 one cs only
 		 * if num-cs is missing in the dts, default to 1
--=20
2.34.1





