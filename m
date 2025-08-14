Return-Path: <linux-spi+bounces-9445-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27869B2707E
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 22:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1E41CC8048
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83247273D8B;
	Thu, 14 Aug 2025 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZBTLYNL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C4272E42;
	Thu, 14 Aug 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205160; cv=none; b=uQ5sjzib1SREbmQL18QKX7inumMOmk+FxEKbii776ETKy5azmffMGQ8ss+8LhHP9EJF5Z+VZNgKVLwMLE0n9fV1twuNkyHLLJ1uletBK6DfAO2HVwokNXDEdFhK15fqDNF/Z/7+hA4ugcCHQLHv6DLsav154kq8n3nwNZcIA11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205160; c=relaxed/simple;
	bh=Tb8hGze9KVpCqWMZFaP75hh5mWHsorO7iqkAvfTQO0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug68nprUDi1Px/uZvaR8mxw+lgeYDdhukztwYtHdH411ckkXWIZqyLTCq0hTcGMH7z+EMsZur6U51WkkJAJxYiwfUywP5FWWgOSv/V6L8HozGLknE3QrwWNcOc7nmyTCBnUi8ZuD1BS+xox+bFIAIhLvcVGiejDhFS6swNBJg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZBTLYNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE42C4CEED;
	Thu, 14 Aug 2025 20:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755205158;
	bh=Tb8hGze9KVpCqWMZFaP75hh5mWHsorO7iqkAvfTQO0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZBTLYNLo7rNXtPYOKWDDRJLNg2SiYsR/U1wfMoexVHfzeh5+ZibOWLXayI+mIaTt
	 ZT96Ozjsd1xBRGn3x5U6VisXs03AJvs8UQYinxH82K3zFUaiGzhh7yUTD6QIMGsgkE
	 zTGnmu5MrD0sAe1rEjhoEAoZFexLOCe1g2gdsLiGUY8+jwGhDrLfNvg8aUx0F7cy98
	 Lwq9S0qxDeGkK13MhRUcBYuUAXYe7GI485FoymZc3ZZQhJ41hudUfwPDxXllrku/9W
	 v2P37OM35nBn/szcH83yL6eTCl3yGQIzS2ApXQNsaCBBp2/FLFgTqkBv0k58wKR11t
	 zrMQg6cwn0jdg==
Date: Thu, 14 Aug 2025 15:59:17 -0500
From: Rob Herring <robh@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 11/13] dt-bindings: lpspi: Update maximum num-cs value
Message-ID: <20250814205917.GA3894941-robh@kernel.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-11-9586d7815d14@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-11-9586d7815d14@linaro.org>

On Thu, Aug 14, 2025 at 05:06:51PM +0100, James Clark wrote:
> As mentioned in commit f46b06e62c86 ("spi: spi-fsl-lpspi: Read
> chip-select amount from hardware for i.MX93"), some devices support up
> to 3 chip selects so update the max value.
> 
> This isn't a fix or functional change because the devices with 3 chip
> selects support reading the number of chip selects from hardware, so the
> value wouldn't have needed to be set here. However the commit states
> that the DT could be used to overwrite any HW value, so the full range
> should be supported. This also avoids confusion for any readers about
> how many chip selects there are.

If reading the h/w gives you 3, when would the DT need to override that 
with 3? You only need an override for 2 or less.

> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index a65a42ccaafe..ce7bd44ee17e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -64,7 +64,7 @@ properties:
>      description:
>        number of chip selects.
>      minimum: 1
> -    maximum: 2
> +    maximum: 3
>      default: 1
>  
>    power-domains:
> 
> -- 
> 2.34.1
> 

