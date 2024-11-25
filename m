Return-Path: <linux-spi+bounces-5834-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B085F9D87C8
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 15:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76328286455
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC701B0F04;
	Mon, 25 Nov 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQZk68ad"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7C1F16B
	for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544417; cv=none; b=rmdgmpaX8fL1h6M2Y8myKzRyW+MrCEpNiLHBjVWs5ofjgDY9hxzafDdlWcyx9bM6cz7H7jVDhqB9gU+gJlNMBvQHs/eGldvx9ZOLBZFy1RmvCee1o5Yx0ZLsqJ6NjFpW5mnDqJRmOb8NhpBIN+sQ0DGNoPoH4KvaLa+h1XHsu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544417; c=relaxed/simple;
	bh=uwCFkQS3nv5Rg35JA0fIBMKmNxCB7z+qZ5RT0xztnv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oHt1kr9/V21BcYmqEJwjWTms5VuxaFbGrEEuPViuyCGOMKffuyAA0rKJCK1liIh3y5I4IbKp1d3sRb2clL9LUs/v2bXkYx/W7DgIQJKpF2tjiTYqGrgaz8dTJ0DtW15boyYHO2z4+ckwRubCkG3Q9yDpvSXSSXZQgw+BglUHjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQZk68ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0271C4CECE;
	Mon, 25 Nov 2024 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732544417;
	bh=uwCFkQS3nv5Rg35JA0fIBMKmNxCB7z+qZ5RT0xztnv4=;
	h=Subject:From:Date:To:From;
	b=IQZk68adxKWm66fBMWm5/wkarftGGCTMPIk5n/a9cc3D29CXMBxBVfI4pImd1E9s0
	 3NtBnI8RcurP1UK+e972UY7cK7TmHO8jnQbP1MMWJjUHSw8nOI+5xX99umVR2H5zqp
	 vnOHccIpXM8hi/gOBy8UC05Puk26u+D+T766PQ33ZnBx6mCo+UzDnAQuLhR5quV+aN
	 s4sIvyb0azcg8SRSwUugf4PkhN1dK8tcMyHGdJJ6V1JUGwRNailO1YmbWe7eJ+U5AZ
	 f5NGjLQdcDz+sWk6z2hpeKMo1AoU3UgjViz38RkxkzSTrNQMSXOeTdU8avfvyDZ0YB
	 GpgKpXRFIeulA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4F543809A00;
	Mon, 25 Nov 2024 14:20:30 +0000 (UTC)
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
 <173254442928.3919473.14678501242646492538.git-patchwork-summary@kernel.org>
Date: Mon, 25 Nov 2024 14:20:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atmel-quadspi: Fix register name in verbose logging function
  Submitter: Csókás, Bence <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=911804
  Lore link: https://lore.kernel.org/r/20241122141302.2599636-1-csokas.bence@prolan.hu


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



