Return-Path: <linux-spi+bounces-3325-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177168FE55B
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 13:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901E1B237A8
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F359194C92;
	Thu,  6 Jun 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bekwKb8z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595791FAA;
	Thu,  6 Jun 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673443; cv=none; b=A4DrQ3cFrwY5fgiBl7SGUXEVp/JQcwLY8Q0SOmb+PwkUFiNNO0VDa9Hn00hAIfEE9o5XUIMRsO86UbS+a7tUbM7kZd3IcUG+izcMU4wEoakmP7GQskE/1P0ptVBAF9dlVaxucMglv5r4J3rDcvsJoq2Jq3g1ncZqMXNOErrknow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673443; c=relaxed/simple;
	bh=0rkDd8mVoj1gvTm4BM8F/12A2+SY1O0XgQZkI7uUmv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lL8qh/tQ/CHpiiV2UF9+OfMih5Ov95BMjrWAKrxrSEu5eE1TUObbbAmvk5qxUcS/ZmIZFKZSLQEzf+bBSllm/VaxQuHdBo/Z9Qy9c/71T1Tl8yn17CzHmERbewZqbvLs6sQm3urVWwzVeqrJCdkbgdceWqa2FPoNoKJxOMu5xOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bekwKb8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4ECC4AF07;
	Thu,  6 Jun 2024 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717673442;
	bh=0rkDd8mVoj1gvTm4BM8F/12A2+SY1O0XgQZkI7uUmv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bekwKb8zgJt4oxDeTej6tAgPbCh9AJJeCVlmTJK9tQYirUflVmw4eBbPj3DGw9DPh
	 /v8zhWPFBuqaslcpDz14RgwbUS8ny5/rWHybGjYMjZP03pky8d2WZHPLlSfRSngZng
	 vJFDnpszRtnTxPQrbL6k0yNapq0d6eDD7Rj0CpFBfjOZGej9nco5EgpN61iIsDp8BK
	 yxByRdI3qIM47ADW73zvYkYU5sI6W5cPz3UC5t3cf5tTZSafrZN802mslPprWzrb7D
	 jleZO8We5qLcwhKuXp29WcjKbefoKyQ3TqH1uO4aVVxoodxsYTM/nsbF1oe/k/3Vk7
	 neM7v/p5esSfQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Kurbanov <mmkurbanov@sberdevices.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-v1-1-380f29ba4a16@linaro.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-v1-1-380f29ba4a16@linaro.org>
Subject: Re: [PATCH] dt-bindings: spi: amlogic,a1-spifc: add missing
 power-domains
Message-Id: <171767344096.946998.3741235965670333447.b4-ty@kernel.org>
Date: Thu, 06 Jun 2024 12:30:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 05 Jun 2024 11:37:45 +0200, Neil Armstrong wrote:
> On the Amlogic A1, the SPI FC controller can require a power-domain to
> operate, add it as optional.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: amlogic,a1-spifc: add missing power-domains
      commit: 3b0d6a32115c88618794406123ef8466f0327898

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


