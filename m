Return-Path: <linux-spi+bounces-4160-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DC994DEBF
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 23:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47181C20BFB
	for <lists+linux-spi@lfdr.de>; Sat, 10 Aug 2024 21:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501CA13C81B;
	Sat, 10 Aug 2024 21:22:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687D1DDC9;
	Sat, 10 Aug 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723324929; cv=none; b=IgY8o+Gv8GsGLHvhE2OFek0LE4kc993CeIjODR5kOp1DKoZ3DaO5YuyBR82NG5CtnW9e8xG/ZUiWYO2i0iSQNDvofo+y4gJnAkdrByYn67oJtHEfc+eUQ9ksNfpzYiA9A8XHKTtzy64HFEIX3jsTPgBHAJlZrPCpWVXDABtSUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723324929; c=relaxed/simple;
	bh=h97yHzqNc8XTefU6NxY46PniLfrokc6I7xIoldVRlVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJD4pAWJHwRHCM0IMwZPL2qbhwJqvywt2OGoDbV1BYGiqzOGNsOhOC2VBJKjhuhs9PUUQgQG1Uekz+L8+uXzos1i7aDGD1FVJ19ZYQPDJdl2uU7b2yIT/e5c0h1gUXByf7kPVYWKDTAPme1xO6RCXZrkevNSAi4+HtgNmeO7gT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sctXI-0007Zs-Mb; Sat, 10 Aug 2024 23:22:04 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: broonie@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Fabio Estevam <festevam@gmail.com>
Subject:
 Re: [PATCH v2 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
Date: Sat, 10 Aug 2024 23:22:02 +0200
Message-ID: <78335249.VQpxGFKSoK@diego>
In-Reply-To: <20240719111210.1287783-1-festevam@gmail.com>
References: <20240719111210.1287783-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 19. Juli 2024, 13:12:08 CEST schrieb Fabio Estevam:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
> 
> Add an entry for the "elgin,jg10309-01" compatible string.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
> Changes since v1:
> - Use a more specific compatible string. (Conor)
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 7913ca9b6b54..49dee2a1f6b4 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -110,6 +110,8 @@ properties:
>            - domintech,dmard09
>              # DMARD10: 3-axis Accelerometer
>            - domintech,dmard10
> +            # Elgin SPI-controlled LCD
> +          - elgin,jg10309-01
>              # MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
>            - fsl,mma7660
>              # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
> 





