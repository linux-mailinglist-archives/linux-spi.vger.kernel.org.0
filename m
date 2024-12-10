Return-Path: <linux-spi+bounces-5998-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC09EB913
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 19:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A722D18898B7
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1C204696;
	Tue, 10 Dec 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQOZQB9z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9486320
	for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854216; cv=none; b=YwkZfHSuyY5qSi6iZ0JPCQ+xue0Fy6vmq514rJvuAD86cnl5HiVrzlfVdHO5zVP+6Jpn07wj4l2q/4k1JDbGgmYxQ2fYrBjREqYMipHicDZPBV04OdkHcvfSWKijZJ2Dza1DZGP5Nw7as7v48KOM/Lu4F3hUqIhQLpw8IQ3MjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854216; c=relaxed/simple;
	bh=xM21d8x2Jb5wRARvU4mEAJNsSlZXk6dvoZlqQX9ASEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=e2y0fpJCEqz0AcsU3q5Ji85U+xYQZn5cw61B9c1WpudciQSUmNvKAGLnRHO3Xi/dyiz5I8y9CtL8WXX548Z6q5Usv8PGISjuQogHZdCUPRsjybn7WT62T/RKkU2qwMov15Pzwv8Nl0bD6tVx31VPNQXoKxUYfTrIWYGWiyVjsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQOZQB9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3D4C4CED6;
	Tue, 10 Dec 2024 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733854216;
	bh=xM21d8x2Jb5wRARvU4mEAJNsSlZXk6dvoZlqQX9ASEU=;
	h=Subject:From:Date:To:From;
	b=fQOZQB9zrkiHVjG++412vT7ycEjNOZpyWHXx06uRkkLCm+v1YnkDCea1WWsarDUgW
	 7YkS5iFNPgsObx5sjKyL/7syp4Z7B7wftXoq2OFirHv2lhiyneMGqCCxd0JWiNj38o
	 +JDoLRIWnpldGIti+AcXf4Ys2vOUMukhvwLLWwSRVa06WiDPImXQ+UcRuZmQNXil5j
	 3YR+h1yjoVqynTeUUAKnV0fCQ/RhkAdTLF4diC9J1eTBIiH0a6ca/vp6PcIG8lThUK
	 2lrN/RwNPY+iA5jYiwXgWfibiap7iZTvKpi/dwMTlBKnJo8kcbn9/Pk9gknDUGggjl
	 c8NGwNwTMrocQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1EAD380A954;
	Tue, 10 Dec 2024 18:10:32 +0000 (UTC)
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
 <173385423163.932624.9594039363560506491.git-patchwork-summary@kernel.org>
Date: Tue, 10 Dec 2024 18:10:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Unify and simplify fwnode related checks
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=915715
  Lore link: https://lore.kernel.org/r/20241208195635.1271656-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/2] spi: Unify firmware node type checks
             [v1,2/2] spi: Deduplicate deferred probe checks in spi_probe()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



