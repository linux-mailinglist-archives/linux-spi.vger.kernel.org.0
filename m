Return-Path: <linux-spi+bounces-4441-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3CB964D00
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 19:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422A91F2152C
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17621B29C0;
	Thu, 29 Aug 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv6PWUsI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C81B1D61
	for <linux-spi@vger.kernel.org>; Thu, 29 Aug 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953226; cv=none; b=GiVgU5XX791WB6/IzKBuaLlup4bYdfdQCXNBZqSgcY2z3sxAyTcp7i6vZsUtkRGtPjXW+l33zwTjD/QEzm/+a5Y+U9S45UX1HmpDPEA0+C9+o/L+VlP50+yeL0WaD51/EwEHtzKH6fxgJ9+bBm/Y+C46iaQuL2B+/vDCtXJwuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953226; c=relaxed/simple;
	bh=QvxBu0sJJSWTxtbr3IktDJcegYmU1/3zjwl17rZHL7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aTr/isdbSDQvswqikhMtfWg8kmdtNnOFw5OVMCyCms3Ngr/s+gVtqD4PCcrExjUmexFdtlG2AY3ykUby1CPHPYOOURCQE8AkXzAM1xd9e/5zPuyxaow3yuROrXSnQFRN6hXRuiMmNYLJOpOyye7cuV66z3cnhXXmIH5Ujh6Tloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv6PWUsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB6CC4CEC1;
	Thu, 29 Aug 2024 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953226;
	bh=QvxBu0sJJSWTxtbr3IktDJcegYmU1/3zjwl17rZHL7Y=;
	h=Subject:From:Date:To:From;
	b=Kv6PWUsI2NZs6gBTOq+GBiLziN894kb83TV3MV6xK5CXW/A/rwvimGX3xMAHPAl/8
	 EPfH4xgfiyAgVZnUbgEGFcfqzZqpCzzDNCO8Kx8/6PdhR5jYxsblPExdF8akcq/pT/
	 oa3PmitIST2PnAVj0Tm+27rUbc3QOz+Lss0VAoUDTlL0IRrbU+w0AUay811zzM/hO/
	 Xq4girB7gGaEUOv4udS5OMoblC2dVQz2dFM1t45i785LwWYHkZHhga3obA5KzZ6MBE
	 FxTwYkCNvBvv2FXY0zQMYl7qQr8IX05bHu4fVpfCClzGidlzMl8kFb42h8M1N9r42D
	 aMBhwavPrKzAw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D1B243805D82;
	Thu, 29 Aug 2024 17:40:27 +0000 (UTC)
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
 <172495322779.2031773.6134179445995282688.git-patchwork-summary@kernel.org>
Date: Thu, 29 Aug 2024 17:40:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] drivers: spi: Insert the missing pci_dev_put()before return
  Submitter: Yang Ruibin <11162571@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=884534
  Lore link: https://lore.kernel.org/r/20240829033511.1917015-1-11162571@vivo.com

Series: [v4,1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
  Submitter: Fabio Estevam <festevam@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=884719
  Lore link: https://lore.kernel.org/r/20240829113158.3324928-1-festevam@gmail.com
    Patches: [v4,1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01

Patch: [v2] spi: nxp-fspi: Use max macro
  Submitter: Yan Zhen <yanzhen@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=883819
  Lore link: https://lore.kernel.org/r/20240827131203.3918516-1-yanzhen@vivo.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



