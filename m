Return-Path: <linux-spi+bounces-6693-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3BEA2D030
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 22:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C786188D12E
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFB1B3953;
	Fri,  7 Feb 2025 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKzF6fu8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEB23C8AA
	for <linux-spi@vger.kernel.org>; Fri,  7 Feb 2025 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965412; cv=none; b=j9FwQ3gxLio0k5CLWPDdfyALWzshOP5tuAQRWcb8ciDHwPg/+dNlDtmAkxf7qwUrJblO5zQQAvfVFgvJSNT424m2NrzxBJtRlOrqd00st2eNIT2doGJeUcFCkKgOc9xem5QwRJPw1x44/8hOb6k9CRVO7lTtFCMnHydTM2FemEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965412; c=relaxed/simple;
	bh=RwNM++mot1guXNNLz/9got92eZ85JujB2WdlrDCQIiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HaLJcPHECop62o9GP5Pi9xht2UVPAugy1KJA3D3TzBG3OU/q3Jj1+F83G5AP19i89leVzmAarFoylfKm8HenBhzL6Xeo/8eCuNHDUQG7s0/2Jo/MrQlFRK6B7ngMxntTn9bbDtYhJ7zsMVt86X5fIQLPd2pA53uWppP0iigAHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKzF6fu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC76C4CED1;
	Fri,  7 Feb 2025 21:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965412;
	bh=RwNM++mot1guXNNLz/9got92eZ85JujB2WdlrDCQIiw=;
	h=Subject:From:Date:To:From;
	b=tKzF6fu82ypN9oPSOeQxvCwlriWe4gXhc3W+rkB5Tkh5CGv80HyYi+na3sT8sQ2w2
	 l/hTF80SV9IH1HHYpdQs+WqNNbBbkWBPlE79ooy362HsOzWYXrEKKlTaCdNfC8pUSj
	 0gEMdh7sbJgyZTtO/hSowvnzTktQfUnk+Dnw0WwryNvy4PwChtjF5dp9PnwUxkxePc
	 PfYZQ3ypRVOGeUPTH4Mtn+gMHEc6EZX02YnEQvK45x2lVEjMDe/c3FWFmPQYoU4ZXu
	 5DgiovKMTklm9y+WD62/CX945MVWLEY2JAsUj5rvlLj4rKs5LlHPnkmlUxY/i4S9gi
	 +ksMsNm1ylL+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71078380AAEB;
	Fri,  7 Feb 2025 21:57:21 +0000 (UTC)
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
 <173896543999.2397029.621360007988842417.git-patchwork-housekeeping@kernel.org>
Date: Fri, 07 Feb 2025 21:57:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] YAML conversion of several Freescale/PowerPC DT bindings (2025-02-07T21:30:17)
  Superseding: [v1] YAML conversion of several Freescale/PowerPC DT bindings (2025-01-26T18:58:57):
    [1/9] dt-bindings: powerpc: Add binding for Freescale/NXP MPC83xx SoCs
    [2/9] dt-bindings: ata: Convert fsl,pq-sata binding to YAML
    [3/9] dt-bindings: crypto: Convert fsl,sec-2.0 binding to YAML
    [4/9] dt-bindings: mfd: Convert fsl,mcu-mpc8349emitx binding to YAML
    [5/9] dt-bindings: dma: Convert fsl,elo*-dma bindings to YAML
    [6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
    [7/9] dt-bindings: watchdog: Convert mpc8xxx-wdt binding to YAML
    [8/9] dt-bindings: spi: Convert Freescale SPI bindings to YAML
    [RFC,9/9] dt-bindings: nand: Convert fsl,elbc bindings to YAML


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


