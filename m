Return-Path: <linux-spi+bounces-11177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00980C53D0F
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 18:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6233A9F3B
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8603B347FCA;
	Wed, 12 Nov 2025 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEv9ueNg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBA347BC1
	for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969835; cv=none; b=FritKvKnsoLR0npGavy78gam3cdLj3RqztX5Jq2BjScFa+Ie79XUz7wdHo88yCk38qKO/ELK5dIgLhP3IKLSnOBwa8t6cSUafn7suzFyY1J8BDfcLP7szjGF3IT5+WikJpCC4U9+SSN4sQIWNUoN9yD+v7Oh5CBpIboOu9ovjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969835; c=relaxed/simple;
	bh=7zc7rjA7YLRcDyDT7L6u7B/Y+9RscFWFD8U2KMYoCNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KEPZSKUhFIctxH8dwN0rD0d+8QZmE1g70cCuf2Yw/BPf4D7L0wyYXhcDLxEGTSWU8Z55SXO9Vweb6gR9Di8iXc2fvzsqIFEhCETpFUFHiK1Q+KRA5p0NC8Qira18gb1s1lk4i2r3XtExRFq/PitPXyxt3s8PBnWQ6gse3yDjeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEv9ueNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F206FC4CEF5;
	Wed, 12 Nov 2025 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762969835;
	bh=7zc7rjA7YLRcDyDT7L6u7B/Y+9RscFWFD8U2KMYoCNA=;
	h=Subject:From:Date:To:From;
	b=kEv9ueNgg5oFdhBi/yzW94TUrLIVlw8OQ+QO2VzK5xm4ku02U5Qrqd5wfXD0nW4F0
	 W9epqzWLwYRNmLtEx+9CAGw0OeeLNtwvVpzLQY0oyZhOyX24A0UBtqbG7L2Mex2AfL
	 rfxvRJtQTHsF0WDfGWKOTH4V54EhO4zAOJ6GiOwUcjZkMgd0fquTAbWQ6+bQdXmJuw
	 lzt5pwoHYceMilJiuzrWnsQeCcRITXZB55GfQC7I0/Ddlp4wXVGAwaKRXY6f08A549
	 eC5lHFSEdIe0yducISVeLG5lTRb/plRy5VCv9hflTMnNHkBMstGFyEDXw1nFe90Y0x
	 XgmjVlCt6z5JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1F9539EFA62;
	Wed, 12 Nov 2025 17:50:05 +0000 (UTC)
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
 <176296980416.100340.5545740088236393597.git-patchwork-summary@kernel.org>
Date: Wed, 12 Nov 2025 17:50:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: dt-bindings: nuvoton,npcm-pspi: Convert to DT schema
  Submitter: Tomer Maimon <tmaimon77@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1022552
  Lore link: https://lore.kernel.org/r/20251112150950.1680154-1-tmaimon77@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



