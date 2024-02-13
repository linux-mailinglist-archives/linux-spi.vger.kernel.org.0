Return-Path: <linux-spi+bounces-1330-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE4F853A42
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 19:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9775D2906B6
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E91111A1;
	Tue, 13 Feb 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9oqx9b+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219060870
	for <linux-spi@vger.kernel.org>; Tue, 13 Feb 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850229; cv=none; b=BZgR/DqyFr3ypXIpHTS/LPLlcUSqtcDEEGoXW/ZdHGziXRmk9EoOTTt0ettpXYZtPQ0RFRFiaRwoIxxzWaqNkP1ThYUkd3QoF7Jck3+yahzs4LepBDAAyJuF+J1Xk0wuuZT4FlDiu5+rFm3UCXhmvftEdbDBf9xvz1K0b507gG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850229; c=relaxed/simple;
	bh=exo5jZmTqaaWNEAT4f4VLQjexoYgrhK1CrpsX9a1YoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RQziE7osz28w+cEFgGWar3d7RCrLjxJ7n3LiEl40R+TiS8so+93X9chCLcqKTtSHND1IjI5o05f3afM1f01nzZQDZTh18ceFCGkeTYU8kb4KJDlQ1NJXj+NDbeZFz5H1ioqyz6Ka3+x1CJdlaIfPznsg9OJ9FzcPbkzjUY8xiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9oqx9b+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD060C433C7;
	Tue, 13 Feb 2024 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707850228;
	bh=exo5jZmTqaaWNEAT4f4VLQjexoYgrhK1CrpsX9a1YoU=;
	h=Subject:From:Date:To:From;
	b=U9oqx9b+q0c8/TsphaX8hZjyc6lPGCU0TYKZL8EwWWOv4kIlBfBohjHsF/PSf46oL
	 R47n710lHqPqfgeizTwbRdr65ABCreQgEv0B/HRnJT0e1c0Cg1gnGdsu04bUx1yDS1
	 nGthDMIlNwVKbcps2ERJgJjfjrLfJjF5p9CIUPLNWIu5/heMZoYx5Lhrd1009Yj3/U
	 y98OuDIRPxLBNDUb8Rle+Kjjfa2mhdoLtTw/c1MOzzkx17sIU9aST1wopapZou8sAP
	 b5eqwU75/9FePHmqVGENyaXZsrG+vU8FNffASRuRZW2KA2MnxIOvwNlpaS4Us/Qp7r
	 ld2HBfwGOYJTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90DF5D84BC6;
	Tue, 13 Feb 2024 18:50:28 +0000 (UTC)
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
 <170785022850.17634.7306047814294556252.git-patchwork-summary@kernel.org>
Date: Tue, 13 Feb 2024 18:50:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2,1/1] spi-mxs: Fix chipselect glitch
  Submitter: Ralf Schlatterbeck <rsc@runtux.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=822506
  Lore link: https://lore.kernel.org/r/20240202115330.wxkbfmvd76sy3a6a@runtux.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



