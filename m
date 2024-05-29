Return-Path: <linux-spi+bounces-3119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE138D2EF7
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 09:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594E9B21322
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD61667C1;
	Wed, 29 May 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIoNATQm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741A1C286
	for <linux-spi@vger.kernel.org>; Wed, 29 May 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969437; cv=none; b=Ljersu9DOxednUQgnNPcrOWASiZjucZ7U2ztwGeQwwvk1UhHvE0/IOIkugLXOJjsVqXiu2MXlJwOhfE9d15XeKEuABjWVP3BShtXCOlyYV2N7VNKjegcPNFIHA7hWuNm7T7jQoiHfXjqbyFdR9j+eWTpWhB/H1LCKQ1nC3zM7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969437; c=relaxed/simple;
	bh=zw8K0BtsMfwRrWPvXXdSv5JcbntcoX76CDB38OTIBeU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=B7SU+HKLAos+0y0RDt58BzQihC3P6XLL1/IA1aYYuPOL6v9JwHSxyXriYxs2KM+7YhuZAyQrrBPKeFl3FJHNIHs16/Tgy/02TAXrCeirWLRmVOsBGRrEhzChe+CF+Dce4VckGCQz1b1GTniCbYqhLoiNkmafZ2JH+SHz2N3nIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIoNATQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAE64C32781;
	Wed, 29 May 2024 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716969436;
	bh=zw8K0BtsMfwRrWPvXXdSv5JcbntcoX76CDB38OTIBeU=;
	h=Subject:From:Date:To:From;
	b=nIoNATQm6exQWZwS7/E67aajlQSmhvpsY8tY8tiZ3A4Er0Y5InrE2LuRCenkmafHc
	 jdDmxxKso8kzCjrnuj2JpddPSUu4bCEClUKRvry3KR7qWIdg8StXolsWHX305YXFDG
	 9c3+SuY6mjltqMe5HPXYTb+AoBWLM2+iOjkL1M/wYGMD6snuFpMYsqsxtZSQN8GMCR
	 wuMcyGOvG6P1pNJEYi3PnIcSuaZob3kV64ssFyRnzM/sIdW4ZTxL+XcW4hgXH2Iieu
	 Hrz/zwVdD1MtIsllx2rBtz28JUSIykQFbf86Y6AgAPe7LfSwHplvAsWTL37VDMkWdC
	 azHUtt1eOoV2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4317CF21E0;
	Wed, 29 May 2024 07:57:16 +0000 (UTC)
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
 <171696943666.19079.13877330598227761320.git-patchwork-housekeeping@kernel.org>
Date: Wed, 29 May 2024 07:57:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Marvell HW overlay support for Cadence xSPI (2024-05-29T07:40:31)
  Superseding: [v5] Marvell HW overlay support for Cadence xSPI (2024-05-27T08:42:10):
    [v5,1/5] spi: cadence: Ensure data lines set to low during dummy-cycle period
    [v5,2/5] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
    [v5,3/5] spi: cadence: Add Marvell xSPI IP overlay changes
    [v5,4/5] spi: cadence: Allow to read basic xSPI configuration from ACPI
    [v5,5/5] spi: cadence: Add MRVL overlay xfer operation support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


