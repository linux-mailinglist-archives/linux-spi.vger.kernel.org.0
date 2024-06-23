Return-Path: <linux-spi+bounces-3541-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE3913A65
	for <lists+linux-spi@lfdr.de>; Sun, 23 Jun 2024 14:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263D12817DC
	for <lists+linux-spi@lfdr.de>; Sun, 23 Jun 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50FA180A90;
	Sun, 23 Jun 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+5ChupB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42E148825
	for <linux-spi@vger.kernel.org>; Sun, 23 Jun 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144628; cv=none; b=Zlk93gr6AhHuF8BekPYNY/ccdfesOSXF9/LVHYN/4PWU/5vlKkiAJJNQhFMPUsG5qqqDqyaVt2qxKJH8coBVUEvdCNKZu7uKhcUuARg8MXwbsGYsK+ktoyxZLTpuuo+ro9HlqgZ1wBFVrcL+2I9XpNMSXurqL0hldxWQdNi/alU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144628; c=relaxed/simple;
	bh=Vv2w5u/epDB1uPt3rmHa9VmDftNWQgt0yAB69J9dnLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Kz7cl73cKIK3BiAqx3JiHIfDa+viAYvmApTv95baGnssq8ytLQAF2/HCce9dWMeDc+rmixvOiIbh1RTcDpsuFBUYVvop6HNu1vCAXU4DDj/zns5Btv00bUHO/8kON492O03xX6dywmWWvnQIUG8x2HoSSu+yAicCXb52R6j/qgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+5ChupB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB61C2BD10;
	Sun, 23 Jun 2024 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719144628;
	bh=Vv2w5u/epDB1uPt3rmHa9VmDftNWQgt0yAB69J9dnLY=;
	h=Subject:From:Date:To:From;
	b=V+5ChupBk1zKlYBKxB8qaD/B94ibgp9hdyIkn6b4LSyeJYVXRiGCCWswO6Om8AXd6
	 S0qR1DyFGjbn0Mn/yet7aIIe0NkuwhYVYjitKj6tWy9rtguCwW02dvviMxANoFNm9j
	 fx+SJqaYv2wpoHe4yuhsPegDkrf4naKmw79SXgJyOlGi0CQBHoviWBb6EZtI9JY7zS
	 zlUMPk9jfKB1R4VfYO6m7ivlIe2uLkVDnbQYoH6kptpTNFn3UauYAdp555U7ckJxfJ
	 B7Z4OAHVM77/CwAXL/iIgj6hm+qlaNdwMlQmZDYXi3zegnMEsTAealFL3VefvRqyBo
	 8pHORXJzwWi9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27BCDC43140;
	Sun, 23 Jun 2024 12:10:28 +0000 (UTC)
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
 <171914462805.16662.7967751825365841869.git-patchwork-summary@kernel.org>
Date: Sun, 23 Jun 2024 12:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=851507
  Lore link: https://lore.kernel.org/r/20240508095610.2146640-2-u.kleine-koenig@pengutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



