Return-Path: <linux-spi+bounces-9564-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF4B2DD14
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0729D565709
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331E308F17;
	Wed, 20 Aug 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvHLTSMy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8AB21ABB0
	for <linux-spi@vger.kernel.org>; Wed, 20 Aug 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694600; cv=none; b=UjFGjxpkAseF8wI5nyanU7DI1tUmZ7CDDXj16qZARacG0qDiGNXteRNp1joH4KP0TZpdAN/39CIr4J6rxI6Bzp48c6a7Y7ltgYr+NyRz1Oigj6BrWRUWDz3rQmb75yUug58W4fo1BJmkOwykvx3daDcZP1dtGDXBy9er8sEDEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694600; c=relaxed/simple;
	bh=vLixU28oqTnJobS/w5/47mUrMvB5kLOIG5LT2G4WkIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DFEu7oTP3R36wezUjdn/aLNldk6As+KMGAfpYsNOf7cOCO0eJ3USy981mwYsGDlUzH7mWHLG3o3TKakQ0/5HMV2NC1tMJzly42nQ1pfa2XSSuhYTZPbMgNK+JDpDCi/qvYNc5rIdApIa/OvpwPtwj2MbN+g3Zi5qE7mufF3LD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvHLTSMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACE8C4CEEB;
	Wed, 20 Aug 2025 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755694600;
	bh=vLixU28oqTnJobS/w5/47mUrMvB5kLOIG5LT2G4WkIA=;
	h=Subject:From:Date:To:From;
	b=HvHLTSMy84glHezNPrbGoegDciEMJhXAP/cilWFKq+Iz2AS/hIm8pxaMs8SC/wvvF
	 pR9PveSqkTUm2e+L8aiZVuTYYn9adXXNgG/d/DJp8GJCgOwJ+rvLqWGpED54m7nqSa
	 vC/JAyXMcDVfJ10niB1OwFXA7f7gCbHt9GvLvJae2McVIz4gI630NOUSO+1WAzuPfs
	 WMWVluh7YOQkJJNH4+jwaKe+GWSbyNexFHYKswSY3QEAPwiM4Ehz54RvPKGNdOotGy
	 hoyptkh8ftG64ydhO54JIwRQQ6bxrPDjqN2Kqi9DOtwmnOpK5q+/CvwbWvvkUyiYf+
	 PDW9spo7JIywg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE94383BF4E;
	Wed, 20 Aug 2025 12:56:50 +0000 (UTC)
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
 <175569460923.225757.16965427316712904699.git-patchwork-housekeeping@kernel.org>
Date: Wed, 20 Aug 2025 12:56:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: airoha: driver fixes & improvements (2025-08-20T12:33:04)
  Superseding: [v2] spi: airoha: driver fixes & improvements (2025-08-15T11:16:06):
    [v2,01/13] spi: airoha: remove unnecessary restriction length
    [v2,02/13] spi: airoha: add support of dual/quad wires spi modes
    [v2,03/13] spi: airoha: remove unnecessary switch to non-dma mode
    [v2,04/13] spi: airoha: unify dirmap read/write code
    [v2,05/13] spi: airoha: switch back to non-dma mode in the case of error
    [v2,06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [v2,07/13] spi: airoha: support of dualio/quadio flash reading commands
    [v2,08/13] spi: airoha: allow reading/writing of oob area
    [v2,09/13] spi: airoha: buffer must be 0xff-ed before writing
    [v2,10/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [v2,11/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [v2,12/13] spi: airoha: set custom sector size equal to flash page size
    [v2,13/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


