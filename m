Return-Path: <linux-spi+bounces-11483-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB02C81751
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 17:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDD5234651E
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B93283CBF;
	Mon, 24 Nov 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRczHQDX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4EE139579
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000042; cv=none; b=KlIpmA9SLgL51AM0NQ42OZuyuHIsU08oHufI6X1DVDE/G1/DxHTrGM+d7GI9U/inLJvN2Nbn7xiP0/YLSStnBsZvfazLDSnE/tbXwexUWgNgKsVU8FDmRM1MPym/RbuYlDIp29jGY5zDhJiROdj3itij8iLVfnr5cosyUD1j7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000042; c=relaxed/simple;
	bh=IBzY4fBJ/hZTlYl2SqPJsf94pMCpfUo4iQ5/pWS5c9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M1EhG0sWNwsrYkdD4GP/3Zfi4J3ty3Q5PsxCZQEWZI2yVCX2rFTLoLk3IR+Z+cc/vKS/iEYtwqrNNUNGcCugV+9DF7hcmnB4T+GZjX8SlXq9ZHCxRImLzCwrx3CqA2Vz2mHPa+cMZ51cbD8E/jSYgH92nB0eG5gk4KyhZSvgeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRczHQDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27259C4CEF1;
	Mon, 24 Nov 2025 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000042;
	bh=IBzY4fBJ/hZTlYl2SqPJsf94pMCpfUo4iQ5/pWS5c9o=;
	h=Subject:From:Date:To:From;
	b=hRczHQDXXjVNCW8LuEKkMca40jdu1dgt1kt6ZkQTV/uM+X6YfOJdNiLV+IRoeGzQo
	 vTZIhuCJ3uroOZS8QLg8d8O2UYgWysDXXlGa9J4R5gttTntWjfXHaX/RTn7Gul7zr8
	 jlvPE2u5ze8n7Gkme3BFDXWF2rb0okf8nyWo545GDjyR8Kb+lJEKtHjHVrmq5iG+8S
	 Gu9fizrjngDBTHFvLKvWITZztUT6mr/7IRA/D3m+lVnUi/LYNNkJhoqyWNZWjRmvET
	 pjknDtxinbXOJ29tD7oq3D6r+X/volgI/1CJ7xE35vTQSEF5bSxom653JjclPOI1w1
	 xFNuMyx5Xahsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3964C3A8628B;
	Mon, 24 Nov 2025 16:00:06 +0000 (UTC)
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
 <176400000477.4175081.11353986141013032420.git-patchwork-summary@kernel.org>
Date: Mon, 24 Nov 2025 16:00:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amlogic-spifc-a1: Handle devm_pm_runtime_enable() errors
  Submitter: Haotian Zhang <vulab@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1026771
  Lore link: https://lore.kernel.org/r/20251124015852.937-1-vulab@iscas.ac.cn


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



