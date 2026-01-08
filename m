Return-Path: <linux-spi+bounces-12209-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9190D02D70
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 14:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EE393001FE3
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974A38E5D7;
	Thu,  8 Jan 2026 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOqzq6Pn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286A3A35C7;
	Thu,  8 Jan 2026 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870143; cv=none; b=IbG+JDNGk/DO2Kttd7WD741LovBRWcXy7RJ99yHCjbeLmpSe4yoigJ+V4BsKaSKaRs5ZgHE6k24u92SMSaoz2Yeca0NytCkuZiE0IIj8nOQHv2Zie2jynXAAP4tRlGeVsEO2tXey7f8S85bHc/g59qYAZ7R+w9+rSKJlvBnY2oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870143; c=relaxed/simple;
	bh=j+m4pmahMPKTeJHv084pK40Ng7vT7Xd+DmVBZhi+jYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LlEEm9mN0YuSlzFg8pFa6VnXt16IECg26ybJkwXkY7PvXi0qGK5J4FpgEPR6JNPp97dgT9ve/bymTwRIBtzYZvn049XsvxkwTgYENqpuwQeZb6hdhtnsPdpKhXva+OJr3C+NYCTwrpCgkYJlAq5OOJ7cP7DI8CAjvhOcHq4Vaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOqzq6Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAE4C116C6;
	Thu,  8 Jan 2026 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767870142;
	bh=j+m4pmahMPKTeJHv084pK40Ng7vT7Xd+DmVBZhi+jYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YOqzq6PnaT+cDFCwGsvnUPhhsiojSFyGw7S2cWyEgMv8hiZvJN2YzGX614CbeH8SK
	 4rvAMSCrFig2CvVI/OrqXwt0SyrsldGYnESbFifm6AOyHeiIabeVk0YfdjwTrVISos
	 i8Rs0dOQi4IQlPvBiWvig1L+3x6/Umj/CLhQVDKCBk8n2xvgYisSJj2JbwsmjjQHGF
	 o5fbJx6bXOGYxKCQ3tAUTlma9mk3aeNSKYHP7mr+Z7/mDYi6iggm0qUywwQCfLPdDj
	 IeEXrKpO24+QrPdyrObWALgAI5cHneSUTWie5XZmD7RBRhVIydCrcE7CQ+OOyijFhR
	 ydnfGIsjnTREA==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Steffen Trumtrar <kernel@pengutronix.de>, Pavel Machek <pavel@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20251201-v6-14-topic-ti-lp5860-v6-0-be9a21218157@pengutronix.de>
References: <20251201-v6-14-topic-ti-lp5860-v6-0-be9a21218157@pengutronix.de>
Subject: Re: [PATCH v6 0/2] LED: Add basic LP5860 LED matrix driver
Message-Id: <176787013936.860906.10157564091923679409.b4-ty@kernel.org>
Date: Thu, 08 Jan 2026 11:02:19 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Mon, 01 Dec 2025 12:19:46 +0100, Steffen Trumtrar wrote:
> The lp5860 is a LED matrix driver with 18 constant current sinks and 11
> scan switches which allows controlling up to 196 LED dots.
> 
> This series adds just the basic support for the device on the SPI bus.
> It is also possible to use it on I2C. The interface can be
> switched/selected via an interface select pin.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: leds: add lp5860 LED controller
      commit: 393d56d437c65e4619cadab9f2347167cde99906
[2/2] leds: add support for TI LP5860 LED driver chip
      commit: 97ee55eb5d33f6b0d2d72954a8ce8a61c15893c8

--
Lee Jones [李琼斯]


