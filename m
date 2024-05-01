Return-Path: <linux-spi+bounces-2674-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051438B8B79
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F76282D18
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF212DDBC;
	Wed,  1 May 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExFpu3CG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE512B15A
	for <linux-spi@vger.kernel.org>; Wed,  1 May 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571527; cv=none; b=qjmFbaoHiRdhXlvzU+bvT/PjBnDJsHEb3OQMi89pJXODL24lOzECXAcRQj+l8OkCmOF3R3fglcvrGc5+g8AslMrI49nOetx/zeLlWl1NYBlL+0OdWJhuVzCLzd9VbI5CMOBEcFUYt09RKdWFMil1VfOlpd2TfW4VyG7VWrQO8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571527; c=relaxed/simple;
	bh=M1lR7MHr/MXZIT955MNDZtXrJwxXPAEujbIDuG9MzCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OIVQfiRNxoaVOW5ipHcLDVBwvreVOrRHCVUj16GzDUIxw4BOfSEBb+w2xo+3XJwyV5LY3D9vVUgMN5Cg34X3jRMwtK5OrpheXBteIuD6Krk1PC/FOxtSW9RSXQwGIX1AjHFhCqRnKqBk8IXv5Md71dbmon0RxIcWNqMZ000KcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExFpu3CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEC1BC072AA;
	Wed,  1 May 2024 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714571527;
	bh=M1lR7MHr/MXZIT955MNDZtXrJwxXPAEujbIDuG9MzCg=;
	h=Subject:From:Date:To:From;
	b=ExFpu3CGapdMUS0Tg2dfsWQwV7V5VT3Je8BrRPBdYs0ZceNLmo0opKkjmzbdqaVIP
	 Lmh35gjwCrnXSlIxCyBhtObi+aiJK0nkVWAIH0ls2em6c7TsOF/rTcDFXezt3F4+p7
	 D6xHQLWTSaVKTAHiZNMyUqFGt+ivfa6b9B0+7EUvd/hLi9WYzhQKbJzsG1K32Is+ZR
	 VXlgdhY8hAuug4mmKDkJb9tShLmridTKm3XvpFp0IvHnI59+XTVZDlGp8jcWJVo/Fd
	 z3kqDUgwjfYAQUnW1GkltC2Gw5EnfGdTTnk9QmSkSTpT2QkTL9nl9YiEjJLWfuTeMl
	 93Et/6AvP/Jeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFABBC433A2;
	Wed,  1 May 2024 13:52:06 +0000 (UTC)
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
 <171457152677.22752.10071785954959116502.git-patchwork-summary@kernel.org>
Date: Wed, 01 May 2024 13:52:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fix null pointer dereference within spi_sync
  Submitter: Mans Rullgard <mans@mansr.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=849435
  Lore link: https://lore.kernel.org/r/20240430182705.13019-1-mans@mansr.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



