Return-Path: <linux-spi+bounces-7715-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8EA96C59
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CE189EE60
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6D27D789;
	Tue, 22 Apr 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJeLLBfU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4328136C
	for <linux-spi@vger.kernel.org>; Tue, 22 Apr 2025 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328057; cv=none; b=IsoXXjqKCeK8IhDLTfEfQkwoZBSGHTyd7CvjeoiAC7395Lx+goLkxEg5bLYiFhD33DpnDQtDUEh6ZUXDuqSOh5qpHGKC5cM0mVmpwWigD513dNWmD1srp1YyGdep8HXZL0Ezj+WlPAlOs6p5bV6za0cFcQ5eNXx/beyZ9u137CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328057; c=relaxed/simple;
	bh=FW0a3LsmPj4kscd1PuqGLZ4ckGHvN88z+J/FBgbEOZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kleW+omQ9CmhuffKM/4qZrl1GBC2J+VLgpGrYqFzI0pf/bPTQBWNAXElzv72nIjwnrPb1OxI/O5cmJOiOCcQBx++h1jKbH9NmzHQTW5h1isa8LdiLqBbuE+eiGrBmfsFm6DHjgluoVqdzHzMZ412LHE/hwT/8zHQZWza3QO8xx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJeLLBfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49351C4CEEC;
	Tue, 22 Apr 2025 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328056;
	bh=FW0a3LsmPj4kscd1PuqGLZ4ckGHvN88z+J/FBgbEOZA=;
	h=Subject:From:Date:To:From;
	b=RJeLLBfUL3ILhOUAI5v1AniSBQc4Sh+b7NU7B0NwyVXNr4NocA24D8OP7u39U2mBs
	 /bhqf8AFZcQQSgcdxcPLtjVignD4s4/ZMCa7CKuZ8PtTzIAEuGDArLf69mdIcvFbq8
	 cnqe3Jl83lV6/FTW3XktszoNjVYvFKqDJy4KuoRE38BsNhwKHKZhkqumgYXJcgHovC
	 rbqmSkrxyoqpq5WjvPtYCSY2yazthXpjLOZFEIkM4d4xliVzLK4fbz54BQ/TyyZlSd
	 HZaQlIIX1Mlfy56PZMrYA1tC+VpKgBaYSxcWz2HCuH1ICqyPfXZVXFf9AGtmAZZa93
	 MDZWQvjIwLR4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77F30380CEF4;
	Tue, 22 Apr 2025 13:21:35 +0000 (UTC)
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
 <174532809397.1904074.16673647154538384702.git-patchwork-summary@kernel.org>
Date: Tue, 22 Apr 2025 13:21:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: offload: remove unnecessary check on trigger->ops
  Submitter: Andres Urian <andres.emb.sys@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=954958
  Lore link: https://lore.kernel.org/r/20250418171426.9868-1-andres.emb.sys@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



