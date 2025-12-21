Return-Path: <linux-spi+bounces-12069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E68BCD41D5
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 16:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 569EA3007631
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD852FF144;
	Sun, 21 Dec 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+U+PK0o"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB701D47B4;
	Sun, 21 Dec 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766329848; cv=none; b=XT4g9LM5uJmezacFCshbRIi8LwlvE0Htj+pNCrChabi0yQSzqeNnSlhHqESzy4wh0BnLnrIC+sgWKyrUQBkCJaYCWpa6y75J8eCCg1Yxc+2UwzMZww6WB+1tCiucs9yYqTyJQUE5gAUnpDCHoupuDf1bQU02Q0k3MtL7rOJcvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766329848; c=relaxed/simple;
	bh=wqazjEUfhNgRi4xDXNm830yr+KxJQkTCkXxzr4Piqy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9W4gxRXlg0Pmal1prAjTSKaVVWv8B3OjFQgEoyP0TGpBNlkXWxmGQYbrZkLPopIT3DikyYuZ3dEhOWakmJU4kI2jLDmnMc0OEFLDdpVHhT71EqIgdNdmXLDzcr5mUhuT1TIA2VXzATOCtnvkzG5lG1kOI1jRtilm2AhxektScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+U+PK0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814F4C4CEFB;
	Sun, 21 Dec 2025 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766329848;
	bh=wqazjEUfhNgRi4xDXNm830yr+KxJQkTCkXxzr4Piqy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+U+PK0oznX66bMrSrirIwA2bNDNTWhEx3AjQ9eOpUwquC6fFMr9bLy0JXYII+aeB
	 zgDJJ59bjJpKg11XxsWaPmtBDDwXhkOQmGyURkJUxUhHuvaZEmd1rJ3wfbDY0sMU6G
	 5037UhP86ccwFU6hAqV9SKMPA1Y8kdxOcAL7SQhUVrknWrBgwDLsyJvv85s/3dM1k6
	 UP0WqDrhFMsoCqZZ2+vioKhy/rNz+cFeYW+mfaZoaVZP5SyPQB45mlGmHEG3hmSuWv
	 KSJ+BKuHJR+epfuZ5pokz798brKVABpph//Fx6wyarz67c1xunRE3bROBxdiUEccJp
	 ETXaEs8cFB2ug==
Date: Sun, 21 Dec 2025 16:10:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] spi: dt-bindings: sun6i: Add compatibles for A523's
 SPI controllers
Message-ID: <20251221-tunneling-intelligent-dogfish-d44a01@quoll>
References: <20251221110513.1850535-1-wens@kernel.org>
 <20251221110513.1850535-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251221110513.1850535-2-wens@kernel.org>

On Sun, Dec 21, 2025 at 07:05:08PM +0800, Chen-Yu Tsai wrote:
> The A523 has four SPI controllers. One of them supports MIPI DBI mode
> in addition to standard SPI.
> 
> Compared to older generations, this newer controller now has a combined
> counter for the RX FIFO ad buffer levels. In older generations, the
> RX buffer level was a separate bitfield in the FIFO status register.
> 
> In practice this difference is negligible. The buffer is mostly
> invisible to the implementation. If programmed I/O transfers are limited
> to the FIFO size, then the contents of the buffer seem to always be
> flushed over to the FIFO. For DMA, the DRQ trigger levels are only tied
> to the FIFO levels. In all other aspects, the controller is the same as
> the one in the R329.
> 
> Add new compatible strings for the new controllers.
> 
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


