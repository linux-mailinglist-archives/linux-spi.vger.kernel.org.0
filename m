Return-Path: <linux-spi+bounces-11606-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7CC8B242
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4D774E1731
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E6633B969;
	Wed, 26 Nov 2025 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbN/K0Ck"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803A306B12
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177042; cv=none; b=BibpVy8AwZcwf5QfGpJ/WBdD0TL6bVfkcGzpQ/QTX9bLo+i0KUuXSgyti7WJMcLN8SKYi/yP89nrcXoWCZmwv5PAUtkdxSeaRP/59GtqKifUwun6OZySG3VSWYnAOVPRigOZBpoX5KCQ3Ah0R3NhMVwN1PghCKzBS0uA1oQH30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177042; c=relaxed/simple;
	bh=C/UDirj/YfGJsXSgsPXTeN7ZMw/lkQ87RDscg1abm9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fQaBwpFcQj64fqVTkzw5GWmLjGJxAoTHkVLvtMJ2AH4tL7nYIPztKV2/ua/g93S2kHrijsSzH+Ogmac+oXiY3yNEOTbfnd+2tCbukh94oV5VidRt6HrrQvQsmBprmWH9qQ2J4HvMD1auokKnBuarGrQvCMMYfEes6MN/6CviHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbN/K0Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE089C4CEF7;
	Wed, 26 Nov 2025 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764177042;
	bh=C/UDirj/YfGJsXSgsPXTeN7ZMw/lkQ87RDscg1abm9M=;
	h=Subject:From:Date:To:From;
	b=DbN/K0Cki7abpJjI2PWci5VNs5cE7MkNIAU5KYb7f23zsZGyo8/NXABoFk02ZxsjB
	 JJ+qovCD9RFj/cHPAigFP2rupZeT67Drg2Suz0/Y2WLhUTxYpY/4cImkgJAyudSGY3
	 /9Nfu/xsCpcjgItUnThfSNOpfbCZZaUDHvwSv4lK/odDNpgcp8Stv2yDVVeoGndad/
	 Ir0fdpip/HhlXnjV8VnKg3Yd6NTduYJmhCzhApKWKvvoGR1VqZlqljQV1Ep1FPN0gs
	 8un5ESD9yUarfiMwGy/851/8k40OBCnYHHa+1nSlSiq1wznSkbPorXiX/Gub3TIK64
	 98xz+sh5cdvXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B182D380CEED;
	Wed, 26 Nov 2025 17:10:05 +0000 (UTC)
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
 <176417700437.1767786.801217280362080951.git-patchwork-summary@kernel.org>
Date: Wed, 26 Nov 2025 17:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: tegra114: remove Kconfig dependency on TEGRA20_APB_DMA
  Submitter: Francesco Lavra <flavra@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1027758
  Lore link: https://lore.kernel.org/r/20251126095027.4102004-1-flavra@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



