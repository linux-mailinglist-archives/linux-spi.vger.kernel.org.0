Return-Path: <linux-spi+bounces-8235-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0094AC0A21
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB57171665
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445317BB6;
	Thu, 22 May 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJc3URsz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038033DB
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911369; cv=none; b=AXfuUOfJRz3106Omr82Bta3EouRp5s/36ANBis6ooh7wdgfhi8GQmAsQYj01ezzg5N6PqnaNwVc7XMRxFFpL4Inrhh/WN/f9z2HrzOEA1yFEL8YaJGHggIFNdhXNJhcEPvSq2dQyCl1xIgRjFHp59+3JUliP7U2ljMnW2kDGvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911369; c=relaxed/simple;
	bh=HxNd6Qu4OweVVm1Am0BG6c+oH2ze7RMGDe4rNUI0jOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=S140zpSPQ4XsLfvqNWrqwDBN1cg9llsVzLvtWBkF0Z3AbNAJYKJq1mkwVjwJSVrrQj1qC3DOBk34xhXZZpqyyEWYrpfVKDNgn6+RWujUUeFQe4HRXp+3rgQZ7W+ojgbmBfx3KuzoZ9skO4cdaoaKf842lsuZp927ll+DMaDH7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJc3URsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB28C4CEE4;
	Thu, 22 May 2025 10:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747911368;
	bh=HxNd6Qu4OweVVm1Am0BG6c+oH2ze7RMGDe4rNUI0jOY=;
	h=Subject:From:Date:To:From;
	b=VJc3URszRWhDl89vBoqz0hlM6i10Dq2gAgk02o7Tn7/bX/7MTdsO36vrM2Aih4UJd
	 ODGfX2nwBusTo41YYVbXtYvmhH8RzArkocV4fUqWKmbK6m5wDaa5lLmNNefMwzjWS7
	 cafCLcVCF90hPmQJaumRIUec1lnOgM5OqqFiFgq8V65G2rOqInXv7e6q18SAWNF/kP
	 bYVCwEg0X8UcfxVGAiKZ/WUluGeWKsUIsfdLpLbZj/8DHziqHDsqoR7fR4fDd1HYQ9
	 sl/tIpH4unogLaBEsNlZ5DZVJGP/LrIXTwSZUdyRYNPOSKfnYs1bfK3rx3Vl17MoOY
	 aAisUhf2G8uxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7454D3805D89;
	Thu, 22 May 2025 10:56:45 +0000 (UTC)
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
 <174791140406.2830333.17865192085931864461.git-patchwork-housekeeping@kernel.org>
Date: Thu, 22 May 2025 10:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller (2025-05-22T10:47:45)
  Superseding: [v1] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller (2025-03-26T11:37:31):
    spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


