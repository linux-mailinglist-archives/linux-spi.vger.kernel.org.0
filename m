Return-Path: <linux-spi+bounces-7346-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF0A735A2
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D7A17B6E2
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85C01527B4;
	Thu, 27 Mar 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goh2onAP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464118A92D
	for <linux-spi@vger.kernel.org>; Thu, 27 Mar 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089400; cv=none; b=Q4C8E0PFeTWv55U1chKTJ8XkGkOwH+mnnFEACWfQAQlUguav5MYhi6f/sE/cTvQiD8G1qcZ5i+5Y/DMN21gnkZYWGBo48Zi9tGiUsObPPREqeRdRhSaZWGbvXEElwC7hD0R7AxAqqRiZfa/EM0gDoTL/TAnMHfRdnn10IHoTcos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089400; c=relaxed/simple;
	bh=GuLrzws5tvWFW7dAHlj3L/+03po+T0Ky1476HZCFQfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=B/2HobnYFDxqGFAqAqjHUWAEWHhx6QRyR2uUt/f4hRyG3bOZuVvb7ldgg7vdf7fTfeVJwcdqL7zT3LKMhKInQ7arvGbcY3I6kra2+YGY3dzmbcD1A1b40iLVEQN6H47rRA+YYeuIWV5f+/2lZE2Ms5DVDR/WiCRs+wX+pFqcAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goh2onAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9EBC4CEDD;
	Thu, 27 Mar 2025 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743089400;
	bh=GuLrzws5tvWFW7dAHlj3L/+03po+T0Ky1476HZCFQfA=;
	h=Subject:From:Date:To:From;
	b=goh2onAPjt+LY64nlobzeMAg80gSAtXBFEEtmj4oD8LoX7AulONp/guQwslOIJsaN
	 Zi8d84/9gPbz0NbkXjPL8gEzMVtPILRtqYyXErteMnaG4OJcSE5nlCj5VCkL8eIFrh
	 lmkcYIbIL4EmWdfv3lwuHbSCqucZu2eGLG3OqTYG5shqlU2K0zix0RJpw7avfXbVbW
	 k3Z7YzpZw7VvTcYvAkNFG3KfdJWKH58napYRqMfJmhb6oUZs/F0BoXutQ7Fj7Z6Byo
	 D0PJ0elC7fgSP8fQrxG4S41oY2N6qqO0RU79MKUAXTwNYxYUL9F+79w3w8AOXM2Aq+
	 n9LPMYVRMBtPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76C81380AAFD;
	Thu, 27 Mar 2025 15:30:37 +0000 (UTC)
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
 <174308943602.2103218.3561690644673242132.git-patchwork-summary@kernel.org>
Date: Thu, 27 Mar 2025 15:30:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: SPI_QPIC_SNAND should be tristate and depend on MTD
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=947467
  Lore link: https://lore.kernel.org/r/b63db431cbf35223a4400e44c296293d32c4543c.1742998909.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



