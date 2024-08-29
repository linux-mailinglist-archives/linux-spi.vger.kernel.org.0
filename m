Return-Path: <linux-spi+bounces-4440-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27A964CF8
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C781F212A6
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306A1B78FD;
	Thu, 29 Aug 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox9zYybu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4A1B655A;
	Thu, 29 Aug 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953129; cv=none; b=mjrb8j5QavZWxsb9IGgZDwdfKwYDq3dycgkmNYP7WlhGBRQ86OadeHeGF4rP7iL1YkQhY1tHn4gUPUb58W0lBy3sOPNABwYKD/ht7ZvslHojcBub8uNgS/2mMmvacw7jFI4BzT0zpg7fGdk67FrHzsg8YkSNN/lrEJHF5q0ZUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953129; c=relaxed/simple;
	bh=D6cDh90LvNxf2g/ZFxNXrnlEDOCi510qk2oefT4tUlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c9mIgcOecOwej/xW9kXumpVBA8EJX8VPS4lx1QuUkVzYOjQZnYRMQHUrtY3PFlburxIFgRHVm9otBzikAzVDqujoGUlhoAGi3DH2IecrDGFHckI721So7X7GI1Amz3MJzTb/b+P+WtC7r8A49UZA7p21F//0lJXN2Yc3eJR/Y4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox9zYybu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC66C4CEC1;
	Thu, 29 Aug 2024 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953129;
	bh=D6cDh90LvNxf2g/ZFxNXrnlEDOCi510qk2oefT4tUlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ox9zYybuzoAQDETjydmdnbCF6KZE/oMU7yZ1YiYjAEB13/ZihsieiDHc599ltyt/R
	 Ia46hSmOyyrN4+pr8kbDweZ5ZgJ6oK7l4YTsFWrsQYi0c8pMz7kzNvnwgu5oPCc1aq
	 tpubr/J8c068F0OD0YLWWAMqOW4ED5wLGxLDjSKbhLDD2Cv+s7Y8RyfaHGkibuMNUB
	 +i8yLNbJE1e2oIagYHNQ9oElwiEc0F08Euc3wwpOTvaDSnfle7Pca2VzwlQ4caPYte
	 QGphuAXQsR6Qn0NLrMq7uQNVHDnTTB/yKnsbw7s821ysvAFGfhsBUMGMhymeiyWLWv
	 uaIhNxGRDvyaA==
From: Mark Brown <broonie@kernel.org>
To: han.xu@nxp.com, haibo.chen@nxp.com, Yan Zhen <yanzhen@vivo.com>
Cc: yogeshgaur.83@gmail.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
In-Reply-To: <20240827131203.3918516-1-yanzhen@vivo.com>
References: <20240827131203.3918516-1-yanzhen@vivo.com>
Subject: Re: [PATCH v2] spi: nxp-fspi: Use max macro
Message-Id: <172495312750.812311.6155936564254648481.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 18:38:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 27 Aug 2024 21:12:03 +0800, Yan Zhen wrote:
> When the original file is guaranteed to contain the minmax.h header file
> and compile correctly, using the real macro is usually
> more intuitive and readable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: Use max macro
      commit: 3959d1f0f8d6682aa896a8f78a9f5ebfd2b6f6c8

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


