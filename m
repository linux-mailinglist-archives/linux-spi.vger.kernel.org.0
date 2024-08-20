Return-Path: <linux-spi+bounces-4256-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 475E395875B
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19651F228C7
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075B18FDB1;
	Tue, 20 Aug 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJu2nj8O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1D18FC81
	for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158293; cv=none; b=eIwYh+en+YR/o2Cd0R1uJQ4MVtaMJij1OXIq2xcvBMZ/fmpXQ2P0+8vmFHpIu25oBVEXUb5KSRVC3bbSEUM1eOz92dm0a1FqSt6CdLJJ1sdL7VovHAkhd/BPolqyIgrzfv+Zbc7R60x/K22T8mvwqWHEAcl92RaG8Y7nqtxTnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158293; c=relaxed/simple;
	bh=wmvIe7yh0GVudW1cpIj4N4p+5sTof+WvUJVWiUCX+rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ukKUeWn2nW1brY51fHE0YsYostZJLspFMPAcspra7A99sFt0qGcmhyagpktFt1IupDiFz1+OwG1qG2RjPANeTuiNNAAkc6goF4SwjjBNDFoiuhRPCnoeBwWQJvz7exMwapE8h6QrnDiiLaWPRq2ZNHJPnQTl8a9ZClb8Z9AUSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJu2nj8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23958C4AF0C;
	Tue, 20 Aug 2024 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724158292;
	bh=wmvIe7yh0GVudW1cpIj4N4p+5sTof+WvUJVWiUCX+rk=;
	h=Subject:From:Date:To:From;
	b=OJu2nj8OU6O8j/AvS073qCR05ROY0so4JPNiC3cPZX0Hj/K7CPYqisCIaI5xFBTfi
	 aKtr+4/38LaUUByX7oDUGGIpjlx3b/S7Ap8F8VvPChutKA1k4TThoUk21jiuBp4CRN
	 LpvgFkA+bbHzT3Kah+1Y1W2SqmyqiudH5GD6bT7x2mfRZ6ADXuh1vM5U4yq9S8qMht
	 eCg+6V9CbD+NK0J4UhNphCSDJTFDoHVde17GdIcbyagnrXZILIjDCahZpOlL2uCHiT
	 nMy5WND9WkqzdfFIggdJNfcmz673bN5Ui+HVqquvud9ZUNI3TiLPTNDP1bEWdb7xfz
	 vF5ovl1rxfEIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5FBE3804CA6;
	Tue, 20 Aug 2024 12:51:32 +0000 (UTC)
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
 <172415829117.1131310.6570769262656691604.git-patchwork-summary@kernel.org>
Date: Tue, 20 Aug 2024 12:51:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: bcm63xx: Fix module autoloading
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=880748
  Lore link: https://lore.kernel.org/r/20240819040709.2801490-1-ruanjinjie@huawei.com

Series: spi: bcm63xx: Fix two bugs
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=880902
  Lore link: https://lore.kernel.org/r/20240819123349.4020472-1-ruanjinjie@huawei.com
    Patches: [-next,v2,RESEND,1/2] spi: bcm63xx: Fix module autoloading
             [-next,v2,RESEND,2/2] spi: bcm63xx: Fix missing pm_runtime_disable()


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



