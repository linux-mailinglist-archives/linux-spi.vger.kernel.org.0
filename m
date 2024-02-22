Return-Path: <linux-spi+bounces-1478-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FEF860283
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A228E282C11
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F651EA95;
	Thu, 22 Feb 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdRk47ep"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493914B824
	for <linux-spi@vger.kernel.org>; Thu, 22 Feb 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629630; cv=none; b=j4XdECuGqwjNvva3+9OTUbajgUrYulx4ZAbnE25Kh70cqNAbtflYJibQnd/f1zCEzfG8g1YB3qc1J/pUZiabF04jC1p3cS00cz45lxlcaWjTrfe+oWgwS9NAWux10fSdJiI7S/e6FtSalFweMio/j7bx7nq+rFCNYytiN0BAUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629630; c=relaxed/simple;
	bh=Du9YUZKmeq4KOfqZhSSz4+cUWY99IC64pH0r0207WkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IvsjPx7jJVhaY8ihaiUPqnQRuYqP3ilhQlxzmqgLib2sfPOxLiEVWkh1KQLWCNW13IIhM6W4XuIw/Z+JkXMY9Fj2vT+XV8bgucArOSelcxxTghVY0X1VwrwqNdVHqFtFkIjuz6RclVawcuuebPabhAnefcWuDtnYqRla58+UUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdRk47ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDE08C433C7;
	Thu, 22 Feb 2024 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629630;
	bh=Du9YUZKmeq4KOfqZhSSz4+cUWY99IC64pH0r0207WkU=;
	h=Subject:From:Date:To:From;
	b=RdRk47epMGQxInbuX8P4JoIjuBPWzQtP4RU3T8n7FfrSJKt7Ar2vBDvWVULza/q82
	 u6jyc8JVWTSSg44JZsaRKptnJjiFCTZN6sz2rv6d3Eegz4v0Tvr0qFYyvgC/yDX4H4
	 Clx/x4+oasabQtJoc1XpTSaFHZAiDfyaLx5gtSul1y7zTfbiisWzuCu4xxGR/So5B8
	 Mr9tlHr9goVxP17vraIfzvm6sXKO/uCbrzM9Ob1WLzmu2wOH2P7dEl0lyWm7aQ6vwQ
	 S6P1o+MB4BFLTOAe/9jYKA7ur02lS0EtqXuctLLB+pbd0S6qGcHVk2vNhCJGyShkI8
	 Y6lmCr03tt0sA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF1A8C395F1;
	Thu, 22 Feb 2024 19:20:29 +0000 (UTC)
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
 <170862962978.25872.13157882662846697497.git-patchwork-summary@kernel.org>
Date: Thu, 22 Feb 2024 19:20:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-qspi: Fix runtime PM and system-wide suspend
  Submitter: Théo Lebrun <theo.lebrun@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=828612
  Lore link: https://lore.kernel.org/r/20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com
    Patches: [v4,1/4] spi: cadence-qspi: fix pointer reference in runtime PM hooks
             [v4,2/4] spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
             [v4,3/4] spi: cadence-qspi: put runtime in runtime PM hooks names
             [v4,4/4] spi: cadence-qspi: add system-wide suspend and resume callbacks


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



