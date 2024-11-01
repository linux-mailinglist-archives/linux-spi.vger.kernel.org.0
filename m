Return-Path: <linux-spi+bounces-5595-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A39B9916
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 20:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CEDB21250
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043C51D0BA4;
	Fri,  1 Nov 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKJbz81T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43EC1CEE94
	for <linux-spi@vger.kernel.org>; Fri,  1 Nov 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490985; cv=none; b=P9HXGKt0dX3+fufu5g0OdDFnIuLTzQ3PLOQmghOfnEd1lnJyq1FHdcqcqVrKvLGABI43vRAodZuaAOcRYFzzdGTfOnlGWZCFQA3tQPW9srVi+tWMORi0VATmagfi/azY5fMyQuQlB0cchtijD4jjZpb0Sncarj0ACBgn4jVpevc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490985; c=relaxed/simple;
	bh=1PnB+1E0irbMmC5DnqA7PkiJkPBG98x2+MFR/ZXxu6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=h1XdAWkYYlLw2GCaPQgP7QbPOWUUBi8bZ2xP4ZZlf9oyBtXRuVcpxwZWmGFiQ20SS1NXr/go+fpryAuVKZ/g2GBmDrOgNxT1J2dWKdRKIpWJHFJ4MuGY7S9RQ7tmDi+ASMrm24SBVRr2eDMa5f9+4O/EQrsJhEY6YzSceQcbicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKJbz81T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3516C4CECD;
	Fri,  1 Nov 2024 19:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490985;
	bh=1PnB+1E0irbMmC5DnqA7PkiJkPBG98x2+MFR/ZXxu6U=;
	h=Subject:From:Date:To:From;
	b=jKJbz81TFV34Mqsl1H1B/ZhZ0UaNE5+6f2g4z0bS3r/t4D6eFUh2nOXc57xf8M6ZE
	 Y0gpFPSDycfOo+lsEx3/gtK9jtk11nehJJr2TF6cHJaji+4UGzhjkzThLEZD6fWXh8
	 vMamc9mBRxmgpqsqaxDauR0lxR6hoQ4Ab0A3UK4uDeDhRLm7wf3QzmlCA7d08vDmik
	 0RKcbtB27x6+DErM2K9zN/PNN4tdb5dK2+BklgfxKaKqvmj7x5LbOyWgMIAPrbSBEj
	 /+IoNrid04Cx8g3rOte2gpDDx5xNqlap/Dm7tX0aulCrLFu7lLIs77UIctXKPvIfSn
	 khnrqtszZev2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1193AB8A94;
	Fri,  1 Nov 2024 19:56:34 +0000 (UTC)
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
 <173049099365.2831285.15581324622379686055.git-patchwork-housekeeping@kernel.org>
Date: Fri, 01 Nov 2024 19:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Apple SPI controller driver (2024-11-01T19:26:12)
  Superseding: [v2] Apple SPI controller driver (2024-11-01T14:25:04):
    [v2,1/3] dt-bindings: spi: apple,spi: Add binding for Apple SPI controllers
    [v2,2/3] spi: apple: Add driver for Apple SPI controller
    [v2,3/3] MAINTAINERS: Add apple-spi driver & binding files


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


