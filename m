Return-Path: <linux-spi+bounces-8262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F5AC1219
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270B11BA6D62
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D43B199FB2;
	Thu, 22 May 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IusWGkAb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E2199FB0
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934994; cv=none; b=hHmESc9kO7LJhntNFCS6RCCJrlJDb97tQsIZqYL47HVEauHK9JKS2Z4xRcLbiJb0A0gU2Z3kJTspj3PwoMIXz78XyTgAhRV6va4XWg720Jva2FyyUuYh6hQWd6Hdn1CYAVFTjcNt3rUfniV17meXC2rmDaKf9iHXP4H/LNN4cPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934994; c=relaxed/simple;
	bh=6WfX2DNL1ifp3UvTZFY7TUwsJHrblTvi+0Adq43YAo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=V2T4tTWUnnkvmbkdggiu6DHLFcLg/iVgeCxwjYa4zP1cVIL4xxeL9re7awhDQGgpgNsop7bJoE8ksLlDuvl5gAdqp6gF1ZQmoPiq2mYBk7cBhCRQdWiYI9jle/FvmUpFQzo2harXdsO5dhIszApQJov8W9jjxr1qpaPtxiLCr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IusWGkAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21404C4CEED;
	Thu, 22 May 2025 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747934993;
	bh=6WfX2DNL1ifp3UvTZFY7TUwsJHrblTvi+0Adq43YAo8=;
	h=Subject:From:Date:To:From;
	b=IusWGkAbW5hEjxeGIKFCoJ2iFRydmPXzzeQXEevub0Xq8Esotblba9juNwWhFZWA0
	 qetYW7cHmvWx/5MFEQeMq4uNQEOu9bsppUCH4b012DqfvGOsG2Jh/KY5hA0MLQYImd
	 yxbI1qRAg4v/Y/3iLbnc3mi9afZeX+YkT9XqtTcA94xo7Ys4VAtF0tfTdFpabSYzF1
	 T/mYJlbFiSJXxwAlcalZuO0qlHZYNAeLRRQYwGTMiKxNLJf6Nb6vCaRqQcG6JECUKx
	 znYnfMZ1TbHrR319NrxYRoqOWQlkvH+iI5tVlwwstVcTcaK7R4SXNHh1OTQhghWFqX
	 6h+EhUaIAVJ0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B36253805D89;
	Thu, 22 May 2025 17:30:29 +0000 (UTC)
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
 <174793502834.2959166.17542003958395292846.git-patchwork-summary@kernel.org>
Date: Thu, 22 May 2025 17:30:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-fsl-dspi: DSPI support for NXP S32G platforms
  Submitter: James Clark <james.clark@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=965438
  Lore link: https://lore.kernel.org/r/20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org
    Patches: [v2,01/14] spi: spi-fsl-dspi: restrict register range for regmap access
             [v2,02/14] spi: spi-fsl-dspi: Halt the module after a new message transfer
             [v2,03/14] spi: spi-fsl-dspi: Reset SR flags before sending a new message


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



