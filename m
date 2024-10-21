Return-Path: <linux-spi+bounces-5289-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F59A92CC
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 00:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF36B23089
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994701FB3D7;
	Mon, 21 Oct 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUxmmId/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DE1C7B63
	for <linux-spi@vger.kernel.org>; Mon, 21 Oct 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548023; cv=none; b=CgIlW4RnnslmLAYVbwl1ktDW+v9wAXRyAid7RQA+iz2Kk4v1/zaPEeUgKrcTIG3fK92NR0kPphJxKfz6yiPcqT4kqA7h1KQ5oNiZ7adsG0JFaHZhMIiD7NrQ8kcSDh4ZX52eie529859CCr0g0x5zp9r6MrbutiPUA/VWwjtKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548023; c=relaxed/simple;
	bh=Uft9mQ5UL4PAYGCgzYpVwq0G0CqSGPYZBPQB09TI220=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HSt+MYkUkRI4x6OgRGjXftxmkA/rcuQR4vmZ9qz4qxjL+KLjpGVyx37wgXmv59NByFA5zKsEnCN7aYGAAfWGcgXUp+K4dzWTADUrGb4PjTDy7uu55A3ChNv/vR3uCcIrhdJgA40/MynOnCCNV1N6766FopllnVpfK13H0lEKTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUxmmId/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E426DC4CEC3;
	Mon, 21 Oct 2024 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729548022;
	bh=Uft9mQ5UL4PAYGCgzYpVwq0G0CqSGPYZBPQB09TI220=;
	h=Subject:From:Date:To:From;
	b=UUxmmId/umPUAB7EPad5c9K/uG1wSeS2gG5bkbsTgXyef7wqmjOh+KyTUdo0lKP2i
	 wEXaELxIMQknLjEKWmH2h3f3TFfX3GUJMTQAclwrcyvlBGHA8Istu9LNq9bOCN/qqn
	 Xdm6qLngSFr7ljbdJBUpcdz+xmr58eAzjbk/imnQBPDmx7ndgXBiTYueQfYunwK2hy
	 CARqoIPaCxVEoN8N8ZddnSqmUmu5rTwETo37oHI1p10l0Bj99ZcEd3XvHnEe3YExF4
	 UN0/n3tE9CpR2UToMlVLXb1shX7uXAiayxc6ukKMLeXzwURpSBJzBugJg83o+X7RM8
	 7fqxz+tXCLIgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 392283809A8A;
	Mon, 21 Oct 2024 22:00:30 +0000 (UTC)
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
 <172954802879.456432.12466254399846275553.git-patchwork-summary@kernel.org>
Date: Mon, 21 Oct 2024 22:00:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: arm64: dts: exynos8895: Add cmu, mct, serial_0/1 and spi_0/1
  Submitter: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=901145
  Lore link: https://lore.kernel.org/r/20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com
    Patches: [v1,1/6] dt-bindings: timer: exynos4210-mct: Add samsung,exynos8895-mct compatible
             [v1,2/6] spi: dt-bindings: samsung: Add a compatible for samsung,exynos8895-spi


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



