Return-Path: <linux-spi+bounces-7123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C83A5F90C
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 15:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49B23B536A
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1737D268690;
	Thu, 13 Mar 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlk75RX4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC397126C1E;
	Thu, 13 Mar 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877592; cv=none; b=EgdmLkew8yPkINVLAPKfI8XXrglktUXBKBjGqxVjTKr4XpDzyOJRn/XfH5pk6J78MYtU2Zav1ZPNLTCUmessy+JT0TFk8dTxve6oSckPPD8knEfmKqvcsO9MHI2/m7iNBHnWtYrdqbW4BX2hAmPP6YUCwtv3/R6eESbLcR5oNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877592; c=relaxed/simple;
	bh=w52BMGEb/zNW6DRdLAa5vip7+Q6bfilfvxV8/qdG/Ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mb3E5Mt2Zi0arT7cWVva/w6YOThhNxFwb8Hn4MQuJWFMVnlT3sm99ylNpsAeSbBK7LzCoasD3UwnC59ee/xIDHQlWoHYK/gR1dgMTmvtpkHkaxGxDVVz4quWnskvfOXsaQvhD3RpjI+n9DdH04ewuSH3GXVbUejwHGAhJutL3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlk75RX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4519BC4CEDD;
	Thu, 13 Mar 2025 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741877591;
	bh=w52BMGEb/zNW6DRdLAa5vip7+Q6bfilfvxV8/qdG/Ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dlk75RX4BJJymKAK8ib8Bfq9GxVJVC5iw3D4UtFdjm3m2z8Pg2Q0X5iVmpCQ0sOnh
	 uCT6cH49pKZGgqc62hABR3U7O1RQ5siUeNePNUP6Rq0fBAdTqYIriSK/ZoNx4Ai4ea
	 pXhb/F+3VhgbaATFUYtUDKS6Ma968EHvM7riUwkHra5//pnsNNS/3akhiVw7GGCOIi
	 aL+xpG5U+UgWe8c3YYiaykJg8kZhQDlU6Mxg501HsmyBYhfpBOeQaJSNZEc+Bxt5a7
	 tAzNeP3CJQrOG15HT62bQh47ak3koZanZsE9XgkKjU7/pDnDSC8NiiVpSAsfhq1/B3
	 EOlmQNs44gKaw==
From: Lee Jones <lee@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, mturquette@baylibre.com, sboyd@kernel.org, 
 arnd@arndb.de, Ryan.Wanner@microchip.com
Cc: dharma.b@microchip.com, mihai.sain@microchip.com, 
 romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9656d46ee0255b9aba404d77d2d204376a9cb248.1736522006.git.Ryan.Wanner@microchip.com>
References: <cover.1736522006.git.Ryan.Wanner@microchip.com>
 <9656d46ee0255b9aba404d77d2d204376a9cb248.1736522006.git.Ryan.Wanner@microchip.com>
Subject: Re: (subset) [PATCH v6 3/3] dt-bindings: mfd:
 atmel,sama5d2-flexcom: add microchip,sama7d65-flexcom
Message-Id: <174187758697.3701280.18234838828113464973.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 14:53:06 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Fri, 10 Jan 2025 08:25:42 -0700, Ryan.Wanner@microchip.com wrote:
> Add flexcom binding documentation for sama7d65.
> 
> Consolidated entries into one enum to match proper coding style.
> 
> 

Applied, thanks!

[3/3] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,sama7d65-flexcom
      commit: c37ee2ed38391eef476fea6af8eccd0d31f5ed98

--
Lee Jones [李琼斯]


