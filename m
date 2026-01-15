Return-Path: <linux-spi+bounces-12395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93522D23BDD
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A4BE303C551
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE53563FB;
	Thu, 15 Jan 2026 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXgAS7WS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6633439A;
	Thu, 15 Jan 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469963; cv=none; b=Kh5jq5WrJAiw21WipGuAn0b1mJBaHUMBDG1tus49cszOv0TOUOshB21EsNPsv/k80/d1NkJLCMyRVUpMGwKb8PSyV0Ami/8yjXuDXs7rhxlSRyGOFb2q2BE/6lN4AqL6uHwR8x8Awg+KOWcUjgnIYRJokn11jkldwd460xx30sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469963; c=relaxed/simple;
	bh=mBx+fIz49RnYEGumbLcy300xsMIP1MaxNQOI4ctMKv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOC9scmYvtcCmUykZoGetktQ2KUzCAdKaI2SDzXtqAhYTiJcs6huPqOuiqGZBo5QsoqIZIfbgf9H9yt/zlE/VOUgo4OFKnzG/8sbl2IonddvhRPlFQGEGuKw4xA35cmy1fu7ZMmkMU8WgpALMigAsU5qBvPTOPtMIdwxrLoWia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXgAS7WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E5CC116D0;
	Thu, 15 Jan 2026 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768469962;
	bh=mBx+fIz49RnYEGumbLcy300xsMIP1MaxNQOI4ctMKv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXgAS7WSEZWb8uBcsXbcLyta62IWCfXW3oyaPnXnNkmhIvEXMuw+FHiacgJLyidLD
	 i8aFCvrAa2k9K5NEOFk+bo9pDbqf/fImM0gXkULtVq8F5MQhr932V9RL0AbVQqfQLX
	 FG6D7avy/PwL8K5/uE+rdG3pS8/L7F35LO7Slr9gIm1eRRdMaqhp/th6DtGTNPsvNI
	 vxCrBQhE/VgxzNmwEXG69XurVA8aw/69I7IIy3Ag9oZdiInkUwdbHzhqCFdBPVS8Zp
	 CMfw04vpjMTmvaBjv0JeOCwEGhVIhTpGtOPpXZuKdADo9R73iIQKXOdj2psSK3dixQ
	 tZLXjNUBs70rg==
Date: Thu, 15 Jan 2026 10:39:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi
Message-ID: <20260115-imaginary-banana-beaver-7b45ea@quoll>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
 <20260114-xspi-imx952-v1-1-acc60a5a2a9d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-xspi-imx952-v1-1-acc60a5a2a9d@nxp.com>

On Wed, Jan 14, 2026 at 02:49:45PM +0800, Haibo Chen wrote:
> Document i.MX952 XSPI compatible, which is derived from
> i.MX94 XSPI.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> index a0f4b162c85855c55d06c6ea1a2417af5121fab2..16a0598c6d033554ce5a42a13a3265315a16992e 100644
> --- a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> @@ -15,6 +15,10 @@ properties:
>      oneOf:
>        - enum:
>            - nxp,imx94-xspi
> +      - items:
> +          - enum:
> +              - nxp,imx952-xspi
> +          - const: nxp,imx94-xspi

You never checked your DTS and broke all existing users. And existing
tools would clearly tell you that if you tried.

Use tools instead of reviewers. Reviewers time is more important, so if
you just disregard it I find it quite disrespectful.

Best regards,
Krzysztof


