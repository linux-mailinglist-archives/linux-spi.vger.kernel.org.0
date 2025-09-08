Return-Path: <linux-spi+bounces-9935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593ACB48378
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC93177020
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 04:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2968221F03;
	Mon,  8 Sep 2025 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ5GghFV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246922172D
	for <linux-spi@vger.kernel.org>; Mon,  8 Sep 2025 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307416; cv=none; b=siR7bl1ahixXEBvB86FsJKdt+BvU1Blu3guT6ObwwGWpmX1LurL5yGBYbGCyMavMAPqeshgYIw2LTeHgIBPtGStjdrlpcYKfPVj9rXF0homKEJ+QQhnf+sAPpu54njrxeyaMaAzHeEAn32dAmcgJ0NYoX4UHWm/k8EFVCemom6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307416; c=relaxed/simple;
	bh=TNx6u6z3bwlOWqG+8dp+zE7lwoRs9Lsg+fdlknoaPSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aqqOlKaPX07YaMnZZz2chFRVHpl/fymzJ1eja4Ayi7ZjQ/bzPIXYGMFv+n/W1Yg+n+C+0aus7/kJZjw7nMMPYYyxGHwZZVmJ/LZYiz5ADbocw1WvF4xs/MYq7l3v9FZfe4DDT/PggTeE9TyQo+ovIr+zLSsTtWhbr7QSynWSFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ5GghFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFF1C4CEF5;
	Mon,  8 Sep 2025 04:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757307416;
	bh=TNx6u6z3bwlOWqG+8dp+zE7lwoRs9Lsg+fdlknoaPSU=;
	h=Subject:From:Date:To:From;
	b=lZ5GghFV0937GldOWpPh36sDkd7mQ6FvH9OjF6maP451UUKZU1w+imS6BRwK/dqGt
	 57odXDDlbdJGVLsgivNpfLXklQ3zkse2wBqqn2z4ko1XMlhygI38Fq4BwApt62YguN
	 txvNQZXtuNjooDP8y+4gG/RkMBP4e/fMh/UFWKBGwhyuMlPqBAvu2/otO5bSeyFBZO
	 2J/+frEf7Ei12ZVWxUE+8oVzmA0yKPmb55s7ZISuIleP7NixcZbrD4hZmsoSQ80zBZ
	 Joacrs5cuTDHx8bUdjYaSTdwgHriInPSuhHNj3OcnQGxv1OF+OW7P8g1gWSb/LpXFk
	 S4LhSCY1Qd4VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0B383BF69;
	Mon,  8 Sep 2025 04:57:00 +0000 (UTC)
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
 <175730741949.3563320.15929857943508863350.git-patchwork-housekeeping@kernel.org>
Date: Mon, 08 Sep 2025 04:56:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add QSPI support for sam9x7 and sama7d65 SoCs (2025-09-08T04:14:15)
  Superseding: [v1] Add QSPI support for sam9x7 and sama7d65 SoCs (2025-09-02T05:52:17):
    [1/5] spi: atmel,quadspi: Document sam9x7 QSPI
    [2/5] spi: atmel,quadspi: Define sama7d65 QSPI
    [3/5] spi: atmel-quadspi: add padcalib, 2xgclk, and dllon capabilities
    [4/5] spi: atmel-quadspi: add support for SAM9X7 QSPI controller
    [5/5] spi: atmel-quadspi: Add support for sama7d65 QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


