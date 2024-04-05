Return-Path: <linux-spi+bounces-2197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E27089A1FA
	for <lists+linux-spi@lfdr.de>; Fri,  5 Apr 2024 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2976B21794
	for <lists+linux-spi@lfdr.de>; Fri,  5 Apr 2024 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAFE16FF48;
	Fri,  5 Apr 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3HOOy0J"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807D16F82C
	for <linux-spi@vger.kernel.org>; Fri,  5 Apr 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332594; cv=none; b=gIrw52AxHDJhpEulXHhpgTdjD4RCcCOJ5ZDZPuyj+pgLud2dxP+OCtcGhnEQbwSJmbqLRJOXyzvNM2Wo+tS4GR/cB8VDh58ChqtMKbPdfensW7/E7dFksIqzUmEYUV6hE53QLkZVyf9oBkG/OOMIj0FWZpXaJpFc8NjxgBPNCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332594; c=relaxed/simple;
	bh=bUsc/OFs327HOBsok/EBGz65ChtSRRuGq1z9Jf8dgfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KfS/mvaef4VHnayF3t9MiEArowC6LSSr3nwExT5CyF6fHkz6f3REP4DTgv6geJgjXkWpi5W3gkQsp8ABV7k1GUd82PtyV7o3aRBTCu+rRlRlgCZfrpYFhNvKUrcxPgvuwev3lzsmIWzM+x+FwD8ktIXQfKuSsAz6RIAwd08jugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3HOOy0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DFD0C433C7;
	Fri,  5 Apr 2024 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712332594;
	bh=bUsc/OFs327HOBsok/EBGz65ChtSRRuGq1z9Jf8dgfY=;
	h=Subject:From:Date:To:From;
	b=U3HOOy0J91M000OR6z3ZquRNcnXSV30c1ewmLEY25SF4lI4SWCIqt57z8vxeNHH4I
	 uZN7P0qAEqpUtdikLWqIHnJxN2Hj1jQeiUlz/ooC15UVv/8fWFenNeAJgcTfXPh7U7
	 Q9YPtr8EuWB2KNFukKSaVk+HOw9EENgcT40J2V3XT6yG8M702ksOzRaHbgkQokpwnZ
	 36U/K5vaidjVao8sQ/P0EyoG/I0VAqyXMh28VvQFsL9tt/taDYfxwAkkuIfhtPUBxs
	 c46MKaqjuMHWNJzvBdWg//MxLupxZwSnXjiGC9tzJTkx0vS8nKSQHCAyvFrj0FwO4y
	 NXbhAlMPZC55A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D883D2D0F1;
	Fri,  5 Apr 2024 15:56:34 +0000 (UTC)
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
 <171233259444.31024.3045354110235271698.git-patchwork-housekeeping@kernel.org>
Date: Fri, 05 Apr 2024 15:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cadence-qspi: add Mobileye EyeQ5 support (2024-04-05T15:02:10)
  Superseding: [v1] spi: cadence-qspi: add Mobileye EyeQ5 support (2024-03-08T17:18:16):
    [01/11] dt-bindings: qspi: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
    [02/11] spi: cadence-qspi: switch from legacy names to modern ones
    [03/11] spi: cadence-qspi: allow building for MIPS
    [04/11] spi: cadence-qspi: store device data pointer in private struct
    [05/11] spi: cadence-qspi: add FIFO depth detection quirk
    [06/11] spi: cadence-qspi: minimise register accesses on each op if !DTR
    [07/11] spi: cadence-qspi: add no-IRQ mode to indirect reads
    [08/11] spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
    [09/11] spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
    [10/11] MIPS: mobileye: eyeq5: Add SPI-NOR controller node
    [11/11] MIPS: mobileye: eyeq5: add octal flash node to eval board DTS


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


