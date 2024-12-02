Return-Path: <linux-spi+bounces-5884-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA59E0A45
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF39281A8E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226881DAC8D;
	Mon,  2 Dec 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r78Ukvid"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17CC13E40F
	for <linux-spi@vger.kernel.org>; Mon,  2 Dec 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161216; cv=none; b=in/CMphHpU48pwkBZuKJ42xbt4+ijnBs2UFShVPzVMrJE1bNyRp4xLM3y9BvegnmmlGMJn9rFDShptl6q4O1WNWC49R7nrrOqHVX5DOUIjm/9PklN3iDCdXayfvEGMmbnHTpKWO2n1C/5WOFMqYP+dDf0MKq4Hizbid9aMPOpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161216; c=relaxed/simple;
	bh=jftqoJPwmqE9tafErXUBA960aj3/LMGTJ55zhlRzY20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XskeF/olGN9VyUh2+s3GHoXn3/n0pwCgxL8x7lF8OboaNhZV7CLq2jc94m51cDKXN5lKMqljXCx/opruXjyxz0Fvy7EA730XUZcsQGhHk7EUEzmwyFWlphR6/5Wi1jQXHHluPHk2x9Ohu2E+97K4P8T65TSkd6F8Eqmz3X3VMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r78Ukvid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A71BC4CED1;
	Mon,  2 Dec 2024 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733161215;
	bh=jftqoJPwmqE9tafErXUBA960aj3/LMGTJ55zhlRzY20=;
	h=Subject:From:Date:To:From;
	b=r78UkvidFgsnNQ3o0W++AGmbgL6y0wyINgzSkRGJ8oXgg9ukcQYhWd/NNf0zPwjXs
	 s9yIYgDjo8CXX+2Zd+68OA27aGY1DCdo2/s12iDAfA/CIaCRlWX9w/cIb5fhWT0Q0H
	 cnd2y6VLcZbZh/o+k/AtvAjGy2XfMaeXX17Jln/Lj368oNr/+aZ2GLtldgM3zUF0s2
	 b3KkW3PRgjxYwNFDWAKghFC3owu1Fx2aCOjhrLamhgOAeRAIcjOVXh1xA4RXss+tMO
	 1KELESG2au9Q+v9Srybv5YhmTiDHJZ/sjUHm/CaJTdZD+X+o6aqgfmpDT/ddj9pJKB
	 jSZlPrl8iDJqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B22BF3806656;
	Mon,  2 Dec 2024 17:40:30 +0000 (UTC)
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
 <173316122938.3771225.9384375799982714769.git-patchwork-summary@kernel.org>
Date: Mon, 02 Dec 2024 17:40:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-quadspi: Add support for device reset
  Submitter: Srikanth Boyapally <srikanth.boyapally@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=911258
  Lore link: https://lore.kernel.org/r/20241120120951.56327-1-srikanth.boyapally@amd.com
    Patches: [1/3] dt-bindings: qspi: cdns,qspi-nor: Add compatible string to support OSPI controller on Versal Gen2 platform
             [2/3] spi: cadence-quadspi: Use quirks to set dma_set_mask instead of compatible string for 64-bit DMA support
             [3/3] spi: cadence-quadspi: Support for device reset via OSPI controller


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



