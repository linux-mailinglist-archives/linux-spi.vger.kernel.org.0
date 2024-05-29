Return-Path: <linux-spi+bounces-3141-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9898D4192
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 00:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF29B22289
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B41CB31B;
	Wed, 29 May 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOK+VSkQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E515D5A3
	for <linux-spi@vger.kernel.org>; Wed, 29 May 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023420; cv=none; b=KSkPQ2xS5moQbwEbUUan1vkEZ3rIYgtGUOpKJzHr0UFoT7951ftSF12AoDumusL1or8bRX6HlFSuI9IQh6TYdM4LZHsg7xJs0UfhkCgrObnMnGRWzdfNaZ2j9tUxRXvJkkT+VMIZA6UFP+MAkfwf64OfFr5CsYe0HAv7ed0bw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023420; c=relaxed/simple;
	bh=wchqF/ng9a7ySm1viQTB0iityKj2MZ5qGdboUnSPye0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bgQsiKo3M+IboS3tPtV2AaeNjC+BguoSb1fCOZn8J6gpYFthMWiAdXiFik+CcjoBEr0Q4cRDb3heCEDHOT56dnrmSWv3wv0u81yAk/DKK+StQ244RofC04dcTi42eB41FaC+SkR6JjuEQEaL3ot1+YnRuIabwP4Wa4FxKT6jLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOK+VSkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02060C32782;
	Wed, 29 May 2024 22:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717023420;
	bh=wchqF/ng9a7ySm1viQTB0iityKj2MZ5qGdboUnSPye0=;
	h=Subject:From:Date:To:From;
	b=WOK+VSkQTmMZ7xUOCn70cxWqCHQUwMA88tMle/SK8/m4XP+1u1S0IJGnP9bTcSAsJ
	 EmieGMZMz0NVyhP/kmQOE87GiQSgKYTjgrBJFK/QGpp2o+oy6b3RWi1RhDgDVVsDXd
	 7Do/ng9QbLthIXhHeQsi4pmlHo+R6KdteOspWtPEhEkBnENlhuQYnzZnibB1sM4TBe
	 iPhyn+TlwmDxygdu6luxPqhwO+t9Pcie4spTqTEzboV1p3X/pUQjHTtC1J2kfWdP3G
	 wqD9Y109cQxG6aXRR8royy6A08/SPD4BjQmbLjt15+dM5a3jYLKk4hpqazxNC+gXum
	 pKckqfBNcf71g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E198FCF21F3;
	Wed, 29 May 2024 22:56:59 +0000 (UTC)
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
 <171702341986.1709.13395470143007841217.git-patchwork-housekeeping@kernel.org>
Date: Wed, 29 May 2024 22:56:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Marvell HW overlay support for Cadence xSPI (2024-05-29T22:00:22)
  Superseding: [v6] Marvell HW overlay support for Cadence xSPI (2024-05-29T07:40:31):
    [v6,1/5] spi: cadence: Ensure data lines set to low during dummy-cycle period
    [v6,2/5] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
    [v6,3/5] spi: cadence: Add Marvell xSPI IP overlay changes
    [v6,4/5] spi: cadence: Allow to read basic xSPI configuration from ACPI
    [v6,5/5] spi: cadence: Add MRVL overlay xfer operation support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


