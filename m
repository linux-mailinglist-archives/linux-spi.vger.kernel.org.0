Return-Path: <linux-spi+bounces-4114-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6B09433C8
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C442C281A04
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A21AD40D;
	Wed, 31 Jul 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvZtTPx8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A90171A7
	for <linux-spi@vger.kernel.org>; Wed, 31 Jul 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441633; cv=none; b=OIeL9JSqj+yqWwNnJk6eWMF9YtyYKomn1DGsthWsYER+Yz3YY6MnDFrhsp9sAFnNIVj3juKMmyULXnUmWtdMJqUTAiRVFd+T2nP9ciabk9LTgMcfAi89w7UkLP3x5FH3TPEakdZ33B7zRd3hpy1lnWeaWlcOu/AQ4AOU5g3kk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441633; c=relaxed/simple;
	bh=K+4+HxSQw0zPAil+em4lj1YNTqf0BrJGG83JhW+CCSA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nhTNdWIm4LNuw6Y2QsNECf+sBhOcw5kNhTkE9MOI2fdCP3ptas5tpAt79NRF8Ire9T+j5XLNTxDQZQdh6mAGsg3mfDLxku8e8nx97b4R3rVVSZm0jHkkNyTcfewXNAOU+oHf6i1hP9iRYtZ7rze8BfsOW8+MvMS1mcXc/WQsPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvZtTPx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EA17C116B1;
	Wed, 31 Jul 2024 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722441633;
	bh=K+4+HxSQw0zPAil+em4lj1YNTqf0BrJGG83JhW+CCSA=;
	h=Subject:From:Date:To:From;
	b=TvZtTPx8nVOZwTMZtIQSrPrZtXm8jeLRtL8GxFOBUHNceMsjRRtbFm1W6glKMHfQO
	 0zJlkVTXVrPkYXP6n+fQUD4EGFPBL5E5eS7HfKMyoRS6TuyPfBQSnj+unNFTj2oTAC
	 hZLFRbrRso7uJ6sGrHn9OOAftIUpHvJ+zl2rZgcRKo6PRkps4XV5oUOpkUBhW+eoQj
	 O3+5ppEyM8sulTrky1Um0snp9TJQwYpYLjFsVxvPOrUx83/ot35YzCkCxw6A4u1geb
	 H6abyxkLaLimGxaXAJjdjG37d/PyVQJ0tRvExRCrkXu3Z9KUZbVHOhwBe8FvccQSaA
	 9pau6nE1wWi3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16E49C4332F;
	Wed, 31 Jul 2024 16:00:33 +0000 (UTC)
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
 <172244163303.23964.10027400277826716716.git-patchwork-summary@kernel.org>
Date: Wed, 31 Jul 2024 16:00:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rpc-if: Add missing MODULE_DEVICE_TABLE
  Submitter: Biju Das <biju.das.jz@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=875350
  Lore link: https://lore.kernel.org/r/20240731072955.224125-1-biju.das.jz@bp.renesas.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



