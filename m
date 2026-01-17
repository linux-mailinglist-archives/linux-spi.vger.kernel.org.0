Return-Path: <linux-spi+bounces-12473-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 156FCD38EDC
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A876B3005192
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99810207A20;
	Sat, 17 Jan 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ2KylWL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121078F4A
	for <linux-spi@vger.kernel.org>; Sat, 17 Jan 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768658395; cv=none; b=ZXkdxfcOCFfJGPHG58mA8CXWwQKDkgT3ynDNKRrzF1TNYK+o6qu0nR7x0u2rt34ihQsgPV2o/4wVC4WxPsx8EipQcq8Nfr68Cwv5sdrsAucUKj9ZEyIUy8QE1nQ0kxXggTbxIuaPE5wSRHTOeoMBA9jokxjIGEu/kOe56ZJ4nj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768658395; c=relaxed/simple;
	bh=SLs++h6k5njDDkdFL3ahozFL46sty34bJQ5MZ8pdp+I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QSuVp92PhnLjjBJu16AvOKyJ7XwTHIRJPT8g6OX04BaCjvgmq9Pg6NSGtTdpVn34/bM/GkT/dog3OjoP5UrAPY6z25N1cm/vNWDBI21aX97gHzVn31KfhpQONsxfftscy6nvykaMDuNqaIM7po7IToKFaNFSRsjSbAYFYQTC1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ2KylWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A5BC4CEF7;
	Sat, 17 Jan 2026 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768658394;
	bh=SLs++h6k5njDDkdFL3ahozFL46sty34bJQ5MZ8pdp+I=;
	h=Subject:From:Date:To:From;
	b=YZ2KylWLyGpZgIgsHCynurxHqL7HyJk3cHL5RJ3HxtShW4nmEX6ykjxBobSL0GtgS
	 AEiHFSSuRZPqUB+OeUdWFTPD+0sG8Ri3byvjPHsv+MexGydLOHWycSe9ZrFytQzJ7W
	 UKa7dB5lUADMnzx6gl67x2/tpMPx7wEJPZnQgk+TB97aRS9T35WyttyvWLWFLrLeUf
	 Vu9QwvQur8p006yut+7AoaChthDNSRMotUdg8fw17GIc2QdFptsjD9EOr43Uk7Kd/X
	 bNh4Yt+QBhQFWrYabgxDfnagYKEmHoS0muCRl37X5ocrmsNNsUmXBogZHXTMEICvoB
	 3k3Ghd2ZAAEgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B65BA39D2F40;
	Sat, 17 Jan 2026 13:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176865818544.974939.2491615908902410530.git-patchwork-housekeeping@kernel.org>
Date: Sat, 17 Jan 2026 13:56:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: aspeed: Improve handling of shared SPI controllers (2026-01-17T13:42:14)
  Superseding: [v1] spi: aspeed: Improve handling of shared SPI controllers (2026-01-15T15:04:52):
    [1/2] spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
    [2/2] spi: aspeed: Add support for non-spi-mem devices


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


