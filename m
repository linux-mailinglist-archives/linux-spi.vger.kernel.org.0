Return-Path: <linux-spi+bounces-12044-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4980CD1C11
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE4A303CF78
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0533ADAC;
	Fri, 19 Dec 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crnVuR+g"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C313BB44;
	Fri, 19 Dec 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176131; cv=none; b=YOA0EkERvgo9ow6rewr/J9Riw9z2BnHWtoUkL70jCqc36P7HPjmXxlTadLmGhrBh5RDObwYSyZbloA/8athohzLjNGBNx24E7FeCg7dtUXLdj6SOhc7GCsbmevtNpHAFf0D72wby4XXd7moiJTv1JyeYwFNXSx8lNHyb5jv2Gt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176131; c=relaxed/simple;
	bh=mH/3+P1Mni8rlKaukV/fxOSy+vtN9HEN1c/tYQywphs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlA7WTeNpqnW+gYGOIYBDRW4CqzNBH3STOfLGYDtmYKrp8pSgS5VgFeNc9Tf/gDnjtDwUz7pfH+aqHeKsFVTxphazpFUzIubesjSurub+brIEBmEXZ5qlFePCVtOWD+bIdtYU4i67GD7QykxxbKSpDvyqW8kBV/8WJvbNu8JBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crnVuR+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A879FC4CEF1;
	Fri, 19 Dec 2025 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766176130;
	bh=mH/3+P1Mni8rlKaukV/fxOSy+vtN9HEN1c/tYQywphs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crnVuR+g5NQ0T9xAWciVjRH4LzvzWCNRFTDXObYNb3YWkrr3WcDTgqyCV0k6jtgjF
	 J6A87OsC47ct0vvFAlcU73hCImjE5ZeQqYGHEj6oUAQTFQgFIE1BlijsFybHHSHkdr
	 VP+b33seyUDuDCouYbAEkiPrQCXoruNMq8nTT0jFwV4RJZ/AjKeFgHn0XE0Tn4ibgy
	 fBmv1I3Wzr+lUpEPNRdQp+Cz6HfAL8ZAuwCFhjrhLk+S5XA+FWXDlhtHbfkh2XGauG
	 5OmJEiHKOUNWYYke88nVE+Ye35NNwy/PERGgNCyyNIFDG/bP/6h7UNz/pgf6vO6LeB
	 2IA9CIpqzW+Mg==
Date: Fri, 19 Dec 2025 14:28:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: derek.fang@realtek.com, krzk+dt@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
	conor+dt@kernel.org, perex@perex.cz, flove@realtek.com,
	jack.yu@realtek.com, shumingf@realtek.com,
	cezary.rojewski@intel.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH v10 2/3] ASoC: dt-bindings: realtek,rt5575: add support
 for ALC5575
Message-ID: <176617612625.3881717.16468499127318005797.robh@kernel.org>
References: <20251216071853.3929135-1-oder_chiou@realtek.com>
 <20251216071853.3929135-3-oder_chiou@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216071853.3929135-3-oder_chiou@realtek.com>


On Tue, 16 Dec 2025 15:18:52 +0800, Oder Chiou wrote:
> Audio codec with I2S, I2C and SPI.
> 
> Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
> ---
>  .../bindings/sound/realtek,rt5575.yaml        | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5575.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


