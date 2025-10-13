Return-Path: <linux-spi+bounces-10609-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3FBD31BE
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7137D4E2FFC
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E2925A2C9;
	Mon, 13 Oct 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn9slmAT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11D2BCFB
	for <linux-spi@vger.kernel.org>; Mon, 13 Oct 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360210; cv=none; b=A/WRCsPJcno/U3ehE5fzWgubdG0T0V4ECx0hLUrbXK3m8vncIxcnqErE/an7YdTg3puvRD8pPFN6Edpnwtmsf+205+o5lYtkFjXqwsJBGjNSa8x6l7WbJXg5OgJkFlSFppFo7U6EYSwkrDFFqYivmLSFvmxSsBN43T8yo//XfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360210; c=relaxed/simple;
	bh=+aLo74Bn7qd0iAaD2CefONrvjzeppKFgsLj6LFQg/PA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kuwAW3s4j78kqVcG3Je0iVeFkPhI4H4mCMK/4NBf0CbRvvK+eQiDAdLD/4HgLTslsSHdEVc7rVYy/JWCawvo7FPa1/Cnh6I2PMjAXh4gFxW92i/B8zm74bh7JduhFZ3lCFKn8shbXN5qI0FMJhEiWohq7P3FNVbQH3kkfsW7oRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn9slmAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91720C4CEE7;
	Mon, 13 Oct 2025 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760360207;
	bh=+aLo74Bn7qd0iAaD2CefONrvjzeppKFgsLj6LFQg/PA=;
	h=Subject:From:Date:To:From;
	b=dn9slmATPRBH/fkMDG6aIVMu1lcW/w/F2keJQOGuisGuWuezheF6rN+l/dj+Ah+SY
	 MQUT+QmkvGRqqlFGcsfQSOmG5XZM0kUjGtHMpDqte/M1FMe672h4IaSol7oS7Tb83U
	 9/aCLWxjGgeamfua/Y1iMGbTUBm2JG0ilOgdw2aYU2+NLyHPAYuLwSFbZjWDTtsfEw
	 rjjV02CHhUwLIPJc+bBzG6W2e22HbV59pmlUzq/UfUuLaiPp031v4qE+lzfATupg4K
	 4Aa6tJO28MdtuSP4WWYEenq8uS0ermxT6pXR8flvCfE9mOLSbbQc/1slWdAzagEjoJ
	 Xb29hjMe2tQOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF21380A940;
	Mon, 13 Oct 2025 12:56:34 +0000 (UTC)
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
 <176036019323.2986889.9186348167170565608.git-patchwork-housekeeping@kernel.org>
Date: Mon, 13 Oct 2025 12:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: support the SpacemiT K1 SPI controller (2025-10-13T12:33:05)
  Superseding: [v4] spi: support the SpacemiT K1 SPI controller (2025-09-25T12:17:10):
    [v4,1/3] dt-bindings: spi: add SpacemiT K1 SPI support
    [v4,2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
    [v4,3/3] riscv: dts: spacemit: define a SPI controller node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


