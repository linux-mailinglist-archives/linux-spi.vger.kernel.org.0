Return-Path: <linux-spi+bounces-8555-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A1AD9C73
	for <lists+linux-spi@lfdr.de>; Sat, 14 Jun 2025 13:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2304117C732
	for <lists+linux-spi@lfdr.de>; Sat, 14 Jun 2025 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69E1EEA3C;
	Sat, 14 Jun 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU+yp9ks"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EAE1E3DEB
	for <linux-spi@vger.kernel.org>; Sat, 14 Jun 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749900006; cv=none; b=noYzRYpeIR8eTAOJCfob6bKINNu9ELc9DZn22MnP2svP97By/a/Db6sKboWHFYP/9j4Ut7rToX7MFQg7epUCJy8mQJt9sdgaQK5pebOfIN8FDyDjDR1S4uw7URxCFe4zrKO04/BlkvIGpMNSQwu7nNv3pkUiCIb9XIqF3Tc2huY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749900006; c=relaxed/simple;
	bh=28jWIp7o6muXPoSUmJt9pRIZnJiJK9fG2QhZ/sRJrjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=k2wNgovapGsn/ehzGV4zno9KJOi9hKZhRyHuKWJeKqx+bKseuhtBpCcccD8GzCbetDbwwhLAonxOcgmwYx/CSGjURvEcflpHGvBtqvD/e+iafHebrN+Es8IJMuEvq4cC5JrNVkg2WZ5DeG3x4xcyTUvUGq+kzela3WcCVd5XMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU+yp9ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A833AC4CEEB;
	Sat, 14 Jun 2025 11:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749900005;
	bh=28jWIp7o6muXPoSUmJt9pRIZnJiJK9fG2QhZ/sRJrjU=;
	h=Subject:From:Date:To:From;
	b=CU+yp9kscCeDyQP1waraa4WZCqN1R256T9oA7jays8ICnk0jF7XW0KokAu+DsXrzK
	 rNxn7xyemeRpuTp3uKkvKAXirYaNL3CSq2J5B0TqtGRyXg42Nu1ZO7HbswFl6IePVf
	 wITzxVN6tm1bkzZr+SnmazJqc8ahiQMX2dQSwLMbVtlNejkXBoXl9oka3D9yANx09K
	 D4pYZ1xp2P24pjd4nfRO5PX1mhpy92pgZ2GTsLZwdz4hHz+TJnyejYkyIob309+bt8
	 ubhCyDIROzS9I2dVfMNrwQgDUL1akTxZF5dCfbnVomCKduhWr1ys8Lu1jSXYtVudmj
	 ILOft3mQKi/Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3745D380AAD0;
	Sat, 14 Jun 2025 11:20:36 +0000 (UTC)
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
 <174990003462.1065220.6001623961032604255.git-patchwork-summary@kernel.org>
Date: Sat, 14 Jun 2025 11:20:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: tegra210-qspi: Remove cache operations
  Submitter: Thierry Reding <thierry.reding@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=971809
  Lore link: https://lore.kernel.org/r/20250613123037.2082788-1-thierry.reding@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



