Return-Path: <linux-spi+bounces-3824-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2607892C65C
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 00:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CFB2831B1
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 22:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F371B155316;
	Tue,  9 Jul 2024 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA4ovljk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5C14D439
	for <linux-spi@vger.kernel.org>; Tue,  9 Jul 2024 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565789; cv=none; b=C4E7SPdNIWz48BafGCBghaqu4pjqtdzno0/1wmM3N3eONiYOwNA3DrN4xQrBVu/HqLkvUMuCsmQYEF9eaL5z/KDFKCvWtZcx0FaMlcQHJK0oBBU4ixdxMZi78PEJyDSq5uPmD1F1LhtiEN7kR9aWyqJjk4CTIuVbuVAZfp62aOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565789; c=relaxed/simple;
	bh=8bGNzPGmhpwi/D9H9337L5IphEhgJSOY+/7THIA/Oo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=E9mHRYxCASZ7h7iy8U7ydO4570zqse3ZLM1r8SjouFOf2+YBMawlN8jy5TVQg28LmfiCIOLDluzVGNMQESBZj0NtPs92d8cKqGs/XTq55jx8AF/aVPUvzHxdi83eg7uWrZoLqp4YaXbAXcD7e3mIafmDiU8xpgxzMmHL3woW7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA4ovljk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FAD1C3277B;
	Tue,  9 Jul 2024 22:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720565789;
	bh=8bGNzPGmhpwi/D9H9337L5IphEhgJSOY+/7THIA/Oo8=;
	h=Subject:From:Date:To:From;
	b=PA4ovljk01gR8w/9ztfEnjXi0HeAT/bZTScR89dFgAziwQKfFOpotFqYf9FKun42e
	 qB1/kgxdooYUb6GdFzL92OqvmC3GtU9O7vr68DSmTHXOftFrgVxeINeKdUXa0Za1AI
	 e9aJkpejPtCYCXuJYViprbIWGyaMQ4eZggQAxyACcgg/Yb+DEi+HMWSfZeXqdgOQum
	 uKqmMmBLKRNYVV7i6jcBpd8yPGGXCvP2H9LRnzATPDeq6NYynQ++dXfuiRQr3KfEve
	 nQCtidazmimfYLmDcmx1uiZyK5X2NGqULHqXuuMlYwC2wRW6wBU+3FgW/ps8rK0GcF
	 bSt7yUJrnluoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BFB4C43468;
	Tue,  9 Jul 2024 22:56:29 +0000 (UTC)
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
 <172056578937.31172.8636464881527817646.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Jul 2024 22:56:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] Marvell HW overlay support for Cadence xSPI (2024-07-09T22:12:03)
  Superseding: [v9] Marvell HW overlay support for Cadence xSPI (2024-06-19T14:17:07):
    [v9,1/9] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
    [v9,2/9] spi: cadence: Add static PHY configuration in Marvell overlay
    [v9,3/9] spi: cadence: Add clock configuration for Marvell xSPI overlay
    [v9,4/9] spi: cadence: Add Marvell SDMA operations
    [v9,5/9] spi: cadence: Add Marvell xSPI interrupt changes
    [v9,6/9] spi: cadence: Add Marvell xfer operation support
    [v9,7/9] spi: cadence: Change resource mapping
    [v9,8/9] spi: cadence: Change cs property reading.
    [v9,9/9] spi: cadence: Try to read spi-tx/rx-bus width property using ACPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


