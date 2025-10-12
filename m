Return-Path: <linux-spi+bounces-10592-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD0BD027D
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5C13B2A2A
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB43213236;
	Sun, 12 Oct 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGx3PK3x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4E78F54
	for <linux-spi@vger.kernel.org>; Sun, 12 Oct 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760273808; cv=none; b=Kvw7b8vP3o9GVKZIzoxycvfYod6aYCpvZCns8kSDvYwPC2Iggf72lVEIDJ8PQBkLNW1UK6nQ9WOhwTI29Fg+2P572/F+L2X4oGkyBCHNuzFg5hGYmUKreJ9CeUCVMq+4aT1I0qx5jbE3ekcj8yJiPgJwXmWhyUY8O+bFacshhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760273808; c=relaxed/simple;
	bh=++8lQtPnW1Mbb2YIIyGGgZJ9UFDT4FAHPlQjysKvhgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=o3jkJPyAoSzGDvoniUsWjJhwzqj3kzyFEIHFscNhDB8VpfX6n3DWt5x6cZXznT51fumqgKuJcFxFRFhEDFtCilynTTDPdPBknbWRPQFwlKPTTpBQB5KKZYvj6m1FJtRaRxa5DaBL42lQUll5OZt6fukEnmapU8g+6pXSJgOgkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGx3PK3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFBEC4CEE7;
	Sun, 12 Oct 2025 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760273807;
	bh=++8lQtPnW1Mbb2YIIyGGgZJ9UFDT4FAHPlQjysKvhgs=;
	h=Subject:From:Date:To:From;
	b=LGx3PK3xC5zBcjuMB9PAKWPpD2n5LtALw5FcqeLLV1Iqyw11922XF1Y9Z9jM/YAe3
	 BlUZyyG0pPubVcMDJk2tGxWhtBV/Sh4n1DBkNif1sYfXi6xt6L2jZMB+gcD2/3jJgn
	 OcPPYp31gjK3u9+pnv611/s3ZZD7yuwdKf2Z98QWg9sO2XXeeUOlMBRPyUPBsR3Ce2
	 7/BDfLYfH033qIEYekiG+d+8ADGqyaVzcDo9tOSJIQ8w/Dm1sqYgCX4mM/ZDewR5ME
	 Hb6AK0cfvnopeHFsSajfT1OPnfKm3zhjWofQT63bgOUCSyIEhB+ZasLdI+9tkIZYSk
	 lFk+qhnEYN9vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 744A53809A1B;
	Sun, 12 Oct 2025 12:56:35 +0000 (UTC)
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
 <176027379391.1642879.13133550557374672302.git-patchwork-housekeeping@kernel.org>
Date: Sun, 12 Oct 2025 12:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] spi: airoha: driver fixes & improvements (2025-10-12T12:16:51)
  Superseding: [v9] spi: airoha: driver fixes & improvements (2025-10-10T20:44:46):
    [v9,01/15] spi: airoha: return an error for continuous mode dirmap creation cases
    [v9,02/15] spi: airoha: remove unnecessary restriction length
    [v9,03/15] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
    [v9,04/15] spi: airoha: remove unnecessary switch to non-dma mode
    [v9,05/15] spi: airoha: switch back to non-dma mode in the case of error
    [v9,06/15] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [v9,07/15] spi: airoha: unify dirmap read/write code
    [v9,08/15] spi: airoha: support of dualio/quadio flash reading commands
    [v9,09/15] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [v9,10/15] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [v9,11/15] spi: airoha: set custom sector size equal to flash page size
    [v9,12/15] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
    [v9,13/15] spi: airoha: buffer must be 0xff-ed before writing
    [v9,14/15] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
    [v9,15/15] arm: dts: airoha: en7523: add SNAND node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


