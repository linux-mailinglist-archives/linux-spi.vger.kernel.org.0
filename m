Return-Path: <linux-spi+bounces-9162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7DB0F7B2
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614441CC03FB
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE331E7C08;
	Wed, 23 Jul 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twnap5DD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B7C13B
	for <linux-spi@vger.kernel.org>; Wed, 23 Jul 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286387; cv=none; b=bL22SXU4++wCscoPr4CIDV8cmNGC6Xf0R1xrJafCVRwJPiwXAxxDFlx+ku1slxuiM6LP37S1CD1W7c+NiYP5hxBlKMDII6vj8ILTl0yDLtTaUpmKODHFtX61WsGNV/NGZmxirwpFemv0X50MYL/gZH5HfEROgKF2LGsvLcf2G7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286387; c=relaxed/simple;
	bh=2MhbxH8A7TYMaWkzldvU4Mq6PuD7udgEB2qc6UT4Ms0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dE7HCy7uSucvIifWaPIZ9V9JZFkEvdzRivVno8xotDrkd9W7TlhFpHB3mnncUrJGsSa0QkIlGhYsbZC4uGtIsjWjwcipzXnEzZGpm+SR593Ch80c71LHPQOyctol3x4dcRBGv2Pwq0N0g1avlz/QCuZyJRT/hKsmljT2xW7Zltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twnap5DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87115C4CEE7;
	Wed, 23 Jul 2025 15:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286386;
	bh=2MhbxH8A7TYMaWkzldvU4Mq6PuD7udgEB2qc6UT4Ms0=;
	h=Subject:From:Date:To:From;
	b=Twnap5DDB7bwEczRfE9/i1tnutqMjktnZXUXEbbsfuK6AVJNKRz+bdSHCDp96Rb5N
	 C1uM4xAAwklr9f0V/bgXhyOodvte5LY4ESIYJBEeXtr/b5SGVy5fXBIFlwVqn+FNxn
	 SFY7v9YJjz0VZkVHaV93f3KdaHhSaGWlc/s/1v6HxAM070ffsSlvE2/yBbRnNhNicm
	 TTKzz0bUUk0eAQ1V/5YRITarJkRZuEuuRBSJP+0al2Q6Mnc+0U2Vpln9V3U4Lv2TOx
	 eMBC1kC4NO4tWyWhoOfv2J7/JRQgniJ0UUFZSiEiMe4lPKnbHX39I6vFQrQ0e8n2QL
	 W8Us8dthaj+JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB241383BF4E;
	Wed, 23 Jul 2025 16:00:05 +0000 (UTC)
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
 <175328640436.1668837.14393703386927247579.git-patchwork-summary@kernel.org>
Date: Wed, 23 Jul 2025 16:00:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: don't hardcode ECC steps
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=985019
  Lore link: https://lore.kernel.org/r/20250723-qpic-snand-fix-steps-v1-1-d800695dde4c@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



