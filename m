Return-Path: <linux-spi+bounces-10819-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AB1C0593A
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85A524F4C6E
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997F2741DA;
	Fri, 24 Oct 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5iYLsmz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55FE26F2BD
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301825; cv=none; b=XC6yCBBUBQJb9RiRCyy0pOgon+tOnNnBYaYfWKWxL9dtqToKoJtZ4EIM0t6JE5r9EZQ2T5lSStThU2B1hdme8Hrwwyi4+T8NEgveOyA3zU2uP//fPvhWkRGa66HehreaM49u/ekOVSRJd9c8iktQgV9aP4n+SAacCwrVb8etNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301825; c=relaxed/simple;
	bh=hNgAjxXTD1/N1DnMIqhPcNZFE9j6gE5kSM6dWbQo4QQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fZu5D/FtWKvGttJ92VIM5Q2qsZ6EeCQSaEyowFnEbAaMvoVHxJ+uh5oQBuqTS/3OVmlFc7A7cZh2NYSR7shFsOJrLFLkjMiP+Jd7gJlRTXQlKfm/EzIkFokdQHABnYYoLbEnXoiOrabllXNqbaQCmiAW+JS0+vJIXoWIm5sZC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5iYLsmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E783C4CEF1;
	Fri, 24 Oct 2025 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761301825;
	bh=hNgAjxXTD1/N1DnMIqhPcNZFE9j6gE5kSM6dWbQo4QQ=;
	h=Subject:From:Date:To:From;
	b=o5iYLsmzLmfZQBvdROI3atOfJwdZZQO2e6FS0bmvQUdnHCqhvNHXG5DH5KTBeZYk7
	 jp6vMQFR+oQACBAhkQ4Cx+CkEFKRuLmhKEOjq/55XgbaYEEzqU5NmOjW2KlGmyBxSL
	 GbUdq8vjYLa40k+adLXx8l3uXr2eazjflSSVTHS3GgOMLkwaBkdzmFLN/PgfPy9khw
	 XEkF6MbzIY9oek+144K5QTPvfp2j04vgXdGDfhkliWhZ1xa3MbsJ3L1EOwKa/CJOIb
	 /t7F+hNaQOk37y4ndc/dWqO1GRigEvNRjLpxjiEhSihIg6wFRzr45fkTOzeBzd3QaM
	 3SakRn3i/zuOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74F8A380A97A;
	Fri, 24 Oct 2025 10:30:06 +0000 (UTC)
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
 <176130180489.3832784.921756039361883077.git-patchwork-summary@kernel.org>
Date: Fri, 24 Oct 2025 10:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: spi-qpic-snand: make qcom_spi_ecc_engine_ops_pipelined const
  Submitter: Can Peng <pengcan@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1014784
  Lore link: https://lore.kernel.org/r/20251023024250.3181084-1-pengcan@kylinos.cn

Patch: dt-bindings: treewide: don't check node names
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1013394
  Lore link: https://lore.kernel.org/r/20251020060951.30776-6-wsa+renesas@sang-engineering.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



