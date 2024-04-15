Return-Path: <linux-spi+bounces-2337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6E8A4674
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 03:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22241F21363
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553E3D68;
	Mon, 15 Apr 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGVPVXrN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065B33CA
	for <linux-spi@vger.kernel.org>; Mon, 15 Apr 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143427; cv=none; b=VgLSHXIZ/SkqBDOhfAavffgBs7RMZFL3gwLChoV0OotiCruO2aIjk+eB2vSiunQ4j1CUTlQi2WT7gO/GwUX4+1uyeumgoKrkGYeF/vFS9I8DsOzeXm2VzTpPGe6U1KdY9ge3aeVmHDidvr+1iE2g4ot/DdQ7Q08+B36Z7ovgBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143427; c=relaxed/simple;
	bh=9220oO5+bQP91lZLgnxVJzMgsavQiA4MiTsWy439vUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IJ5Yw7gvaIGiBkFob5VFkPFigDXvO2uu7mGC2rZwiWnTXn4+amMU7KmShhx7waEFIBOiwV9qTKpdPGkgSkKZbWYGnp9gJphA7/dr3q8kh6+BhPO8m+7X1u1wsKSf5wiwxtq4IIZglRbMNPo2n0JZp1Elj4rbyo7g9XQpaZ3JLMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGVPVXrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28FF5C072AA;
	Mon, 15 Apr 2024 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713143427;
	bh=9220oO5+bQP91lZLgnxVJzMgsavQiA4MiTsWy439vUE=;
	h=Subject:From:Date:To:From;
	b=BGVPVXrNHCKX/789L5zVAWnzK1zFiTfmRsxhun3skS14LRRLCwuI5GK6Fjqhz5yv/
	 N6eSVDYL4BlhmfpMQYYHH+6WyDMV+ZXYlqm+wME9vo4wEGx9nSlSsiuxkEMQvL2QD8
	 JAZwRYVNXxLtJzgfje9aNbH/WWfT8P7yP3Zk20jb6FjOKiCi5jRGD8vLLdWI6+3lxr
	 CRvqfVRGSj4ufpPdw2UEY8gZ50sWv6N1XnRFg+q1bS2wGWhkmz3z6TY3Un5N8NTWDP
	 YEQV2f5vwAF6oQpY/w6L6b+x82HzgCkwBFUmZGYYrbYtbiKSt02U7ikXxXwE71YLtC
	 AAooIg+n32pWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12A93DADD1D;
	Mon, 15 Apr 2024 01:10:27 +0000 (UTC)
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
 <171314342700.16512.15518154091525719134.git-patchwork-summary@kernel.org>
Date: Mon, 15 Apr 2024 01:10:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: axi-spi-engine: fix version format string
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=844187
  Lore link: https://lore.kernel.org/r/20240412-axi-spi-engine-version-printf-v1-1-95e1e842c1a6@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



