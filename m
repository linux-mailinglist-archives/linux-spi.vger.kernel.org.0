Return-Path: <linux-spi+bounces-11578-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FDC891C0
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C9A3A53AE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1124B2DECDF;
	Wed, 26 Nov 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llsKr8Sl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBB2EBBB4;
	Wed, 26 Nov 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150609; cv=none; b=KO/X0ttPJ55tnXWMKz4gPdNh9N2hOCK00xioyLbXH1MPinLmJItyPHeTcr3WmwMDHWtkTcEL0jCRXFvkLpvMBv1weF/14yE0ZmcyGQR2xjWCqB3XqXSyw3gk/CJ5lObI+5nFjhpnf39BGwxgfXILnv4z4PGKRTMGbvrWEC/Sr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150609; c=relaxed/simple;
	bh=H+4zx+UsNc04/booLLfbhUc+FC8ScxXoB4fFnM/XB48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAR7DqCiHt6U9lJnZ9nch4yV42gvuVXg8DJ4GR8R7sWMx4ZxxiPyE3F8CdDnUb24bndqkY1UkMuOSsbZFYUCPGFa+4roUcvsrC34DyGGmB/srQYEURMFezcW5FsO9j0pUnZv0isNzIO2gJ3AD64HM3NDr6JSkCwAW1RpJuBUd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llsKr8Sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1155C113D0;
	Wed, 26 Nov 2025 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764150608;
	bh=H+4zx+UsNc04/booLLfbhUc+FC8ScxXoB4fFnM/XB48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llsKr8Sl929Oau2ZnXLhK8NaO/aWot5j8Wej8OuW+DkhBtaslsnbUKwDSp4L5wwv2
	 wpJaETkiPab7ShCVnBnP5ARFERkRuUjUrcw7GNqX/OLTAcm63PTLhQEBH0qhJoeRjJ
	 YA6Hl7iDRZ519eiSQpOsBBU9gwWEoRrW7MEe3Rob3/cTF7yF3DoEApVQQx86XhsjPy
	 YcRqzEMFw9TRmrks5wjlFDoVU5Z3faDJh3SZhXl86iL/n7R+WRHtYqd0xRPWKFP+Y7
	 84I47u2FXVHKL8r4Jy0gc/cUafHYroYWqWXfORcePn+BlWI/NFQsSAIz5GTbBZF0Nb
	 0eEH98aCVduaA==
Date: Wed, 26 Nov 2025 10:50:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N
 SoC support
Message-ID: <20251126-nifty-bug-of-music-d9f1cd@kuoka>
References: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Tue, Nov 25, 2025 at 09:45:29PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
> compatible with the RSPI implementation found on the RZ/V2H(P) family.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


