Return-Path: <linux-spi+bounces-196-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D97E80BD57
	for <lists+linux-spi@lfdr.de>; Sun, 10 Dec 2023 22:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2801C20311
	for <lists+linux-spi@lfdr.de>; Sun, 10 Dec 2023 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846181CABF;
	Sun, 10 Dec 2023 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuPeNWBD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EC1944F
	for <linux-spi@vger.kernel.org>; Sun, 10 Dec 2023 21:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D61EAC433C8;
	Sun, 10 Dec 2023 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702243231;
	bh=yO1xiYle8lmW9nEwnVgfEyrp/7nebCFSpFWWLA1OZNs=;
	h=Subject:From:Date:To:From;
	b=SuPeNWBDUcXTzKPy4tobznxx2sb9Uqhqrmw2pEfFgf3OhVTgZQHdz9MAZVbg4+shG
	 WQh9+Glavzk5BNP5lhdEb1vqjPYymfvnzVo22OX2arhgGqygpBSr+gYcb/tCxIJ4Jx
	 9ofC2AeuD/i5Y+JKX9T93IFs89EIpp68rs4yG8l1TjRijsatMeRJT4jNeCvtynKGSu
	 ernhvbauVXYIlqbYg66rob0v2ebvTZO5zERfuIZy/CpDO6SR48J205X4XX0t22igoS
	 pappvvno8l2JweRQj7Eo7GYCdzu/HzyaEqKAu8g3/Qkfu0qOraTSUlaeGh77u+FgoL
	 JLCTVD9bzoBGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1539C04E32;
	Sun, 10 Dec 2023 21:20:31 +0000 (UTC)
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
 <170224323167.25171.2055211651517504591.git-patchwork-summary@kernel.org>
Date: Sun, 10 Dec 2023 21:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-imx: correctly configure burst length when using dma
  Submitter: Benjamin Bigler <benjamin@bigler.one>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=808501
  Lore link: https://lore.kernel.org/r/20231209222338.5564-1-benjamin@bigler.one


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



