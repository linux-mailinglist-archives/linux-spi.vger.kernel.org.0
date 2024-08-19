Return-Path: <linux-spi+bounces-4235-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4AF9573F6
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2808A281DE0
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743F4642D;
	Mon, 19 Aug 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDy5khzn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D51EB3D
	for <linux-spi@vger.kernel.org>; Mon, 19 Aug 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093430; cv=none; b=ChVE6Yc7bmYlxCNsf4V/DAcCXOyNmcBbV8hZpjEwu/K/Z0mEyISKmZ5hqZTng/r7j00VWGFbH0yFLHw1glk4XzdicECowwSQWWb1g2Q50D19dp0QcjvSaN1avYllltfw9Iye0cPqt6lwgNKr0K0m/rwI5iOKEBFA8Wn+gRGnkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093430; c=relaxed/simple;
	bh=aV3fkZXK3GT4AxAYe+clcF3IaefaEmhXmkANbaU/FuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LH6EIS/s8c1ajsfsrh0iwQzmBolhFGul3zGJbMruBZbVCIH2xI8oh4Vtyfy8PNDTTV+a2nzQc67TkzVmuHZGzSyFJJs2T/m87RqrdtpX9yiqMQeg275scGfYqFMIw2SD8z/oR9p8bf0+2wMf/SQWb5+ECrCy0oWdpPKF500gy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDy5khzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACF0C4AF0C;
	Mon, 19 Aug 2024 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724093429;
	bh=aV3fkZXK3GT4AxAYe+clcF3IaefaEmhXmkANbaU/FuU=;
	h=Subject:From:Date:To:From;
	b=CDy5khzn1+goQXpFEBONJw/ldTYoTk2yfjb/+b/hxAYIyEtdtpIrPG+b265jd1Dpx
	 Isiy3UcwXicWUL0Q5cZe2fJY/VZ6lb4onmysmLLaXiuHMtch5t7sEd6kGUOMQqK4F2
	 mseBcn3LJdBxmv1QtNGwteSzBLC4n7x1eC4WmvxF/JnhKmOPRPf6td+0QexMcaH4Xi
	 gqRwyum2hCtO2MDd9HTCt8Ri1dGwcjIaSefXM/xGJsBVezwGOeKbgbf2gaNPaVPa0y
	 oADfw8V38YXlZkkyoOl6VjDimINT60caEN7AE9uwm1XW+ExPQ1NnrOd53B69t3zX5P
	 3N+jzP060XTww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3AEC03823097;
	Mon, 19 Aug 2024 18:50:30 +0000 (UTC)
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
 <172409342875.625924.7408644814452992539.git-patchwork-summary@kernel.org>
Date: Mon, 19 Aug 2024 18:50:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: None
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=880885
  Lore link: https://lore.kernel.org/r/20240819120031.3884913-1-ruanjinjie@huawei.com

Patch: [-next] spi: s3c64xx: Fix module autoloading
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=880747
  Lore link: https://lore.kernel.org/r/20240819040523.2801461-1-ruanjinjie@huawei.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



