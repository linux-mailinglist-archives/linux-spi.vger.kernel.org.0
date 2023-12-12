Return-Path: <linux-spi+bounces-248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2C780F1B6
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 17:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DD3281812
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6476DDE;
	Tue, 12 Dec 2023 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp2c4LgZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696076DC8
	for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 16:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 625B0C433C8;
	Tue, 12 Dec 2023 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702396823;
	bh=OTzc8G7U6sXH1MBKBswNURqTJb5qa+5AQnk4HU5ty04=;
	h=Subject:From:Date:To:From;
	b=Xp2c4LgZtqHA1Qnb8A7j8wBmIZBlhd6LMNL3dbY5DbGCdp5nz3JBrjEFUMoGuLgvv
	 juclrM6zRiscDgq3qKkooqG3PG2o34XvQY1rydH7FqS8nzZSqhtvfXokzDcxmGep9m
	 94DuhAOn4oOsRYWQgMcmly8jBND+kGLFWsXImSQRXsP1Yb4vIZsKlMKe179cKxSwnD
	 a4aQzlbEk1XYbqB0uqHC5EX4AorMuoGXgKBio9+pPFRChS493buvksGXMvbqCyYgsi
	 xV4aeKJpgRWWdtdMS7fSkewNEeFruWyT3IMvxiSFrbZ6J64Za2PSgH2KhzkfcW19zY
	 jSZci7g8d+Nuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D041DFC906;
	Tue, 12 Dec 2023 16:00:23 +0000 (UTC)
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
 <170239682319.10108.5648756923732980711.git-patchwork-summary@kernel.org>
Date: Tue, 12 Dec 2023 16:00:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=809092
  Lore link: https://lore.kernel.org/r/20231212081239.14254-1-wsa+renesas@sang-engineering.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



