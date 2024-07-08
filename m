Return-Path: <linux-spi+bounces-3789-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3D92A9FD
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 21:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C0D1F221AB
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569814EC5B;
	Mon,  8 Jul 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trU4ev13"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215011CD3D
	for <linux-spi@vger.kernel.org>; Mon,  8 Jul 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467738; cv=none; b=LFNvu7PRGpKkp9z2XGW1cVMDDmHlm3zpqlofsG+9v+fmBN8e/q5sV2PDeFFcVZ+BlaZSHgOadiazUPP/EE3mMPmDIqsoOsIP7NMKNnVsSgv932Q3arVJVd20arnwSNMi21z5clqyHZf3w9MXGoYBUrYTDyWBCdHmyBcK1uJOOK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467738; c=relaxed/simple;
	bh=UU8uCmAqLKtd4VV3aclRmDDsDHIRbVcfLZgC0ZGyimw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DhjC7LYUGd2v2O0yVZ2UDgbfqanEtRLOovuPYU9qySocHytP5mKUj/bqUMhlkhQiM74xTBPl45gAzNwaqm4u0a+NghfhJQ2EkOe+FhzhMn4bSj+HzsQOld5tbf3QQyKJq+0pHk7HRlUiI/VDg74uyQs9yaOmOEiZZ7NHpwhRCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trU4ev13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC8B4C4AF0C;
	Mon,  8 Jul 2024 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720467737;
	bh=UU8uCmAqLKtd4VV3aclRmDDsDHIRbVcfLZgC0ZGyimw=;
	h=Subject:From:Date:To:From;
	b=trU4ev13QGL0pu3xGmNRkJQ20uzuvey5LdLxNXUbBVS1nYy9lFCCx8aQGZvtDY95B
	 EnNEO2eb253UXf3Gy+3CtYnp+7LhOhNYnEC3x3gfgGaWTCqWZWKhvFg3lcZJL3BnDf
	 0UWJD81l2m8rPFxvo9GfC5X9Vrt3yDozMR2pwTAD3yf42mEJJQAf/OlEL7Yo7fkbwD
	 5GhibRjxAjRNq32mKVNt8KYM/Q+nc9ThiblS5TAbEhs8k30NUmDHlE5lhs37ahv9WU
	 YPa6ag72I9HDngXwTFcGgNhlK0kTrFS0blNsP260NmYdOK5hqlKIs/lCfx1LLJtLUp
	 cvXSMLKm42tbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90AAEDF370E;
	Mon,  8 Jul 2024 19:42:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <172046773752.17805.9392169740536581677.git-patchwork-summary@kernel.org>
Date: Mon, 08 Jul 2024 19:42:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: add ch341a usb2spi driver
  Submitter: Johannes Thumshirn <jth@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=869346
  Lore link: https://lore.kernel.org/r/20240708-spi-ch341a-v3-1-cf7f9b2c1e31@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



