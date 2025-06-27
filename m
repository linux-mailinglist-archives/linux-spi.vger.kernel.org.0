Return-Path: <linux-spi+bounces-8805-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10AEAEB58E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86591BC7762
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A28E2980BF;
	Fri, 27 Jun 2025 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjKIJLj3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA103224893
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021781; cv=none; b=qj0KTaUV9vUSMAlkqB9Cx4tjzXB0ovXneAFCn+BzjoiiCmz0ig7KC43pk3NwADjJECzZLML/za/CLSZhaaK+PU2SlPjgHBwhLDI0c+wy9xLOBTwiqTtH113oz646m2EpcDHU8NPsaT1peLgXBjpv9D1o66GGGCtJW/od47IdklY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021781; c=relaxed/simple;
	bh=NPGd6WiCB1L6pVtrQiTy+xK+6GHTSA0fU/CdgoAnZzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bIAM3bDtqdUQLC9rpxpwolte8FnZrw45dIEe26iZJLYb+D8aRb3DF2RAsAvNyYjFwOWgRrH+ptREA//OJHSdZUj/vVRKVbVsX28ehwwvs+vkO0ZxlMalvjgLN+SlUV3KgFRceD6sAjvtgs6aVb3OIMTv4w4viZ8UkCugillqxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjKIJLj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701D4C4CEE3;
	Fri, 27 Jun 2025 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021778;
	bh=NPGd6WiCB1L6pVtrQiTy+xK+6GHTSA0fU/CdgoAnZzI=;
	h=Subject:From:Date:To:From;
	b=IjKIJLj37MFV7V3Ql/TvcUqGVvZLiycoEynQjE2XIo0ReFu1aNAkjtGFTRNcprSSx
	 zooatxqyQ5mZ58jtRi77/frk5dnS+MjFzw9JSS4w3WWjKx+kWUcpDJpG61nXi+T0xR
	 R7ViknQUJX3GwGZujZ5MjxFDizYC7jpzQX8DgrQTikVk4hNKZE+Lt7QoZ0XFkKTdZY
	 0VVh2jUCk/PYIRlhaMR0ro2IdNaZ5AeWX2joOwAH/PdjWg5nAIuFQeTdmvPzECL97w
	 HWmKpWbZoeHEx6yajaQ+6wLYDcs6CjMDVaK7TxO//5bQ/EY+jixwiPP5077qBN6klz
	 ESdxXDbUCma6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE38380DBEE;
	Fri, 27 Jun 2025 10:56:45 +0000 (UTC)
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
 <175102180419.1880578.1103317312636650360.git-patchwork-housekeeping@kernel.org>
Date: Fri, 27 Jun 2025 10:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: spi-fsl-dspi: Target mode improvements (2025-06-27T10:21:36)
  Superseding: [v3] spi: spi-fsl-dspi: Target mode improvements (2025-06-24T10:35:30):
    [v3,1/6] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
    [v3,2/6] spi: spi-fsl-dspi: Store status directly in cur_msg->status
    [v3,3/6] spi: spi-fsl-dspi: Stub out DMA functions
    [v3,4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
    [v3,5/6] spi: spi-fsl-dspi: Increase DMA buffer size
    [v3,6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


