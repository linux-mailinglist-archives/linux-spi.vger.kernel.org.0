Return-Path: <linux-spi+bounces-1342-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A153853D6C
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 22:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9CE1C218D6
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163063114;
	Tue, 13 Feb 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEodpx2U"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9FE6310B
	for <linux-spi@vger.kernel.org>; Tue, 13 Feb 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860427; cv=none; b=Z/yyPTPHvA9LolqqjYPD63XxPs9iTO9Tc7ApHcBlOEq2xzbw9CrhJhdERF9LdMSTU4nyJvzbyk6SBKNwFYTiJKZD6pIJ5usMb2mRynNiBaCE2K4bU/n/GR035IxATuXeyq+4VcPSYXy+dl9BQKEdWIXF+UG0ajnSEfZfYpBTH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860427; c=relaxed/simple;
	bh=E+HTrznUpdZvQyyKc36wy65J/3Bzh93It78YJGAhqQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mJzi9hQNiLWY9uF/e/QozOG5+t2RX4SKMtZqnSCB1nCKceNTdxuo9E49sSE0QJK2fBzlhsWQOykbgPHFG+bViKE4bew7vK1x36/3p8XbKd8z/FMNiDZ9WBaJ1qAPYEZ7Yc5lAW7Gs5+x4tA80wMb5FWNElQbo869rJzBkYAAhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEodpx2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D23C433C7;
	Tue, 13 Feb 2024 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860427;
	bh=E+HTrznUpdZvQyyKc36wy65J/3Bzh93It78YJGAhqQM=;
	h=Subject:From:Date:To:From;
	b=TEodpx2UgzjO+5ePYcWtghuC1G9fv6CrIs8SyPxyfusVuLeIOp1x91oquS72JA1UL
	 rr3o984ocPEOw5/Z2YT8oZV1aZPFERDAIVFL+absIFEsre0e6n7YNWvv5ofZIvROem
	 E7MR7fz0hyWRH1SG/rdpXDlbtMeHPVj2PNT+11Ci6YQ73CeiDE8sFo8IE68A/SWvA1
	 rCIHwlSmlysYgmt0t3A8ta2CV2qJ8r9VDYKtjP4Ubi9taHvnPJuqgNb6vsgOp+85q5
	 iIJGp+Z1JaXhJFcPS3mmz/565ghvyhAZMSvkOo40HzBWltcv7E2B5Lcw4fzhP6qx/I
	 IenNRyS0n+MIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2C00D84BCD;
	Tue, 13 Feb 2024 21:40:26 +0000 (UTC)
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
 <170786042691.17681.8711406198732972875.git-patchwork-summary@kernel.org>
Date: Tue, 13 Feb 2024 21:40:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mchp-pci1xxxx: release resources on error in probe()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=825752
  Lore link: https://lore.kernel.org/r/efc92197-4023-4bfe-bc63-452e7ed112e8@moroto.mountain


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



