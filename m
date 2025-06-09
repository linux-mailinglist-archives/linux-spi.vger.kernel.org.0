Return-Path: <linux-spi+bounces-8394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B644DAD1F21
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9B6188DFB6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2213B25D8F5;
	Mon,  9 Jun 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOIO3sKZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1925D8E8;
	Mon,  9 Jun 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476452; cv=none; b=IrcgROtipVro4AbKv0w1LzkFSKndvpf3FJKNXMwsDi1bUgqTzDWN1KgscBs0Mlo+Q2w1Njj1nKd8pkKMnF66IBO76WQDuhd0iavJBwWl22mzUWL1W1QBlH3LgKFjbFKZVk/1JRiMTdx3JhMR9XZE88pKDYpkjjvJ1RTjb9TTsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476452; c=relaxed/simple;
	bh=rXM/olUNBsHBKpnIkVc27Lx2zncWkI8thqeMKGhAr5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QJRff71refMLCKpe1880srMF0HyNE6Cb1Pi7NGpI7h1W8k2k9FinIpW/QRhhRoKve7J4p7hSob/cehBhOXHoEYJhnOwUqCbnSsIO3UJO/6+yNoH7QqGcHCEwsYzkdp+fBm2SIivwEsDoNt8vf60EASHYjEuPl4uPGdlDvnbZhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOIO3sKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539B2C4CEEB;
	Mon,  9 Jun 2025 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476451;
	bh=rXM/olUNBsHBKpnIkVc27Lx2zncWkI8thqeMKGhAr5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oOIO3sKZ8EDwkvZ19jYrY47LqoxcJowUeozQHjrjcayEFKMmw/ip2H9UdWBBupt/i
	 GqSqO0qMAX54wpZpDL3OdiP/XSDu+vWnHEbl8nNEQFKg6/tJH/JHzgQ1yEHL72PbCv
	 0t9IzhKzvCG+FLPBG0L2voBBFrz0cToVlCemwMP5iOYEl/yDk4zVor5P9/ZDnZK9Kl
	 E0wIVQv1bxutDDKFliLvxW35VVMv6NUUPYUOtwqtqvDcjZJdmNvUyCb3EO1V1yPydN
	 zT9LsW2ClWIHWxTqVlOhGajLLOuPOpCCAs6Rtnon5FthNWsu9SkIYW4QDgoz9+GKRN
	 TcRhI9ojmxf+Q==
From: Mark Brown <broonie@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
 Yinbo Zhu <zhuyinbo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20250608142939.172108-1-chenhuacai@loongson.cn>
References: <20250608142939.172108-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH] spi: loongson: Fix build warnings about export.h
Message-Id: <174947645007.127013.1393483830894525759.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 14:40:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Sun, 08 Jun 2025 22:29:39 +0800, Huacai Chen wrote:
> After commit a934a57a42f64a4 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=1") and 7d95680d64ac8e836c ("scripts/misc-check:
> check unnecessary #include <linux/export.h> when W=1"), we get some build
> warnings with W=1:
> 
> drivers/spi/spi-loongson-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: loongson: Fix build warnings about export.h
      commit: 1dd630088332b5b310f3dd7eaacae9f3c4465651

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


