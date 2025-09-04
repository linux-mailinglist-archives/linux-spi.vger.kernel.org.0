Return-Path: <linux-spi+bounces-9913-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916CDB43FC0
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807107B8D01
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED606302CDA;
	Thu,  4 Sep 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrMRJpUP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9327302CC8
	for <linux-spi@vger.kernel.org>; Thu,  4 Sep 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997825; cv=none; b=nmDgtEtw476z6ifr39Xs9FytU5Y/uGN+19aEL4TNA4AlgJAqYTyr7REj9FqYq6HOPUort298jpN9RIB/NYv+Pw/rhm8ovBL0CwZ1dH4Zh71pq60z8o10XIsaafqXfF9Vs/BBr7XL+WmtZV5pwy1tmVBSYwPUIHXmlVC+nKd/6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997825; c=relaxed/simple;
	bh=zy7ci82Nyudi63bmHkw44W6TtTWn2ujyRA3oF3cE0GY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=E6PO6zImz4n3BuyTmhzEutPSRHR6kZY9bPbsV8uVPWFJNF4cxEmz2y7BpTli7VyNqBmNQgiztZcrGARtbpTM8Xa6d2sLjMzEwJTrvcUbGaLvfl2uE83B6crwbDwOVw7CPxqVQxDu9alQcxMp3QgKamrSHj3FFpEUS6JPNAzcIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrMRJpUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DA9C4CEF0;
	Thu,  4 Sep 2025 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756997825;
	bh=zy7ci82Nyudi63bmHkw44W6TtTWn2ujyRA3oF3cE0GY=;
	h=Subject:From:Date:To:From;
	b=nrMRJpUPo5MBNKiRO/+Yx/f1HOamGuTOc9g+RzSR/2ZxAJRsAFST1Baz9p3A4CHqF
	 d4MiVEMUAehlyYRbg/MBG0ToSnZqwPjip4+NwJ3jfxVHHRkMLnME9CSxux5/9vcL2V
	 PDlQomaaXTXNDrO2dthMEFSK6sGTCvDJV9slfXsun6ZTSLl2dCOwlYsDSFyKms6xg2
	 MudNf3D+Rt8mN8P9CSkPHSbvPnmd6VSvp9mq+8LPYCixeptiCDqgSmOkLt3lUepwyQ
	 aeTnAFRF+GV3uzF/wW0IiZcjKZnmBFTLqAKP1H2IL14nMouwosWoFdDWVfdrEBtYoh
	 bYLwgpbMenmtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F82383BF69;
	Thu,  4 Sep 2025 14:57:11 +0000 (UTC)
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
 <175699783008.1839472.2162600494504662104.git-patchwork-housekeeping@kernel.org>
Date: Thu, 04 Sep 2025 14:57:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: airoha: driver fixes & improvements (2025-09-04T14:23:26)
  Superseding: [v5] spi: airoha: driver fixes & improvements (2025-08-23T16:01:03):
    [v5,01/13] spi: airoha: return an error for continuous mode dirmap creation cases
    [v5,02/13] spi: airoha: remove unnecessary restriction length
    [v5,03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
    [v5,04/13] spi: airoha: remove unnecessary switch to non-dma mode
    [v5,05/13] spi: airoha: switch back to non-dma mode in the case of error
    [v5,06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [v5,07/13] spi: airoha: unify dirmap read/write code
    [v5,08/13] spi: airoha: support of dualio/quadio flash reading commands
    [v5,09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [v5,10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [v5,11/13] spi: airoha: set custom sector size equal to flash page size
    [v5,12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
    [v5,13/13] spi: airoha: buffer must be 0xff-ed before writing


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


