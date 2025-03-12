Return-Path: <linux-spi+bounces-7103-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B03A5E807
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 00:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F511728EC
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 23:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25FA1EFF81;
	Wed, 12 Mar 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bImXtQ3N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33A1EEA5F
	for <linux-spi@vger.kernel.org>; Wed, 12 Mar 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820995; cv=none; b=N7K3qjZLjcns+Q0smiE5NH5a9I2cfUYu8AmUakqLfgk1GrDOlFDwaFs8h3UCHXk8R2Z3pHlP+r5BagheYQgOtZVbyHUunMHLwrI2WZgbLoUTnIxYSI8llHTrhEZqJ/NMwesEdwii8H/AT88fDXAfWQO+5KUUJFv6516OW9UhLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820995; c=relaxed/simple;
	bh=+F0Hd5QFedXYaRLFdB6q861fMdB8UUJolxIo+I+iQG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VF1Xb2RQHfDNeoNOtSCxy1KMlUICnGZpp5kYsgM4d9czlYl6lUpnbz1JSeB+NTTGfbllejZHT0dbJHw3NTTnLeXWwPq/oSMU6v9qng8Wn16AEbXiz3/FdPGf4JQ9e+zIoaE8B1ngADYAv/LR/nK1pXM1iolTUQ+Z4xm2bNULRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bImXtQ3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30891C4CEDD;
	Wed, 12 Mar 2025 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741820995;
	bh=+F0Hd5QFedXYaRLFdB6q861fMdB8UUJolxIo+I+iQG4=;
	h=Subject:From:Date:To:From;
	b=bImXtQ3NY6XZsL0mZuJauMvrvWO8KiPBVjrUYF6432qHpPKa011JwbucPJUZBh16Y
	 ZZpqatTGJr45/S3PUfZpHgOuPGELNx6VKn4EXBoYbkU52HQz9QcU94h6YAlpUCr80v
	 Jk1dt/acBDYpp+kPusd+cnlxyHvfRiiZjmJlKlAcVfPAG3mwTjitOPj//Elc5i5Znr
	 k1SzjlMfzL/XxRHTrekQgxJKqavT1RGCrez/mVecqabKLVLscLEC4k78zRV7g5vXv0
	 IVczyvu0DZMhqDLBxtoQDshTDkhFnlSFxLRvTVw6K/eSO8+F1mMc0pUQ/TA9+umbyq
	 9aUjsxpX/em/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1B2C380DBDF;
	Wed, 12 Mar 2025 23:10:30 +0000 (UTC)
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
 <174182102928.964052.9687195896689084678.git-patchwork-summary@kernel.org>
Date: Wed, 12 Mar 2025 23:10:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-qspi: Make it work on AM62A LP SK
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=940717
  Lore link: https://lore.kernel.org/r/20250305200933.2512925-1-miquel.raynal@bootlin.com
    Patches: [1/2] spi: cadence-qspi: Fix probe on AM62A LP SK
             [2/2] spi: cadence-qspi: Improve spi memory performance


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



