Return-Path: <linux-spi+bounces-8386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F5AD1B7A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 12:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6362B16B0FD
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E69C254848;
	Mon,  9 Jun 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="X3aQk6g9"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AF253954;
	Mon,  9 Jun 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749464623; cv=none; b=FWJe3QiXx/OFCfPhx1G/yp9f7Hhc7qKce0I+DQ0rAINo4JUIbxZJR3LahaA6w7ESXViWlcHQsrXXY+M1C2XZbs9dYUD+/qjfdcwqSLaeddtSjBVDJPdcHpyZISLJWUl7GfJT4qzz/IqpR/KzljrNr6ZsNha+bc018Gl78Nas7Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749464623; c=relaxed/simple;
	bh=QLKevxjgpLuMuZS/j47Bya3QvOELVxCtvO5e5Jg3Cf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7Hge/JjU7HHpcM7PixguvdAxupTygn1M709SBt3RCwUQzCa3c625q/D1xTDoctbzJMnxfqBmDpIl18veAjtZ3SpWQt/GpJ611q4IpI/hVRxl4VdNdSmqpNXCTXBLXC5qXXo8wgb1S94Crh03auUxX4W/03/IMveClAq6WvoGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=X3aQk6g9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=daOC+vKgljGGAi24/WQBuWAe1UD9I//0tA3pjxmN7ro=; b=X3aQk6g97/OfFKGH+TrgrKp7+9
	XphR7NRaWmB8Ir2rLPm9OgPt5xHBAz7e/yweXDZq0rU3NJEzCvMXzq0QUa3N4tTM0gTJutwAm4Hw8
	ZZyxTLkzjfuFQWVDl/zx7qxMvhIIv7PzL2ChCmmEx80YEaHj8pL+QAIyK71dpHGGdQjEo94vLUJ+v
	IXjWyW3fsIQSVPwGdBj5Lwzca1kOCT1gtKV7uXr3M93azRn8U97uqWU4qhEdd+UNErDvz+YeoekI8
	JJkSbAeQhifiOPtGDVjndTyaOwZOiS1L5VIHLkRDXy6GCa9DEUGjKz9w7l+e6M8Mw+lW+jLAtu/dK
	XUHRhAFg==;
Received: from i53875b1c.versanet.de ([83.135.91.28] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uOZfB-0006Av-AU; Mon, 09 Jun 2025 12:23:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: dts: rockchip: Add spi nodes for RK3528
Date: Mon,  9 Jun 2025 12:22:56 +0200
Message-ID: <174946455541.762051.5287964403437718499.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
References: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 20 May 2025 18:01:00 +0800, Chukun Pan wrote:
> There are 2 SPI controllers on the RK3528 SoC, describe it.
> Tested using st7789v chip with spi-cpha and spi-cpol properties.
> 
> [   10.831306] fb_st7789v spi0.0: fbtft_property_value: buswidth = 8
> [   11.042915] graphics fb0: fb_st7789v frame buffer, 240x320, 150 KiB
>  video memory, 4 KiB buffer memory, fps=20, spi0.0 at 15 MHz
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: Add spi nodes for RK3528
      commit: 2783335329e5762deb0dc5b6d634225d8613af16

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

