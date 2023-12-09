Return-Path: <linux-spi+bounces-190-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A9B80B5BD
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDF11F21008
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577319444;
	Sat,  9 Dec 2023 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+1YhmGb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB646187C
	for <linux-spi@vger.kernel.org>; Sat,  9 Dec 2023 17:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7491C433C9;
	Sat,  9 Dec 2023 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702144347;
	bh=ONsFIGiWbHdnQS2adnSV1qao80egjbH8N4a7p9ZpSXw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Y+1YhmGbLVIzcDljpsL9WkWNmMe68Sjnge4N0E3K8O5FSCg0vB6ZkbVQTjaO64Q0z
	 MMc+TRICXeMDSUDCqu22YinDQB8IXhn+RC9myv3qDGV9VxFkekv/PYzfDeV5SYADpJ
	 qm3zBM4EzZKc4s/DtBKJ0oAhQaLK0Dqbe9u3PStXnqBbXzdm5TnztTVBC7B5+DffzR
	 YPBaygPNLZumZqxOx2CxkodYeMv9hlTZ/0mNhL3NLyk1XHTsKCCBkf5q1iNS411kL+
	 8SA13zK6gS/8zKQBT45hs1FuF7J+rlkfS7jC9ly7OPcqy3xttaOrTGyY8vhoLt6AGn
	 seWT/8zxL218Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
References: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/2] spi: pxa2xx: Update documentation
Message-Id: <170214434667.2928550.7302807797153128431.b4-ty@kernel.org>
Date: Sat, 09 Dec 2023 17:52:26 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 08 Dec 2023 19:02:53 +0200, Andy Shevchenko wrote:
> A couple of documentation updates.
> 
> Since v1:
> - spelled controller fully in patch 1
> - fixed inconsistent indentation in patch 2
> 
> Andy Shevchenko (2):
>   spi: pxa2xx: Use inclusive language
>   spi: pxa2xx: Update DMA mapping and using logic in the documentation
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: pxa2xx: Use inclusive language
      commit: c3aeaf2f0ec8af93189488bda3928a1ac7752388
[2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation
      commit: 8bc2a3634b87e2235535b5527f83ff529df68b56

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


