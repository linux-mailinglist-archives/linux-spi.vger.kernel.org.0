Return-Path: <linux-spi+bounces-3587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E70917093
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230FB1C24197
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A45176ADA;
	Tue, 25 Jun 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZqldWNg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575816B72D
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341431; cv=none; b=o7yehnRhXVoIlBhT+jiWjfP8cPAJmSazLFbsX9YGCkLWBgsqhqc6wAgeDzBDN2OaxEMcRv90dpBatmhRPVAPansrSV4wLvPG3+UX7iur+o7Lw2peg7GwjZ6qTMEb62+CByTNRV/76NBq7KZfg8N88GgR1JyRTu2UOO2lAbcQCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341431; c=relaxed/simple;
	bh=1ZtFUmmXRAOWjpJKJnE/77rhtcwqLeqoQRiYGo1XAoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VFU1pKzFd0ZEzD0vG3SrkRdjZw0QgrG8MW5J+Zk/XksilH0bSXkKOXWrmuon3459rXkl8iPq2ZgG0qsUFYvFwCTnScEyrtxePkpY9kiFcN19Cxi219gr/ln4ex1L0MlWfZ09c1QONotNt0UI50GPon7mpFowQofU8nfiIllUiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZqldWNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F8D9C32781;
	Tue, 25 Jun 2024 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719341431;
	bh=1ZtFUmmXRAOWjpJKJnE/77rhtcwqLeqoQRiYGo1XAoI=;
	h=Subject:From:Date:To:From;
	b=oZqldWNgE0zL4yuYKJ4KBDoRZsr2BAnyWuUnMCYxj74mklUmH0kJ7K04GwI7KeMaW
	 xGdKjHjcFiB5vmC6utN9iJcEIRaYwCDzixWuh8IWKqFc4XIPNhpQWrWmqnocZ7eVrJ
	 q8zBwwF2zCA5rFdCml32p+IQemj0YgBPQn/Cw/OPxXtYdwqKOktZSCPbDI5onkcsEu
	 q41SMNTpr9bQvWaoVPqRaARhRbogb+NQFPHyyjKlGDX2tTGy+JMse50HwyEziKM54S
	 ENa+1C1poJmEffd3k50p8zPSnKRGELC4D4eev4zBHbVI21yuFEVUBIXl8jqm53JS/+
	 ZkU1jwNGYjwcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2072CC41677;
	Tue, 25 Jun 2024 18:50:31 +0000 (UTC)
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
 <171934143105.5441.1450354962626107195.git-patchwork-summary@kernel.org>
Date: Tue, 25 Jun 2024 18:50:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: add devm_spi_optimize_message() helper
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=865059
  Lore link: https://lore.kernel.org/r/20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com
    Patches: [v3,1/2] spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



