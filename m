Return-Path: <linux-spi+bounces-10711-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B758BE8547
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 13:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA07335C71B
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D5334688;
	Fri, 17 Oct 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MScn1u3C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1597442C
	for <linux-spi@vger.kernel.org>; Fri, 17 Oct 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700622; cv=none; b=UNT7LM0sdzKnl2wGWFDOeSVhrdwpEXxDWzmKEYhG17n28FQ6TLRj4AuUaPLWRl2HC6cMi81/S9SyK8AAOvHZA5Fl3xY2GVsPFNxHdTcph6IznlMrJO11DVD5hU1QCAJ13RvUvmU/XqSG8kduODRHwzBaF8GyYMGLjbC0GTltVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700622; c=relaxed/simple;
	bh=rFERgBVWPHeoUEySMUXeYLX9QaEYYC19jctNi9/RPwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=vAqz5zEguOrrycCj4SmAsLsGle3BmdRDCVxzGscv+X2nhEu/i4k0djAZdQ03MWHnRL4pivpLnUKW6rbV4bmlNMnmhh7rbwZMZvieDMi/sdtqXxXW+GD/bD6NK04DQpRtMS7kJuVOMeL5DbmrG/NuZoV2nti//Kotdkz9QL1ZE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MScn1u3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625E1C4CEE7;
	Fri, 17 Oct 2025 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700622;
	bh=rFERgBVWPHeoUEySMUXeYLX9QaEYYC19jctNi9/RPwk=;
	h=Subject:From:Date:To:From;
	b=MScn1u3C9DXOWSbtytwpzCzHCz1uhW6KK2nzku/WE6tCCP04eLW8dl59+Eo6lyXHp
	 7rJSFr1b9FUlmMGtSCnOz8cuPHdkdhfiis41laIQO46UdNJ2UNPyPsD0p4FKm6OoWq
	 HGylvRlhRQ/C+5ceZhJtHn8ydN6Ts59tTxi6BtrhyDTjmJR9p5qxTkqY1x3HnoA/+j
	 nNBoYTJMtzyLCSQHhiYbrc36nvXZQHCoYBdy94Z47A+FaPH9ctJUILpjan11Im9deG
	 QPbPBVxb5g7eeJRWOEjs+PNYgeIBUZjrzCwA5xluRHGDTTZnk583LtQWVkYLcdH9/z
	 4vfTQGv2yzs5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3792639EF96B;
	Fri, 17 Oct 2025 11:30:07 +0000 (UTC)
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
 <176070060581.2166134.15724914510639972137.git-patchwork-summary@kernel.org>
Date: Fri, 17 Oct 2025 11:30:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: aspeed: fix spelling mistake "triming" -> "trimming"
  Submitter: Colin Ian King <coking@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1012434
  Lore link: https://lore.kernel.org/r/20251016153000.9142-1-coking@nvidia.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



