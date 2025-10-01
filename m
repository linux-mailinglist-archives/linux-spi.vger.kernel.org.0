Return-Path: <linux-spi+bounces-10421-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3FBB206A
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6683A1921B6C
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFD31195A;
	Wed,  1 Oct 2025 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljsQfaEm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7531194C
	for <linux-spi@vger.kernel.org>; Wed,  1 Oct 2025 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359410; cv=none; b=Ir4XJCxgT4wg3m2Q6l7dKaS941z03baD7fNZcj8OC6x/HlTp9ZaNBKe2LdmAsxc2xAAcahPHDjp0eMs5Sd4OMY2tlnekFwE4mWX5/U7wAHldr7+XeW/Jr68wsPdjOZSKvReFleujXC6ae/0pWqSLXTtLvrMLKDYLBs2Eqc/WqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359410; c=relaxed/simple;
	bh=sNpMnzessh6Aa3PNS6EmrW3BjS2M2aii1pIizbytVUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SvqBAk2T3+ifdY5ZU5fONFUJEOaWwZoUzNScQQYJ+J4Rr6pnAD8jtWMj8nAerolWuSdOgZD3CHRyJFu8ezh95/SBqLr3HOGUSOR/y45oaTJbVz9p2zFb52puiMtAOsi6jsFccjGpyhMZz4Ly0CTHqvv0g5W1k1XsosioPKSfIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljsQfaEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC15C4CEF1;
	Wed,  1 Oct 2025 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359410;
	bh=sNpMnzessh6Aa3PNS6EmrW3BjS2M2aii1pIizbytVUo=;
	h=Subject:From:Date:To:From;
	b=ljsQfaEmFbIeG4rTHSkz/IfrM3Aj0ZsbWz9jUPxexlIqDFlUkskXdWyq/UnEDA1ic
	 H3+GR6OkJs3xkPMlgKM51UklzAWPBwBlinLvE3hi6PaqFE9htVwCoXCF+s8BaG3kWS
	 sQBmV5BL3wr8NqdtnbnfiJpafm7/AlMXU0FPp8OTq9kM6/bSG8OV5m9FkwSBRsmtdd
	 w8tHePLDWD49nf8q2O8pgD+gi3bp/0pkW9j5byNKCvFhCv4jamt8090YiDzmXzOaas
	 9FIIAHvdjGnPrAMEhb/XXMFegwATZHUbvp1z2a2qlUaCFxBPf71qOSWGHXOZ1wDRb3
	 XLDV/Q/PjR7vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED139EE03D;
	Wed,  1 Oct 2025 22:56:43 +0000 (UTC)
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
 <175935940262.2648150.582560258457566047.git-patchwork-housekeeping@kernel.org>
Date: Wed, 01 Oct 2025 22:56:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: airoha: driver fixes & improvements (2025-10-01T22:23:33)
  Superseding: [v5] spi: airoha: driver fixes & improvements (2025-09-30T02:26:47):
    [RESEND,v5,01/13] spi: airoha: return an error for continuous mode dirmap creation cases
    [RESEND,v5,02/13] spi: airoha: remove unnecessary restriction length
    [RESEND,v5,03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
    [RESEND,v5,04/13] spi: airoha: remove unnecessary switch to non-dma mode
    [RESEND,v5,05/13] spi: airoha: switch back to non-dma mode in the case of error
    [RESEND,v5,06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [RESEND,v5,07/13] spi: airoha: unify dirmap read/write code
    [RESEND,v5,08/13] spi: airoha: support of dualio/quadio flash reading commands
    [RESEND,v5,09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [RESEND,v5,10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [RESEND,v5,11/13] spi: airoha: set custom sector size equal to flash page size
    [RESEND,v5,12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
    [RESEND,v5,13/13] spi: airoha: buffer must be 0xff-ed before writing


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


