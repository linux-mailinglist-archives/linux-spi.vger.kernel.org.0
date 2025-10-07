Return-Path: <linux-spi+bounces-10446-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1A5BC1088
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 12:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1013BF061
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE63230BCC;
	Tue,  7 Oct 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRfinKh9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1C19E7E2
	for <linux-spi@vger.kernel.org>; Tue,  7 Oct 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833617; cv=none; b=ZQW+S5poVjoG5qQKi8H/hZ8XuiaS+xOSssSeUfS95H+yd1+WpiXm1sPXFizlGCHp91iSeinWI4vgEhM5LuF6y4xMLi6tVQVdMX7BEXgZcFBPjRfPIBughmWwV4c8W6XcpSd1mLenqqzxksVOv1GL17H9s4+7eWO32zw0U89ipRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833617; c=relaxed/simple;
	bh=lPxMp3bFrYYQhPUp4DyTGjtZkfYAb0fuJgWAb0bW5RU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=h2U4GbX14G6mVyidmgd4U494ZID4X6eZIMqCVBV7aQIugLU3q1QBFtghS0GO0JcJaRfLyLdvlFDWPrQf1ivq+EMarJa1+sX5WOqyGTMsP0LR9yXTbTneFOL6c6LdTfOULOJNSWyRJKePtDm72MxutDFCJA8TlUimvqfLqkLHQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRfinKh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56339C4CEF9;
	Tue,  7 Oct 2025 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759833616;
	bh=lPxMp3bFrYYQhPUp4DyTGjtZkfYAb0fuJgWAb0bW5RU=;
	h=Subject:From:Date:To:From;
	b=TRfinKh9maeN9bwvQhps0KTJrBXYBGuGdVLCL3SeRh+Evpz13ZvbRWRSXyo7BKzmc
	 kGL5WvvhT/NkSggcB9pi+9zCzYR7GAwn9cPabLurn5EvxS/+znlH1KNLJQH8mIs7Z+
	 bEFHrL5h9FvXYmlBLXIrFRW1vVpYb+M6YKtQN0wG+eeC9niS49f5pnpUJiBc0zAG79
	 aRLyJdGER2lv9qwT3ES6LncQl3r9fDAksVPQmGTOSY1fjDq0wXpcR9TlEdBhG+HRrE
	 hOp4le2RLP8LGm/neCN7tfT2jeEJHyL0Nm6wTqJ2fMZlq+TpK6cuwjMrowhDzI6JSv
	 wgl45+YKFuqHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B16F039EFA5E;
	Tue,  7 Oct 2025 10:40:06 +0000 (UTC)
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
 <175983360509.1846366.4317923760071095542.git-patchwork-summary@kernel.org>
Date: Tue, 07 Oct 2025 10:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rockchip-sfc: Fix DMA-API usage
  Submitter: Marek Szyprowski <m.szyprowski@samsung.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1008244
  Lore link: https://lore.kernel.org/r/20251003114239.431114-1-m.szyprowski@samsung.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



