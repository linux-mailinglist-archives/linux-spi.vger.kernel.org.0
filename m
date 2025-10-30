Return-Path: <linux-spi+bounces-10920-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D6C20D98
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 16:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C11E1A21B9B
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82053218BA;
	Thu, 30 Oct 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6touqN/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DB31D736
	for <linux-spi@vger.kernel.org>; Thu, 30 Oct 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837028; cv=none; b=ANQfmRHoyx19Mys5cby/xCsf3KWxfI/UpHgYdg1b2E836bYjUVMX0LBDpx7OSu72w1IEHaNojWFzpfzLeWIypqYnYAsjhi0xJXLRoC9sGKuOraKBWtZlYtT9Em1s7SutKiJkT+Qz8PVxD5ylWrJDP0/v9v4aeBxWF3La8wxTclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837028; c=relaxed/simple;
	bh=Y5+9qjyzS/NtiwdhbvWdbAunKqFZEOouFrssJic8qAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Zg/MHEd+lazSVj6if3RejMrgYsjfsOa8k1M635L0UEjj4Drxwsz4+BF4hVDczEk96GM64PyWEWmXaTSryNd7Y+Ki9DZsVOGahjgsiU1YHD1sIbLhYphFj9d0wBiAiaxxVvG4zgwHYbfO1lRcFBSXSJ+eHWzWbrkWcUNdvN19NDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6touqN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9D5C4CEF1;
	Thu, 30 Oct 2025 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761837028;
	bh=Y5+9qjyzS/NtiwdhbvWdbAunKqFZEOouFrssJic8qAw=;
	h=Subject:From:Date:To:From;
	b=N6touqN/YZLZKZfxdH76DihYfSVMf1ULfbD09/yQzNg0LGfeDzY38JPWyX30y1y09
	 0lCgS9h8dzSJBxINC0b3hetDY2C4wA8n6D0/jCqay1U4Q2zug5wn0BEvKLX1x46J8H
	 JjoVxAEb+YkdDXSQmymoiQc3a7C/7wzGe+BvnxcGDldP3a9nPRCNIqhAxxyh8TtFhY
	 7O3Sb5jb6vuymca9qr4HtBmoEmQkilGP8t6/h7Kk8DsahrdMTfQbfURgO/zvrQ9cJo
	 4PinRJUpB4/M2CTnnADbpHaaH7y0RDz1EsairCWK5wnTMSc68+JeK/rNFqq4Zh3Wqg
	 fQZ1eD9/IDWCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE7303A78277;
	Thu, 30 Oct 2025 15:10:05 +0000 (UTC)
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
 <176183700444.3885214.15996171407815888236.git-patchwork-summary@kernel.org>
Date: Thu, 30 Oct 2025 15:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: tle62x0: Add newline to sysfs attribute output
  Submitter: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1017730
  Lore link: https://lore.kernel.org/r/20251030124755.1828434-1-zhongqiu.han@oss.qualcomm.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



