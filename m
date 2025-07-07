Return-Path: <linux-spi+bounces-9068-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A6CAFB8CB
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDF11680FF
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 16:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19912248B3;
	Mon,  7 Jul 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzRd2E+5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12F22424E
	for <linux-spi@vger.kernel.org>; Mon,  7 Jul 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906384; cv=none; b=mhN4bRd3Dag9ssRCOf9RFixAmAEYFooTQpAhY1VjVweVyXaelly+az0hTGQD0ZcjfNLtI/hgKO7Ia1IBSYD7Pfc+FlGCsucbXKyt2Uud0YQ7JckTLn6bdq4cOc/fHBF2TpU6sXiBVpzvV6p5uvH++Lmu6bQYFto1Hqp6oKSQ4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906384; c=relaxed/simple;
	bh=skC509hKb8sxLsF45gR30zYFiYrWlpedfs/DHleOS2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=psxgIouLUZvNyVqaiNjO+arpnZFzM+vVsVbAdNb5FybRwq52vtPpauDG0HO8cww16Xhn1ckqs8u4TemYXh46+1SRbVpByS6VyBnq6YLRWB59YEcx9wRZNr/WMxgz/FoBrnG+X1RBwWe1FyQ/7XsBmJ3mHi8CS6dkCEFZBq7G6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzRd2E+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32714C4CEE3;
	Mon,  7 Jul 2025 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751906383;
	bh=skC509hKb8sxLsF45gR30zYFiYrWlpedfs/DHleOS2k=;
	h=Subject:From:Date:To:From;
	b=MzRd2E+5BDsiwQfJLy16Y+wNKQ82RjIR+CHMWQsKNwKbfirp7JAiME7/ksgsRJKqA
	 d24BUSGydXAIqSSjamPFEPHqv1Av283Q30Q4sM33J/1wNT7yM6uIsb8r7qpnIletS8
	 f4Fuu0BrrShv9hH2tPSmP+Jl3skVuzxhcUifA79GCGHj7PHalilV3E4lehtIxCtJE+
	 Hw8Qp0hAIKK5TR7q1Cr7BV8s8+4nPguPS5HHS6AfP2wKtP7V91Cl9DWuwnsPVfL8Ik
	 dSGiM1+mBfbClSxL4HPxbchZ+Y0A3uTJbRJVggzTsXzNtrpmZccRli8EUxABtbpWGq
	 jN+ZnjPMV/lGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75E97383BA25;
	Mon,  7 Jul 2025 16:40:07 +0000 (UTC)
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
 <175190640620.3354396.12261724220461673521.git-patchwork-summary@kernel.org>
Date: Mon, 07 Jul 2025 16:40:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: None
  Submitter: Sakari Ailus <sakari.ailus@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=979025
  Lore link: https://lore.kernel.org/r/20250704075447.3221784-1-sakari.ailus@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



