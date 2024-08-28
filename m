Return-Path: <linux-spi+bounces-4358-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB6962DAC
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 18:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0481C23AF0
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6431A3BD1;
	Wed, 28 Aug 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htNumggn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE01A2576
	for <linux-spi@vger.kernel.org>; Wed, 28 Aug 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862631; cv=none; b=hMlk1XPh11BJVpDkRaKzu0C+/v1rxm3h1ynUgNqvWFniEgXhCk4vhoXHrKQFnST6XxUfpXHE6QQgLjccnmSe67WpGEGLk4Q2e1oY8+SEGUtLyxigtVOBlTQgl7CLL6UAT0xC8rJZEQAKoYgnvcqx7Vm7gZpkBDFgmS4ZgZ5PXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862631; c=relaxed/simple;
	bh=o/Fhz5JB7WW7Y4JNMnj0NWlHgcjmrhN+IZDU7Pd9bHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=K5f0vmphbd+L4Jm7wvZlOFAHO384X097okBHxee+kRVScXGK89RefzPHDD8gNmyThRTkJmwyIDnCNq5lrNyGx4qNmY3vfSZf/WPqL3An5rJsDHqPJZAutDMAob8ONbauqvy5nrO+t9dQoP8QXjozFe7cRkAuE2TvGeD6bzuButU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htNumggn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E4EC4FF57;
	Wed, 28 Aug 2024 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862630;
	bh=o/Fhz5JB7WW7Y4JNMnj0NWlHgcjmrhN+IZDU7Pd9bHs=;
	h=Subject:From:Date:To:From;
	b=htNumggnGJaTY/B+4aTNz/Wf8BAYj8gdx4D9EFVDXRzxsmmRzvMFtazXayt2A70Zj
	 wnr3aOmKW3sZKa8Z3k4P9PTM3XgnJPwGy4jqEdtlOAaeGNw+y9GP5fvIzRJJMlNQPJ
	 K44fDi/qmBu0Dm+IDUCrZFR8lddrUd6bW+rdRt/rhjjijEw1DNLbG6jqc+KjR6jHzj
	 eUqYL/gISv4Ghd9lU0sIEbwUnOWDFcSpufGZVU8DkWhXEhcRSx7D9CK4nLQYKfqKGF
	 ZralS6v1kvErTZyevwsPh8nFgOY9eLBrrP92sjj4aWb4+iUX6Wy6iDrf+bqHq4sMeP
	 WVH59M1at9dhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3817B380666A;
	Wed, 28 Aug 2024 16:30:32 +0000 (UTC)
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
 <172486263088.1318569.15236024644863410700.git-patchwork-summary@kernel.org>
Date: Wed, 28 Aug 2024 16:30:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: davinci: Adapt transfer's timeout to transfer's length
  Submitter: Bastien Curutchet <bastien.curutchet@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=884106
  Lore link: https://lore.kernel.org/r/20240828063131.10507-1-bastien.curutchet@bootlin.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



