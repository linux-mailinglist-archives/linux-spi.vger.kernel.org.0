Return-Path: <linux-spi+bounces-5454-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0519B01B3
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 13:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335BAB2293B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 11:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EBA2010FA;
	Fri, 25 Oct 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G64e1iLa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B112022DA
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857025; cv=none; b=fdnVfpSybWB5tq5Nc4EwFE/dxzgETVZYCRp2gt4PTkFtIG5n7A0Y542+FlH2hhdv9+Cx2YOxVuzTH8uDhCpnnDADtFLIshNnXIyOqLvcOXbUXQXggLESPddLf8g8zuujjPWDidqgjTeKctepHzkqaYUL5kUWuGvlN4VUs5yc2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857025; c=relaxed/simple;
	bh=kMzqEJHWFyuy4Vg4EZDAzDHXx5Mkcl67oBLlnOUvRNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cI20dd0Fgzv9b54WUD4FyIG7kN4koK/LYxUGcFntQMFo3U6LHqQEdeb9DDgpSVl69aRm5PoB+oOM5LEHOye+Dg0fl44EyU6HOAbc7SL/FxDEXuQ9PjAlPUa/hPI0p7CDvgB9lkbQPYjIQApJn8aFH0MgTzB+9NDkOGy9BEMPJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G64e1iLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54802C4CEC3;
	Fri, 25 Oct 2024 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729857025;
	bh=kMzqEJHWFyuy4Vg4EZDAzDHXx5Mkcl67oBLlnOUvRNg=;
	h=Subject:From:Date:To:From;
	b=G64e1iLaJ9bZXOH+0mPSEpBJtY7Lv0Rlb3N1iVcXJ68YNFLWKq8oVdgB9zvMzBnP1
	 v0FGmZiTouMOlZ4UM/OVoDnY7rGvYPBM0oldBpZ8JmN2wLn6Py/dQ8vXXS8q+7n93r
	 FRsByxiiq2A2BQVP86M4kJIHH+ODvJZ8pk+2rLJshWD8O+nQK/5JwT0f/a+FPsA2je
	 AVarOzXOq0T9atQ8QKRwXB4jcMQeI15omh99HgkOxchdEJX5AX8p5ccFxCk25minvS
	 hcTY7EBSHLD2BMNOg+xT0VosXT139m5Sli59t2am+s2aQy/0o0JvBhrI74Fx/d6dQA
	 7ZyveiFfZVcSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3AA183809A8A;
	Fri, 25 Oct 2024 11:50:33 +0000 (UTC)
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
 <172985703178.2880373.5493044825073354541.git-patchwork-summary@kernel.org>
Date: Fri, 25 Oct 2024 11:50:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: spi-fsl-dspi: Fix crash when not using GPIO chip select
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=902400
  Lore link: https://lore.kernel.org/r/20241023203032.1388491-1-Frank.Li@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



