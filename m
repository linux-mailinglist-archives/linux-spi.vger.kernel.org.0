Return-Path: <linux-spi+bounces-279-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04F8131CB
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 14:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5331C20C5C
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9156B61;
	Thu, 14 Dec 2023 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J82Tmq9s"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D034B5A3
	for <linux-spi@vger.kernel.org>; Thu, 14 Dec 2023 13:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB5E8C433C7;
	Thu, 14 Dec 2023 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702561225;
	bh=3YgZqe+NSg4mZcABZT0InaL2XwvnJKbZVYoLXg9VvEA=;
	h=Subject:From:Date:To:From;
	b=J82Tmq9s0QfDWpq4UMnwl+8w/RbeTnlT/rxv/Mdm0e2KjZFWK8a0Hc5Xt7Ii9dOxG
	 1XPQn5/xbZV6n5Gaw24R3qe7dqdMEsCIUzCckCi8qsX2bqntfl4WZ3S0YJXqAILNTV
	 hltGCOiSKDiHXoUGYVvA/iGukoIZDEtQNyt6kCE6Mh34goyMwt3b2ipVEmdn/86EoP
	 esKTWSHrH76Qh9n39qwIJb6LvRW7lq3nHWOlX8B7Lo6bItltlip6GV4hOMlPviXgZa
	 oL9ZyHWsuIyw9A6AsKCs44Em796Gc/RMRyu8oew7P8rUsbMAFnes6mGH0ZKllZX6Fy
	 C9ettaUUcdGpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88053DD4EFA;
	Thu, 14 Dec 2023 13:40:25 +0000 (UTC)
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
 <170256122550.3747.12914533089593764822.git-patchwork-summary@kernel.org>
Date: Thu, 14 Dec 2023 13:40:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atmel: Fix clock issue when using devices with different polarities
  Submitter: Louis Chauvet <louis.chauvet@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=806692
  Lore link: https://lore.kernel.org/r/20231204154903.11607-1-louis.chauvet@bootlin.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



