Return-Path: <linux-spi+bounces-9378-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01249B22CD3
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 18:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA6D18871FC
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB42FD1A4;
	Tue, 12 Aug 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSrtl4+l"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFF2FD1A2
	for <linux-spi@vger.kernel.org>; Tue, 12 Aug 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014376; cv=none; b=H4zVKsMK6tGKCz6krQw7Pux+RifA/sn7i59XWZE8qm0Ee5+bBC4Ay9I4h9raMfrytoFIw/e77PWemzVoyWDabHEas7eTEC/Y2uJKyni/PKQFBehar76uHVfEp3ysd5XBWsiD634ArgPbDn9QatHhWX/Z5sb1HhPaxOO81K5e2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014376; c=relaxed/simple;
	bh=RBXZf82R4h/p5WSU6GIeo3PTlR+v+L/BzRDyGzbmpfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Bfd13F5WCBJPeEOw25LnjFDoaq64GXpRg0DSGLvWf6tPygkb5V+durnF7YfhNrdNGP3yWGwSy1yJ3hir1dqWjn8uGjglSG+5bi5bzkW2OCuN26X4u2Nj2Ny918t+XbrR3bZxTOob3PkBSirJfomC/pEvZPXsZ5adHd5hhrEONP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSrtl4+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DCCC4CEF0;
	Tue, 12 Aug 2025 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755014375;
	bh=RBXZf82R4h/p5WSU6GIeo3PTlR+v+L/BzRDyGzbmpfo=;
	h=Subject:From:Date:To:From;
	b=oSrtl4+l7Eplj3vuNpxT3pOnd1+hKOFeNEMn0b9r26UQDSXdSiC16P4NupDaiS7Y8
	 G+7oMa83y6Y2EH0bHh8HNa/IvvRtSFcO31UUq4RdlohTqvwYu/ImL2kjTG5+ojMl5r
	 92sFV8/eN6mCO4gTyBpmdMxKPj3mzE8mQgjqYzULLKR/blOQ7j3A2MudgDxiGDTk94
	 YTjgLY83sjW9duj3tNJVERySAkdbVo8AP5sQpolr7/2ipUYfcNJjaiyREfF/JZtbXm
	 v7doM7eLtsYuAQlCSAUyG9rfwpE8zWIEXgxa6y+JDF2Ks6cG9dCO3XcNYzBEgXOIGd
	 4i0WVwE3AR1Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 748A3383BF51;
	Tue, 12 Aug 2025 15:59:48 +0000 (UTC)
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
 <175501438698.2641567.15641515880265193867.git-patchwork-summary@kernel.org>
Date: Tue, 12 Aug 2025 15:59:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-qpic-snand: cleanup 'qpic_ecc' structure
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=989714
  Lore link: https://lore.kernel.org/r/20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com
    Patches: [1/2] spi: spi-qpic-snand: remove unused 'dev' member of struct 'qpic_ecc'
             [2/2] spi: spi-qpic-snand: remove 'clr*status' members of struct 'qpic_ecc'


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



