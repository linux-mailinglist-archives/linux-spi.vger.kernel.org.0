Return-Path: <linux-spi+bounces-7975-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E1AAD945
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 09:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0B27BE878
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B7221560;
	Wed,  7 May 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJufmO/v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7351221704
	for <linux-spi@vger.kernel.org>; Wed,  7 May 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604599; cv=none; b=quP7mG5Zt1FgLaP4ZYh2B5sqvDrNSrlUUDAo4r2WULOHkbjpl5eyV2RVuRBlAxlc4BzD86o0VWZebrgYdy8qTAg6w3crFNADZSamzRvWZxjHIHQL4aJwgI17kkB+o8cmkuCCr8UDoxyqg5EzCsMzJpHXwAgW3L84LbfdJxl+55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604599; c=relaxed/simple;
	bh=4IkRpJJNLsj+nfT7vL0/swI9taC5/TfbD/SOQxJiGrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=H2WzJ1vMKa4Z7YlX7UdgHC5PExs4R2hC1xgUXGWjZAmQi8vl7Ahe6gBghDtdV63k9CxWcyK3SgTmSODNExUkIL/SQ7uSZUx8nmp5jKATZa1W/fbb1WuBBgkwfX1fgTgPcxQ1lvWRXkUOmrAG3Ogbkr1UvCJeXYd1ldKv/XeSAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJufmO/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5094FC4CEE7;
	Wed,  7 May 2025 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746604599;
	bh=4IkRpJJNLsj+nfT7vL0/swI9taC5/TfbD/SOQxJiGrQ=;
	h=Subject:From:Date:To:From;
	b=NJufmO/vCZ8CLnCxPPLjHTdX9ZBdUY1y9cJ9TnbbRiVNhZ2zDGZ8xFjM25nFOvHdQ
	 BOZ2HkP7gaYhLVY9q99U4mnSNG/1Vqj0PnTk0eonWLHb+iZgG50atEcqA55rwttN5Z
	 Is2eJEIZDuElRUuJkwaL9qxkVA3eZ6q7PGKrs5tq7F6UVQVTLC2Zp4dpE/1MZnMBS/
	 gBCWaoAVXU49Y41iaU5xgxVeoj04R1x7Pz/C2m4zgYQbZi3+Bg0QdmfZFtt1j96bC7
	 snttShh9Ek0x/l7D+DURyhSw02ZDLOCgvHnRDoL7+sLuufRYwH05rjfJJrRlzfcmu4
	 dxmziQjGtPHbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F08380AA70;
	Wed,  7 May 2025 07:57:19 +0000 (UTC)
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
 <174660463808.1796859.6937995175319351679.git-patchwork-housekeeping@kernel.org>
Date: Wed, 07 May 2025 07:57:18 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] lan966x pci device: Add support for SFPs (2025-05-07T07:12:42)
  Superseding: [v1] lan966x pci device: Add support for SFPs (2025-04-07T14:55:29):
    [01/16] Revert "treewide: Fix probing of devices in DT overlays"
    [02/16] driver core: Rename get_dev_from_fwnode() wrapper to get_device_from_fwnode()
    [03/16] of: dynamic: Fix overlayed devices not probing because of fw_devlink
    [04/16] driver core: Avoid warning when removing a device while its supplier is unbinding
    [05/16] bus: simple-pm-bus: Populate child nodes at probe
    [06/16] PCI: of: Set fwnode.dev of newly created PCI device nodes
    [07/16] PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge node
    [08/16] i2c: core: Introduce i2c_get_adapter_supplier()
    [09/16] i2c: mux: Set adapter supplier
    [10/16] i2c: mux: Create missing devlink between mux and adapter supplier
    [11/16] of: property: Allow fw_devlink device-tree support for x86
    [12/16] clk: lan966x: Add MCHP_LAN966X_PCI dependency
    [13/16] i2c: busses: at91: Add MCHP_LAN966X_PCI dependency
    [14/16] misc: lan966x_pci: Fix dtso nodes ordering
    [15/16] misc: lan966x_pci: Add dtso nodes in order to support SFPs
    [16/16] misc: lan966x_pci: Add drivers needed to support SFPs in Kconfig help


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


