Return-Path: <linux-spi+bounces-1258-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C37A84FDF4
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 21:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AF2284B22
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5CFBF0;
	Fri,  9 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noEp5pwF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB06200D4
	for <linux-spi@vger.kernel.org>; Fri,  9 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511829; cv=none; b=DF2mzTZcQw+aRb+4VGKQwJEcdlcHbER1mFs73ChLDIWJb14rJaHSf/cajZIOZxD9XPeFYN4L1vDRXFc/we5QTH7Q46BIr0EVHLgkWRONgWPAVWFdLf54C3HkG+NCNZ0ju1/hDij3Mp12cSF6IUxnwvZFGc6WPFwP7vuoByHc6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511829; c=relaxed/simple;
	bh=6Vkbhyj3p4O7LLfhs64zWsiBM4rAvl4L5A19JedawKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qMEQBenQSch3Zr/uTIhMT0Vt1mg+zZoSwbEr/w2nZS0HSIOqn8DCFJg+lAom7du5AGLs9K74xy403YW7jcFojBq11OOj6B73gzuN75Yk9+d5RfaFp/43HcZCyuaXqahSxQ8UJ5cCSsvyPIfbCsMrXMxUTjZPrloGzwjJiw3GlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noEp5pwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B678C433F1;
	Fri,  9 Feb 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707511829;
	bh=6Vkbhyj3p4O7LLfhs64zWsiBM4rAvl4L5A19JedawKA=;
	h=Subject:From:Date:To:From;
	b=noEp5pwFyuyxouSGhUSqz01Wo1RE0hrAnDdIN18I4UDUbz5wTg5M/dLl6OPKnnaKa
	 UzIAUwQrSQ4RcHZ43Bxi1QMq+Qt8HF7ogMJ9T48twLwZMALP+8XTwk/GVjAjaDgfDJ
	 GY9fWHek5O1ixFu76lIRziZkKabCGBA/Y4tJvqSk2QYFmO3YoKzL6vjdxdM22LBgRv
	 bdSG/j+dU80Xe5SkHrgXXS+gbhD1+wpkhCNPXeWpU22Z1rVdrDMkNFdfZfAWUiwquk
	 aJGe7zfJjeQUHqv5FXUw1fwOFA85aCJ7ofkuBg2w11BmqXPXvAgY3XCTDG+dibZWKz
	 lqOjBZSN+fGQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0221E2F2FC;
	Fri,  9 Feb 2024 20:50:28 +0000 (UTC)
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
 <170751182885.4516.9581122308426947104.git-patchwork-summary@kernel.org>
Date: Fri, 09 Feb 2024 20:50:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1] spi: spi-ppc4xx: include missing platform_device.h
  Submitter: Christian Lamparter <chunkeey@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=824684
  Lore link: https://lore.kernel.org/r/3eb3f9c4407ba99d1cd275662081e46b9e839173.1707490664.git.chunkeey@gmail.com

Patch: [v1,1/1] spi: gpio: Follow renaming of SPI "master" to "controller"
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=824739
  Lore link: https://lore.kernel.org/r/20240209165423.2305493-1-andriy.shevchenko@linux.intel.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



