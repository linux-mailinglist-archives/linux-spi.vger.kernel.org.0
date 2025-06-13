Return-Path: <linux-spi+bounces-8540-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF056AD8EBA
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 16:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A0E1E4C32
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 14:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDCE2E7F0E;
	Fri, 13 Jun 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qL38fmFS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F72E7F0B
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822979; cv=none; b=s5LjklgGIfwC8tf+lIft6y0QkykKqAr/QgGzqtl4Gy1lieFzQvIrTvwPHyrjxk9ywea5U7RIclgZInM/mrHi6e5SJbDmOOTo9amSEf9XsETB8oVvlfNlq82b4oQxqDHa+ak1EFugg7xTdFCLqurWKSj2511RkOo7NKrtk4fSU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822979; c=relaxed/simple;
	bh=E17qcRvIupRzt/5gyVfi3TQTfY9YoPMquvzXpZYZHFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qdncQOONtNVI36gbBVD/yQ7qZ2fk1HuqoRVSiFkRxvoG9heXJnEe4cM+/n/bdtJBBdZm/SZxdS06/+HA76Ixp4/6HJSzrbC9ldYEHtDXCCR2bCy1HIb6gxMq/cte7EHh48LIyJTW8kqeFgUgxMLEw/BeUDPaQO6PERn81u9ftgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qL38fmFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58703C4CEE3;
	Fri, 13 Jun 2025 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749822979;
	bh=E17qcRvIupRzt/5gyVfi3TQTfY9YoPMquvzXpZYZHFg=;
	h=Subject:From:Date:To:From;
	b=qL38fmFStGJWeV0zSOF3OtHZNp3cHIp63F/iYYRr5VGLJcpAxEy9JWEea1elXhFcM
	 DLXh9jZ3mu1ceTaKUQx3qyC6sNNegK4Q0gkg17XUVN7BDqHgZx22vgnFw1TvgzTsx5
	 D8Ao8dfhmrvgMxJSLdHt5ZdwKRLDCCp3T1W3EkNYTA2SdmqZwbcjQ9pRvyWGQdUQKT
	 TLxVPF/Xnx40IKy3tzeXbfQmc+lqXA0qSMwF36SeFgYYEleQTSxPCijTmlhv/wS6SA
	 dNbMawDOO3WC5sZJi53+ezWaTuJsP0cgzMDQgYesMlj5Z9O3LMtgKD7eeonWdTLa46
	 ZYjIp9NleMJvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E71380AAD0;
	Fri, 13 Jun 2025 13:56:50 +0000 (UTC)
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
 <174982300887.740765.15726112647767137222.git-patchwork-housekeeping@kernel.org>
Date: Fri, 13 Jun 2025 13:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] lan966x pci device: Add support for SFPs (2025-06-13T13:47:40)
  Superseding: [v2] lan966x pci device: Add support for SFPs (2025-05-07T07:12:42):
    [v2,01/26] Revert "treewide: Fix probing of devices in DT overlays"
    [v2,02/26] driver core: Rename get_dev_from_fwnode() wrapper to get_device_from_fwnode()
    [v2,03/26] of: dynamic: Fix overlayed devices not probing because of fw_devlink
    [v2,04/26] driver core: Avoid warning when removing a device while its supplier is unbinding
    [v2,05/26] bus: simple-pm-bus: Populate child nodes at probe
    [v2,06/26] driver core: fw_devlink: Introduce fw_devlink_set_device()
    [v2,07/26] drivers: core: Use fw_devlink_set_device()
    [v2,08/26] pinctrl: cs42l43: Use fw_devlink_set_device()
    [v2,09/26] cxl/test: Use device_set_node()
    [v2,10/26] cxl/test: Use fw_devlink_set_device()
    [v2,11/26] PCI: of: Use fw_devlink_set_device()
    [v2,12/26] PCI: of: Set fwnode device of newly created PCI device nodes
    [v2,13/26] PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge node
    [v2,14/26] i2c: core: Introduce i2c_get_adapter_physdev()
    [v2,15/26] i2c: mux: Set adapter physical device
    [v2,16/26] i2c: mux: Create missing devlink between mux and adapter physical device
    [v2,17/26] of: property: Allow fw_devlink device-tree on x86 when PCI device-tree node creation is enabled
    [v2,18/26] clk: lan966x: Add MCHP_LAN966X_PCI dependency
    [v2,19/26] i2c: busses: at91: Add MCHP_LAN966X_PCI dependency
    [v2,20/26] misc: lan966x_pci: Fix dtso nodes ordering
    [v2,21/26] misc: lan966x_pci: Split dtso in dtsi/dtso
    [v2,22/26] misc: lan966x_pci: Rename lan966x_pci.dtso to lan966x_evb_lan9662_nic.dtso
    [v2,23/26] misc: lan966x_pci: Introduce board specific data
    [v2,24/26] misc: lan966x_pci: Add dtsi/dtso nodes in order to support SFPs
    [v2,25/26] misc: lan966x_pci: Sort the drivers list in Kconfig help
    [v2,26/26] misc: lan966x_pci: Add drivers needed to support SFPs in Kconfig help


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


