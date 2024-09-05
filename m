Return-Path: <linux-spi+bounces-4693-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F196E54E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 23:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07F11C22BC6
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771D1B2538;
	Thu,  5 Sep 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtJJjh4c"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C81B252E;
	Thu,  5 Sep 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573088; cv=none; b=qs0jf17YpaMP+zrF+pe9ds6CAzxRbRdRq0KnrOXgn6PcaHF/3MxDxSQrDychjU5JtQ5DUlWx5hD5ESxrGrBriPhiRWeeBSQHy2/l/11Mv7T9AZSB0RgrgC/A4HHrOWfenUsRHkA5BjdYIE1nrWgGwX12FLpMmiCWSrFkD+FKagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573088; c=relaxed/simple;
	bh=SD/SEcrCwUNTY3FOK1aucqG3fxDWUGgFv8tlzqnnDqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DN/KfwxrslIBGPTYTwgIdg4ZFp51jkKCnnM9UubS+j6FEgWAHmMe+ToscC5WYjFH6FwfHSsHXuMa4rCHOy5lCPxWSXawH2pqjGFtewkTjlvfiN6n71AeqH16HlC8vKOBANQOerHTtZOHJt3o/9Yyjpm11XMIaSQWm4oDUDsJxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtJJjh4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A454AC4CEC9;
	Thu,  5 Sep 2024 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725573088;
	bh=SD/SEcrCwUNTY3FOK1aucqG3fxDWUGgFv8tlzqnnDqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TtJJjh4czJPVF8rlfjDSmCyhWAo88yeQrkSB+AigoBf6Q+5mH6kqpAYJlO9MP359i
	 9DIlS5ARR8cNOrDKydTNmm9ol3zrHHny53IMfNm1I7+0WLUKoykaL4onAOFUSYqlnu
	 RtYs2p3eSalE5aHV/thS8aJuKAtZBwFnYxIgozDnPr+dapEw2zx9wXYVAHdaYeBRxm
	 YTOa4SVVzy0q2wV0nkLoCNgxtSOKhAPi5sp+7mpfXHBzVufKivNBkOKZ35g26jIZCI
	 L3w1tA5SXwK32CPhSAR8moxP8tmw05rmctBR2fOQYZQzFUF28sYi59rzkVRmglmNNu
	 JC28V8iyf3f5g==
From: Mark Brown <broonie@kernel.org>
To: wahrenst@gmx.net, Frank Li <Frank.Li@nxp.com>
Cc: carlos.song@nxp.com, festevam@gmail.com, imx@lists.linux.dev, 
 kernel@pengutronix.de, linux-spi@vger.kernel.org, s.hauer@pengutronix.de, 
 shawnguo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240905155230.1901787-1-Frank.Li@nxp.com>
References: <20240905155230.1901787-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: SPI: Add mailing list
 imx@lists.linux.dev for nxp spi drivers
Message-Id: <172557308640.131770.14736792145544159830.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 22:51:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 05 Sep 2024 11:52:30 -0400, Frank Li wrote:
> Add mailing list imx@lists.linux.dev for nxp spi drivers(qspi, fspi and
> dspi).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: SPI: Add mailing list imx@lists.linux.dev for nxp spi drivers
      commit: c9ca76e8239810ccb08825a7b847c39d367410a6

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


