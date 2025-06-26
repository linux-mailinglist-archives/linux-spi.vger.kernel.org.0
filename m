Return-Path: <linux-spi+bounces-8792-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22047AEAAFF
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 01:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E3F4E2B42
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 23:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03235226D1D;
	Thu, 26 Jun 2025 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxPrTB21"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65132264C7;
	Thu, 26 Jun 2025 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982155; cv=none; b=nmtlgcJCRQgYVzBywdt7j1mZyc6m5bSQdyoFcIkfqqIU6ww+c12OxlUCZmL4ne45VsNq35a2lHFdXZG/75b+68FHHl8yzSp45lF0QyNLteDiLqnENoRdoRqyW3HMQyk1ZrR5QQ2Kd9mZvUK1qR3iRQgHuO9YPGW2nA9vRMoufxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982155; c=relaxed/simple;
	bh=5q/h+3DJYN/pbUXgz2Yx1HCCXOVW+num0rrcpIOKu2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT+5Q9dTrKqb/IvaaZKXPxVeK1Pjwlp8h0Lap3v+68K6cnk9syTN8PAi4zOWirlkhAUuzeD0FvdmroR3IaKQvM6GaOiygSeVR6IvvxH3HrCqGcQXLTHU7nC4AS4fh/Yegg164Sfd2vse2DrG2fHW4pB+4fa8fu7H32rG7cSonek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxPrTB21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5F9C4CEEB;
	Thu, 26 Jun 2025 23:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750982155;
	bh=5q/h+3DJYN/pbUXgz2Yx1HCCXOVW+num0rrcpIOKu2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxPrTB21Ngv6csFOPm2RQ0pN5AQcFVaGIzqdvwoTnjBPOFmSpJfopuZsaic+h8J/j
	 rYhMDXbKbC+VSu6JX9upHv0GazowbQKZakQxSlxaCYbI1Y0Sm5qTbrOakFTpHsXbAt
	 wrkppV00le/etXCgN/5HoQNRnZZ1Eq1lfU3wsQMy+KFi4xhHVGKn05VyyJ5dLgFvNx
	 nnSpPHv+lvPntrccAXbdXf/efcQQbT90PrdbntZhGPFY5EWM31MSN5PGHgbQaIc58c
	 mHlh9XP9/UzxNhAuFQnQNqzKPaWSnDZSWffTGZxfMBg6OeXuZtdzYnZwyAVMUP/1Xm
	 Kqn1U+OTYhGKw==
Date: Thu, 26 Jun 2025 18:55:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: dt-bindings: add nxp,lpc3220-spi.yaml
Message-ID: <175098215389.1435530.4404307945311612465.robh@kernel.org>
References: <20250625215255.2640538-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625215255.2640538-1-Frank.Li@nxp.com>


On Wed, 25 Jun 2025 17:52:54 -0400, Frank Li wrote:
> Add lpc3220 spi controller binding doc to fix below CHECK_DTBS warning:
>   arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: /ahb/apb/spi@20088000: failed to match any schema with compatible: ['nxp,lpc3220-spi']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/spi/nxp,lpc3220-spi.yaml         | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


