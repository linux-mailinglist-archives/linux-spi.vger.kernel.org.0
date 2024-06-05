Return-Path: <linux-spi+bounces-3316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093758FD96A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2448E1C21AAB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DA113A87A;
	Wed,  5 Jun 2024 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jybpsqTn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC673C062
	for <linux-spi@vger.kernel.org>; Wed,  5 Jun 2024 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624611; cv=none; b=Vp8mSM2nTJgEpl1jDvaBSKW/TyCuDkUPG8wv0EB8WMHt55xWnNUWkvNFe101adetBU8cew6TADIDJ1LrfIVLkK3XRvNj3bYpKX3wa4dLF01mcq3NKCb5n3UszSJWB/U9Z8ZDL/Qtz5z6vyHEsShsElJZr0tumo1vXADoqmw6EHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624611; c=relaxed/simple;
	bh=AZLhgZIK+xR+Lz8Bc2V3QyVe6tuq+F44I1uQOiXKHVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=eL0lpmfuR9n6h22pKiD3WRORm8Jb7hg2APH6ylCOuTd20IjLdBTN3hkb7PGDNgAG3m9733PfAtYPDE9YT9YR/vW6sUWXB2wO7VasJCx6l6aFi2JQW2D9OEP11JlA3WGQYrruffd8veipu23WgHR44drtVXYDG7S/ju4NrDL//20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jybpsqTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBA62C2BD11;
	Wed,  5 Jun 2024 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717624610;
	bh=AZLhgZIK+xR+Lz8Bc2V3QyVe6tuq+F44I1uQOiXKHVo=;
	h=Subject:From:Date:To:From;
	b=jybpsqTn7HiUpwZnBing5Qi2YY7Jw6QiCh8ntQL+AjKJ/I2f8sXZ1iC/+58F0bOF1
	 d6a3AnYoP19TtxdBg9ce8EOaRALOCgdqHxORPwMX9K69B0aLREbcb4B9gIDF32YFtT
	 9L1R5HRxQMo3XIXUEU2ESVmiOEU3X0XcekxIsF4KhqEA41nKVLDjxE6DeLE+v8T1cY
	 Jjp8j4SNGGh8A5Qbv08MltFyVUYqktMPXy3gIiLGK+J4g1P/k6hkwS3yybUg+OtPUc
	 Gz6Q8TP+av1CHXMvoM5HMf6J0+fFHS537tY+Fw/bCp+v77QGwA0dhHsgf4SwqwkIRA
	 dG9tZxm8WS7FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B97B3D3E996;
	Wed,  5 Jun 2024 21:56:50 +0000 (UTC)
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
 <171762461074.7104.12921845808124534886.git-patchwork-housekeeping@kernel.org>
Date: Wed, 05 Jun 2024 21:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] fsi: Add interrupt support (2024-06-05T21:22:36)
  Superseding: [v3] fsi: Add interrupt support (2024-05-16T18:18:36):
    [v3,01/40] fsi: hub: Set master index to link number plus one
    [v3,02/40] fsi: Move slave definitions to fsi-slave.h
    [v3,03/40] fsi: Fix slave addressing after break command
    [v3,04/40] fsi: Use a defined value for default echo delay
    [v3,05/40] fsi: Calculate local bus clock frequency
    [v3,06/40] fsi: core: Improve master read/write/error traces
    [v3,07/40] fsi: core: Add slave error trace
    [v3,08/40] fsi: core: Reset errors instead of clearing interrupts
    [v3,09/40] fsi: aspeed: Add AST2700 support
    [v3,10/40] fsi: core: Add slave spinlock
    [v3,11/40] fsi: core: Allow cfam device type aliases
    [v3,12/40] fsi: core: Add common regmap master functions
    [v3,13/40] fsi: core: Disable relative addressing during scan
    [v3,14/40] fsi: hub: Use common initialization and link enable
    [v3,15/40] fsi: aspeed: Use common initialization and link enable
    [v3,16/40] fsi: aspeed: Remove cfam reset sysfs file in error path and remove
    [v3,17/40] fsi: aspeed: Refactor trace functions
    [v3,18/40] fsi: aspeed: Don't clear all IRQs during OPB transfers
    [v3,19/40] fsi: aspeed: Only read result register for successful read
    [v3,20/40] fsi: aspeed: Switch to spinlock
    [v3,21/40] fsi: aspeed: Disable relative addressing and IPOLL for cfam reset
    [v3,22/40] fsi: aspeed: Use common master error handler
    [v3,23/40] fsi: core: Add interrupt support
    [v3,24/40] fsi: aspeed: Add interrupt support
    [v3,25/40] fsi: hub: Add interrupt support
    [v3,26/40] i2c: fsi: Calculate clock divider from local bus frequency
    [v3,27/40] i2c: fsi: Improve formatting
    [v3,28/40] i2c: fsi: Change fsi_i2c_write_reg to accept data instead of a pointer
    [v3,29/40] i2c: fsi: Remove list structure of ports
    [v3,30/40] i2c: fsi: Define a function to check status error bits
    [v3,31/40] i2c: fsi: Add boolean for skip stop command on abort
    [v3,32/40] i2c: fsi: Add interrupt support
    [v3,33/40] fsi: hub master: Reset hub master after errors
    [v3,34/40] fsi: core: Add master register read-only sysfs
    [v3,35/40] fsi: core: Add slave register read-only sysfs
    [v3,36/40] fsi: i2cr: Adjust virtual CFAM ID to match Odyssey chip
    [v3,37/40] fsi: core: Add different types of CFAM
    [v3,38/40] spi: fsi: Calculate clock divider from local bus frequency
    [v3,39/40] ARM: dts: aspeed: P10 and tacoma: Set FSI clock frequency
    [v3,40/40] ARM: dts: aspeed: P10: Bump SPI max frequencies


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


