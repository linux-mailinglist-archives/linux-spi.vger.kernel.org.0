Return-Path: <linux-spi+bounces-2410-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3257D8A84A0
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 15:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2099B287A0
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3681411DA;
	Wed, 17 Apr 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfMBHhlA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0D1411CC;
	Wed, 17 Apr 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360522; cv=none; b=tnDFfd1mnoNuhwcB9AFqDO4ZVIjDDzTyg3cPhMdbfDMBpY49IT+B2WkpjjCcvZQ4//yZGjhBY4qgGxart+B9fIYjP7PJw05fweks2zvb39UKLGCqdfUHZKTSGdEtYuzBcYD+rMpYISmhxhvVAw2CFCfAaFRHbq18tCZrasyCThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360522; c=relaxed/simple;
	bh=lqa4Juxf0WEfUGXrAzHfnxrI0oFVoAKGZcOv04ym5QM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nRa0HvfnEB4R4CEebi8ncPOKlFzsqQ2V7twA5iS4IUMEPLZrY7ofQp1AVcxh4YuaPPsy9vztNX8x3AfzUEFnZnMeCcz7RF9u/OY3jmtGM3mXg/WawBUYXLwA/4CQwOglFQTBXqAOLABKWKod1XqQhB7Jn7xbPaVvKozJCbRd1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfMBHhlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D145C072AA;
	Wed, 17 Apr 2024 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713360521;
	bh=lqa4Juxf0WEfUGXrAzHfnxrI0oFVoAKGZcOv04ym5QM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RfMBHhlAwhaPav6Uml+GXDYvv5KFLB/HI4W2ZJVwARdmN++jQIFqkch7arcjVokOg
	 uBz+3DUIYznrZALSLp9llVz/frSy6WYmlT+YfkbYW7K7kFpx//47loo6WELzfh7oxn
	 CYC0GqC/RUUOHJLFgQExOt0O2p/F5a1AFK2vOIgLxf9QXVfXn7kTJCeKBtLYhDpZPW
	 1pss//6fKWW+77RYHM9DA9l0vqARJnVfcEvpPg/nsZQmGN/aOk815aqTcaGhoLl+p1
	 Gu+fwGaNxVMQiaymCKQh3wJAw1tRenzKx3qit7y+chtzewWsMHY2dxOssK6j+kC/e5
	 kzaCD6vV/CYOA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <68a4d8ad8638c1133e21d0eef87e8982ddea3dd8.1713279687.git.geert+renesas@glider.be>
References: <68a4d8ad8638c1133e21d0eef87e8982ddea3dd8.1713279687.git.geert+renesas@glider.be>
Subject: Re: [PATCH dt-bindings] spi: renesas,sh-msiof: Add r8a779h0
 support
Message-Id: <171336052029.1701161.15301025990181660561.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 22:28:40 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 16 Apr 2024 17:11:48 +0200, Geert Uytterhoeven wrote:
> Document support for the Clock-Synchronized Serial Interface with FIFO
> (MSIOF) in the Renesas R-Car V4M (R8A779H0) SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: renesas,sh-msiof: Add r8a779h0 support
      commit: 1f48cbd6f00f2d1442ac8757ae8c32b672073927

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


