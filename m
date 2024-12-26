Return-Path: <linux-spi+bounces-6189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565FD9FC71F
	for <lists+linux-spi@lfdr.de>; Thu, 26 Dec 2024 02:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDA01881C08
	for <lists+linux-spi@lfdr.de>; Thu, 26 Dec 2024 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED742F5B;
	Thu, 26 Dec 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Wyeka9DB"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11CD27E;
	Thu, 26 Dec 2024 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735175035; cv=none; b=sp9K4d9ovt1oObJgl1grLATA8zIqvWO1R4NjSEs16PI1ilDFSyLIb8eXmKuMEWuwxO/p03cDJ+CJDvCmSdQtL4FLzyWdWbLuIbuATmk5FZ/k9blyZ4y88lMdpLjPulLu+ZK40/plPEshog2rlbc3jW4kUEuYpB8lxaYvpUlr82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735175035; c=relaxed/simple;
	bh=cerY22D4eVntKAQUS8DBw77VgTnork+Orm9lzfUABQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DF9Mhn96KdPKLu9/t+mZMxA5qJheR5G8uGuziG74cqHlVF3eloucalH6pvefzV+R7EA3T6n6Mi1BoOaQcn58g0RzZuACxsRSfUVKRYFJRB1O5AcIoCCb9WIYdH02s2Y4QbV/G2Af6oXP/lO3VxiqPaiP+HQyWjxb9Ye42+BVD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Wyeka9DB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XfW+FErZ5uemWJ+QBpgvCgdf7t8nzwinnsolNQHp+n0=; b=Wyeka9DBsSFrg6HICJYAVqRxiY
	my9eB04uh52BOT/tBX1j5WJuQxSZIa/GzRzb+5Ynui7I6BsJdFiVqDCN9JOCIGWuykZzPsDQVyD8F
	gtaCbDRDL92CeKRLdGFMSRQ1UGo36D8dn9TlFH0bYef1/rmtiMyB9lsieoXHKOjPoyJvKuo7Lbxa9
	KbfCaJEeGp7XlxX7cWRBbcCIbv9I15oKiDqPCITa5zWlO6uVKc+D48e34tjVZCJIoDUaJ6ONvuCM0
	ITse8dipe3ZKshaKLc0Pp9BA4Yqex9rCGBj4C1bRuAOV4Gh0n+HBab7uzAvMbcwK52wVUVfXywAlx
	OWVI4RGQ==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tQcI1-0004ql-OB; Thu, 26 Dec 2024 02:03:49 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject:
 Re: [PATCH v2 08/17] dt-bindings: spi: Add rockchip,rk3562-spi compatible
Date: Thu, 26 Dec 2024 02:03:48 +0100
Message-ID: <4045324.kQq0lBPeGt@phil>
In-Reply-To: <20241224094920.3821861-9-kever.yang@rock-chips.com>
References:
 <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-9-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 24. Dezember 2024, 10:49:11 CET schrieb Kever Yang:
> Add rockchip,rk3562-spi compatible for rk3562.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> index 46d9d6ee0923..104f5ffdd04e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> @@ -34,6 +34,7 @@ properties:
>                - rockchip,rk3328-spi
>                - rockchip,rk3368-spi
>                - rockchip,rk3399-spi
> +              - rockchip,rk3562-spi
>                - rockchip,rk3568-spi
>                - rockchip,rk3576-spi
>                - rockchip,rk3588-spi
> 





