Return-Path: <linux-spi+bounces-12098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69047CD9DAB
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22C130402FC
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F292517AF;
	Tue, 23 Dec 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdtdZydW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DB1494C2;
	Tue, 23 Dec 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766504882; cv=none; b=Tl0HR7Bgy4LpUxbc70vRULiTk8EvxNuYBncYkiGcb+4rIE818E0q5gpJ4H8lvyxr2GUgO2yq9gw0h/X+LXzJnJvvy27y+3iI212i3fSqzSHxBNMjNK9S832/OrN3UaEaVDXdIlhAj8Yuqzl+y/zJmuNWovLaGKAksm8ZI7UqC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766504882; c=relaxed/simple;
	bh=Mpr8HzWjcBxOU7Y5X3r2Q1rE7twn+RHWLYcnM80d8PI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AV/avvhGyqYvmb/DoDcE/1wlKOrHhrDePcjOd/OW3ZhuXnuu6kUPHWq9tjlnhGoBCiWutXVLFs1NF8gy6oWWNzE+uAjuNjFQZ2RcVWS0XmUJ3upY5Adm4JapYlwf2W3ByjrjWJL8b1Dl/NcyLRosU8VhDQAahb/uFn2+q3Cg7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdtdZydW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61763C113D0;
	Tue, 23 Dec 2025 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766504880;
	bh=Mpr8HzWjcBxOU7Y5X3r2Q1rE7twn+RHWLYcnM80d8PI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LdtdZydWjDykDcQ8MwZe/WYc0An3swcSu7m3Zz40XZiFB8j1F4Wa377ckpn+gsy1C
	 ld6XRBrr8TSgd0fLgqKOwAa2wNKWLwls2oxMe7aQDBIUxpP42n2Ciez4QmAp5ec30+
	 Cx4SBhT8gYD19wllqRw2tb6WAxB3lmtIQ4UuKDdYBLlSOrwClin4W9k5J5eboUe6za
	 TzH8qCowUXAai2tJGcM/ibzrTTnbFfDN3pTY8CCsjLny1/I+ezR85wowEzXj/Q9ufS
	 c8v06YbiziWtwd0oCqeXcTqzDKoNFfw5HDHDjQ52LxhD8FIFiV7Z2ru7fTdbDepwIQ
	 5zbXhKz1wn9iw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 54A5F5F86B;
	Tue, 23 Dec 2025 23:47:57 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251221110513.1850535-1-wens@kernel.org>
References: <20251221110513.1850535-1-wens@kernel.org>
Subject: Re: (subset) [PATCH 0/4] arm64: allwinner: a523: Support SPI
 controllers
Message-Id: <176650487726.2524343.9774305641530243477.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:47:57 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sun, 21 Dec 2025 19:05:07 +0800, Chen-Yu Tsai wrote:
> This series adds support for the SPI controllers found in the Allwinner
> A523 SoC family. The SPI controller is almost the same as the ones in
> previous generations, except that it moved the "RX buffer count"
> register field to a separate register, and that register now reports
> the total count for RX buffer and FIFO.
> 
> In practice the driver has never cared about the buffer count, but if
> any implementation were to use it, this counts as a non-backward
> compatible change.
> 
> [...]

Applied to sunxi/dt-for-6.20 in local tree, thanks!

[3/4] arm64: dts: allwinner: sun55i: Add SPI controllers
      commit: 1bec3bd1f839f269dfdec3c635dd2afe15e30995
[4/4] arm64: dts: allwinner: t527: orangepi-4a: Enable SPI-NOR flash
      commit: bd14ba160bbe863e7b7bc489fd947ae1cdc03047

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


