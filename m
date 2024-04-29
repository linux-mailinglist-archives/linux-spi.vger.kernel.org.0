Return-Path: <linux-spi+bounces-2635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C08B64EF
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 23:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC6DB219ED
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 21:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E564F839FD;
	Mon, 29 Apr 2024 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="res0itKd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231418410D
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427818; cv=none; b=Pm23FjUreDYgVtD4WuXNDiGFiaLpJSlVqMFu0t0XFtgkHg/Ryqp5ndflY8GGmSD+E3Jd6GhJ8Rp7rCHheH9BxO/GQat0oINNHceNRn4huAtaQPbDVmQOennMTyeDGJ0FnyPmeVVMarh/Pq4ChZhkZyND+ojLXDrl8WgGtP5JrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427818; c=relaxed/simple;
	bh=BFZ9qvnABccSx5mBm1SessMkBuCYXj+mcncq9Gi9sKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=C/1WDew5Imh3xfZNpcfOBSGU0g4hN91V1RBVFKkcO9wwPy/9iesrvf3F2vx2buVtDXy0+rx/giFY0Y+ymezHECUimMeaeRwiS/j1Wwpb/dXeRmL/1zZWidCnAKEg8VAFkfsYKhgn349N2LDaSuZvEQwK/GU9AHLWW1t9OFi6wIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=res0itKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57F04C113CD;
	Mon, 29 Apr 2024 21:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714427818;
	bh=BFZ9qvnABccSx5mBm1SessMkBuCYXj+mcncq9Gi9sKk=;
	h=Subject:From:Date:To:From;
	b=res0itKddUxg5v4z+sDuOqhP1bGyNVfMOJEYXbRukMHocO8IMDpIeXRpxv6HQu+uA
	 mOI85JveRvkjS0UpORVP9OBYAQTNv5No6BLMoSMZy7gbBBcukQfcWIR3EsZO2J4E+h
	 UMC40PWkKEEociy27I/i0iGiBmLvxXzFm8DtoQaW4s0JYIRwZZbnj2ShHS+7L7Kl7C
	 goLNjFlFIv6NAaiNAagvEZySp/cP6FDfyqRqLls+mibrxKOWpZrA3Sp8YPNJ9lSfAL
	 CBn2ReUWU7+1uvqXbksSe115zBnMq7CNVzwahVIVvDI1IZNWmREYACaf5woiuQsyCf
	 CrRWnIoAZk+lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F746E2D48A;
	Mon, 29 Apr 2024 21:56:58 +0000 (UTC)
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
 <171442781825.21344.6021412061932505403.git-patchwork-housekeeping@kernel.org>
Date: Mon, 29 Apr 2024 21:56:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] ARM: dts: aspeed: Add IBM P11 BMC Boards (2024-04-29T21:01:15)
  Superseding: [v3] ARM: dts: aspeed: Add IBM P11 BMC Boards (2024-04-25T21:36:53):
    [v3,01/14] dt-bindings: spi: Document the IBM Power SPI controller
    [v3,02/14] dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
    [v3,03/14] dt-bindings: fsi: Document the FSI2PIB engine
    [v3,04/14] dt-bindings: fsi: p9-occ: Switch to yaml format
    [v3,05/14] dt-bindings: fsi: Document the IBM SBEFIFO engine
    [v3,06/14] dt-bindings: fsi: Document the FSI controller common properties
    [v3,07/14] dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
    [v3,08/14] dt-bindings: fsi: ast2600-fsi-master: Switch to yaml format
    [v3,09/14] dt-bindings: fsi: Document the FSI Hub Controller
    [v3,10/14] dt-bindings: i2c: i2c-fsi: Switch to yaml format
    [v3,11/14] dt-bindings: arm: aspeed: add IBM P11 BMC boards
    [v3,12/14] ARM: dts: aspeed: Add IBM P11 FSI devices
    [v3,13/14] ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
    [v3,14/14] ARM: dts: aspeed: Add IBM P11 Fuji BMC system


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


