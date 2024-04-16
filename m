Return-Path: <linux-spi+bounces-2366-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C28A6931
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B212820C7
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB496D1BC;
	Tue, 16 Apr 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3an6MwJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9071E87F
	for <linux-spi@vger.kernel.org>; Tue, 16 Apr 2024 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264996; cv=none; b=oxeKaThLj7uAhr5GCR8km470VAMCC7prylgdIrbdOm+wa7MRWhb8lOT9yyFp/tByjcqQyptV9lYHBUGKTX0JOZyM4dpZWdgumwOPRAm7iOxzSyGg/iyiutIHB4RUb+dmzOib27mvmso3hyo3it+iP+YjpmA10HQrmwu0nVelnDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264996; c=relaxed/simple;
	bh=rcGzYzzTlHu62+kbGsQnsEg6tWscl/0zwZjvZopJKpE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ADDYI76vqKdWaDK3H4AkJ31tpK1ssWVpZZl3a5N2+0RMV1x5Zddl6wIv6jh2vfiuA0AFrdEwpv9haX441mjonu8lqbWYxqBP2+FyaOmeg8tHXdCxtCorjxJhcFDKp9qz+Damvolxx/T6LyeoVPPxNuonbrake+pAP/NkoL5tfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3an6MwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70827C3277B;
	Tue, 16 Apr 2024 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713264995;
	bh=rcGzYzzTlHu62+kbGsQnsEg6tWscl/0zwZjvZopJKpE=;
	h=Subject:From:Date:To:From;
	b=p3an6MwJR2B83BJxTZhnpBeNQ0wKbZeFiPo1i67ydceev9nPKdfPzMKghlsWLdBm3
	 lIXje3mLWrMQVEQBMMAAcd1+hW6WKnM1QS3BEOcza1sOq3S2Wjns5TJ3dFZ7hoVBFI
	 iiFl23pod1Cn5jU10fxQgVE4Kf3nAduZMuhadeArzzU/JZyv5wu7Sc69hyQWCQ487K
	 lIkpqW9zkl6MIN5O3BNa0wVLgABHaLuODnG3J7QTtNQsI8bTWLGUdKcMaBpfS5g7rx
	 a4drqRFtsBAiczvxZ8prkdqmC07vuEhm6yQBozSkah96Zpz9zp4BA8G1vkdRgTIX0I
	 bYq8qZQ40qsnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EED6D4F145;
	Tue, 16 Apr 2024 10:56:35 +0000 (UTC)
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
 <171326499538.24407.5530517056105426839.git-patchwork-housekeeping@kernel.org>
Date: Tue, 16 Apr 2024 10:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Add bridged amplifiers to cs42l43 (2024-04-16T10:09:03)
  Superseding: [v6] Add bridged amplifiers to cs42l43 (2024-04-15T14:09:21):
    [v6,1/4] gpio: swnode: Add ability to specify native chip selects for SPI
    [v6,2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
    [v6,3/4] spi: Update swnode based SPI devices to use the fwnode name
    [v6,4/4] spi: cs42l43: Add bridged cs35l56 amplifiers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


