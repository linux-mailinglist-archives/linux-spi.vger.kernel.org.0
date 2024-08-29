Return-Path: <linux-spi+bounces-4442-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384D964DE3
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 20:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63961C23019
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E83E1B8E8D;
	Thu, 29 Aug 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZfeLNrk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB031B8E8B;
	Thu, 29 Aug 2024 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956866; cv=none; b=srxGRRssJU94EthwsNUUrdvC6m56fs8QlJsf+WOenNC3/1iNJic61++cXASsfRZ6G14Ch4avP57Ayb6yRfae6gym2QE1gkuxMdbnMLw4ZTngR5KNMzzeRisf70pteNIBHkFkuKY/gtW+9YkYmbggzuQsEWipx+1j/LQhrHV8JTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956866; c=relaxed/simple;
	bh=EH6w/yfzJU9m+iKLbKv1njmpS02ICxa3eYGuAq2C0Ts=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UEZD/F5RHyOywVduOWAi3mPbrSGxdeyOJVheHuMAnshNs//gWSzVixYIkP+RUNJi2BOp8eiptsKwYUA6ariGZ4l0MBtJ4Nw6PMZC2Qiy19+poi2zb1diMmxhQOp6MbdEoKQfD+4eHSUjmy5jd7PU2q1xJBTItejkKhYnce6a7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZfeLNrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575B3C4CEC2;
	Thu, 29 Aug 2024 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956865;
	bh=EH6w/yfzJU9m+iKLbKv1njmpS02ICxa3eYGuAq2C0Ts=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oZfeLNrkPUheFJwSIPpfVXwRmMIYJA8P9Ca7KF7npGpBiZLlL450Ssr1KNDoRStba
	 y7iI5n5yXLfcoVN0Kuq7eg74ZO1MVWQImpN6dUSm6dZIGtM+U8M4OeXtvOMxmgjxEH
	 JFJ4+mR1Tuka45xIOnr+iQmZf9F2kq8j9s+XxobksOoc/77RAThvfcpB6/xoCkqpsU
	 sFlBnbJWGOYmh0LOv+OWumt3nWI+rBQ7u0U1LilXZec6kat/JLFONWEUy9sKuUaAdr
	 Jk0X3owr9kI6TyNcvx7dVIWQVRcNiqJcYdCQGNAAd/RYUCGeRBI+7H223pIrL+CuCc
	 7HOYcXFtv7oDg==
Date: Thu, 29 Aug 2024 13:41:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: heiko@sntech.de, broonie@kernel.org, krzk+dt@kernel.org, 
 linux-spi@vger.kernel.org, conor+dt@kernel.org, 
 otavio.salvador@ossystems.com.br, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240829113158.3324928-1-festevam@gmail.com>
References: <20240829113158.3324928-1-festevam@gmail.com>
Message-Id: <172495658983.899923.10430034751474903183.robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: trivial-devices: Document
 elgin,jg10309-01


On Thu, 29 Aug 2024 08:31:56 -0300, Fabio Estevam wrote:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
> 
> Add an entry for the "elgin,jg10309-01" compatible string.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes since v3:
> - Fix the series numbering version.
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rv1108-elgin-r1.dtb' for 20240829113158.3324928-1-festevam@gmail.com:

arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#






