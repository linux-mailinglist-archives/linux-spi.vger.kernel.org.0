Return-Path: <linux-spi+bounces-10902-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593DBC15A6B
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 17:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCBF1881DDB
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD563328E5;
	Tue, 28 Oct 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF2Y3wiO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0C1862A
	for <linux-spi@vger.kernel.org>; Tue, 28 Oct 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667040; cv=none; b=EvQ7g30WAcjjfvGYG9s7zFJnfoLObhrJgivIbMjiU1XmpyJPnfNKm21wmXGOSiKo47TtEhjaGnX214lgp3gb8yX780Soq87ZaGiwc8t1Y5LCjoa+uyzKbKVL4yYRjKKx1Xm9uZ/6prc9xVDLCKi6H00fB0D0tQO4fIu8+zTsGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667040; c=relaxed/simple;
	bh=QepLB0pdgqqi3VGwoZqzmO1IZmiMHxjfXupzj/6vrCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=V10ck1CKgFu7OcZ+hmS3BTeKt5WfkDGUfgijqUMz2HRDbJ+fkF/z8VE898m7sDDJkHyC7535raDrrvn2XgdNSuW1F3aNLzkqo8AjLRilzHuZtmPXzSiz62FkXL++VgG+zD5lxy5/I880PKwbeQKgYnVhy0auPVEZOS8jljOm1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF2Y3wiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8540AC4CEE7;
	Tue, 28 Oct 2025 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761667039;
	bh=QepLB0pdgqqi3VGwoZqzmO1IZmiMHxjfXupzj/6vrCw=;
	h=Subject:From:Date:To:From;
	b=oF2Y3wiOyjptLMl5MQTuZYjN+8S4HQMjYelUANda0c2Dq7tpsKOoGCd/mPke+pqOz
	 +iYQTPxpbq6FhTXC1aJNIrNXxol289tqMZx/Bmpy4rYMjWWR9YpQ4HhPg5CAqvPxRy
	 i0/yzeo3L+Qg4uCLl171x7/aGz+tryOpbg9NxAOY6oMqvCLOVL86Wri8b5OFL5fM68
	 W9PkuAc6LrXSNZMQCW5RZnD9+V/QPqDQn10KqcsxOfqTdej09GpDrfOo8DCMKtlVWD
	 72QVgh1CxMN3+0uoKEIy2hmiUDHAzqG36iQ04L8PPUiq3fRbO06MlQCLUqYFJ3Tq/J
	 kBf2/KkC+HNBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4639EFA65;
	Tue, 28 Oct 2025 15:56:58 +0000 (UTC)
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
 <176166701708.2285815.2197914873427442146.git-patchwork-housekeeping@kernel.org>
Date: Tue, 28 Oct 2025 15:56:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: tegra210-quad: Improve timeout handling under high system load (2025-10-28T15:25:14)
  Superseding: [v2] spi: tegra210-quad: Improve timeout handling under high system load (2025-10-16T13:29:21):
    [v2,1/2] spi: tegra210-quad: Fix timeout handling
    [v2,2/2] spi: tegra210-quad: Check hardware status on timeout
  Superseding: [v3] spi: tegra210-quad: Improve timeout handling under high system load (2025-10-28T15:15:12):
    [v3,1/3] spi: tegra210-quad: Fix timeout handling
    [v3,2/3] spi: tegra210-quad: Refactor error handling into helper functions
    [v3,3/3] spi: tegra210-quad: Check hardware status on timeout


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


