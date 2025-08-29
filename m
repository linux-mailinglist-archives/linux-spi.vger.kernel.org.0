Return-Path: <linux-spi+bounces-9782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D709B3C217
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 19:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C987BD37C
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88779335BCC;
	Fri, 29 Aug 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5OCkg4F"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724E32C32D;
	Fri, 29 Aug 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489973; cv=none; b=sfzNrNXCiBCSJ8+ubqSmCZvQrKZYu70w3I/NKi3B/bMJheLonm8VEFH2Cn2xRxEp1n91yraj0vWMlbTXYM+QfJoODddAyDVShUcp6TAvIJgF8o8DUAxdlVC029CfhQVXUw2ZmuTsMPYKYUcEvSk3GTOd7K1y7GFOtAiziwEvKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489973; c=relaxed/simple;
	bh=cPpcFQUzbuutVeKl8aE/0slH8JOuPl9Xymm4xKi2SFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVaeRHDoi5ND0llktzjyZ1CauvnR70fbAcKF0ITM9pmjtIO7LOP1R2S4dWM1ungDdvwG7xY9l9kkrh2UgpDXTWbUnw8RGSbXABk0/rtHxjU2hyKlC9WahUy2OabE2DG2qVw/l31um5wKAwvAQMnbCmxVTbU3g4Lx7V1kqLwpaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5OCkg4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B325BC4CEF0;
	Fri, 29 Aug 2025 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756489972;
	bh=cPpcFQUzbuutVeKl8aE/0slH8JOuPl9Xymm4xKi2SFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5OCkg4FTWL+k5V0z7jqf9GuYZo0khzXnogeposoA2knfWpK3tmAv4CJ9Oy3hSAMl
	 cUQ/0akIm1+kePxA8FMVCyaE8K+/Q363wcZOt2+fSTek2yd9M7XPT9EUIuUnHBKZKV
	 UR2Z4mO5uCFpRCmcEWUmL5Dc3dN8kxPe6/s11NJwnc6sViCqRFQNm87MbqKvu6jfW3
	 Nmb64v+NKhN9SBfOHbsYTdUSvSouHiuzo3fXrhd5ZPt82/GKqJ1lRzOYARgE6DRxdm
	 0v5kN3td8nqlcMI31Bxyy3n8RTi5l5OQE7Rk5nQcmD7glbZerRIkaCC8iIhYZ2URhz
	 m5VJ0kyBy8O/Q==
Date: Fri, 29 Aug 2025 12:52:51 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>, s32@nxp.com,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev,
	linux-spi@vger.kernel.org, Clark Wang <xiaoning.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 5/9] dt-bindings: lpspi: Document support for S32G
Message-ID: <175648997150.1070762.3258877988488262868.robh@kernel.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-5-6262b9aa9be4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-james-nxp-lpspi-v2-5-6262b9aa9be4@linaro.org>


On Thu, 28 Aug 2025 11:14:44 +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
> 
> Add compatible strings 'nxp,s32g2-lpspi' and 'nxp,s32g3-lpspi' for S32G2
> and S32G3. Require nxp,s32g3-lpspi to fallback to nxp,s32g2-lpspi since
> they are currently compatible.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


