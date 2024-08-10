Return-Path: <linux-spi+bounces-4162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5069A94DEC2
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 23:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF351F2187F
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AA7446A2;
	Sat, 10 Aug 2024 21:23:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45D1DDC9;
	Sat, 10 Aug 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723325012; cv=none; b=l47bSQDFO055424u4qm6fEJw46LIL0cMWeEMh/0QPxiqyUJ9sxc2/KCpmQDURM6KoIDPGVZHJMdO2PbrHjaC52vt34dRlq8EstQ5gNRFSLV061hrCpN8HPK4hMpSSip329MS276jH50fHcSEG0FG1ZOW3c8HQu0JoSGNGqY6yCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723325012; c=relaxed/simple;
	bh=nfDfb25Q4ETuIvpjTgTPjLgZiDDrcd1eiGuRc5AivSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKASFJ1yigLYvj1OPszkgwJp6W6ebh1WmbYFQb84AVZwdXxCw+DB0RmhFkUFfnHy2uxH/6+zajHq9B95Ba72JZvQYC6ztdKF2y5/2v3xRX6bgj8T3zqixfdWSHPfss44C9FpKAYgIr9IahdAPCZ1feu46hX1tOWeCuWWI3y3oug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sctYe-0007b0-CU; Sat, 10 Aug 2024 23:23:28 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: broonie@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject:
 Re: [PATCH v2 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe
 unexisting DAC device
Date: Sat, 10 Aug 2024 23:23:26 +0200
Message-ID: <574443966.JY4mfKhWER@diego>
In-Reply-To: <20240719111210.1287783-3-festevam@gmail.com>
References:
 <20240719111210.1287783-1-festevam@gmail.com>
 <20240719111210.1287783-3-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 19. Juli 2024, 13:12:10 CEST schrieb Fabio Estevam:
> There is no DAC connected to the SPI bus of the Elgin RV1108 R1 board.
> 
> There is a JG10309-01 LCD controlled via SPI though.
> 
> Properly describe it by adding the "elgin,jg10309-01" compatible
> string.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-arm-kernel/20240717-parrot-malt-83cc04bf6b36@spud/
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

Mark, do you want to take all 3 patches (fine by me) or just the
first two?


Heiko



