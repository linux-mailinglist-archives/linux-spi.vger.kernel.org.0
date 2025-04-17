Return-Path: <linux-spi+bounces-7648-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508DA922B6
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067414628A2
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F19254AEC;
	Thu, 17 Apr 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhoPeKHF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9491254867
	for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907395; cv=none; b=BCQc05QWNJH6rKYCcn7bBi7Tdb2NvctzD50mUH954VmNjDfV5ZbNG/s3CoBzmqix7DFw6r/03OD+XAHQz0wMffLK6xJsibhkqwqWO6MF/mRv9MI1Ljln4zJDdsehbF9S6zW4/qWTlNEoRiNsid9As43EY/eMYBIQY5J5mpMl8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907395; c=relaxed/simple;
	bh=6e9EMLM+K9oDNxoGD03YsWFLfB8pRGisRjOm+nBkdHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lkg6kiTZz2Mb56jnhc/9S+sT/qABPc5HA1alWWdTYh8KxtMou9z4uwpJAc8IxV8JalxQC+xlKHWhFD8dw/LY4mTuFyP/CsANJpoDLC+Cu/2+HkJu4ZX7C7mLfs2Q/v6YhYUMZy1YA3OYVbAH+bUUbmSeHEFu36s4c5GppLsd6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhoPeKHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA243C4CEE4;
	Thu, 17 Apr 2025 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744907394;
	bh=6e9EMLM+K9oDNxoGD03YsWFLfB8pRGisRjOm+nBkdHw=;
	h=Subject:From:Date:To:From;
	b=UhoPeKHFeQqXsCNIP2nxf1hBqu+LOft9iMP1shzDOPgHbuLsdoN+BFUxWXcsi2DPB
	 rK20E5pU4N//sW+s+s5x56BWHK0i8s5NIPXXsMLhiqkzg3qvdk7h3JkD0nqmY/IYJL
	 FVxO06a1hqfHMc/HtYW94Np10ufV4IDFkNpP3SLs6xP/ufoAKptzLQOoexofqYKJWi
	 WEzv2Yh4ayuBoT/SYlo+pOH6uuKMv37T6BHC2apiUm7PL/gH7VqOuzF03YxoGHPJhv
	 9v/QCmIHdiY09jsm0yMaJ4z70Yc15/3MfRKH46VNr71CMJAKpX4msIS54OrEduH8Qh
	 5tXlTsZ6iox4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F22A1380664C;
	Thu, 17 Apr 2025 16:30:33 +0000 (UTC)
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
 <174490743257.4135398.863007487862460184.git-patchwork-summary@kernel.org>
Date: Thu, 17 Apr 2025 16:30:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-imx: Add check for spi_imx_setupxfer()
  Submitter: Tamura Dai <kirinode0@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=954232
  Lore link: https://lore.kernel.org/r/20250417011700.14436-1-kirinode0@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



