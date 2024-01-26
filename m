Return-Path: <linux-spi+bounces-873-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC1D83E2CC
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB101F23C21
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565D6224D1;
	Fri, 26 Jan 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA25HX0R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF9225A5
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298397; cv=none; b=SD8O7dXmV6gKIF7+/rMD+SqsfkVkhaooNAGX5dTEimeMx1q1MnGssKBg2/Ny9L0rtxmFCSghyrYlm6Nei8Mx3OZSiBL0F/xbWwY8p8h4a72bQMpnw1li5+ByZBfo1dPX2SBgTxpMiBXeTfeYuc+aZ2xBx3tVed6H6HBK6x5S62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298397; c=relaxed/simple;
	bh=muonXau7WQwP2PnBlYtn91QK/4ndN4KwkZd4IQ6kJpw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=bn94pFEawBTQbGXFQJ9a4IR405u1axH6j6C3rcj6LW/ZWblMJQfv9lddXyse67O5JKTX97b8US0+fhJpcagzd2sytO/wR1CXwbEQOxFKKza49d8gNhILix6Vln/zQeXox2vDLX+ONk1MWhBNL8UDzc/U6jwetz71JW1GmQexxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA25HX0R; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso13527835e9.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 11:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706298394; x=1706903194; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ELPxmtn49SBjAi9TU0DUsydleKjJ78oJdceadEbwh5I=;
        b=EA25HX0RPXzEDiN1x7MfKKXU3ljNtdJA/H/Dbk5zXvboqXxfWPxusGXEm9QVqp7r7q
         s42CY6bJui73tSeinx62cv0Mwcm7qM5hlL7+1tGuDJyE903sbYEfg6EfmsXk3Lhzvuqs
         i4Z9bofdrvTfuz9iuo4xzyl5uvozD5QwMM/BN6l90nLMnJ9rkJPQJ6MwK0IF23IT39EJ
         4BoD2qvBRAjzATFI1QEa92sBV7GPLBleH82zuq6GYbnwALVKpxcljAF+htOF/qdpT5RA
         tqqGJPxejKSYSjZctu9YCjpZ1wC296rKt0JDpZGmfJ243gBWO1YlyBnUVga0XO4HmD18
         kPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298394; x=1706903194;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELPxmtn49SBjAi9TU0DUsydleKjJ78oJdceadEbwh5I=;
        b=OWV75Z5uJ+GbIVxvogS8MxDJfNN7QHjVxQzYL8yhTbm+evwhl9S/wxO9fGPq0mg3Wp
         cJASbwVucgCmGkhMfzT2Bh+vf/OCxQ6Hltrvk/9n0gIzYYgTHLkJUKIk64AjlSi03zJS
         fpgHG04fdhdh2XUb2Ws2WbMZvAmjDgRspYLrWP6gBAJeYnE9YD5RLjwdq4MEs8Mm4qmn
         TKYR/dXhPa392rOVcSHbYBTnlYcK8BeObmvWWanJTkDLip/e5R77FvdkVqq+Nh/HV27w
         lcUlZlqLmDhKIlPfVgxgBeT5IcyxNuJbJA0GeruMQYseT6kXf0rTWzkxwaUiAUi2UfK8
         2AzA==
X-Gm-Message-State: AOJu0YzuQphOW+bRGAofxfk3AqcYRNgAr+m+HC0p3TUxZQQD6wyBcFBS
	Ww8qI3zcKcRFgYA/gsWsizQQpx0PaT6KaDcL6EvEyoQfiPTBD4k2kne94v8DgljHeQ==
X-Google-Smtp-Source: AGHT+IFDktryRMsL2GnllBeHMRu5xBVFqB3atm9WtCpg9CMFwPfsoTLWDKvyE2nSetolmi+Q1tYvmQ==
X-Received: by 2002:a7b:c8ca:0:b0:40e:e97c:247a with SMTP id f10-20020a7bc8ca000000b0040ee97c247amr224674wml.51.1706298393788;
        Fri, 26 Jan 2024 11:46:33 -0800 (PST)
Received: from [192.168.0.5] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b0040e621feca9sm2723301wmq.17.2024.01.26.11.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 11:46:33 -0800 (PST)
Message-ID: <d0a0c4b94f933f7f43973c34765214303ee82b77.camel@gmail.com>
Subject: [PATCH 1/3] spi: spi-rockchip: Fix out of bounds array access
From: Luis de Arquer <ldearquer@gmail.com>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org,  Robin Murphy <robin.murphy@arm.com>,
 luis.dearquer@inertim.com
Date: Fri, 26 Jan 2024 20:46:22 +0100
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

Since spi-rockchip enables use_gpio_descriptors and the
SPI_CONTROLLER_GPIO_SS flag, the spi subsytem may call set_cs()
for spi devices with indexes above ROCKCHIP_SPI_MAX_CS_NUM

Remove array cs_asserted[] which held a shadow copy of the state
of the chip select lines with the only purpose of optimizing out
rewriting a chip select line to the current state (no-op)
This case is already handled by spi.c

Signed-off-by: Luis de Arquer <luis.dearquer@inertim.com>
---
 drivers/spi/spi-rockchip.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 4b9669da2cf3..2fb2d65bd5f4 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -192,8 +192,6 @@ struct rockchip_spi {
 	u8 n_bytes;
 	u8 rsd;
=20
-	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
-
 	bool target_abort;
 	bool cs_inactive; /* spi target tansmition stop when cs inactive */
 	bool cs_high_supported; /* native CS supports active-high polarity */
@@ -245,10 +243,6 @@ static void rockchip_spi_set_cs(struct spi_device *spi=
, bool enable)
 	struct rockchip_spi *rs =3D spi_controller_get_devdata(ctlr);
 	bool cs_asserted =3D spi->mode & SPI_CS_HIGH ? enable : !enable;
=20
-	/* Return immediately for no-op */
-	if (cs_asserted =3D=3D rs->cs_asserted[spi_get_chipselect(spi, 0)])
-		return;
-
 	if (cs_asserted) {
 		/* Keep things powered as long as CS is asserted */
 		pm_runtime_get_sync(rs->dev);
@@ -268,8 +262,6 @@ static void rockchip_spi_set_cs(struct spi_device *spi,=
 bool enable)
 		/* Drop reference from when we first asserted CS */
 		pm_runtime_put(rs->dev);
 	}
-
-	rs->cs_asserted[spi_get_chipselect(spi, 0)] =3D cs_asserted;
 }
=20
 static void rockchip_spi_handle_err(struct spi_controller *ctlr,
--=20
2.34.1



