Return-Path: <linux-spi+bounces-9305-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA3B1C730
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F8A1893937
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D522F767;
	Wed,  6 Aug 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNn7jJ2b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170D218ACA
	for <linux-spi@vger.kernel.org>; Wed,  6 Aug 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488791; cv=none; b=A1QqbrIheOkMgp0CJBWExfdCRkRSCPM8uX8WzNDYXcpyMFNF8+Mk7WbNmv5p+XPgRziPGE6waaV4FJJRxyrVTa9znl14ZZT39HApi+SpvXnCApXYrwNH624U0JxeP6fFm7oUx2sZHI3YhRbQcQBDswfafU7e3d7RoGAAB7PWNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488791; c=relaxed/simple;
	bh=pgjvJcDOuiq6B1BFkPaK7TcsDM+HiAokW3I6BEae3yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Xy5fp0T8xYXigLxge+nMIVTe98Mipy1NZk2GuWk0m/92AjJG2ev8CT6dCloHa5aIPKPFlix+HWM67scYtB4TzJXcFYopWY6PvkC9gtLIeXkrSXAQqAIR6s3j3abQ9SdBM1G1Tar2U5A6U8jtwNGi5f2dTnhT6EiHmX5tpUymMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNn7jJ2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3BEC4CEEB;
	Wed,  6 Aug 2025 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754488791;
	bh=pgjvJcDOuiq6B1BFkPaK7TcsDM+HiAokW3I6BEae3yc=;
	h=Subject:From:Date:To:From;
	b=DNn7jJ2bVqkqo4vG27Hd8kwLTt9uDoaDsqFasLmQQqAqgkgJoNH1Ec9JRUpHKvzX5
	 +6Vb8YbUHq6Cf4P9PYUr2EfXuVTbiwjhCw1n1YeEZ4hysk4MHc/XUw8eu0XbFxcyrp
	 5qU4/MflyTCj3oO0GJ3if2DR6SjSPdLKQnW50awcdjswqIv7ix1cfxDqUH68FJa51C
	 Q0yBnWCg5Jb2jdy/1Cvb/wNFeibF0QQipNEIoYDdX2azZ9SOZZQuoT4cd4qvz2i5Xb
	 Y1H7iKfiCOA5ZmLBFenEOjhjDJIBFnYwTtLa7UsqmyKMgojQ/CVF8e9CwQ6GIbegWO
	 wge+jcoMHQUOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37AA0383BF63;
	Wed,  6 Aug 2025 14:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175448880481.2801181.13291265627684462945.git-patchwork-summary@kernel.org>
Date: Wed, 06 Aug 2025 14:00:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-mem: add spi_mem_adjust_op_freq() in spi_mem_supports_op()
  Submitter: Tianyu Xu <xtydtc@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=988295
  Lore link: https://lore.kernel.org/r/20250805015403.43928-1-tianyxu@cisco.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



