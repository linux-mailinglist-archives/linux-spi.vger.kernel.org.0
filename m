Return-Path: <linux-spi+bounces-11574-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4BEC88CD0
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A66F4EB804
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E4310624;
	Wed, 26 Nov 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP5t8Wjx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0131A7F9
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147466; cv=none; b=ccS6y/nXydy8Wha0ic5dJHkR0ZKjONieJYjAcbtyGHrRi6XHDTbs3C6+tW0VVoYvkZ1QAXaT0iVidJp4TbAXsUIY77nbVKdzcAWoBZFwrVY6r9lsqAojFMQf4qaXUUWpIuT9d2BstU933bUbCdVqeFknLZpMx7jBEW/Wj+RgLaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147466; c=relaxed/simple;
	bh=5JbiZQmcJd3DrXYBCFXJFf18hEZEkc438bO3xBSlit8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OmuGpB4s+FQlDQpqTCeElThxZxC7bZc3Ukmspv4ax+kDDsWGXPOybBwErw8eBt3RSFdK+Q4zxzng/zWcBZhR2+YM8uQsz6sWf0jcuEXeTC/4YCUZA0nnCvQ9JEZZGW+PfMeH1XjHNoB2L7ZCeqh2gkAxUIafE2H1tKvyLrDXVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP5t8Wjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CB7C113D0;
	Wed, 26 Nov 2025 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764147466;
	bh=5JbiZQmcJd3DrXYBCFXJFf18hEZEkc438bO3xBSlit8=;
	h=Subject:From:Date:To:From;
	b=mP5t8Wjx9Or9t6cLgIwqWxyz3Vqd3ZI0lS15WtwYjYvFaAnXHL0NYnFg42MXj/ZXd
	 BrMzfMHYz4dHYDUPx+iifjF7XJHSdTRUoZje3cN/bfVqcUH4GlYA1zllP0DXX6XE2f
	 Zs4/fnqPwRfUItGCKeFFeYCxQVHuln4hf0j0RIUoapNXS0IsgEnx1SUFoTdKa5jPjH
	 R51fkeKPpRQpDgAUpfXcUY/nLvqIbkC6854Lh7z2O6zOEnSkESNIoWmDu0hXjjz8R+
	 gj9haQbj+j9OLzRYmiVrtO8qiWojwnSR4J6icZEOQLiEJA/x2NPPrHqGf703/cS0EF
	 VUruJuj9FJ2KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D15380AAEA;
	Wed, 26 Nov 2025 08:57:09 +0000 (UTC)
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
 <176414742794.1591174.3987267771942551181.git-patchwork-housekeeping@kernel.org>
Date: Wed, 26 Nov 2025 08:57:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: microchip-core: Code improvements (2025-11-26T07:54:41)
  Superseding: [v1] spi: microchip-core: Code improvements (2025-11-25T20:15:31):
    [v1,1/7] spi: microchip-core: use min() instead of min_t()
    [v1,2/7] spi: microchip-core: Make use of device properties
    [v1,3/7] spi: microchip-core: Refactor FIFO read and write handlers
    [v1,4/7] spi: microchip-core: Replace dead code (-ENOMEM error message)
    [v1,5/7] spi: microchip-core: Utilise temporary variable for struct device
    [v1,6/7] spi: microchip-core: Use SPI_MODE_X_MASK
    [v1,7/7] spi: microchip-core: Remove unneeded PM related macro


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


