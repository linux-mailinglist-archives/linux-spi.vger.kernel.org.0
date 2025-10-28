Return-Path: <linux-spi+bounces-10908-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB214C15FE4
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 17:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C37C13560E2
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AB0346E51;
	Tue, 28 Oct 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtNPRWTI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12DD346E5B
	for <linux-spi@vger.kernel.org>; Tue, 28 Oct 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670630; cv=none; b=Mlx5shE/pnDlbD0HRUgfOCYyY41dRznvxrCWv+fpp4aibK8RxxJ2c66RbSwsu3vT+fEDE4WOiCk+IM66+6u2kdINJVR5KzosCNK6O5v8hbb3CkE4HMSXXp9m+RaGMHT464HTNXLTorfFxCkwInq8VTz/2aBdP7T73LPMZGujFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670630; c=relaxed/simple;
	bh=YnnZJh2/oDZSjHtFD1VfaIampUCwMDUjtZQ7LdYxiP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GjlI/thVM/eVr3VgCKlRWOpgg2Sm1oxAepnmIF1pZT/4t+Nq5IKYZ1+VYEd6R1KWSQcO2gojEG/tVVfmgCYpv0ncCmZW27QacIQRDKpUxFKnM9jpuZQgvRYK+fY+nfVLrDDJr7XJZDt/yP6LF4GOkR+KsCYixaxK4uk4o6MMjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtNPRWTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DADC4CEE7;
	Tue, 28 Oct 2025 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761670630;
	bh=YnnZJh2/oDZSjHtFD1VfaIampUCwMDUjtZQ7LdYxiP4=;
	h=Subject:From:Date:To:From;
	b=RtNPRWTII4z7h49reQCoyIkz0j7eLK3HxOKbmrkKVhrf/wkbfVeRxFLNrVHnwanMb
	 xP4rBr35H/bRjLdxI+OAHWoRODf6DKKzhnxqa07qGRIHNQPrcBOMErwqwHjm54tSdG
	 DLB+B1XplfTtl8e4MeJgi0GjREg9u096Ec+6SaDSdn3rKjq0TkpjuIiqb9lhILLYf/
	 3BnWkiZc1cm2o2YuvIbcyQBQwVJwxtVpxdvJk8+Gg4BKPk1iXq0+ffoB+gvE3wyS7J
	 aAkLt7UYMqKDGLHxxMLCz9ERr/B1Cgt5SAW6i1zIl9l6cDRlZp4xYeTO/TtZiwo8sv
	 vp6aHuDC1D2GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9139EFA6A;
	Tue, 28 Oct 2025 16:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176167060807.2309657.4007129943648085895.git-patchwork-housekeeping@kernel.org>
Date: Tue, 28 Oct 2025 16:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: tegra210-quad: Improve timeout handling under high system load (2025-10-28T15:57:00)
  Superseding: [v4] spi: tegra210-quad: Improve timeout handling under high system load (2025-10-28T15:25:14):
    [v4,1/3] spi: tegra210-quad: Fix timeout handling
    [v4,2/3] spi: tegra210-quad: Refactor error handling into helper functions
    [v4,3/3] spi: tegra210-quad: Check hardware status on timeout


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


