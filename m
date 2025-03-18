Return-Path: <linux-spi+bounces-7196-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF6EA676AC
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 15:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD21631E0
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E97920CCEA;
	Tue, 18 Mar 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pomWoBh7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54B20CCC3
	for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308797; cv=none; b=rxfDRIBGLXONLrck5kbdE9XxXam7wRP517B4dplptvr4avsNQAViv47QMufdcvjh9p3ER6FHgleOGxOxjCxX4qCG9Fs9St7ESaogp2w/wXnSEDzuiEacBu1iTPIxMV+P90c6H1KtDNCgIimvtBALu2CMMX7dWIxOUHu1xwnVLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308797; c=relaxed/simple;
	bh=n2jl67qeLnWQDKOrB1vNfYYYU7rGnnf66ikIQ1wNSco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=acoLNBYzzOZr5bVry1pW9nQeElcj7UxJ1JuibmP61pq20g3ioJlRmIX2CjuNFDcTPZSxk6WONdn+tvTZVuuMv96TKTTP7O/Jcvju4X1w2U6RMvQRpwsU1uRWD1shb8keyqzi6qU75lrQpQNkC0eWBkzFQ5VJvOCcM5KtDCuG404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pomWoBh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E0CC4CEDD;
	Tue, 18 Mar 2025 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742308797;
	bh=n2jl67qeLnWQDKOrB1vNfYYYU7rGnnf66ikIQ1wNSco=;
	h=Subject:From:Date:To:From;
	b=pomWoBh7m6tdT9syFoNxVGWxM1wu/BMJ0wQ5/2IZfVUCB0fTbUDZ8NALLNqpslFjM
	 a1g2bzNrZlLQkruwM6FBduZKzc65q5gyZ82tVV7ezj+ZgI6sRBdJX1zM8h2PaYtocz
	 7I/h85iKG7VcO7Wng3GsxN3nBOdSBYe9UNA3O1ByuiQb4WBKzMCbZy6WhSPOq6l8cb
	 UV0SGZp91RAgicfFPIo5M0bi6tnj7J5dbmmLosoRdiNAIQrUIq/10tfY2GEqm9yjtl
	 5GuMiwF06jpNI3xwTUW4xHYnXOyOWLMwmN135T2ELkNgM2q+oX407GWCXxnWrp2cZ8
	 MZpM5H6rc4qhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77C9F380DBE8;
	Tue, 18 Mar 2025 14:40:33 +0000 (UTC)
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
 <174230883189.336357.14104895823222551153.git-patchwork-summary@kernel.org>
Date: Tue, 18 Mar 2025 14:40:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: MAINTAINERS: adjust the file entry in GOCONTROLL MODULINE MODULE SLOT
  Submitter: Lukas Bulwahn <lbulwahn@redhat.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=945000
  Lore link: https://lore.kernel.org/r/20250318080913.31455-1-lukas.bulwahn@redhat.com

Patch: spi: stm32-ospi: Include "gpio/consumer.h"
  Submitter: Peng Fan <peng.fan@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=944928
  Lore link: https://lore.kernel.org/r/20250318045549.1711502-1-peng.fan@oss.nxp.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



