Return-Path: <linux-spi+bounces-10066-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D79B7E3DA
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F0F1B2236C
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C852C21C5;
	Wed, 17 Sep 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rc1fplWY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA461F5820
	for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095813; cv=none; b=aVcPLs+QFQ4Y3L48RKNblGP52dgGae58CMBdlKNLtodbY0S4npXz9LcogJM26UFbznLtNxyq2uMa3MLukNQW9cI2Y8guZdKM4sKsmdmzMHRXAo5ZyUiZTCTtbmZgYh9K1KXf49hE/dZX33Ibx6/pCBDmeV9/Fbf3smTtullk5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095813; c=relaxed/simple;
	bh=GdGVcgayB/CkwYoykWwCbQxwnKsFwsf4qzEfFwoHmWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RuEzkBNI2LtPxRCYS7tEzuVLFzD8CyOVabD0Un5P7f4ALutcCTMW7DpzUdqjvEEzxL80gvCDUFcPlF6FD/3k5x0Xu0W2vgt0KpSg92qefTJqr+kps6TZh5mv9O2mhG08r6lei629RD127I62XJLK8sdAao3m7PsjbPmPqV5Q7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rc1fplWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67E7C4CEF0;
	Wed, 17 Sep 2025 07:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095812;
	bh=GdGVcgayB/CkwYoykWwCbQxwnKsFwsf4qzEfFwoHmWQ=;
	h=Subject:From:Date:To:From;
	b=rc1fplWYMp70zLq0ECAvelz/oyaxLsl9T4qJlFokXt33ZHh1ur2ogvnnyyat1m9bb
	 WQ/QZrH7T3WJjbPMjm4ZgBw6Cu70pUHZHeQsMAgkICOTDRHmjBSScDjVT0l7580ZMQ
	 BaZ2Q2puinGJqMzizIFtNfUhm0VqfPXxnTgjr98zdwIMVKXu6eV8QzOS0MWZ6Fjv3H
	 zQV2lYFnP4FfT+9o+WypV5Co7VnCP1t+3a36Wj3YfXtP+7jUejJZtLngnlOaiFWkQn
	 cGoLdBfiHL/QDQnac9DT+E1AffZwasP42t05jXFKhlIum/VPaLMCaTSjWiqJ0keKcc
	 +2v5ueyDqGkUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1539D0C1A;
	Wed, 17 Sep 2025 07:56:54 +0000 (UTC)
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
 <175809581313.1512343.17773508613384562671.git-patchwork-housekeeping@kernel.org>
Date: Wed, 17 Sep 2025 07:56:53 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-nxp-fspi: add DTR mode support (2025-09-17T07:27:05)
  Superseding: [v1] spi: spi-nxp-fspi: add DTR mode support (2025-09-16T07:56:39):
    [1/5] spi: spi-nxp-fspi: extract function nxp_fspi_dll_override()
    [2/5] spi: spi-nxp-fspi: Add the DDR LUT command support
    [3/5] spi: spi-nxp-fspi: add the support for sample data from DQS pad
    [4/5] spi: spi-nxp-fspi: correct the clock rate for DTR mode
    [5/5] spi: spi-nxp-fspi: Add OCT-DTR mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


