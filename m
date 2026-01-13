Return-Path: <linux-spi+bounces-12330-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4817D18876
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 12:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673FD300FFBE
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC41934A3C1;
	Tue, 13 Jan 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1oMX33g"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974B2BE620
	for <linux-spi@vger.kernel.org>; Tue, 13 Jan 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304612; cv=none; b=gyr7Zh/2o3DCPSWLCHK/gwni0D5MiKXYLYENPSsMEHqjhT62+4OEPqZUelrEjU5HQftl+kCRmxuKIRmP1Fr/Jgi09lQ3ukVH5fk2zUfXNK2FhLm7C5Addmk+ef1ZT+66UA9Y35GQYO4hC3MFq4T4x34LP0WHTMY/dR545hsd1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304612; c=relaxed/simple;
	bh=Kj+y2hmHujwRKg9IZ6u8heiLFDsl5DKkjJgGXtH6FUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZEpeDFim6JEKPr0gI9hhxo7E8rKDoZJcNXf4eGJwO8pZ6HeXdDl5/Q8sbMwpPA93DZyxo7vFse0FCKmb0TPTWva7PtbdACN0v+jZiUDim/Oh7QjbMyZEHq1F7YBuBeB68WI9uvI3v3al2x0PxVpAjqZIs/pY5G/8TSuNrvqQNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1oMX33g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669CAC116C6;
	Tue, 13 Jan 2026 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768304612;
	bh=Kj+y2hmHujwRKg9IZ6u8heiLFDsl5DKkjJgGXtH6FUA=;
	h=Subject:From:Date:To:From;
	b=n1oMX33geX9/Of68c1m6N7my9SBxgmumZJSTWUUP4sljXl2oiOrg/vITQcCKUPF2J
	 RYTKekOT06oai7pQVseQJfWa/HO3+353NoRBVQ4I9+Gz+COBXCxCPhcn9oq33Yj1lm
	 wvYsraskx8ZdV40yfcBBomGqeWQgUr0zmuIXZoisgCnjXbijzXR+89k9hKw0J57Fo3
	 xAxR4KEteAOuhz+M8ogbCItvj1eIljmMYoVzPBvMlUHeyXZLcGxhArd9GjUWAzu26U
	 oEle2pMEYaoATzgFXqzVv05YMtLJ88w4ZlmZVs36Om4wL3/4AFQ+hpykRdCH4pF9hE
	 LmMcyK/116iWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 04DDA3808200;
	Tue, 13 Jan 2026 11:40:07 +0000 (UTC)
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
 <176830440546.2202748.13657556349498577509.git-patchwork-summary@kernel.org>
Date: Tue, 13 Jan 2026 11:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization
  Submitter: Devyn Liu <liudingyuan@h-partners.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1039738
  Lore link: https://lore.kernel.org/r/20260108075323.3831574-1-liudingyuan@h-partners.com

Patch: [v2] spi: spi-sprd-adi: Fix double free in probe error path
  Submitter: Felix Gu <gu_0233@qq.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1040465
  Lore link: https://lore.kernel.org/r/tencent_AC7D389CE7E24318445E226F7CDCCC2F0D07@qq.com

Patch: spi: dt-bindings: nxp,lpc3220-spi: Add DMA specific properties
  Submitter: Vladimir Zapolskiy <vz@mleia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1040300
  Lore link: https://lore.kernel.org/r/20260109075032.3287109-1-vz@mleia.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



