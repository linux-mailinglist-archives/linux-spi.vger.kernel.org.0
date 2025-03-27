Return-Path: <linux-spi+bounces-7356-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF225A74063
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 22:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA96E7A3B70
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 21:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AA1DC9AB;
	Thu, 27 Mar 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxbedYK9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F31CCB21
	for <linux-spi@vger.kernel.org>; Thu, 27 Mar 2025 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111598; cv=none; b=TrYAq2whzBOfGj2S9TkGj4uecoSqnb2UPztD7GT+MzqlHdBZGe4KfaSSs2XVn/2hHzDPk5iNFxeDwJtMN0PP/W6Za4VAOP9pUzQ+DukgikxzWJWmf1YCrfwg3XYJyLL2ESQ2RWNxwlUlvRsRO3lLkOFmoNfSNYdBefyxkYjt0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111598; c=relaxed/simple;
	bh=4WBy/iS6qRsK0SI4vy0Oc0jXxzHu+BL384GtD5RBR28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OQnvb+Hvb8DapnPr8BO3BKyDIk+bKVYJcnVgXWy7q1+iDRS/k/hpaRTugGJOAQY8qiKOs5RwPJoaIDs3qjGJNYX0Vv3B1NaHydTG9ujy7jasmTpMbcubLTHeqjc2ROFit88Ra5piAHhjzTqa7jWa3HzKEWAUjejxQthvOgFdOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxbedYK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1351C4CEDD;
	Thu, 27 Mar 2025 21:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743111596;
	bh=4WBy/iS6qRsK0SI4vy0Oc0jXxzHu+BL384GtD5RBR28=;
	h=Subject:From:Date:To:From;
	b=NxbedYK9Qy5NXoDEN4nEQvpZBKbqoJTNSsDGkfnMWeF6+DdfSe6WSQrXZLhNGWmJr
	 6GoswcZ4Mo2I1Cqwmp1f6lUjfXruNT6deJe6p7d1ctGsY8ozYIsAeiF70fGgj9fs05
	 P7670XGWNadvGz4g+AHBDVTakDe3TZ8njCcCx/9vnGWx4JqdX9YgeeAaxsZkJYRSmD
	 u0oTdyU747iMCo2G+WWn06Bt8lBtwflL2YefXSMO/bpt8ZLqlKl9bowX98HHRNkxP+
	 X0OGgvi3+EjDzMrN2g1QkI6lOGlyWuFlxy/8pjMGUDhGz4wJh7jTrzwCF7xMj7NYUG
	 aX1IGupwRDPmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39CFA380AAFD;
	Thu, 27 Mar 2025 21:40:34 +0000 (UTC)
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
 <174311163283.2230226.9925235583514256314.git-patchwork-summary@kernel.org>
Date: Thu, 27 Mar 2025 21:40:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fsl-qspi: use devm function instead of driver remove
  Submitter: Han Xu <han.xu@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=947594
  Lore link: https://lore.kernel.org/r/20250326224152.2147099-1-han.xu@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



