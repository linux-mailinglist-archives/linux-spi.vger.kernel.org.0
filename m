Return-Path: <linux-spi+bounces-7272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F9EA6BB51
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 13:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CC73AD1D4
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7869227EB6;
	Fri, 21 Mar 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzaob1vg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33B1C2DB2
	for <linux-spi@vger.kernel.org>; Fri, 21 Mar 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561878; cv=none; b=YugiN3MG8c9Z2Ec0coAS14ydym+r556Ot9Fw5z1YIiFcP0neEqVGKdOQjYZXCsZ7PQ2Gz2yxSW9kxOnN8Yip1LFkRgSx7Grlf1wONbY1dI7X+VPEOuj+uvUMYSQEEfwEmwe+9s3xz9gLKc/m8cI1yfFGuT7ECQVvl42W/0tCCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561878; c=relaxed/simple;
	bh=WV8h01DTcYDCIkHtkZM+u69dA+vE5s2D8YrFHIABG3A=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Z7OeGX7xt6DcIHNmoCqGXztqcjAJFvsar2KV9kn1DN7TE08xOMSVDA9GVWPuXay+c2NTLxFh/p4h/VwqLkLDOEwoT+IHm1kEuUdN95iJotJyKDjlhUIBCE8ZcL27526TwtrZ+HmHqJbM3+8guTjzKrpt/gSlLgzIJT0dGgg1W0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzaob1vg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe574976so11740945e9.1
        for <linux-spi@vger.kernel.org>; Fri, 21 Mar 2025 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742561875; x=1743166675; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tMXqvTBhDsmIU46dwieyVJOz1wRi4N2crzClzNAU/UQ=;
        b=Wzaob1vg4MKFuSRb0G0UfW1s154fHWpptt8xwIdCDpgqIXmIykl6gpNCu3jMTZU4Fv
         AKdl7w5A1KB3bUkGRJK0nhHynFBjR5ha8zGmJlrSSGiSGVNQQ43PXQvOlFAotYJcxFpm
         rO/Ts5MXxAKvOVG9Wq6xA9AnDtZWubYUR9FIrvyf3NhmDDKI+4XF7OU7fVhZvt3H6Be9
         z5lCYuWNEiWUP4UtsL8ZgjAzDH+cVeqTeY6abTYOa1KxEWsQ+OEXkNW968meuXgdn1cb
         0DlCdTGc9gHX4fE59gwk2V82XOvohYrm1Hh6vPEIg68Ajz1iHsBfRomLyZqMzs3fTdev
         x8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742561875; x=1743166675;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMXqvTBhDsmIU46dwieyVJOz1wRi4N2crzClzNAU/UQ=;
        b=cq0bQ3+YgY3ABB2EjA2c3VGCmJ3cDTxzzA6E9eNCy0DcCcVQL6cY7ZuIbriwA2WC2u
         XOT0/SSj8wfIy+3WWY7Hkxu+HLg/WE9iBakAMnvly7AqIUgauPnClOFvy9U/nSaOTz+n
         iJ6UCVu/fkbdY49qzKOdWVvWxn8yL58l9IlTrU0HpmrdYJXJZSw1G8NVS/bZtZRNw9zq
         A688W7is0p5xinZOhx0wrIW1ipVXSJlOvhwRpzPcqpm4kmR58d/MlFvkq6RGxnmfnPRh
         VUuEyt2R3SGZ0ii4xpxzuDN+STHRdAWm+Huems3S2gQgatS2Ij+GAVYzTi4T0ICBRe5n
         Qx6w==
X-Gm-Message-State: AOJu0YxxN8uB/D8gKVFC73L1cLBvrNjZRWsXiXj4XJ1OqNqIoIRfSX6T
	uuAV6HGcg1Cv1RkAcyd8wmxVGh9Eaf5I39IYr2DFxYT1n4ICliSLVuU8no/yZMM=
X-Gm-Gg: ASbGncuikGDZxTTQ+H95cx4Pez6VQtew7RNydya0vIgANe63cWceFdLhxDRIf+iC/HH
	kWgBELVWwwZeusUwRL+PEp/DTqcU6n7CI8peXZ/V3UYNM8MgnGqbsMdYS7JpmeDH08kz6zkDdd0
	WUdFqqhtc9asCM1Qq6Evpm2E5Dyl59A21TtgJ80Q8j1PuqXOHZ4hs9hHNInDH6Wky7PcheRt8O1
	Pe9+lhdH0NpwbVu0fDWPk8hcmwyFAErP0ZE1nUXRKvRrGKqvLHO1HgPXgRmfG6fJ24d1/TsFaVn
	vYZEWC4FP5+gfnHq8HVbxJdvLHZIJonpYC953ZA1UqG0LoqR22A+BqO2IQT5zJn/gDtxBQnqw/u
	aUSBvuWEcAErBVw==
X-Google-Smtp-Source: AGHT+IGWi+Gt4v13gDghCGe+Jbu5Q3l2IMxPm/TVT4lgzDqW9EW/9FUF0r63MdffknW3eQkELufzyQ==
X-Received: by 2002:a05:600c:5488:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43d50a219a4mr31708785e9.23.1742561874835;
        Fri, 21 Mar 2025 05:57:54 -0700 (PDT)
Received: from uefi-arm64.Home (236.red-88-30-84.staticip.rima-tde.net. [88.30.84.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f331dasm78492825e9.8.2025.03.21.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:57:54 -0700 (PDT)
Message-ID: <365ccddfba110549202b3520f4401a6a936e82a8.camel@gmail.com>
Subject: [PATCH] spi-rockchip: Fix register out of bounds access
From: Luis de Arquer <ldearquer@gmail.com>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org,  Robin Murphy <robin.murphy@arm.com>,
 luis.dearquer@inertim.com
Date: Fri, 21 Mar 2025 13:57:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Luis de Arquer <luis.dearquer@inertim.com>

Do not write native chip select stuff for GPIO chip selects.
GPIOs can be numbered much higher than native CS.
Also, it makes no sense.

Signed-off-by: Luis de Arquer <luis.dearquer@inertim.com>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1bc012fce..1a6381de6 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -547,7 +547,7 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	cr0 |=3D (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
 		cr0 |=3D CR0_FBM_LSB << CR0_FBM_OFFSET;
-	if (spi->mode & SPI_CS_HIGH)
+	if ((spi->mode & SPI_CS_HIGH) && !(spi_get_csgpiod(spi, 0)))
 		cr0 |=3D BIT(spi_get_chipselect(spi, 0)) << CR0_SOI_OFFSET;
=20
 	if (xfer->rx_buf && xfer->tx_buf)
--=20
2.43.0



