Return-Path: <linux-spi+bounces-3625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7391A7C0
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 15:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6891C21479
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1910192B7C;
	Thu, 27 Jun 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHiUOEy2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85581922F4
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494433; cv=none; b=BudzHOcki4mES3uPRHu2I5p1D+R+eLE7uvi9WduCYzXChjbJCgCNRCvTrcGgBsxIqMJzSGrHmGUXBGQZLuNrRGCdDbdZwLfyDMbatte5zncD83YhETXh8E/EahnolFnBNc3hA285MrE+KxUtbrADvuhnXi9pxKdRdxYQswyd5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494433; c=relaxed/simple;
	bh=KL6RqFH3HXQ7BnOG/3t4CkPLofUlkkc7OOsyQkNiduo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iM9ufG0cMs5MF4EQeBN3XhWG+3p4Z33rRaPYRqafwoSX3yiFMQYxjEBvoucpMFW+PAcrvEjgTI/Mu+DAGlxRUhYJp/+w+ih2HVPo7WBJlZ8mfWvteqEJPzZKIINuZgPeMaQJhz6ZzT2NUrUJhIu84AXkB+qfzajt/TKmfm8kulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHiUOEy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B366C2BBFC;
	Thu, 27 Jun 2024 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719494431;
	bh=KL6RqFH3HXQ7BnOG/3t4CkPLofUlkkc7OOsyQkNiduo=;
	h=Subject:From:Date:To:From;
	b=OHiUOEy260WviJGr2dCP+cjkUbLSdrjdbK4p0dwpmgZh0Jt6F7Be17M5lpvhUJ32N
	 TP4bb17GimzYfj+4KV3BsRPFotp6qUFX5vwUGWlhuERtPwsuB5JiBDQbFKZgBRNPXE
	 rDjXAsGZLZeP2WW2GgOOiq+s/RbKuuTZDZ3m94EqFnteFJjDudBLgK0EGKGj4SRn4O
	 dVxd6T7EawWzdkywyGGsCRuJXcNxMGc68z/12Vdcz9bFah7W44/1dlWeZJCJtB/5uQ
	 fwxUvhYbY338je1Aaq48G1azfxQgHOM8n61kkQIJOfdNdGzNfSi3ZUsVtP15oyG4kE
	 zReMlLCQN5Ceg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A16AC433E9;
	Thu, 27 Jun 2024 13:20:31 +0000 (UTC)
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
 <171949443117.896.8838247065277015665.git-patchwork-summary@kernel.org>
Date: Thu, 27 Jun 2024 13:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: axi-spi-engine: remove platform_set_drvdata()
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=865885
  Lore link: https://lore.kernel.org/r/20240626-spi-axi-spi-engine-remove-drvdata-v1-1-1752e372dd5d@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



