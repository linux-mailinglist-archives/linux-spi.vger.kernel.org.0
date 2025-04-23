Return-Path: <linux-spi+bounces-7725-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC10A988E2
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E529C5A53A3
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F320D51F;
	Wed, 23 Apr 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUjxM8Rq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3249FC08
	for <linux-spi@vger.kernel.org>; Wed, 23 Apr 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408990; cv=none; b=q2RavaW873LpshWfjrrdjvgnL+nqiAqTfTlNu2O6aZ1t/KTCAmxdz9wenPvKdg7gOqLL8kMa2uQbPaLjERdt28VcHeRzbSCyTe4mZ1W3TBAZrVLUdxNR1RGtJgK7kN+eN5AhtyvsCMU6yWLbwqNobJZF90vXWvXw+tX2lR1NgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408990; c=relaxed/simple;
	bh=gFlUUe6JRXbS75a8OztGt8du79Dm7GIWy0QX15YRObM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BzuLO4JOCm9c26mNnh9VJfJVeYHIocQIsXLGTBIKdS4gozkfh3eGJ2X8CtzgyoqTiPIMhcu7ghW6I5pChqaT2bEWtAzWmUgeQawUv3p5W+9RoauK/t0fkZnnw1yff9USFxW38dju9MjylzNAuODCwsVGOXu/wFIFF8ZVUfDNZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUjxM8Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06ADC4CEE2;
	Wed, 23 Apr 2025 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745408989;
	bh=gFlUUe6JRXbS75a8OztGt8du79Dm7GIWy0QX15YRObM=;
	h=Subject:From:Date:To:From;
	b=kUjxM8RqwMmoAe+IuJzsMuzCpmdNY8InISCfLiaeWPJfgMPsmFMy376Tg2oU+QNQP
	 /kZB7qeR/SfUxen7F0o6fH35wolbybeowuGrEyIjQkDTpDGP7m+zAyv1CNJ5zAOiFe
	 OAOVbaqsHHSWkKbFf88v4c/e6qR8rPbSLwgWxTVBOMvszez3n6Yz3OcEannhT7SMYq
	 Uj697ROmDD9trTfKn1heAI9lZUemqdjFvWuBhbYLKsCvzEOaJOFXdTgHQtw8qLvFUl
	 EXrU+QV/Qkv5nYu2+2jFZZUFscwqRJOLI+fw0V6dRwFtJFHGV8WeZm/yLtedkBE1s+
	 zgDM7o3otv5aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 745C2380CED9;
	Wed, 23 Apr 2025 11:50:29 +0000 (UTC)
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
 <174540902792.2597714.10717148755269577548.git-patchwork-summary@kernel.org>
Date: Wed, 23 Apr 2025 11:50:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: stm32-ospi: Fix an error handling path in stm32_ospi_probe()
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=954834
  Lore link: https://lore.kernel.org/r/2674c8df1d05ab312826b69bfe9559f81d125a0b.1744975624.git.christophe.jaillet@wanadoo.fr


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



