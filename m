Return-Path: <linux-spi+bounces-2052-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED7688D9AD
	for <lists+linux-spi@lfdr.de>; Wed, 27 Mar 2024 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8102A2F11
	for <lists+linux-spi@lfdr.de>; Wed, 27 Mar 2024 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F031A82;
	Wed, 27 Mar 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAEaQKQx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD728DBC
	for <linux-spi@vger.kernel.org>; Wed, 27 Mar 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529816; cv=none; b=A6JPoSb4CBu7Niu8Sf0dThfs/fAhY9Fhr0hSuhZ02D9/0E1iRtsciuKf3mGkaPpOYXjnFcHAS8R99HzPK2+W5vnsW53Oo9DBPxc/nqqF98/HqDRvZMx24z1UVR1dr+c2O6QUs4SqADzyFgvyAFh8/NQvYiRK1VQ3rsub87yD6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529816; c=relaxed/simple;
	bh=jeuXa6t/DE9nNS+z088AKpkCLMcQtWTSGQk1bS4yHtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=j9thEOFH6CkTB+cqL11ZeRxNdtx6ylvQHZXHW/qP4LYOUoGzxzv+HHEO1idW7O66kMtMIWpDAhlqkpMAIzDRzMKMUCfML5lzD6MltalJd/bwWEHfEVrE6luHcjCZkG9tviS4uGOz0TlVJHSpxi3DBHC3GvlFTbL96SPLax98B/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAEaQKQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D162CC433F1;
	Wed, 27 Mar 2024 08:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711529815;
	bh=jeuXa6t/DE9nNS+z088AKpkCLMcQtWTSGQk1bS4yHtg=;
	h=Subject:From:Date:To:From;
	b=qAEaQKQxe92G22seEZnETC5JslteiwEweYZu6NxovA5nbQvA/sEiZ6v/pN2b9MdTL
	 tsYnEbaR1gUbgLukS7KyTrhL5HA3A+0BxCesuTza6lT9OcCR632wRfZBhGKpSVJfJ/
	 psM4zbQb/GuwLZPriveQZ+hehwjkano6tjazg9S9OhMlAjjGVr8ywCkqgMUE8JgvKh
	 /VbUmS5isYmMUJPPtGmeWMThODdLkgZ4tfJ40I7KjaB9Cu6dmh/x5kgNXRsUFpH6Vc
	 8n5lqofkUxdNi8zCNpuuajOd57vs3WtVok6hmpk98bJ7ppWQMhXB1ofpnpgcFcAiDv
	 nyxCri0jCi/zQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C88F3D2D0EC;
	Wed, 27 Mar 2024 08:56:55 +0000 (UTC)
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
 <171152981581.15143.5260716380585453197.git-patchwork-housekeeping@kernel.org>
Date: Wed, 27 Mar 2024 08:56:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add multi mode support for omap-mcspi (2024-03-27T08:43:35)
  Superseding: [v2] Add multi mode support for omap-mcspi (2024-02-23T09:32:10):
    [v2,1/3] spi: spi-omap2-mcspi.c: revert "Toggle CS after each word"
    [v2,2/3] spi: omap2-mcspi: Add support for MULTI-mode
    [v2,3/3] spi: omap2-mcpsi: Enable MULTI-mode in more situations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


