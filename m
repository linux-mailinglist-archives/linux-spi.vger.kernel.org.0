Return-Path: <linux-spi+bounces-6093-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4917D9F566F
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 19:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBBB7A03FD
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C8161310;
	Tue, 17 Dec 2024 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+z950vx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B029442F
	for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460813; cv=none; b=FRB16Q84JZt0VR8JN5z6akXHGsbMymSTQpQX6oVBpzh+njj6lo0xA9BGVg8Sg7KDS/v38OuVCe/zJyqHQW3U9R0Z71hn26zLuLw8kuVHOO/Zsj0DojNvrkpPCQmDh7oang2Zy0JzPhx4l6coEZNR5ZLyRxGj2xFnG1ggvJeCf9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460813; c=relaxed/simple;
	bh=B54rxQx5QGGGrcVICXxd1qVVdukfKYg3TFWixwkdjZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=opzYtzKETJ6eF4/6ljouNYEBj/DqHEYABmPVueleU2TRksBgHPu67AR8iX4vsF3ULWOkQQrowbonM0cfhbB209FgqWvjJoMtIlmdaUzDy9ozn3SZvtJgY7+cheoW3mVICaL8MJsbOn8tmtCpEnaKwjMg+gEyqo8jaQd1vYRloGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+z950vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BDBC4CED3;
	Tue, 17 Dec 2024 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460812;
	bh=B54rxQx5QGGGrcVICXxd1qVVdukfKYg3TFWixwkdjZA=;
	h=Subject:From:Date:To:From;
	b=R+z950vx9vDoi3dnH+vG3tXUqrbu+BIr/ly05xbRTQEG++OnGa7sZ8Zf00G1EEY6Z
	 B/X1X2CSq/yaBUSGCHCkCy9pD6/AnZqVo4MJpkRzYAU7225AzHzV0M/vDSBjNd0j1j
	 fWKZ53SzveIi3mwdUxOKn2Tu1OJEetz4U21mk/DswsWBILgGX7sgm4Yu4Q+IY8x4Vd
	 QBFNoAzZ+5nOlo+aSA5bIk6IC4sGL1dfSUoiyRZX9fl4C/ngaJcsrfY4V09YuRK0WT
	 4hrjPJUwN72Ct4nkBpLPoFvowRQZ7Nxid99mviOg5L982RJTGnKmPOi+zItFc+eeBn
	 GoOe4L58jd1AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 017DB3806656;
	Tue, 17 Dec 2024 18:40:30 +0000 (UTC)
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
 <173446082946.999617.4790801424198706960.git-patchwork-summary@kernel.org>
Date: Tue, 17 Dec 2024 18:40:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families
  Submitter: Bence Csókás <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=904554
  Lore link: https://lore.kernel.org/r/20241030084445.2438750-1-csokas.bence@prolan.hu

Series: spi: atmel-quadspi: Refactor to allow supporting SAMA7G5 O/QSPI
  Submitter: Bence Csókás <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=913174
  Lore link: https://lore.kernel.org/r/20241128174316.3209354-1-csokas.bence@prolan.hu
    Patches: [v3,1/2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families
             [v3,2/2] spi: atmel-quadspi: Add support for sama7g5 QSPI


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



