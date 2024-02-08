Return-Path: <linux-spi+bounces-1217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2384E526
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 17:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A9328C324
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9E7FBB0;
	Thu,  8 Feb 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzIpCb+N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEC7FBAF
	for <linux-spi@vger.kernel.org>; Thu,  8 Feb 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410429; cv=none; b=hbqEgkmr5/pexMjryZKG5ndQZlDqCbimtADxT0Ul+raJZJKPMscg+uQ7yt3c3L8Qm9pkKK2GXHOZOTR0zPYHzqfQQyCemXKDPQGgjrdlHetsidIvlr8Wa8VCNU7xJeHne8e/0p8GdFveOZC9sX9fk1eiXQ0/NDHDNflOHjv0zT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410429; c=relaxed/simple;
	bh=3gtHaOXHFtc2RidUHLmYcwb9jZkdzdby1/9zVBCWYHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Gt3BFhJomf/rrtFUqH4pE93kbZ1DC5hY+G8UWCi/e9K/ldHUCUMl/Egrk97tQkIDfh+xpHdZbgiYkPNoFO0HvlUoqxskeCAEYgxSWnVBVCqOFEjZ70lxh6Ayt7nr02Lm1Nl1noVpWXj9BzOoVerB8F/DPACAUnbTx2cFiAqJKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzIpCb+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 387DCC433C7;
	Thu,  8 Feb 2024 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707410428;
	bh=3gtHaOXHFtc2RidUHLmYcwb9jZkdzdby1/9zVBCWYHE=;
	h=Subject:From:Date:To:From;
	b=QzIpCb+Nsq7XnYlnVJqdajzhmeenvopldnJfot9qcYojf7MdVk4N5F2yRV5ukXZXj
	 A2KP/GrqmspUbqcT2npHz/D9XrpQnBR1UmhpZ0YVJ1UjMZv3KlGpCNMSx7srf40/GC
	 6I7t6qDqv+uKxfXtapPrg0p8KBHDO9wpI6ueEjRQMDmDTAIbVWW8a1xpnU+v6kBSlk
	 RsCvTPmNShey9Zvue0h4e6doxMeRLgnfB6MT7c84DW9L/M+ejQKTn/XXDSmvcbADee
	 SZzsOw0MjR80bU+M1DFQjzfHhuQ5lgBkV/XJVJuJjr81EkFmzRvOiiQI+oN3JPl4PB
	 2nECLgpg+GjQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13BA0E2F2F0;
	Thu,  8 Feb 2024 16:40:28 +0000 (UTC)
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
 <170741042799.6856.17611960976103479027.git-patchwork-summary@kernel.org>
Date: Thu, 08 Feb 2024 16:40:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: axi-spi-engine: performance improvements
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=823991
  Lore link: https://lore.kernel.org/r/20240207-axi-spi-engine-round-2-1-v2-0-40c0b4e85352@baylibre.com
    Patches: [v2,1/2] spi: axi-spi-engine: remove use of ida for sync id
             [v2,2/2] spi: axi-spi-engine: move msg finalization out of irq handler


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



