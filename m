Return-Path: <linux-spi+bounces-10001-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28AB54116
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 05:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2776D189CBB9
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DF9234963;
	Fri, 12 Sep 2025 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbyDxmwk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C87494
	for <linux-spi@vger.kernel.org>; Fri, 12 Sep 2025 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648404; cv=none; b=Vb4Kxgktgf1YEjfpr+Dk/sBYgKYwZrCt5fnsaSk95beHRMiC4XKWqiWsruXzkIPEFC+EWB8miUO2XPjCMxEloYXKHRwbl4d5iuGLEyai6jAqz+yi8ghAXfW/aJjE9TNFlFn4TPdtuf14oOtGCAqZHPT/boMTBF2w8eViEjUylTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648404; c=relaxed/simple;
	bh=1jOVrnUatABklFnjGm4YGk3E8xz/ag6wj9g9dfNaeaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Ao31owovFPFMz7ei6SwSfmogL9WvfyaXdegnoDE6BfQ3WIdMe+cP1TFjizCMCe/Md60ZBTERnTKAnmotWBHVUXHAZrGwBzu40ELIQ2GYoNWwY+rR+8J8oDENTfZi1A0trHOMJ6XQvBA6rbwBecHhjm/YABmDIwEm7/d6HCzAsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbyDxmwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9C8C4CEF4;
	Fri, 12 Sep 2025 03:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757648403;
	bh=1jOVrnUatABklFnjGm4YGk3E8xz/ag6wj9g9dfNaeaY=;
	h=Subject:From:Date:To:From;
	b=ZbyDxmwkZGNrcEHweCU9oDsUzhzVW2yIQRBsW3dkt3X8p6KeCkWcsDC1y5Br0GcO2
	 PT1DVO7VL56esKCg+izQ/gIFUYAVAueTHYO4AgKoij82oK+oV8ErqPKaJ8PVpMOaSg
	 FnrqXQZ7lq8F2gAVyCaK81J7lOtWq/A+iQ+4PaEhTzHWX88RR1Fugcf/0k+bSS9WnK
	 1zr+lH1qh2/ps6rI9Yn5iExo31LS8oZHnxuag+2c/I/zbrNiaPOjf2+fq56uZyJ14a
	 svNZ6MUyHvMjWNIghbvJJx9shuB0YQ4Mc+BZPXEOmxziwlnP1Pzul6jX19OiUjf8W+
	 d6bNSWXoUsFOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74588383BF69;
	Fri, 12 Sep 2025 03:40:07 +0000 (UTC)
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
 <175764840600.2393485.3691515909316091519.git-patchwork-summary@kernel.org>
Date: Fri, 12 Sep 2025 03:40:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: axi-spi-engine: improve version checks
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=992021
  Lore link: https://lore.kernel.org/r/20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com
    Patches: [1/2] include: adi-axi-common: add version check function
             [2/2] spi: axi-spi-engine: use adi_axi_pcore_ver_gteq()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



