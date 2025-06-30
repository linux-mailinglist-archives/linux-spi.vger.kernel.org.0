Return-Path: <linux-spi+bounces-8908-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D755CAEDD41
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089253BADF0
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002CA286427;
	Mon, 30 Jun 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzwfDf6x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C51F8EFF
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287180; cv=none; b=fZzCR0JjYA0Ny9gzr8NoHxoTWTNL+4SzlzN5FpHB9AytmGyJCKkV7GhstTA0r3os116ZBCq2s76p03uZ5Rpg30WGy6YFpllkdCEbiBZfR1i+j+onKcLvo0cfzsIFPB+Q12WyJDc1oedhGtsGP6RU/CFMbU11D7/OG22Ml0yLGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287180; c=relaxed/simple;
	bh=cY++rBuw8hzX+SJM69eALxH2zbEjbPM86qSMkBQ7vho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=N4dSWLuWpT7W+ClJpDupJrIi6OaFZxljZ2ebwJPIcXUvkLog2rAyHFimH7XdBp1AvUH9uBl60VMLQdyGdNf8L5ZGz5b0VryS//GjLYm1VIq2EFP9gA7T8dbSj/HvkGFwVkKCUWtIMjU4k5spXiy+CQ+xFK/4L2FZh4bUJCZe7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzwfDf6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8A9C4CEE3;
	Mon, 30 Jun 2025 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287180;
	bh=cY++rBuw8hzX+SJM69eALxH2zbEjbPM86qSMkBQ7vho=;
	h=Subject:From:Date:To:From;
	b=uzwfDf6xpzKgXM17uPd0wF1BdIiHeJReQ4bcaIp+AzajWih3H/RuW29jC5BMY9Qa7
	 lZ59U/PFfDqeIt0COZxESCeq7/p/uxauzR7nXQY+ETTrupiJILwRH1/Z/xAKMIhHI/
	 HvDQG9qrmLiI/Gv/Wf6clJ5sqJddKbiQesAU8jK8rAprjfbBfLmgmSQNohFVrzNx9j
	 o2PsS5MGr8POs9hYXhPSuvyffxyRZJnEbn2+CoehDyEpLmALcw7iWcugoxUe4n4UhC
	 8cOTX/ngIeLm9mw69dUNcIvhO7fLVpIH4grqFWfgJd5AzP9zc1IHm+k/RJ7XLx9n7E
	 lgd2qeHaf5tiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3380383BA00;
	Mon, 30 Jun 2025 12:40:06 +0000 (UTC)
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
 <175128720520.3367578.14908573342530380739.git-patchwork-summary@kernel.org>
Date: Mon, 30 Jun 2025 12:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-qpic-snand: avoid memory corruption
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=973577
  Lore link: https://lore.kernel.org/r/20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com
    Patches: [v3,1/2] spi: spi-qpic-snand: reallocate BAM transactions
             [v3,2/2] mtd: nand: qpic_common: prevent out of bounds access of BAM arrays


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



